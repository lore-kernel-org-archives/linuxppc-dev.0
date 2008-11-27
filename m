Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82F25DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 11:26:40 +1100 (EST)
Date: Thu, 27 Nov 2008 03:26:33 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1351427808.20081127032633@emcraft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re[4]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
In-Reply-To: <1767195957.20081127032002@emcraft.com>
References: <200811131149.14715.yur@emcraft.com>
	<1226568352.7178.44.camel@pasglop>
	<1102187680.20081114074513@emcraft.com>
	<1226641289.7178.117.camel@pasglop>
	<1767195957.20081127032002@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Ben,

On Friday, November 14, 2008 you wrote:

>>  My understanding was that the dma-ranges property is responsible for=20
>> setting up the inbound ranges of RAM's physical addresses, where PCI=20
>> could DMA to/from. As regarding the outbound property, this patch=20
>> doesn't change this, and there we have the PCI space split (2 GB of=20
>> memory, and 64K of I/O spaces mapped from the 64-bit physical=20
>> addresses into 32-bit PCI address space). Am I missing something ?

> The PCI memory space doesn't differenciate inbound and outbound.

> For example, if you take the example of a PCI 2.0 or PCI-X setup (I'm
> leaving PCI-E alone in the discussion because it's a bit special in that
> area, but the problem is fundamentally the same), and you have on the
> PCI bus of that thing a device X configured to respond to MMIO at
> address, for example, 0x80000000.

> Now, what happens if another device, let's call it Y, tries to DMA to
> that same address ? Who will pick up the memory write at address
> 0x80000000 ? The host controller or device X ?=20

> There is no concept of "inbound" here.. it's just a memory cycle to
> address A that gets decoded by whoever tries to decode it on that bus
> segment.

> Thus DMA ranges must -not- overlap areas of memory used for MMIO, it
> just won't work.

 Understood. Thanks a lot for the exhaustive comment.

 Speaking about inbound/outbound above I assumed the traffic direction=20
through the PLB(Processor Local Bus)-PCI bridge controller of=20
ppc440spe.

>>  With the default 2GB dma-ranges we just get the following on Katmai=20
>> with 4GB of SDRAM installed:

> Because that is simply not supported at the moment unless we add what
> I've talked about earlier, ie basically, swiotlb support (which Becky is
> working on at the moment).

(1):
> You might be able to work around it somewhat if your PCI device supports
> 64-bit BARs in which case you can set your outbound regions above the
> 32-bit space. Note that I haven't verified whether the 32-bit linux
> kernel supports that tho. There used to be issues with >32-bit PCI BARs
> on 32-bit kernel, at least it wouldn't assign them but that may have
> been fixed.

(2):
> Another option you can try if you device only does 32-bit BARs but
> supports 64-bit DMA, is to move the DMA window away from the 32-bit MMIO
> space. Stick it at 1T or so in PCI space. You might need a little bit of
> kernel tweaking to make the dma-ops pick that up properly but that
> shouldnt be too hard.


 OK. Then I see the following major difference between the two=20
approaches you suggest above:

(1) means that I should move MMIO ranges to the high PCI addresses=20
(after 4GB), and thus we'll be able to extend dma-ranges up to 4GB.=20
So, with work-around (1), any 32-bit PCI card will not work on my=20
(Katmai) board.

(2) means that I should move the PCI address of the host RAM (DMA=20
window) away from 32-bit PCI address space, and thus we'll be able to=20
increase the window size up to necessary 4GB. So, with work-around=20
(2), only that PCI cards will not work on Katmai, which do DMA but=20
can't do the 64-bit DMA.

 Hence, the item (2) looks less harmful, and more preferable.

 I've implemented (2) (the code is below), and it works. But,=20
admittedly, this (working) looks strange to me because of the=20
following:
 To be able to use 64-bit PCI mapping on PPC32 I had to replace the
'unsigned long' type of pci_dram_offset with 'resource_size_t', which=20
on ppc440spe is 'u64'. So, in dma_alloc_coherent() I put the 64-bit=20
value into the 'dma_addr_t' handle. I use 2.6.27 kernel for testing,=20
which has sizeof(dma_addr_t) =3D=3D sizeof(u32). Thus,=20
dma_alloc_coherent() cuts the upper 32 bits of PCI address, and returns=20
only low 32-bit part of PCI address to its caller. And, regardless of=20
this fact, the PCI device does operate somehow (this is the PCI-E LSI=20
disk controller served by the drivers/message/fusion/mptbase.c +=20
mptsas.c drivers).

 I've verified that ppc440spe PCI-E bridge's BARs (PECFGn_BAR0L,H) are=20
configured with the new, 1TB, address value:

