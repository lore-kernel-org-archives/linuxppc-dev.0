Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B86841007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2011 09:09:06 +1100 (EST)
Received: from bzq-79-176-251-112.red.bezeqint.net ([79.176.251.112]:48167
	helo=felix.lan) by sh78.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1PhUFZ-00014w-Rc
	for linuxppc-dev@ozlabs.org; Mon, 24 Jan 2011 16:47:02 -0500
Message-ID: <4D3DF36A.5050609@embedded-sol.com>
Date: Mon, 24 Jan 2011 23:47:22 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: FSL DMA engine transfer to PCI memory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to use FSL DMA engine to perform DMA transfer from
memory buffer obtained by kmalloc() to PCI memory. This is on
custom board based on P2020 running linux-2.6.35. The PCI
device is Altera FPGA, connected directly to SoC PCI-E controller.

01:00.0 Unassigned class [ff00]: Altera Corporation Unknown device 
0004 (rev 01)
         Subsystem: Altera Corporation Unknown device 0004
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at c0000000 (32-bit, non-prefetchable) 
[size=128K]
         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 256 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                 Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1
         Capabilities: [100] Virtual Channel


I can successfully writel() to PCI memory via address obtained from 
pci_ioremap_bar().
Here's my DMA transfer routine

static int dma_transfer(struct dma_chan *chan, void *dst, void *src, 
size_t len)
{
     int rc = 0;
     dma_addr_t dma_src;
     dma_addr_t dma_dst;
     dma_cookie_t cookie;
     struct completion cmp;
     enum dma_status status;
     enum dma_ctrl_flags flags = 0;
     struct dma_device *dev = chan->device;
     struct dma_async_tx_descriptor *tx = NULL;
     unsigned long tmo = msecs_to_jiffies(FPGA_DMA_TIMEOUT_MS);

     dma_src = dma_map_single(dev->dev, src, len, DMA_TO_DEVICE);
     if (dma_mapping_error(dev->dev, dma_src)) {
         printk(KERN_ERR "Failed to map src for DMA\n");
         return -EIO;
     }

     dma_dst = (dma_addr_t)dst;

     flags = DMA_CTRL_ACK |
         DMA_COMPL_SRC_UNMAP_SINGLE  |
         DMA_COMPL_SKIP_DEST_UNMAP |
         DMA_PREP_INTERRUPT;

     tx = dev->device_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
     if (!tx) {
         printk(KERN_ERR "%s: Failed to prepare DMA transfer\n",
                __FUNCTION__);
         dma_unmap_single(dev->dev, dma_src, len, DMA_TO_DEVICE);
         return -ENOMEM;
     }

     init_completion(&cmp);
     tx->callback = dma_callback;
     tx->callback_param = &cmp;
     cookie = tx->tx_submit(tx);

     if (dma_submit_error(cookie)) {
         printk(KERN_ERR "%s: Failed to start DMA transfer\n",
                __FUNCTION__);
         return -ENOMEM;
     }

     dma_async_issue_pending(chan);

     tmo = wait_for_completion_timeout(&cmp, tmo);
     status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);

     if (tmo == 0) {
         printk(KERN_ERR "%s: Transfer timed out\n", __FUNCTION__);
         rc = -ETIMEDOUT;
     } else if (status != DMA_SUCCESS) {
         printk(KERN_ERR "%s: Transfer failed: status is %s\n",
                __FUNCTION__,
                status == DMA_ERROR ? "error" : "in progress");

         dev->device_control(chan, DMA_TERMINATE_ALL, 0);
         rc = -EIO;
     }

     return rc;
}

The destination address is PCI memory address returned by 
pci_ioremap_bar().
The transfer silently fails, destination buffer doesn't change 
contents, but no
error condition is reported.

What am I doing wrong ?

Thanks a lot in advance.

Felix.
