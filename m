Return-Path: <srs0=jygr=3t=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2MNw5zZCzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 19:35:44 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2MNw54xmz8swH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 19:35:44 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2MNt2tsnz9sNZ
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 19:35:42 +1000 (AEST)
Message-ID: <1491903331.4166.240.camel@kernel.crashing.org>
Subject: Re: EEH error in doing DMA with PEX 8619
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: IanJiang <ianjiang.cn@gmail.com>, linuxppc-dev@ozlabs.org
Date: Tue, 11 Apr 2017 19:35:31 +1000
In-Reply-To: <1491902810921-121181.post@n7.nabble.com>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan> <1491876268752-121154.post@n7.nabble.com>
 <1491876910.4166.219.camel@au1.ibm.com> <20170411044238.GA8157@gwshan>
 <1491902810921-121181.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 02:26 -0700, IanJiang wrote:
> I did another test:
> - Call dma_set_mask_and_coherent(&pPciDev->dev, DMA_BIT_MASK(32)) in
> probe;
> - Use DMA address or BUS address in DMA
> But EHH error remains.

We need to dig out the details of the EEH error. It will tell us
more precisely what is happening.

Note also that if your device can do 64-bit addresses, you should use
a 64-bit mask, it will result in more efficient transfers. However, we
should first investigate the problem with 32-bit because it seems to
indicate that you might be DMA'ing beyond your buffer.

Another possibility would be if the requests from the PLX have a
different initiator ID on the bus than the device you are setting up
the DMA for.