--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1439,6 +1446,8 @@ static void __init ppc4xx_configure_pciex_PIMs(struct=
 ppc4xx_pciex_port *port,
=20
                out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->st=
art));
                out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->s=
tart));
+               printk("<<<< base PCI_BASE_ADDRESS_0 0x%08x. PCI_BASE_ADDRE=
SS_1 0x%08x\n",
+                      in_le32(mbase + PCI_BASE_ADDRESS_0), in_le32(mbase +=
 PCI_BASE_ADDRESS_1));

 resulting to the following during boot:

<<<< base PCI_BASE_ADDRESS_0 0x00000008. PCI_BASE_ADDRESS_1 0x00000100


 Also I verified that the LSI device driver passes the DMA mapped=20
addresses (which turn out to be cut because of types mismatching) to=20
the PCI device indeed, and the latter manages to write there!:

--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -209,6 +209,8 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, g=
fp_t gfp)
                 * Set the "dma handle"
                 */
                *handle =3D page_to_bus(page);
+               printk("\n### cut 0x%016llx to 0x%08x ###\n", page_to_bus(p=
age), *handle);
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c

@@ -396,8 +397,8 @@ mpt_reply(MPT_ADAPTER *ioc, u32 pa)
        cb_idx =3D mr->u.frame.hwhdr.msgctxu.fld.cb_idx;
        mf =3D MPT_INDEX_2_MFPTR(ioc, req_idx);
=20
-       dmfprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Got non-TURBO reply=3D%p r=
eq_idx=3D
-                       ioc->name, mr, req_idx, cb_idx, mr->u.hdr.Function)=
);
+       printk("Got non-TURBO reply=3D%p req_idx=3D%x cb_idx=3D%x Function=
=3D%x\n",
+               mr, req_idx, cb_idx, mr->u.hdr.Function);
        DBG_DUMP_REPLY_FRAME(ioc, (u32 *)mr);
=20
         /*  Check/log IOC log info
@@ -4271,13 +4273,16 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
        /* Post Reply frames to FIFO
         */
        alloc_dma =3D ioc->alloc_dma;
+       mem =3D ioc->alloc;
        dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "ReplyBuffers @ %p[%p]\n",
                ioc->name, ioc->reply_frames, (void *)(ulong)alloc_dma));
=20
        for (i =3D 0; i < ioc->reply_depth; i++) {
                /*  Write each address to the IOC!  */
                CHIPREG_WRITE32(&ioc->chip->ReplyFifo, alloc_dma);
+               printk("post 0x%08x(0x%p)\n", alloc_dma, mem);
                alloc_dma +=3D ioc->reply_sz;
+               mem =3D (u8*)mem + ioc->reply_sz;
        }