> All sources are based on PLX SDK 7.25.
> Note: Sample test is in user space. It allocates memory and starts
> DMA
> through PLX API.
> The original sample NT_DmaTest does DMA between BARx and Host memory.
> I change this for simple: Allocate two host memory buffers and try to
> do DMA
> between them.
> 
> Device probe
> ===========
> (Driver/Source.Plx8000_DMA/Driver.c)
> 
> int
> AddDevice(
>     DRIVER_OBJECT  *pDriverObject,
>     struct pci_dev *pPciDev
>     )
> {
>     U8                channel;
>     int               status;
>     U32               RegValue;
>     DEVICE_OBJECT    *fdo;
>     DEVICE_OBJECT    *pDevice;
>     DEVICE_EXTENSION *pdx;
> 
> 
>     // Allocate memory for the device object
>     fdo =
>         kmalloc(
>             sizeof(DEVICE_OBJECT),
>             GFP_KERNEL
>             );
> 
>     if (fdo == NULL)
>     {
>         ErrorPrintf(("ERROR - memory allocation for device object
> failed\n"));
>         return (-ENOMEM);
>     }
> 
>     // Initialize device object
>     RtlZeroMemory( fdo, sizeof(DEVICE_OBJECT) );
> 
>     fdo->DriverObject    = pDriverObject;         // Save parent
> driver
> object
>     fdo->DeviceExtension = &(fdo->DeviceInfo);
> 
>     // Enable the device
>     if (pci_enable_device( pPciDev ) == 0)
>     {
>         DebugPrintf(("Enabled PCI device\n"));
>     }
>     else
>     {
>         ErrorPrintf(("WARNING - PCI device enable failed\n"));
>     }
> 
> #if 1
>     /* New added: Set DMA mask as suggestied on linuxppc */
> {
>     int err;
>     printk("Debug %s: dma_set_mask_and_coherent()...\n", __func__);
>     err = dma_set_mask_and_coherent(&pPciDev->dev, DMA_BIT_MASK(32));
>     if (err != 0) {
>         printk("Error %s: Failed dma_set_mask_and_coherent(). ret =
> %d\n",
> __func__, err);
>         return err;
>     }
> 
> }
> #endif
>     // Enable bus mastering
>     pci_set_master( pPciDev );
> 
>     //
>     // Initialize the device extension
>     //
> 
>     pdx = fdo->DeviceExtension;
> 
>     // Clear device extension
>     RtlZeroMemory( pdx, sizeof(DEVICE_EXTENSION) );
> 
>     // Store parent device object
>     pdx->pDeviceObject = fdo;
> 
>     // Save the OS-supplied PCI object
>     pdx->pPciDevice = pPciDev;
> 
>     // Set initial device device state
>     pdx->State = PLX_STATE_STOPPED;
> 
>     // Set initial power state
>     pdx->PowerState = PowerDeviceD0;
> 
>     // Store device location information
>     pdx->Key.domain       = pci_domain_nr(pPciDev->bus);
>     pdx->Key.bus          = pPciDev->bus->number;
>     pdx->Key.slot         = PCI_SLOT(pPciDev->devfn);
>     pdx->Key.function     = PCI_FUNC(pPciDev->devfn);
>     pdx->Key.DeviceId     = pPciDev->device;
>     pdx->Key.VendorId     = pPciDev->vendor;
>     pdx->Key.SubVendorId  = pPciDev->subsystem_vendor;
>     pdx->Key.SubDeviceId  = pPciDev->subsystem_device;
>     pdx->Key.DeviceNumber = pDriverObject->DeviceCount;
> 
>     // Set API access mode
>     pdx->Key.ApiMode = PLX_API_MODE_PCI;
> 
>     // Update Revision ID
>     PLX_PCI_REG_READ( pdx, PCI_REG_CLASS_REV, &RegValue );
>     pdx->Key.Revision = (U8)(RegValue & 0xFF);
> 
>     // Set device mode
>     pdx->Key.DeviceMode = PLX_CHIP_MODE_STANDARD;
> 
>     // Set PLX-specific port type
>     pdx->Key.PlxPortType = PLX_SPEC_PORT_DMA;
> 
>     // Build device name
>     sprintf(
>         pdx->LinkName,
>         PLX_DRIVER_NAME "-%d",
>         pDriverObject->DeviceCount
>         );
> 
>     // Initialize work queue for ISR DPC queueing
>     PLX_INIT_WORK(
>         &(pdx->Task_DpcForIsr),
>         DpcForIsr,                // DPC routine
>         &(pdx->Task_DpcForIsr)    // DPC parameter (pre-2.6.20 only)
>         );
> 
>     // Initialize ISR spinlock
>     spin_lock_init( &(pdx->Lock_Isr) );
> 
>     // Initialize interrupt wait list
>     INIT_LIST_HEAD( &(pdx->List_WaitObjects) );
>     spin_lock_init( &(pdx->Lock_WaitObjectsList) );
> 
>     // Initialize physical memories list
>     INIT_LIST_HEAD( &(pdx->List_PhysicalMem) );
>     spin_lock_init( &(pdx->Lock_PhysicalMemList) );
> 
>     // Set the DMA mask
>     if (Plx_dma_set_mask( pdx, PLX_DMA_BIT_MASK(48) ) == 0)
>     {
>         DebugPrintf(("Set DMA bit mask to 48-bits\n"));
>     }
>     else
>     {
>         DebugPrintf(("ERROR - Unable to set DMA mask to 48-bits,
> revert to
> 32-bit\n"));
>         Plx_dma_set_mask( pdx, PLX_DMA_BIT_MASK(32) );
>     }
> 
>     // Set buffer allocation mask
>     if (Plx_dma_set_coherent_mask( pdx, PLX_DMA_BIT_MASK(32) ) != 0)
>     {
>         ErrorPrintf(("WARNING - Set DMA coherent mask failed\n"));
>     }
> 
>     // Initialize DMA spinlocks
>     for (channel = 0; channel < MAX_DMA_CHANNELS; channel++)
>     {
>         spin_lock_init( &(pdx->Lock_Dma[channel]) );
>     }
> 
>     //
>     // Add to driver device list
>     //
> 
>     // Acquire Device List lock
>     spin_lock( &(pDriverObject->Lock_DeviceList) );
> 
>     // Get device list head
>     pDevice = pDriverObject->DeviceObject;
> 
>     if (pDevice == NULL)
>     {
>         // Add device as first in list
>         pDriverObject->DeviceObject = fdo;
>     }
>     else
>     {
>         // Go to end of list
>         while (pDevice->NextDevice != NULL)
>         {
>             pDevice = pDevice->NextDevice;
>         }
> 
>         // Add device to end of list
>         pDevice->NextDevice = fdo;
>     }
> 
>     // Increment device count
>     pDriverObject->DeviceCount++;
> 
>     // Release Device List lock
>     spin_unlock( &(pDriverObject->Lock_DeviceList) );
> 
>     DebugPrintf(("Created Device (%s)\n", pdx->LinkName));
> 
>     // Start the device
>     status = StartDevice( fdo );
>     if (status != 0)
>     {
>         RemoveDevice( fdo );
>         return status;
>     }
> 
>     return 0;
> }
> 
> 
> Memory allocate
> ============
> (Driver/Source.Plx8000_DMA/SuppFunc.c)
> 
> /********************************************************************
> ***********
>  *
>  * Function   :  Plx_dma_buffer_alloc
>  *
>  * Description:  Allocates physically contiguous non-paged memory
>  *
>  * Note       :  The function allocates a contiguous block of system
> memory
> and
>  *               marks it as reserved. Marking the memory as reserved
> is
> required
>  *               in case the memory is later mapped to user virtual
> space.
>  *
> 
> *********************************************************************
> *********/
> VOID*
> Plx_dma_buffer_alloc(
>     DEVICE_EXTENSION    *pdx,
>     PLX_PHYS_MEM_OBJECT *pMemObject
>     )
> {
>     dma_addr_t   BusAddress;
>     PLX_UINT_PTR virt_addr;
> 
> 
>     // Verify size
>     if (pMemObject->Size == 0)
>     {
>         ErrorPrintf(("ERROR: Unable to allocate buffer, requested
> size =
> 0\n"));
>         RtlZeroMemory( pMemObject, sizeof(PLX_PHYS_MEM_OBJECT) );
>         return NULL;
>     }
> 
>     /*********************************************************
>      * Attempt to allocate contiguous memory
>      *
>      * Additional flags are specified as follows:
>      *
>      * __GFP_NOWARN : Prevents the kernel from dumping warnings
>      *                about a failed allocation attempt.  The
>      *                PLX driver already handles failures.
>      *
>      * __GFP_REPEAT : Not enabled by default, but may be added
>      *                manually.  It asks the kernel to "try a
>      *                little harder" in the allocation effort.
>      ********************************************************/
>     pMemObject->pKernelVa =
>         Plx_dma_alloc_coherent(
>             pdx,
>             pMemObject->Size,
>             &BusAddress,
>             GFP_KERNEL | __GFP_NOWARN
>             );
> 
>     if (pMemObject->pKernelVa == NULL)
>     {
>         return NULL;
>     }
> 
>     // Store the bus address
>     pMemObject->BusPhysical = (U64)BusAddress;
> 
>     // Tag all pages as reserved
>     for (virt_addr = (PLX_UINT_PTR)pMemObject->pKernelVa;
>          virt_addr < ((PLX_UINT_PTR)pMemObject->pKernelVa +
> pMemObject->Size);
>          virt_addr += PAGE_SIZE)
>     {
>         SetPageReserved(
>             virt_to_page( PLX_INT_TO_PTR(virt_addr) )
>             );
>     }
> 
>     // Get CPU physical address of buffer
>     pMemObject->CpuPhysical =
>         virt_to_phys(
>             pMemObject->pKernelVa
>             );
> 
>     // Clear the buffer
>     RtlZeroMemory(
>         pMemObject->pKernelVa,
>         pMemObject->Size
>         );
> 
>     DebugPrintf(("Allocated physical memory...\n"));
> 
>     DebugPrintf((
>         "    CPU Phys Addr: %08llx\n",
>         pMemObject->CpuPhysical
>         ));
> 
>     DebugPrintf((
>         "    Bus Phys Addr: %08llx\n",
>         pMemObject->BusPhysical
>         ));
> 
>     DebugPrintf((
>         "    Kernel VA    : %p\n",
>         pMemObject->pKernelVa
>         ));
> 
>     DebugPrintf((
>         "    Size         : %Xh (%d%s)\n",
>         pMemObject->Size,
>         (pMemObject->Size > (1 << 30)) ? (pMemObject->Size >> 30) :
>           (pMemObject->Size > (1 << 20)) ? (pMemObject->Size >> 20) :
>           (pMemObject->Size > (1 << 10)) ? (pMemObject->Size >> 10) :
>           pMemObject->Size,
>         (pMemObject->Size > (1 << 30)) ? "GB" :
>           (pMemObject->Size > (1 << 20)) ? "MB" :
>           (pMemObject->Size > (1 << 10)) ? "KB" : "B"
>         ));
> 
>     // Return the kernel virtual address of the allocated block
>     return pMemObject->pKernelVa;
> }
> 
> 
> DMA transfer
> ==========
> (Driver/Source.Plx8000_DMA/ApiFunc.c)
> 
> /********************************************************************
> **********
>  *
>  * Function   :  PlxDmaTransferBlock
>  *
>  * Description:  Performs DMA block transfer
>  *
> 
> *********************************************************************
> *********/
> PLX_STATUS
> PlxDmaTransferBlock(
>     DEVICE_EXTENSION *pdx,
>     U8                channel,
>     PLX_DMA_PARAMS   *pParams,
>     VOID             *pOwner
>     )
> {
>     U16        OffsetDmaBase;
>     U32        RegValue;
>     PLX_STATUS status;
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Verify DMA channel is available
>     status =
>         PlxDmaStatus(
>             pdx,
>             channel,
>             pOwner
>             );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     if (status != PLX_STATUS_COMPLETE)
>     {
>         DebugPrintf(("ERROR - DMA unavailable or in-progress\n"));
>         return status;
>     }
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     DebugPrintf((
>         "Ch %d - DMA %08X_%08X --> %08X_%08X (%d bytes)\n",
>         channel, PLX_64_HIGH_32(pParams->AddrSource),
> PLX_64_LOW_32(pParams->AddrSource),
>         PLX_64_HIGH_32(pParams->AddrDest), PLX_64_LOW_32(pParams-
> >AddrDest),
>         pParams->ByteCount
>         ));
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Set the channel's base register offset (200h, 300h, etc)
>     OffsetDmaBase = 0x200 + (channel * 0x100);
> 
>     spin_lock(
>         &(pdx->Lock_Dma[channel])
>         );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Write Source Address
>     PLX_DMA_REG_WRITE( pdx, OffsetDmaBase + 0x0,
> PLX_64_LOW_32(pParams->AddrSource) );
>     PLX_DMA_REG_WRITE( pdx, OffsetDmaBase + 0x4,
> PLX_64_HIGH_32(pParams->AddrSource) );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Write Destination Address
>     PLX_DMA_REG_WRITE( pdx, OffsetDmaBase + 0x8,
> PLX_64_LOW_32(pParams->AddrDest) );
>     PLX_DMA_REG_WRITE( pdx, OffsetDmaBase + 0xC,
> PLX_64_HIGH_32(pParams->AddrDest) );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Set Transfer Count & address & interrupt options
>     RegValue =
>         (1                       << 31) |   // Valid bit
>         (pParams->bConstAddrSrc  << 29) |   // Keep source address
> constant
>         (pParams->bConstAddrDest << 28) |   // Keep destination
> address
> constant
>         (pParams->ByteCount      <<  0);    // Byte count
>     if (pParams->bIgnoreBlockInt == 0)
>     {
>         RegValue |= (1 << 30);
>     }
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     PLX_DMA_REG_WRITE( pdx, OffsetDmaBase + 0x10, RegValue );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Get DMA control/status
>     RegValue = PLX_DMA_REG_READ( pdx, OffsetDmaBase + 0x38 );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Set DMA to block mode
>     if (pdx->Key.PlxFamily == PLX_FAMILY_SIRIUS)
>     {
>         RegValue &= ~(1 << 4);
>     }
>     else
>     {
>         RegValue &= ~(3 << 5);
>     }
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Make sure descriptor write-back ([2]) is disabled
>     RegValue &= ~(1 << 2);
> 
>     // Clear any active status bits ([31,12:8])
>     RegValue |= ((1 << 31) | (0x1F << 8));
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     spin_unlock(
>         &(pdx->Lock_Dma[channel])
>         );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     DebugPrintf(("Start DMA transfer...\n"));
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     // Start DMA ([3])
>     PLX_DMA_REG_WRITE( pdx, OffsetDmaBase + 0x38, RegValue | (1 << 3)
> );
> 
>     printk("PLX DMA[%s-%d]\n", __func__, __LINE__);
>     return PLX_STATUS_OK;
> }
> 
> Latest dmesg with EEH error
> ======================
> [156541.460091] Plx8000_NT:
> <========================================================>
> [156541.460316] Plx8000_NT: PLX 8000_NT driver v7.25 (64-bit)
> [156541.460365] Plx8000_NT: Supports Linux kernel
> v3.10.0-514.10.2.el7.ppc64le
> [156541.460428] Plx8000_NT: Allocated global driver object
> (c000003c841f0200)
> [156541.460432] Plx8000_NT: Registered driver (MajorID = 247)
> [156541.460463] Plx8000_NT:    --------------------
> [156541.460469] Plx8000_NT: Probe: 8619 10B5 [D1 01:00.1]
> [156541.460482] Plx8000_NT: Probe: -- Unsupported Device --
> [156541.460506] Plx8000_NT:    --------------------
> [156541.460509] Plx8000_NT: Probe: 8619 10B5 [D1 02:01.0]
> [156541.460518] Plx8000_NT: Enabled PCI device
> [156541.460527] Plx8000_NT: Created Device (Plx8000_NT-0)
> [156541.460530] Plx8000_NT: Start: 8619 10B5 [D1 02:01.0]
> [156541.460532] Debug StartDevice 723: Reading PCI header command...
> [156541.460720] Debug StartDevice 725: Reading PCI header command...
> =
> 0x100146
> [156541.460790] Plx8000_NT:    Resource 00
> [156541.460792] Plx8000_NT:      Type     : Memory
> [156541.460798] Plx8000_NT:      PCI BAR 0: 81000000
> [156541.460799] Plx8000_NT:      Phys Addr: 3FE081000000
> [156541.460802] Plx8000_NT:      Size     : 20000h (128KB)
> [156541.460804] Plx8000_NT:      Property : Non-Prefetchable 32-bit
> [156541.460819] Plx8000_NT:      Kernel VA: d000080081480000
> [156541.460822] Debug StartDevice 841: Read BAR0[0xd000080081480000]
> after
> map...
> [156541.460895] Debug StartDevice 843: Read BAR0[0xd000080081480000]
> after
> map... = 0x861910b5
> [156541.460966] Plx8000_NT:    Resource 01
> [156541.460967] Plx8000_NT:      Type     : Memory
> [156541.460973] Plx8000_NT:      PCI BAR 2: 80000000
> [156541.460974] Plx8000_NT:      Phys Addr: 3FE080000000
> [156541.460976] Plx8000_NT:      Size     : 400000h (4MB)
> [156541.460978] Plx8000_NT:      Property : Non-Prefetchable 32-bit
> [156541.460983] Plx8000_NT:      Kernel VA: d000080084000000
> [156541.460985] Debug StartDevice 849: Read BAR2[0xd000080084000000]
> after
> map...
> [156541.461073] Debug StartDevice 851: Read BAR2[0xd000080084000000]
> after
> map... = 0xf000eef3
> [156541.461146] Plx8000_NT:    Resource 02
> [156541.461147] Plx8000_NT:      Type     : Memory
> [156541.461152] Plx8000_NT:      PCI BAR 3: 80400000
> [156541.461154] Plx8000_NT:      Phys Addr: 3FE080400000
> [156541.461156] Plx8000_NT:      Size     : 400000h (4MB)
> [156541.461157] Plx8000_NT:      Property : Non-Prefetchable 32-bit
> [156541.461162] Plx8000_NT:      Kernel VA: d000080084800000
> [156541.461163] Plx8000_NT:    Resource 03
> [156541.461165] Plx8000_NT:      Type     : Memory
> [156541.461170] Plx8000_NT:      PCI BAR 4: 80800000
> [156541.461171] Plx8000_NT:      Phys Addr: 3FE080800000
> [156541.461173] Plx8000_NT:      Size     : 400000h (4MB)
> [156541.461175] Plx8000_NT:      Property : Non-Prefetchable 32-bit
> [156541.461179] Plx8000_NT:      Kernel VA: d000080085000000
> [156541.461180] Plx8000_NT:    Resource 04
> [156541.461182] Plx8000_NT:      Type     : Memory
> [156541.461187] Plx8000_NT:      PCI BAR 5: 80C00000
> [156541.461188] Plx8000_NT:      Phys Addr: 3FE080C00000
> [156541.461190] Plx8000_NT:      Size     : 400000h (4MB)
> [156541.461192] Plx8000_NT:      Property : Non-Prefetchable 32-bit
> [156541.461196] Plx8000_NT:      Kernel VA: d000080085800000
> [156541.461198] Debug StartDevice 862: Reading PCI header command...
> [156541.461261] Debug StartDevice 864: Reading PCI header command...
> =
> 0x100146
> [156541.461409] Plx8000_NT: Device 8619_10B5 = 8619 rev BA
> [156541.461412] Plx8000_NT: Device in NT LEGACY mode
> [156541.461414] Debug StartDevice 891: Read BAR0[0xd000080081480000]
> before
> PlxDetermineNtPortSide...
> [156541.461497] Debug StartDevice 893: Read BAR0[0xd000080081480000]
> before
> PlxDetermineNtPortSide map... = 0x861910b5
> [156541.461595] Plx8000_NT: NT port is VIRTUAL-side (NT base=10000h)
> [156541.461597] Debug StartDevice 901: Read BAR0[0xd000080081480000]
> after
> PlxDetermineNtPortSide...
> [156541.461684] Debug StartDevice 903: Read BAR0[0xd000080081480000]
> after
> PlxDetermineNtPortSide map... = 0x861910b5
> [156541.461834] Plx8000_NT: MSI enabled, change IRQ 249 --> 499
> [156541.461836] Plx8000_NT:    Resource 05
> [156541.461838] Plx8000_NT:      Type     : Interrupt (MSI)
> [156541.461840] Plx8000_NT:      IRQ      : 499 [1F3h]
> [156541.461850] Plx8000_NT:      MSI Addr : 10000000
> [156541.461855] Plx8000_NT: _00000000
> [156541.461860] Plx8000_NT:      MSI Data : 0001
> [156541.461878] Plx8000_NT: Installed ISR for interrupt
> [156541.461895] Plx8000_NT:    --------------------
> [156541.461899] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.1]
> [156541.461909] Plx8000_NT: Probe: -- Unsupported Device --
> [156541.461916] Plx8000_NT:    --------------------
> [156541.461918] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.2]
> [156541.461925] Plx8000_NT: Probe: -- Unsupported Device --
> [156541.461931] Plx8000_NT:    --------------------
> [156541.461933] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.3]
> [156541.461940] Plx8000_NT: Probe: -- Unsupported Device --
> [156541.461946] Plx8000_NT:    --------------------
> [156541.461948] Plx8000_NT: Probe: 87D0 10B5 [D3 01:00.4]
> [156541.461956] Plx8000_NT: Probe: -- Unsupported Device --
> [156541.461984] Plx8000_NT: Attempt to allocate physical memory (8KB)
> [156541.461999] Plx8000_NT: Allocated physical memory...
> [156541.462001] Plx8000_NT:     CPU Phys Addr: 1f87000000
> [156541.462002] Plx8000_NT:     Bus Phys Addr: 60df0000
> [156541.462004] Plx8000_NT:     Kernel VA    : c000001f87000000
> [156541.462006] Plx8000_NT:     Size         : 2000h (8KB)
> [156541.462008] Plx8000_NT:    --------------------
> [156541.462009] Plx8000_NT: Added: 1 device
> [156541.462011] Plx8000_NT: ...driver loaded
> 
> 
> [156542.961942] Plx8000_DMA:
> <========================================================>
> [156542.962168] Plx8000_DMA: PLX 8000_DMA driver v7.25 (64-bit)
> [156542.962227] Plx8000_DMA: Supports Linux kernel
> v3.10.0-514.10.2.el7.ppc64le
> [156542.962301] Plx8000_DMA: Allocated global driver object
> (c000003c834af800)
> [156542.962543] Plx8000_DMA: Registered driver (MajorID = 246)
> [156542.962616] Plx8000_DMA:    --------------------
> [156542.962668] Plx8000_DMA: Probe: 8619 10B5 [D1 01:00.1]
> [156542.962724] Plx8000_DMA: Enabled PCI device
> [156542.962772] Debug AddDevice: dma_set_mask_and_coherent()...
> [156542.962836] PLX 8000 DMA Driver 0001:01:00.1: Using 32-bit DMA
> via iommu
> [156542.962901] PLX 8000 DMA Driver 0001:01:00.1: Using 32-bit DMA
> via iommu
> [156542.962959] Plx8000_DMA: Set DMA bit mask to 48-bits
> [156542.963006] Plx8000_DMA: Created Device (Plx8000_DMA-0)
> [156542.963054] Plx8000_DMA: Start: 8619 10B5 [D1 01:00.1]
> [156542.963102] Plx8000_DMA:    Resource 00
> [156542.963138] Plx8000_DMA:      Type     : Memory
> [156542.963189] Plx8000_DMA:      PCI BAR 0: 81820000
> [156542.963236] Plx8000_DMA:      Phys Addr: 3FE081820000
> [156542.963284] Plx8000_DMA:      Size     : 20000h (128KB)
> [156542.963332] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
> [156542.963395] Plx8000_DMA:      Kernel VA: d0000800814c0000
> [156542.963489] Plx8000_DMA: Device 8619_10B5 = 8619 rev BA
> [156542.963583] Plx8000_DMA: MSI enabled, change IRQ 249 --> 500
> [156542.963642] Plx8000_DMA:    Resource 01
> [156542.963679] Plx8000_DMA:      Type     : Interrupt (MSI)
> [156542.963727] Plx8000_DMA:      IRQ      : 500 [1F4h]
> [156542.963782] Plx8000_DMA:      MSI Addr : 10000000
> [156542.963832] Plx8000_DMA: _00000000
> [156542.963882] Plx8000_DMA:      MSI Data : 0002
> [156542.963941] Plx8000_DMA: Installed ISR for interrupt
> [156542.964013] Plx8000_DMA:    --------------------
> [156542.964070] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.1]
> [156542.964142] Plx8000_DMA: Enabled PCI device
> [156542.964191] Debug AddDevice: dma_set_mask_and_coherent()...
> [156542.964255] PLX 8000 DMA Driver 0003:01:00.1: Using 32-bit DMA
> via iommu
> [156542.964324] PLX 8000 DMA Driver 0003:01:00.1: Using 32-bit DMA
> via iommu
> [156542.964385] Plx8000_DMA: Set DMA bit mask to 48-bits
> [156542.964432] Plx8000_DMA: Created Device (Plx8000_DMA-1)
> [156542.964482] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.1]
> [156542.964528] Plx8000_DMA:    Resource 00
> [156542.964564] Plx8000_DMA:      Type     : Memory
> [156542.964617] Plx8000_DMA:      PCI BAR 0: 83040000
> [156542.964666] Plx8000_DMA:      Phys Addr: 3FE883040000
> [156542.964716] Plx8000_DMA:      Size     : 2000h (8KB)
> [156542.964766] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
> [156542.964857] Plx8000_DMA:      Kernel VA: d000080081500000
> [156542.964996] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
> [156542.965096] Plx8000_DMA: MSI enabled, change IRQ 251 --> 272
> [156542.965157] Plx8000_DMA:    Resource 01
> [156542.965193] Plx8000_DMA:      Type     : Interrupt (MSI)
> [156542.965239] Plx8000_DMA:      IRQ      : 272 [110h]
> [156542.965296] Plx8000_DMA:      MSI Addr : 10000000
> [156542.965349] Plx8000_DMA: _00000000
> [156542.965403] Plx8000_DMA:      MSI Data : 0010
> [156542.965481] Plx8000_DMA: Installed ISR for interrupt
> [156542.965537] Plx8000_DMA:    --------------------
> [156542.965587] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.2]
> [156542.965642] Plx8000_DMA: Enabled PCI device
> [156542.965726] Debug AddDevice: dma_set_mask_and_coherent()...
> [156542.965790] PLX 8000 DMA Driver 0003:01:00.2: Using 32-bit DMA
> via iommu
> [156542.965884] PLX 8000 DMA Driver 0003:01:00.2: Using 32-bit DMA
> via iommu
> [156542.965948] Plx8000_DMA: Set DMA bit mask to 48-bits
> [156542.966026] Plx8000_DMA: Created Device (Plx8000_DMA-2)
> [156542.966077] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.2]
> [156542.966153] Plx8000_DMA:    Resource 00
> [156542.966190] Plx8000_DMA:      Type     : Memory
> [156542.966245] Plx8000_DMA:      PCI BAR 0: 83042000
> [156542.966329] Plx8000_DMA:      Phys Addr: 3FE883042000
> [156542.966395] Plx8000_DMA:      Size     : 2000h (8KB)
> [156542.966466] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
> [156542.966531] Plx8000_DMA:      Kernel VA: d000080081522000
> [156542.986063] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
> [156543.012909] Plx8000_DMA: MSI enabled, change IRQ 251 --> 273
> [156543.033885] Plx8000_DMA:    Resource 01
> [156543.051045] Plx8000_DMA:      Type     : Interrupt (MSI)
> [156543.058139] Plx8000_DMA:      IRQ      : 273 [111h]
> [156543.081938] Plx8000_DMA:      MSI Addr : 10000000
> [156543.151285] Plx8000_DMA: _00000000
> [156543.151340] Plx8000_DMA:      MSI Data : 0011
> [156543.175049] Plx8000_DMA: Installed ISR for interrupt
> [156543.199076] Plx8000_DMA:    --------------------
> [156543.228325] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.3]
> [156543.266237] Plx8000_DMA: Enabled PCI device
> [156543.266287] Debug AddDevice: dma_set_mask_and_coherent()...
> [156543.284766] PLX 8000 DMA Driver 0003:01:00.3: Using 32-bit DMA
> via iommu
> [156543.302570] PLX 8000 DMA Driver 0003:01:00.3: Using 32-bit DMA
> via iommu
> [156543.338986] Plx8000_DMA: Set DMA bit mask to 48-bits
> [156543.356741] Plx8000_DMA: Created Device (Plx8000_DMA-3)
> [156543.385337] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.3]
> [156543.385384] Plx8000_DMA:    Resource 00
> [156543.401548] Plx8000_DMA:      Type     : Memory
> [156543.416851] Plx8000_DMA:      PCI BAR 0: 83044000
> [156543.432384] Plx8000_DMA:      Phys Addr: 3FE883044000
> [156543.447424] Plx8000_DMA:      Size     : 2000h (8KB)
> [156543.462876] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
> [156543.502837] Plx8000_DMA:      Kernel VA: d000080081544000
> [156543.522190] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
> [156543.536863] Plx8000_DMA: MSI enabled, change IRQ 251 --> 274
> [156543.536923] Plx8000_DMA:    Resource 01
> [156543.558229] Plx8000_DMA:      Type     : Interrupt (MSI)
> [156543.579107] Plx8000_DMA:      IRQ      : 274 [112h]
> [156543.593668] Plx8000_DMA:      MSI Addr : 10000000
> [156543.607511] Plx8000_DMA: _00000000
> [156543.622554] Plx8000_DMA:      MSI Data : 0012
> [156543.622630] Plx8000_DMA: Installed ISR for interrupt
> [156543.645996] Plx8000_DMA:    --------------------
> [156543.659853] Plx8000_DMA: Probe: 87D0 10B5 [D3 01:00.4]
> [156543.667360] Plx8000_DMA: Enabled PCI device
> [156543.681660] Debug AddDevice: dma_set_mask_and_coherent()...
> [156543.695406] PLX 8000 DMA Driver 0003:01:00.4: Using 32-bit DMA
> via iommu
> [156543.709749] PLX 8000 DMA Driver 0003:01:00.4: Using 32-bit DMA
> via iommu
> [156543.723734] Plx8000_DMA: Set DMA bit mask to 48-bits
> [156543.744728] Plx8000_DMA: Created Device (Plx8000_DMA-4)
> [156543.758804] Plx8000_DMA: Start: 87D0 10B5 [D3 01:00.4]
> [156543.773284] Plx8000_DMA:    Resource 00
> [156543.773322] Plx8000_DMA:      Type     : Memory
> [156543.791508] Plx8000_DMA:      PCI BAR 0: 83046000
> [156543.805245] Plx8000_DMA:      Phys Addr: 3FE883046000
> [156543.819215] Plx8000_DMA:      Size     : 2000h (8KB)
> [156543.833571] Plx8000_DMA:      Property : Non-Prefetchable 32-bit
> [156543.847515] Plx8000_DMA:      Kernel VA: d000080081566000
> [156543.886524] Plx8000_DMA: Device 87D0_10B5 = 8725 rev CA
> [156543.906770] Plx8000_DMA: MSI enabled, change IRQ 251 --> 275
> [156543.924546] Plx8000_DMA:    Resource 01
> [156543.938587] Plx8000_DMA:      Type     : Interrupt (MSI)
> [156543.938637] Plx8000_DMA:      IRQ      : 275 [113h]
> [156543.959460] Plx8000_DMA:      MSI Addr : 10000000
> [156543.974286] Plx8000_DMA: _00000000
> [156543.989775] Plx8000_DMA:      MSI Data : 0013
> [156544.005015] Plx8000_DMA: Installed ISR for interrupt
> [156544.018303] Plx8000_DMA: Attempt to allocate physical memory
> (64KB)
> [156544.040309] Plx8000_DMA: Allocated physical memory...
> [156544.069896] Plx8000_DMA:     CPU Phys Addr: 1fc3dd0000
> [156544.136502] Plx8000_DMA:     Bus Phys Addr: 60030000
> [156544.136551] Plx8000_DMA:     Kernel VA    : c000001fc3dd0000
> [156544.183572] Plx8000_DMA:     Size         : 10000h (64KB)
> [156544.222978] Plx8000_DMA:    --------------------
> [156544.253033] Plx8000_DMA: Added: 5 devices
> [156544.296043] Plx8000_DMA: ...driver loaded
> 
> [156562.531757] Plx8000_NT: 
> [156562.531762] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156562.531764] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156562.531766] Plx8000_NT: ...device opened
> [156562.531769] Plx8000_NT: 
> [156562.531771] Plx8000_NT: Received PLX message ===> 
> [156562.531772] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156562.531774] Plx8000_NT: ...Completed message
> [156562.531776] Plx8000_NT: 
> [156562.531777] Plx8000_NT: Received PLX message ===> 
> [156562.531779] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.531782] Plx8000_NT: Criteria matched device 8619_10B5
> [02:01.0]
> [156562.531783] Plx8000_NT: ...Completed message
> [156562.531787] Plx8000_NT: 
> [156562.531788] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156562.531790] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156562.531792] Plx8000_NT: ...device closed
> [156562.531798] Plx8000_NT: 
> [156562.531799] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156562.531801] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156562.531802] Plx8000_NT: ...device opened
> [156562.531805] Plx8000_NT: 
> [156562.531806] Plx8000_NT: Received PLX message ===> 
> [156562.531807] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156562.531809] Plx8000_NT: ...Completed message
> [156562.531814] Plx8000_NT: 
> [156562.531815] Plx8000_NT: Received PLX message ===> 
> [156562.531816] Plx8000_NT: PLX_IOCTL_GET_PORT_PROPERTIES
> [156562.531861] Plx8000_NT: [D1 02:01.0] P=1 T=0 MPS=512/2048 MRR=128
> L=G2x4/G2x8
> [156562.531863] Plx8000_NT: ...Completed message
> [156562.531866] Plx8000_NT: 
> [156562.531867] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156562.531869] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156562.531870] Plx8000_NT: ...device closed
> [156562.531898] Plx8000_NT: 
> [156562.531899] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156562.531901] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156562.531902] Plx8000_NT: ...device opened
> [156562.531905] Plx8000_NT: 
> [156562.531906] Plx8000_NT: Received PLX message ===> 
> [156562.531907] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156562.531909] Plx8000_NT: ...Completed message
> [156562.531911] Plx8000_NT: 
> [156562.531912] Plx8000_NT: Received PLX message ===> 
> [156562.531913] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.531915] Plx8000_NT: Criteria did not match any devices
> [156562.531916] Plx8000_NT: ...Completed message
> [156562.531919] Plx8000_NT: 
> [156562.531920] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156562.531922] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156562.531923] Plx8000_NT: ...device closed
> [156562.531930] Plx8000_DMA: 
> [156562.532042] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156562.532211] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156562.532256] Plx8000_DMA: ...device opened
> [156562.532294] Plx8000_DMA: 
> [156562.532320] Plx8000_DMA: Received PLX message ===> 
> [156562.532409] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156562.532592] Plx8000_DMA: ...Completed message
> [156562.532641] PLX DMA[Dispatch_IoControl-1053]
> [156562.532688] PLX DMA[Dispatch_IoControl-1061]
> [156562.532736] Plx8000_DMA: 
> [156562.532762] Plx8000_DMA: Received PLX message ===> 
> [156562.532809] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.532871] Plx8000_DMA: Criteria matched device 8619_10B5
> [01:00.1]
> [156562.532932] Plx8000_DMA: ...Completed message
> [156562.532979] PLX DMA[Dispatch_IoControl-1053]
> [156562.533027] PLX DMA[Dispatch_IoControl-1061]
> [156562.533077] Plx8000_DMA: 
> [156562.533102] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156562.533151] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156562.533199] Plx8000_DMA: ...device closed
> [156562.533239] Plx8000_DMA: 
> [156562.533263] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156562.533313] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156562.533362] Plx8000_DMA: ...device opened
> [156562.533399] Plx8000_DMA: 
> [156562.533425] Plx8000_DMA: Received PLX message ===> 
> [156562.533473] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156562.533532] Plx8000_DMA: ...Completed message
> [156562.533581] PLX DMA[Dispatch_IoControl-1053]
> [156562.533628] PLX DMA[Dispatch_IoControl-1061]
> [156562.533677] Plx8000_DMA: 
> [156562.533701] Plx8000_DMA: Received PLX message ===> 
> [156562.533746] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
> [156562.533838] Plx8000_DMA: [D1 01:00.1] P=0 T=0 MPS=512/2048
> MRR=512
> L=G2x8/G2x8
> [156562.533910] Plx8000_DMA: ...Completed message
> [156562.533956] PLX DMA[Dispatch_IoControl-1053]
> [156562.534002] PLX DMA[Dispatch_IoControl-1061]
> [156562.534050] Plx8000_DMA: 
> [156562.534075] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156562.534122] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156562.534169] Plx8000_DMA: ...device closed
> [156562.534233] Plx8000_NT: 
> [156562.534235] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156562.534236] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156562.534238] Plx8000_NT: ...device opened
> [156562.534240] Plx8000_NT: 
> [156562.534242] Plx8000_NT: Received PLX message ===> 
> [156562.534243] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156562.534244] Plx8000_NT: ...Completed message
> [156562.534246] Plx8000_NT: 
> [156562.534247] Plx8000_NT: Received PLX message ===> 
> [156562.534249] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.534250] Plx8000_NT: Criteria did not match any devices
> [156562.534251] Plx8000_NT: ...Completed message
> [156562.534254] Plx8000_NT: 
> [156562.534255] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156562.534257] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156562.534258] Plx8000_NT: ...device closed
> [156562.534263] Plx8000_DMA: 
> [156562.534287] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156562.534335] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156562.534383] Plx8000_DMA: ...device opened
> [156562.534421] Plx8000_DMA: 
> [156562.534446] Plx8000_DMA: Received PLX message ===> 
> [156562.534495] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156562.534553] Plx8000_DMA: ...Completed message
> [156562.534600] PLX DMA[Dispatch_IoControl-1053]
> [156562.534649] PLX DMA[Dispatch_IoControl-1061]
> [156562.534697] Plx8000_DMA: 
> [156562.534721] Plx8000_DMA: Received PLX message ===> 
> [156562.534769] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.534829] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.1]
> [156562.534889] Plx8000_DMA: ...Completed message
> [156562.534937] PLX DMA[Dispatch_IoControl-1053]
> [156562.534986] PLX DMA[Dispatch_IoControl-1061]
> [156562.535036] Plx8000_DMA: 
> [156562.535060] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156562.535106] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156562.535155] Plx8000_DMA: ...device closed
> [156562.535194] Plx8000_DMA: 
> [156562.535221] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156562.535269] Plx8000_DMA: Open device (Plx8000_DMA-1)...
> [156562.535331] Plx8000_DMA: ...device opened
> [156562.535378] Plx8000_DMA: 
> [156562.535404] Plx8000_DMA: Received PLX message ===> 
> [156562.535452] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156562.535511] Plx8000_DMA: ...Completed message
> [156562.535560] PLX DMA[Dispatch_IoControl-1053]
> [156562.535650] PLX DMA[Dispatch_IoControl-1061]
> [156562.535705] Plx8000_DMA: 
> [156562.535730] Plx8000_DMA: Received PLX message ===> 
> [156562.535801] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
> [156562.535928] Plx8000_DMA: [D3 01:00.1] P=0 T=0 MPS=128/2048
> MRR=512
> L=G3x8/G3x8
> [156562.536001] Plx8000_DMA: ...Completed message
> [156562.536077] PLX DMA[Dispatch_IoControl-1053]
> [156562.536147] PLX DMA[Dispatch_IoControl-1061]
> [156562.536218] Plx8000_DMA: 
> [156562.536243] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156562.536302] Plx8000_DMA: Close device (Plx8000_DMA-1)...
> [156562.546438] Plx8000_DMA: ...device closed
> [156562.570813] Plx8000_NT: 
> [156562.570815] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156562.570817] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156562.570818] Plx8000_NT: ...device opened
> [156562.570821] Plx8000_NT: 
> [156562.570822] Plx8000_NT: Received PLX message ===> 
> [156562.570823] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156562.570825] Plx8000_NT: ...Completed message
> [156562.570827] Plx8000_NT: 
> [156562.570828] Plx8000_NT: Received PLX message ===> 
> [156562.570829] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.570831] Plx8000_NT: Criteria did not match any devices
> [156562.570832] Plx8000_NT: ...Completed message
> [156562.570835] Plx8000_NT: 
> [156562.570836] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156562.570838] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156562.570839] Plx8000_NT: ...device closed
> [156562.570844] Plx8000_DMA: 
> [156562.570872] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156562.584646] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156562.608579] Plx8000_DMA: ...device opened
> [156562.622863] Plx8000_DMA: 
> [156562.622889] Plx8000_DMA: Received PLX message ===> 
> [156562.635962] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156562.656582] Plx8000_DMA: ...Completed message
> [156562.669725] PLX DMA[Dispatch_IoControl-1053]
> [156562.669775] PLX DMA[Dispatch_IoControl-1061]
> [156562.690495] Plx8000_DMA: 
> [156562.716736] Plx8000_DMA: Received PLX message ===> 
> [156562.716786] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156562.729952] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.2]
> [156562.747900] Plx8000_DMA: ...Completed message
> [156562.761509] PLX DMA[Dispatch_IoControl-1053]
> [156562.781887] PLX DMA[Dispatch_IoControl-1061]
> [156562.795281] Plx8000_DMA: 
> [156562.795310] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156562.809295] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156562.828996] Plx8000_DMA: ...device closed
> [156562.843210] Plx8000_DMA: 
> [156562.843236] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156562.856779] Plx8000_DMA: Open device (Plx8000_DMA-2)...
> [156562.880503] Plx8000_DMA: ...device opened
> [156562.894602] Plx8000_DMA: 
> [156562.894626] Plx8000_DMA: Received PLX message ===> 
> [156562.908203] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156562.922109] Plx8000_DMA: ...Completed message
> [156562.945318] PLX DMA[Dispatch_IoControl-1053]
> [156562.959849] PLX DMA[Dispatch_IoControl-1061]
> [156562.959898] Plx8000_DMA: 
> [156562.973546] Plx8000_DMA: Received PLX message ===> 
> [156562.987656] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
> [156563.002661] Plx8000_DMA: [D3 01:00.2] P=0 T=0 MPS=128/2048
> MRR=512
> L=G3x8/G3x8
> [156563.026654] Plx8000_DMA: ...Completed message
> [156563.040343] PLX DMA[Dispatch_IoControl-1053]
> [156563.040389] PLX DMA[Dispatch_IoControl-1061]
> [156563.054462] Plx8000_DMA: 
> [156563.069658] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156563.090858] Plx8000_DMA: Close device (Plx8000_DMA-2)...
> [156563.105070] Plx8000_DMA: ...device closed
> [156563.105135] Plx8000_NT: 
> [156563.105136] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156563.105137] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156563.105139] Plx8000_NT: ...device opened
> [156563.105141] Plx8000_NT: 
> [156563.105142] Plx8000_NT: Received PLX message ===> 
> [156563.105143] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156563.105144] Plx8000_NT: ...Completed message
> [156563.105145] Plx8000_NT: 
> [156563.105146] Plx8000_NT: Received PLX message ===> 
> [156563.105147] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156563.105148] Plx8000_NT: Criteria did not match any devices
> [156563.105150] Plx8000_NT: ...Completed message
> [156563.105152] Plx8000_NT: 
> [156563.105153] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156563.105154] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156563.105155] Plx8000_NT: ...device closed
> [156563.105159] Plx8000_DMA: 
> [156563.118343] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156563.138958] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156563.156417] Plx8000_DMA: ...device opened
> [156563.156454] Plx8000_DMA: 
> [156563.170984] Plx8000_DMA: Received PLX message ===> 
> [156563.191831] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156563.205911] Plx8000_DMA: ...Completed message
> [156563.205956] PLX DMA[Dispatch_IoControl-1053]
> [156563.225683] PLX DMA[Dispatch_IoControl-1061]
> [156563.239309] Plx8000_DMA: 
> [156563.239332] Plx8000_DMA: Received PLX message ===> 
> [156563.253748] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156563.267644] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.3]
> [156563.288620] Plx8000_DMA: ...Completed message
> [156563.342195] PLX DMA[Dispatch_IoControl-1053]
> [156563.361609] PLX DMA[Dispatch_IoControl-1061]
> [156563.361667] Plx8000_DMA: 
> [156563.385195] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156563.413351] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156563.442696] Plx8000_DMA: ...device closed
> [156563.463349] Plx8000_DMA: 
> [156563.463383] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156563.482592] Plx8000_DMA: Open device (Plx8000_DMA-3)...
> [156563.522918] Plx8000_DMA: ...device opened
> [156563.552722] Plx8000_DMA: 
> [156563.552751] Plx8000_DMA: Received PLX message ===> 
> [156563.571726] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156563.602616] Plx8000_DMA: ...Completed message
> [156563.625686] PLX DMA[Dispatch_IoControl-1053]
> [156563.625735] PLX DMA[Dispatch_IoControl-1061]
> [156563.653003] Plx8000_DMA: 
> [156563.682700] Plx8000_DMA: Received PLX message ===> 
> [156563.682748] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
> [156563.698771] Plx8000_DMA: [D3 01:00.3] P=0 T=0 MPS=128/2048
> MRR=512
> L=G3x8/G3x8
> [156563.753133] Plx8000_DMA: ...Completed message
> [156563.773272] PLX DMA[Dispatch_IoControl-1053]
> [156563.773321] PLX DMA[Dispatch_IoControl-1061]
> [156563.787388] Plx8000_DMA: 
> [156563.787415] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156563.801760] Plx8000_DMA: Close device (Plx8000_DMA-3)...
> [156563.815276] Plx8000_DMA: ...device closed
> [156563.839004] Plx8000_NT: 
> [156563.839006] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156563.839008] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156563.839010] Plx8000_NT: ...device opened
> [156563.839012] Plx8000_NT: 
> [156563.839014] Plx8000_NT: Received PLX message ===> 
> [156563.839015] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156563.839017] Plx8000_NT: ...Completed message
> [156563.839019] Plx8000_NT: 
> [156563.839020] Plx8000_NT: Received PLX message ===> 
> [156563.839022] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156563.839023] Plx8000_NT: Criteria did not match any devices
> [156563.839025] Plx8000_NT: ...Completed message
> [156563.839027] Plx8000_NT: 
> [156563.839029] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156563.839030] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156563.839032] Plx8000_NT: ...device closed
> [156563.839038] Plx8000_DMA: 
> [156563.853847] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156563.867182] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156563.867230] Plx8000_DMA: ...device opened
> [156563.887836] Plx8000_DMA: 
> [156563.901487] Plx8000_DMA: Received PLX message ===> 
> [156563.931748] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156563.931806] Plx8000_DMA: ...Completed message
> [156563.945807] PLX DMA[Dispatch_IoControl-1053]
> [156563.969968] PLX DMA[Dispatch_IoControl-1061]
> [156563.985037] Plx8000_DMA: 
> [156563.985063] Plx8000_DMA: Received PLX message ===> 
> [156563.998669] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156564.013716] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.4]
> [156564.036795] Plx8000_DMA: ...Completed message
> [156564.051283] PLX DMA[Dispatch_IoControl-1053]
> [156564.067066] PLX DMA[Dispatch_IoControl-1061]
> [156564.067120] Plx8000_DMA: 
> [156564.081454] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156564.106002] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156564.120673] Plx8000_DMA: ...device closed
> [156564.120717] Plx8000_DMA: 
> [156564.135396] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156564.155769] Plx8000_DMA: Open device (Plx8000_DMA-4)...
> [156564.169952] Plx8000_DMA: ...device opened
> [156564.170075] Plx8000_DMA: 
> [156564.184096] Plx8000_DMA: Received PLX message ===> 
> [156564.218424] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156564.241590] Plx8000_DMA: ...Completed message
> [156564.241637] PLX DMA[Dispatch_IoControl-1053]
> [156564.267168] PLX DMA[Dispatch_IoControl-1061]
> [156564.284546] Plx8000_DMA: 
> [156564.299010] Plx8000_DMA: Received PLX message ===> 
> [156564.299054] Plx8000_DMA: PLX_IOCTL_GET_PORT_PROPERTIES
> [156564.342078] Plx8000_DMA: [D3 01:00.4] P=0 T=0 MPS=128/2048
> MRR=512
> L=G3x8/G3x8
> [156564.381570] Plx8000_DMA: ...Completed message
> [156564.381615] PLX DMA[Dispatch_IoControl-1053]
> [156564.413790] PLX DMA[Dispatch_IoControl-1061]
> [156564.434488] Plx8000_DMA: 
> [156564.434512] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156564.456071] Plx8000_DMA: Close device (Plx8000_DMA-4)...
> [156564.481577] Plx8000_DMA: ...device closed
> [156564.496407] Plx8000_NT: 
> [156564.496409] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156564.496410] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156564.496411] Plx8000_NT: ...device opened
> [156564.496413] Plx8000_NT: 
> [156564.496415] Plx8000_NT: Received PLX message ===> 
> [156564.496415] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156564.496416] Plx8000_NT: ...Completed message
> [156564.496418] Plx8000_NT: 
> [156564.496419] Plx8000_NT: Received PLX message ===> 
> [156564.496420] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156564.496421] Plx8000_NT: Criteria did not match any devices
> [156564.496422] Plx8000_NT: ...Completed message
> [156564.496425] Plx8000_NT: 
> [156564.496426] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156564.496427] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156564.496428] Plx8000_NT: ...device closed
> [156564.496432] Plx8000_DMA: 
> [156564.496456] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156564.514010] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156564.535514] Plx8000_DMA: ...device opened
> [156564.549372] Plx8000_DMA: 
> [156564.564439] Plx8000_DMA: Received PLX message ===> 
> [156564.564487] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156564.578562] Plx8000_DMA: ...Completed message
> [156564.599768] PLX DMA[Dispatch_IoControl-1053]
> [156564.614704] PLX DMA[Dispatch_IoControl-1061]
> [156564.614754] Plx8000_DMA: 
> [156564.628538] Plx8000_DMA: Received PLX message ===> 
> [156564.646209] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156564.660652] Plx8000_DMA: Criteria did not match any devices
> [156564.682553] Plx8000_DMA: ...Completed message
> [156564.696647] PLX DMA[Dispatch_IoControl-1053]
> [156564.696696] PLX DMA[Dispatch_IoControl-1061]
> [156564.710744] Plx8000_DMA: 
> [156564.732090] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156564.751953] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156564.752004] Plx8000_DMA: ...device closed
> [156568.052329] Plx8000_NT: 
> [156568.052331] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156568.052333] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156568.052335] Plx8000_NT: ...device opened
> [156568.052338] Plx8000_NT: 
> [156568.052339] Plx8000_NT: Received PLX message ===> 
> [156568.052341] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156568.052342] Plx8000_NT: ...Completed message
> [156568.052447] Plx8000_NT: 
> [156568.052449] Plx8000_NT: Received PLX message ===> 
> [156568.052450] Plx8000_NT: PLX_IOCTL_PCI_BAR_PROPERTIES
> [156568.052452] Plx8000_NT:     PCI BAR 2: 80000000
> [156568.052454] Plx8000_NT:     Phys Addr: 3FE080000000
> [156568.052456] Plx8000_NT:     Size     : 400000h (4MB)
> [156568.052458] Plx8000_NT:     Property : Non-Prefetchable 32-bit
> [156568.052460] Plx8000_NT: ...Completed message
> [156568.052507] Plx8000_NT: 
> [156568.052509] Plx8000_NT: Received PLX message ===> 
> [156568.052510] Plx8000_NT: PLX_IOCTL_PCI_BAR_PROPERTIES
> [156568.052512] Plx8000_NT:     PCI BAR 2: 80000000
> [156568.052513] Plx8000_NT:     Phys Addr: 3FE080000000
> [156568.052515] Plx8000_NT:     Size     : 400000h (4MB)
> [156568.052517] Plx8000_NT:     Property : Non-Prefetchable 32-bit
> [156568.052518] Plx8000_NT: ...Completed message
> [156568.052556] Plx8000_NT: 
> [156568.052558] Plx8000_NT: Received message ===> MMAP
> [156568.052559] Plx8000_NT: Map PCI BAR 2...
> [156568.052563] Plx8000_NT: Mapped Phys (3fe080000000) ==> User VA
> (3fff79040000)
> [156568.052564] Plx8000_NT: ...Completed message
> [156568.052623] Plx8000_NT: 
> [156568.052625] Plx8000_NT: Received PLX message ===> 
> [156568.052626] Plx8000_NT: PLX_IOCTL_NT_LUT_ADD
> [156568.052635] Plx8000_NT: Req ID (0000) already exists in LUT #0,
> skipping
> update
> [156568.052636] Plx8000_NT: ...Completed message
> [156568.052673] Plx8000_NT: 
> [156568.052675] Plx8000_NT: Received PLX message ===> 
> [156568.052676] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_ALLOCATE
> [156568.052678] Plx8000_NT: Attempt to allocate physical memory
> (1953KB)
> [156568.053069] Plx8000_NT: Allocated physical memory...
> [156568.053071] Plx8000_NT:     CPU Phys Addr: 1f9e400000
> [156568.053073] Plx8000_NT:     Bus Phys Addr: 60e00000
> [156568.053075] Plx8000_NT:     Kernel VA    : c000001f9e400000
> [156568.053077] Plx8000_NT:     Size         : 1E8480h (1MB)
> [156568.053078] Plx8000_NT: ...Completed message
> [156568.053099] Plx8000_NT: 
> [156568.053100] Plx8000_NT: Received message ===> MMAP
> [156568.053103] Plx8000_NT: Mapped Phys (1f9e400000) ==> User VA
> (3fff78e50000)
> [156568.053105] Plx8000_NT: ...Completed message
> [156568.053119] Plx8000_NT: 
> [156568.053120] Plx8000_NT: Received PLX message ===> 
> [156568.053121] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_ALLOCATE
> [156568.053123] Plx8000_NT: Attempt to allocate physical memory
> (1953KB)
> [156568.053511] Plx8000_NT: Allocated physical memory...
> [156568.053513] Plx8000_NT:     CPU Phys Addr: 1f82c00000
> [156568.053515] Plx8000_NT:     Bus Phys Addr: 61000000
> [156568.053516] Plx8000_NT:     Kernel VA    : c000001f82c00000
> [156568.053518] Plx8000_NT:     Size         : 1E8480h (1MB)
> [156568.053520] Plx8000_NT: ...Completed message
> [156568.053540] Plx8000_NT: 
> [156568.053541] Plx8000_NT: Received message ===> MMAP
> [156568.053544] Plx8000_NT: Mapped Phys (1f82c00000) ==> User VA
> (3fff78c60000)
> [156568.053545] Plx8000_NT: ...Completed message
> [156568.053576] Plx8000_NT: 
> [156568.053577] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156568.053579] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156568.053580] Plx8000_NT: ...device opened
> [156568.053583] Plx8000_NT: 
> [156568.053584] Plx8000_NT: Received PLX message ===> 
> [156568.053585] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156568.053587] Plx8000_NT: ...Completed message
> [156568.053589] Plx8000_NT: 
> [156568.053590] Plx8000_NT: Received PLX message ===> 
> [156568.053591] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.053594] Plx8000_NT: Criteria matched device 8619_10B5
> [02:01.0]
> [156568.053595] Plx8000_NT: ...Completed message
> [156568.053598] Plx8000_NT: 
> [156568.053600] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156568.053601] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156568.053603] Plx8000_NT: ...device closed
> [156568.053608] Plx8000_NT: 
> [156568.053610] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156568.053611] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156568.053613] Plx8000_NT: ...device opened
> [156568.053615] Plx8000_NT: 
> [156568.053616] Plx8000_NT: Received PLX message ===> 
> [156568.053618] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156568.053619] Plx8000_NT: ...Completed message
> [156568.053621] Plx8000_NT: 
> [156568.053622] Plx8000_NT: Received PLX message ===> 
> [156568.053623] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.053625] Plx8000_NT: Criteria did not match any devices
> [156568.053626] Plx8000_NT: ...Completed message
> [156568.053629] Plx8000_NT: 
> [156568.053630] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156568.053632] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156568.053633] Plx8000_NT: ...device closed
> [156568.053638] Plx8000_DMA: 
> [156568.053730] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.053921] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156568.053968] Plx8000_DMA: ...device opened
> [156568.054007] Plx8000_DMA: 
> [156568.054033] Plx8000_DMA: Received PLX message ===> 
> [156568.054081] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.054306] Plx8000_DMA: ...Completed message
> [156568.054356] PLX DMA[Dispatch_IoControl-1053]
> [156568.054404] PLX DMA[Dispatch_IoControl-1061]
> [156568.054451] Plx8000_DMA: 
> [156568.054476] Plx8000_DMA: Received PLX message ===> 
> [156568.054524] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.054583] Plx8000_DMA: Criteria matched device 8619_10B5
> [01:00.1]
> [156568.054643] Plx8000_DMA: ...Completed message
> [156568.054691] PLX DMA[Dispatch_IoControl-1053]
> [156568.054739] PLX DMA[Dispatch_IoControl-1061]
> [156568.054786] Plx8000_DMA: 
> [156568.054810] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.054858] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156568.054904] Plx8000_DMA: ...device closed
> [156568.054945] Plx8000_DMA: 
> [156568.054971] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.055018] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156568.055066] Plx8000_DMA: ...device opened
> [156568.055104] Plx8000_DMA: 
> [156568.055130] Plx8000_DMA: Received PLX message ===> 
> [156568.055180] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.055239] Plx8000_DMA: ...Completed message
> [156568.055312] PLX DMA[Dispatch_IoControl-1053]
> [156568.055364] PLX DMA[Dispatch_IoControl-1061]
> [156568.055422] Plx8000_DMA: 
> [156568.055446] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.055497] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156568.055546] Plx8000_DMA: ...device closed
> [156568.055606] Plx8000_NT: 
> [156568.055608] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156568.055610] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156568.055611] Plx8000_NT: ...device opened
> [156568.055613] Plx8000_NT: 
> [156568.055615] Plx8000_NT: Received PLX message ===> 
> [156568.055616] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156568.055617] Plx8000_NT: ...Completed message
> [156568.055619] Plx8000_NT: 
> [156568.055621] Plx8000_NT: Received PLX message ===> 
> [156568.055622] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.055623] Plx8000_NT: Criteria did not match any devices
> [156568.055624] Plx8000_NT: ...Completed message
> [156568.055627] Plx8000_NT: 
> [156568.055630] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156568.055634] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156568.055636] Plx8000_NT: ...device closed
> [156568.055641] Plx8000_DMA: 
> [156568.055667] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.055717] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156568.055766] Plx8000_DMA: ...device opened
> [156568.055804] Plx8000_DMA: 
> [156568.055828] Plx8000_DMA: Received PLX message ===> 
> [156568.055875] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.055936] Plx8000_DMA: ...Completed message
> [156568.055985] PLX DMA[Dispatch_IoControl-1053]
> [156568.056036] PLX DMA[Dispatch_IoControl-1061]
> [156568.056086] Plx8000_DMA: 
> [156568.056111] Plx8000_DMA: Received PLX message ===> 
> [156568.056160] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.056222] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.1]
> [156568.056282] Plx8000_DMA: ...Completed message
> [156568.056332] PLX DMA[Dispatch_IoControl-1053]
> [156568.056382] PLX DMA[Dispatch_IoControl-1061]
> [156568.056430] Plx8000_DMA: 
> [156568.056455] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.056504] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156568.056554] Plx8000_DMA: ...device closed
> [156568.056595] Plx8000_DMA: 
> [156568.056621] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.056669] Plx8000_DMA: Open device (Plx8000_DMA-1)...
> [156568.056716] Plx8000_DMA: ...device opened
> [156568.056755] Plx8000_DMA: 
> [156568.056781] Plx8000_DMA: Received PLX message ===> 
> [156568.056828] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.056887] Plx8000_DMA: ...Completed message
> [156568.056935] PLX DMA[Dispatch_IoControl-1053]
> [156568.056982] PLX DMA[Dispatch_IoControl-1061]
> [156568.057036] Plx8000_DMA: 
> [156568.057061] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.057110] Plx8000_DMA: Close device (Plx8000_DMA-1)...
> [156568.057158] Plx8000_DMA: ...device closed
> [156568.057233] Plx8000_NT: 
> [156568.057235] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156568.057236] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156568.057238] Plx8000_NT: ...device opened
> [156568.057240] Plx8000_NT: 
> [156568.057241] Plx8000_NT: Received PLX message ===> 
> [156568.057243] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156568.057246] Plx8000_NT: ...Completed message
> [156568.057251] Plx8000_NT: 
> [156568.057253] Plx8000_NT: Received PLX message ===> 
> [156568.057254] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.057257] Plx8000_NT: Criteria did not match any devices
> [156568.057258] Plx8000_NT: ...Completed message
> [156568.057261] Plx8000_NT: 
> [156568.057262] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156568.057264] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156568.057265] Plx8000_NT: ...device closed
> [156568.057270] Plx8000_DMA: 
> [156568.057297] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.057344] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156568.057394] Plx8000_DMA: ...device opened
> [156568.057432] Plx8000_DMA: 
> [156568.057458] Plx8000_DMA: Received PLX message ===> 
> [156568.057506] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.057565] Plx8000_DMA: ...Completed message
> [156568.057614] PLX DMA[Dispatch_IoControl-1053]
> [156568.057661] PLX DMA[Dispatch_IoControl-1061]
> [156568.057712] Plx8000_DMA: 
> [156568.057736] Plx8000_DMA: Received PLX message ===> 
> [156568.057785] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.057846] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.2]
> [156568.071390] Plx8000_DMA: ...Completed message
> [156568.071442] PLX DMA[Dispatch_IoControl-1053]
> [156568.084861] PLX DMA[Dispatch_IoControl-1061]
> [156568.108956] Plx8000_DMA: 
> [156568.108982] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.123073] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156568.137299] Plx8000_DMA: ...device closed
> [156568.157187] Plx8000_DMA: 
> [156568.157212] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.171567] Plx8000_DMA: Open device (Plx8000_DMA-2)...
> [156568.192333] Plx8000_DMA: ...device opened
> [156568.205962] Plx8000_DMA: 
> [156568.222240] Plx8000_DMA: Received PLX message ===> 
> [156568.222290] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.237977] Plx8000_DMA: ...Completed message
> [156568.252826] PLX DMA[Dispatch_IoControl-1053]
> [156568.272657] PLX DMA[Dispatch_IoControl-1061]
> [156568.272716] Plx8000_DMA: 
> [156568.287136] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.301621] Plx8000_DMA: Close device (Plx8000_DMA-2)...
> [156568.336957] Plx8000_DMA: ...device closed
> [156568.391165] Plx8000_NT: 
> [156568.391167] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156568.391169] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156568.391170] Plx8000_NT: ...device opened
> [156568.391172] Plx8000_NT: 
> [156568.391173] Plx8000_NT: Received PLX message ===> 
> [156568.391174] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156568.391176] Plx8000_NT: ...Completed message
> [156568.391178] Plx8000_NT: 
> [156568.391179] Plx8000_NT: Received PLX message ===> 
> [156568.391180] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.391182] Plx8000_NT: Criteria did not match any devices
> [156568.391183] Plx8000_NT: ...Completed message
> [156568.391185] Plx8000_NT: 
> [156568.391186] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156568.391188] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156568.391189] Plx8000_NT: ...device closed
> [156568.391194] Plx8000_DMA: 
> [156568.391220] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.411367] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156568.432257] Plx8000_DMA: ...device opened
> [156568.484646] Plx8000_DMA: 
> [156568.484672] Plx8000_DMA: Received PLX message ===> 
> [156568.508696] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.529863] Plx8000_DMA: ...Completed message
> [156568.557840] PLX DMA[Dispatch_IoControl-1053]
> [156568.557887] PLX DMA[Dispatch_IoControl-1061]
> [156568.592037] Plx8000_DMA: 
> [156568.624958] Plx8000_DMA: Received PLX message ===> 
> [156568.642587] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156568.642647] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.3]
> [156568.712452] Plx8000_DMA: ...Completed message
> [156568.712500] PLX DMA[Dispatch_IoControl-1053]
> [156568.739829] PLX DMA[Dispatch_IoControl-1061]
> [156568.775573] Plx8000_DMA: 
> [156568.775596] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.793855] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156568.823125] Plx8000_DMA: ...device closed
> [156568.837261] Plx8000_DMA: 
> [156568.837284] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156568.850823] Plx8000_DMA: Open device (Plx8000_DMA-3)...
> [156568.870811] Plx8000_DMA: ...device opened
> [156568.883983] Plx8000_DMA: 
> [156568.897485] Plx8000_DMA: Received PLX message ===> 
> [156568.897527] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156568.913771] Plx8000_DMA: ...Completed message
> [156568.927886] PLX DMA[Dispatch_IoControl-1053]
> [156568.947136] PLX DMA[Dispatch_IoControl-1061]
> [156568.961367] Plx8000_DMA: 
> [156568.961391] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156568.974749] Plx8000_DMA: Close device (Plx8000_DMA-3)...
> [156568.989049] Plx8000_DMA: ...device closed
> [156569.008972] Plx8000_NT: 
> [156569.008974] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156569.008975] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156569.008976] Plx8000_NT: ...device opened
> [156569.008978] Plx8000_NT: 
> [156569.008979] Plx8000_NT: Received PLX message ===> 
> [156569.008979] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156569.008980] Plx8000_NT: ...Completed message
> [156569.008982] Plx8000_NT: 
> [156569.008983] Plx8000_NT: Received PLX message ===> 
> [156569.008984] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156569.008985] Plx8000_NT: Criteria did not match any devices
> [156569.008986] Plx8000_NT: ...Completed message
> [156569.008988] Plx8000_NT: 
> [156569.008989] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156569.008990] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156569.008991] Plx8000_NT: ...device closed
> [156569.008995] Plx8000_DMA: 
> [156569.009018] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156569.022988] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156569.038588] Plx8000_DMA: ...device opened
> [156569.064580] Plx8000_DMA: 
> [156569.064603] Plx8000_DMA: Received PLX message ===> 
> [156569.078977] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156569.092497] Plx8000_DMA: ...Completed message
> [156569.112340] PLX DMA[Dispatch_IoControl-1053]
> [156569.125860] PLX DMA[Dispatch_IoControl-1061]
> [156569.125906] Plx8000_DMA: 
> [156569.139408] Plx8000_DMA: Received PLX message ===> 
> [156569.139453] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156569.153404] Plx8000_DMA: Criteria matched device 87D0_10B5
> [01:00.4]
> [156569.173730] Plx8000_DMA: ...Completed message
> [156569.192216] PLX DMA[Dispatch_IoControl-1053]
> [156569.205416] PLX DMA[Dispatch_IoControl-1061]
> [156569.225320] Plx8000_DMA: 
> [156569.225343] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156569.239133] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156569.259248] Plx8000_DMA: ...device closed
> [156569.272774] Plx8000_DMA: 
> [156569.272796] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156569.286763] Plx8000_DMA: Open device (Plx8000_DMA-4)...
> [156569.323763] Plx8000_DMA: ...device opened
> [156569.350921] Plx8000_DMA: 
> [156569.350943] Plx8000_DMA: Received PLX message ===> 
> [156569.391522] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156569.411420] Plx8000_DMA: ...Completed message
> [156569.432018] PLX DMA[Dispatch_IoControl-1053]
> [156569.461219] PLX DMA[Dispatch_IoControl-1061]
> [156569.488454] Plx8000_DMA: 
> [156569.488475] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156569.507184] Plx8000_DMA: Close device (Plx8000_DMA-4)...
> [156569.521552] Plx8000_DMA: ...device closed
> [156569.521606] Plx8000_NT: 
> [156569.521607] Plx8000_NT: Received message ==> OPEN_DEVICE
> [156569.521608] Plx8000_NT: Open device (Plx8000_NT-0)...
> [156569.521609] Plx8000_NT: ...device opened
> [156569.521610] Plx8000_NT: 
> [156569.521611] Plx8000_NT: Received PLX message ===> 
> [156569.521612] Plx8000_NT: PLX_IOCTL_DRIVER_VERSION
> [156569.521613] Plx8000_NT: ...Completed message
> [156569.521614] Plx8000_NT: 
> [156569.521615] Plx8000_NT: Received PLX message ===> 
> [156569.521615] Plx8000_NT: PLX_IOCTL_PCI_DEVICE_FIND
> [156569.521616] Plx8000_NT: Criteria did not match any devices
> [156569.521617] Plx8000_NT: ...Completed message
> [156569.521619] Plx8000_NT: 
> [156569.521619] Plx8000_NT: Received message ==> CLOSE_DEVICE
> [156569.521620] Plx8000_NT: Close device (Plx8000_NT-0)...
> [156569.521621] Plx8000_NT: ...device closed
> [156569.521624] Plx8000_DMA: 
> [156569.541221] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156569.555596] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156569.569411] Plx8000_DMA: ...device opened
> [156569.591053] Plx8000_DMA: 
> [156569.591075] Plx8000_DMA: Received PLX message ===> 
> [156569.608531] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156569.622776] Plx8000_DMA: ...Completed message
> [156569.643340] PLX DMA[Dispatch_IoControl-1053]
> [156569.643381] PLX DMA[Dispatch_IoControl-1061]
> [156569.661435] Plx8000_DMA: 
> [156569.697493] Plx8000_DMA: Received PLX message ===> 
> [156569.697533] Plx8000_DMA: PLX_IOCTL_PCI_DEVICE_FIND
> [156569.712283] Plx8000_DMA: Criteria did not match any devices
> [156569.726097] Plx8000_DMA: ...Completed message
> [156569.743793] PLX DMA[Dispatch_IoControl-1053]
> [156569.757271] PLX DMA[Dispatch_IoControl-1061]
> [156569.778014] Plx8000_DMA: 
> [156569.778035] Plx8000_DMA: Received message ==> CLOSE_DEVICE
> [156569.792130] Plx8000_DMA: Close device (Plx8000_DMA-0)...
> [156569.812514] Plx8000_DMA: ...device closed
> ^[[B[156595.458146] Plx8000_DMA: 
> [156595.458253] Plx8000_DMA: Received message ==> OPEN_DEVICE
> [156595.458430] Plx8000_DMA: Open device (Plx8000_DMA-0)...
> [156595.458478] Plx8000_DMA: ...device opened
> [156595.458514] Plx8000_DMA: 
> [156595.458539] Plx8000_DMA: Received PLX message ===> 
> [156595.458588] Plx8000_DMA: PLX_IOCTL_DRIVER_VERSION
> [156595.458818] Plx8000_DMA: ...Completed message
> [156595.458868] PLX DMA[Dispatch_IoControl-1053]
> [156595.458918] PLX DMA[Dispatch_IoControl-1061]
> [156595.458977] Plx8000_NT: 
> [156595.458978] Plx8000_NT: Received PLX message ===> 
> [156595.458980] Plx8000_NT: PLX_IOCTL_NT_LUT_ADD
> [156595.458988] Plx8000_NT: Req ID (0101) already exists in LUT #1,
> skipping
> update
> [156595.458990] Plx8000_NT: ...Completed message
> [156598.640885] Plx8000_DMA: 
> [156598.640992] Plx8000_DMA: Received PLX message ===> 
> [156598.641163] Plx8000_DMA: PLX_IOCTL_DMA_CHANNEL_OPEN
> [156598.641226] Plx8000_DMA: Opened DMA channel 0
> [156598.641273] Plx8000_DMA: ...Completed message
> [156598.641320] PLX DMA[Dispatch_IoControl-1053]
> [156598.641369] PLX DMA[Dispatch_IoControl-1061]
> [156598.641499] Plx8000_DMA: 
> [156598.641608] Plx8000_DMA: Received PLX message ===> 
> [156598.641655] Plx8000_DMA: PLX_IOCTL_DMA_GET_PROPERTIES
> [156598.641718] Plx8000_DMA: ...Completed message
> [156598.641769] PLX DMA[Dispatch_IoControl-1053]
> [156598.641818] PLX DMA[Dispatch_IoControl-1061]
> [156598.641870] Plx8000_DMA: 
> [156598.641895] Plx8000_DMA: Received PLX message ===> 
> [156598.641943] Plx8000_DMA: PLX_IOCTL_DMA_SET_PROPERTIES
> [156598.642008] Plx8000_DMA: ...Completed message
> [156598.642057] PLX DMA[Dispatch_IoControl-1053]
> [156598.642106] PLX DMA[Dispatch_IoControl-1061]
> [156598.642160] Plx8000_DMA: 
> [156598.642185] Plx8000_DMA: Received PLX message ===> 
> [156598.642234] Plx8000_DMA: PLX_IOCTL_NOTIFICATION_REGISTER_FOR
> [156598.642308] Plx8000_DMA: Registered interrupt wait object
> (c000003bb93fd440)
> [156598.642378] Plx8000_DMA: ...Completed message
> [156598.642426] PLX DMA[Dispatch_IoControl-1053]
> [156598.642475] PLX DMA[Dispatch_IoControl-1061]
> [156598.642542] Plx8000_DMA: 
> [156598.642568] Plx8000_DMA: Received PLX message ===> 
> [156598.642615] Plx8000_DMA: PLX_IOCTL_DMA_TRANSFER_BLOCK
> [156598.642675] PLX DMA[PlxDmaTransferBlock-2479]
> [156598.642724] PLX DMA[PlxDmaTransferBlock-2488]
> [156598.642774] PLX DMA[PlxDmaTransferBlock-2495]
> [156598.642823] Plx8000_DMA: Ch 0 - DMA 00000000_60E00000 -->
> 00000000_61000000 (65536 bytes)
> [156598.642897] PLX DMA[PlxDmaTransferBlock-2503]
> [156598.642945] PLX DMA[PlxDmaTransferBlock-2511]
> [156598.642996] PLX DMA[PlxDmaTransferBlock-2516]
> [156598.643045] PLX DMA[PlxDmaTransferBlock-2521]
> [156598.643094] PLX DMA[PlxDmaTransferBlock-2532]
> [156598.643141] PLX DMA[PlxDmaTransferBlock-2535]
> [156598.643191] PLX DMA[PlxDmaTransferBlock-2539]
> [156598.643239] PLX DMA[PlxDmaTransferBlock-2550]
> [156598.643288] PLX DMA[PlxDmaTransferBlock-2557]
> [156598.643335] PLX DMA[PlxDmaTransferBlock-2562]
> [156598.643383] Plx8000_DMA: Start DMA transfer...
> [156598.643432] PLX DMA[PlxDmaTransferBlock-2565]
> [156598.643481] PLX DMA[PlxDmaTransferBlock-2569]
> [156598.643525] EEH: Frozen PE#1 on PHB#1 detected
> [156598.643529] EEH: PE location: Slot4, PHB location: N/A
> [156598.644631] EEH: This PCI device has failed 1 times in the last
> hour
> [156598.644632] EEH: Notify device drivers to shutdown
> [156598.644638] EEH: Collect temporary log
> [156598.644710] EEH: of node=0001:01:00:0
> [156598.644713] EEH: PCI device/vendor: 861910b5
> [156598.644715] EEH: PCI cmd/status register: 00100547
> [156598.644717] EEH: Bridge secondary status: 0000
> [156598.644719] EEH: Bridge control: 0002
> [156598.644720] EEH: PCI-E capabilities and status follow:
> [156598.644729] EEH: PCI-E 00: 0052a410 00008004 00000046 0000cc82 
> [156598.644736] EEH: PCI-E 10: 00820000 00000000 00000000 00000000 
> [156598.644737] EEH: PCI-E 20: 00000000 
> [156598.644738] EEH: PCI-E AER capability register set follows:
> [156598.644746] EEH: PCI-E AER 00: 13810001 00000000 00000000
> 00062030 
> [156598.644753] EEH: PCI-E AER 10: 00000000 00002000 000000ff
> 00000000 
> [156598.644760] EEH: PCI-E AER 20: 00000000 00000000 00000000
> 00000000 
> [156598.644762] EEH: PCI-E AER 30: 00000000 0e0e0e0e 
> [156598.644764] EEH: of node=0001:01:00:1
> [156598.644766] EEH: PCI device/vendor: 861910b5
> [156598.644767] EEH: PCI cmd/status register: 10100546
> [156598.644768] EEH: PCI-E capabilities and status follow:
> [156598.644777] EEH: PCI-E 00: 0002a410 00008fe4 0020204e 0000cc82 
> [156598.644784] EEH: PCI-E 10: 00820000 00000000 00000000 00000000 
> [156598.644785] EEH: PCI-E 20: 00000000 
> [156598.644785] EEH: PCI-E AER capability register set follows:
> [156598.644793] EEH: PCI-E AER 00: 1f410001 00000000 00000000
> 00062030 
> [156598.644800] EEH: PCI-E AER 10: 00000000 00002000 000001ff
> 00000000 
> [156598.644807] EEH: PCI-E AER 20: 00000000 00000000 00000000
> 00000000 
> [156598.644809] EEH: PCI-E AER 30: 00000000 00000000 
> [156598.644810] EEH: of node=0001:02:01:0
> [156598.644812] EEH: PCI device/vendor: 861910b5
> [156598.644814] EEH: PCI cmd/status register: 00100546
> [156598.644814] EEH: PCI-E capabilities and status follow:
> [156598.644823] EEH: PCI-E 00: 0002a410 00008fc4 0000004e 0100cc82 
> [156598.644830] EEH: PCI-E 10: 00420000 00000000 00000000 00000000 
> [156598.644831] EEH: PCI-E 20: 00000000 
> [156598.644831] EEH: PCI-E AER capability register set follows:
> [156598.644840] EEH: PCI-E AER 00: 14810001 00000000 00000000
> 00062030 
> [156598.644847] EEH: PCI-E AER 10: 00000000 00002000 000001ff
> 00000000 
> [156598.644853] EEH: PCI-E AER 20: 00000000 00000000 00000000
> 00000000 
> [156598.644856] EEH: PCI-E AER 30: 00000000 00000000 
> [156598.644857] PHB3 PHB#1 Diag-data (Version: 1)
> [156598.644858] brdgCtl:     00000002
> [156598.644860] RootSts:     0002004f 00400000 f0820008 00100147
> 00002800
> [156598.644861] RootErrSts:  00000000 00008000 00000000
> [156598.644862] PhbSts:      0000001c00000000 0000001c00000000
> [156598.644863] Lem:         0000000004000000 42498e327f502eae
> 0000000000000000
> [156598.644865] InAErr:      0000000000004000 0000000000004000
> 8000000060e00001 8400000000000001
> [156598.644866] PE[  1] A/B: 8200302500000000 8000000060e00000
> [156598.644869] EEH: Enable I/O for affected devices
> [156598.644884] EEH: Notify device drivers to resume I/O
> [156598.644886] EEH: Enabled DMA for affected devices
> [156598.644898] EEH: Notify device driver to resume
> [156599.227910] Plx8000_DMA: ...Completed message
> [156599.241749] PLX DMA[Dispatch_IoControl-1053]
> [156599.241802] PLX DMA[Dispatch_IoControl-1061]
> 
> 
> 
> 
> 
> --
> View this message in context: http://linuxppc.10917.n7.nabble.com/EEH
> -error-in-doing-DMA-with-PEX-8619-tp121121p121181.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