@@ -466,6 +467,7 @@ mpt_interrupt(int irq, void *bus_id)
         *  Drain the reply FIFO!
         */
        do {
+               printk("%s: %08x\n", __FUNCTION__, le32_to_cpu(pa));
                if (pa & MPI_ADDRESS_REPLY_A_BIT)
                        mpt_reply(ioc, pa);
                else

 resulting to the following:

...
ioc0: LSISAS1068E B3: Capabilities=3D{Initiator}
### cut 0x00000100288c0000 to 0x288c0000 ###
### cut 0x00000100288f0000 to 0x288f0000 ###
post 0x288c0000(0xffe10000)
post 0x288c0050(0xffe10050)
post 0x288c00a0(0xffe100a0)
...
mpt_interrupt: 00004694
Got non-TURBO reply=3Dffe10000 req_idx=3D0 cb_idx=3Df Function=3D7
mpt_interrupt: 28004694
Got non-TURBO reply=3Dffe10050 req_idx=3D1 cb_idx=3Df Function=3D4



 So, probably the following patch for work-around (2) is still
missing something, since cutting the high bits of 64-bit PCI address=20
doesn't break anything:

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katma=
i.dts
index 983272e..690ae4b 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -245,8 +245,8 @@
                        ranges =3D <0x02000000 0x00000000 0x80000000 0x0000=
000d 0x80000000 0x00000000 0x80000000
                                  0x01000000 0x00000000 0x00000000 0x000000=
0c 0x08000000 0x00000000 0x00010000>;
=20
-                       /* Inbound 4GB range starting at 0 */
-                       dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00=
000000>;
+                       /* Inbound 4GB range starting at 1T */
+                       dma-ranges =3D <0x42000000 0x100 0x0 0x0 0x0 0x1 0x=
00000000>;
=20
                        /* This drives busses 0 to 0xf */
                        bus-range =3D <0x0 0xf>;
@@ -289,8 +289,8 @@
                        ranges =3D <0x02000000 0x00000000 0x80000000 0x0000=
000e 0x00000000 0x00000000 0x80000000
                                  0x01000000 0x00000000 0x00000000 0x000000=
0f 0x80000000 0x00000000 0x00010000>;
=20
-                       /* Inbound 4GB range starting at 0 */
-                       dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00=
000000>;
+                       /* Inbound 4GB range starting at 1T */
+                       dma-ranges =3D <0x42000000 0x100 0x0 0x0 0x0 0x1 0x=
00000000>;
=20
                        /* This drives busses 10 to 0x1f */
                        bus-range =3D <0x10 0x1f>;
@@ -330,8 +330,8 @@
                        ranges =3D <0x02000000 0x00000000 0x80000000 0x0000=
000e 0x80000000 0x00000000 0x80000000
                                  0x01000000 0x00000000 0x00000000 0x000000=
0f 0x80010000 0x00000000 0x00010000>;
=20
-                       /* Inbound 4GB range starting at 0 */
-                       dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00=
000000>;
+                       /* Inbound 4GB range starting at 1T */
+                       dma-ranges =3D <0x42000000 0x100 0x0 0x0 0x0 0x1 0x=
00000000>;
=20
                        /* This drives busses 10 to 0x1f */
                        bus-range =3D <0x20 0x2f>;
@@ -371,8 +371,8 @@
                        ranges =3D <0x02000000 0x00000000 0x80000000 0x0000=
000f 0x00000000 0x00000000 0x80000000
                                  0x01000000 0x00000000 0x00000000 0x000000=
0f 0x80020000 0x00000000 0x00010000>;
=20
-                       /* Inbound 4GB range starting at 0 */
-                       dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00=
000000>;
+                       /* Inbound 4GB range starting at 1T */
+                       dma-ranges =3D <0x42000000 0x100 0x0 0x0 0x0 0x1 0x=
00000000>;
=20
                        /* This drives busses 10 to 0x1f */
                        bus-range =3D <0x30 0x3f>;
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 77c7fa0..adbeb19 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -59,7 +59,7 @@ extern int check_legacy_ioport(unsigned long base_port);
=20
 extern unsigned long isa_io_base;
 extern unsigned long pci_io_base;
-extern unsigned long pci_dram_offset;
+extern resource_size_t pci_dram_offset;
=20
 extern resource_size_t isa_mem_base;
=20
@@ -728,14 +728,14 @@ static inline void * phys_to_virt(unsigned long addre=
ss)
  */
 #ifdef CONFIG_PPC32
=20
-static inline unsigned long virt_to_bus(volatile void * address)
+static inline resource_size_t virt_to_bus(volatile void * address)
 {
         if (address =3D=3D NULL)
                return 0;
         return __pa(address) + PCI_DRAM_OFFSET;
 }
=20
-static inline void * bus_to_virt(unsigned long address)
+static inline void * bus_to_virt(resource_size_t address)
 {
         if (address =3D=3D 0)
                return NULL;
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 88db4ff..5855937 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -33,7 +33,7 @@
 #endif
=20
 unsigned long isa_io_base     =3D 0;
-unsigned long pci_dram_offset =3D 0;
+resource_size_t pci_dram_offset =3D 0;
 int pcibios_assign_bus_offset =3D 1;
=20
 void pcibios_make_OF_bus_map(void);
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_=
pci.c
index afbdd48..f748c5b 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -126,10 +126,8 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_c=
ontroller *hose,
                if ((pci_space & 0x03000000) !=3D 0x02000000)
                        continue;

-               /* We currently only support memory at 0, and pci_addr
-                * within 32 bits space
-                */
-               if (cpu_addr !=3D 0 || pci_addr > 0xffffffff) {
+               /* We currently only support memory at 0 */
+               if (cpu_addr !=3D 0) {
                        printk(KERN_WARNING "%s: Ignored unsupported dma ra=
nge"
                               " 0x%016llx...0x%016llx -> 0x%016llx\n",
                               hose->dn->full_name,
@@ -179,18 +177,12 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_=
controller *hose,
                return -ENXIO;
        }

-       /* Check that we are fully contained within 32 bits space */
-       if (res->end > 0xffffffff) {
-               printk(KERN_ERR "%s: dma-ranges outside of 32 bits space\n",
-                      hose->dn->full_name);
-               return -ENXIO;
-       }
  out:
        dma_offset_set =3D 1;
        pci_dram_offset =3D res->start;

-       printk(KERN_INFO "4xx PCI DMA offset set to 0x%08lx\n",
-              pci_dram_offset);
+       printk(KERN_INFO "4xx PCI DMA offset set to 0x%016llx\n",
+              (unsigned long long)pci_dram_offset);
        return 0;
 }


 Any ideas ?

> If you really need 32-bit DMA support, you'll have to wait for swiotlb
> from Becky or work with her in bringing it to powerpc so that we can do
> bounce buffering for those devices.

> Ben.


 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
