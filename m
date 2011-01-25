Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 83F01B7124
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2011 11:18:41 +1100 (EST)
Date: Mon, 24 Jan 2011 16:18:38 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: FSL DMA engine transfer to PCI memory
Message-ID: <20110125001837.GD26404@ovro.caltech.edu>
References: <4D3DF36A.5050609@embedded-sol.com>
	<20110124222641.GC26404@ovro.caltech.edu>
	<4D3E0DBB.60308@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D3E0DBB.60308@embedded-sol.com>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 25, 2011 at 01:39:39AM +0200, Felix Radensky wrote:
> Hi Ira, Scott
> 
> On 01/25/2011 12:26 AM, Ira W. Snyder wrote:
> > On Mon, Jan 24, 2011 at 11:47:22PM +0200, Felix Radensky wrote:
> >> Hi,
> >>
> >> I'm trying to use FSL DMA engine to perform DMA transfer from
> >> memory buffer obtained by kmalloc() to PCI memory. This is on
> >> custom board based on P2020 running linux-2.6.35. The PCI
> >> device is Altera FPGA, connected directly to SoC PCI-E controller.
> >>
> >> 01:00.0 Unassigned class [ff00]: Altera Corporation Unknown device
> >> 0004 (rev 01)
> >>           Subsystem: Altera Corporation Unknown device 0004
> >>           Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> >> ParErr- Stepping- SERR- FastB2B-
> >>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >>   >TAbort-<TAbort-<MAbort->SERR-<PERR-
> >>           Interrupt: pin A routed to IRQ 16
> >>           Region 0: Memory at c0000000 (32-bit, non-prefetchable)
> >> [size=128K]
> >>           Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
> >> Queue=0/0 Enable-
> >>                   Address: 0000000000000000  Data: 0000
> >>           Capabilities: [78] Power Management version 3
> >>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> >> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >>                   Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >>           Capabilities: [80] Express Endpoint IRQ 0
> >>                   Device: Supported: MaxPayload 256 bytes, PhantFunc 0,
> >> ExtTag-
> >>                   Device: Latency L0s<64ns, L1<1us
> >>                   Device: AtnBtn- AtnInd- PwrInd-
> >>                   Device: Errors: Correctable- Non-Fatal- Fatal-
> >> Unsupported-
> >>                   Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> >>                   Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
> >>                   Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
> >>                   Link: Latency L0s unlimited, L1 unlimited
> >>                   Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
> >>                   Link: Speed 2.5Gb/s, Width x1
> >>           Capabilities: [100] Virtual Channel
> >>
> >>
> >> I can successfully writel() to PCI memory via address obtained from
> >> pci_ioremap_bar().
> >> Here's my DMA transfer routine
> >>
> >> static int dma_transfer(struct dma_chan *chan, void *dst, void *src,
> >> size_t len)
> >> {
> >>       int rc = 0;
> >>       dma_addr_t dma_src;
> >>       dma_addr_t dma_dst;
> >>       dma_cookie_t cookie;
> >>       struct completion cmp;
> >>       enum dma_status status;
> >>       enum dma_ctrl_flags flags = 0;
> >>       struct dma_device *dev = chan->device;
> >>       struct dma_async_tx_descriptor *tx = NULL;
> >>       unsigned long tmo = msecs_to_jiffies(FPGA_DMA_TIMEOUT_MS);
> >>
> >>       dma_src = dma_map_single(dev->dev, src, len, DMA_TO_DEVICE);
> >>       if (dma_mapping_error(dev->dev, dma_src)) {
> >>           printk(KERN_ERR "Failed to map src for DMA\n");
> >>           return -EIO;
> >>       }
> >>
> >>       dma_dst = (dma_addr_t)dst;
> >>
> >>       flags = DMA_CTRL_ACK |
> >>           DMA_COMPL_SRC_UNMAP_SINGLE  |
> >>           DMA_COMPL_SKIP_DEST_UNMAP |
> >>           DMA_PREP_INTERRUPT;
> >>
> >>       tx = dev->device_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> >>       if (!tx) {
> >>           printk(KERN_ERR "%s: Failed to prepare DMA transfer\n",
> >>                  __FUNCTION__);
> >>           dma_unmap_single(dev->dev, dma_src, len, DMA_TO_DEVICE);
> >>           return -ENOMEM;
> >>       }
> >>
> >>       init_completion(&cmp);
> >>       tx->callback = dma_callback;
> >>       tx->callback_param =&cmp;
> >>       cookie = tx->tx_submit(tx);
> >>
> >>       if (dma_submit_error(cookie)) {
> >>           printk(KERN_ERR "%s: Failed to start DMA transfer\n",
> >>                  __FUNCTION__);
> >>           return -ENOMEM;
> >>       }
> >>
> >>       dma_async_issue_pending(chan);
> >>
> >>       tmo = wait_for_completion_timeout(&cmp, tmo);
> >>       status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
> >>
> >>       if (tmo == 0) {
> >>           printk(KERN_ERR "%s: Transfer timed out\n", __FUNCTION__);
> >>           rc = -ETIMEDOUT;
> >>       } else if (status != DMA_SUCCESS) {
> >>           printk(KERN_ERR "%s: Transfer failed: status is %s\n",
> >>                  __FUNCTION__,
> >>                  status == DMA_ERROR ? "error" : "in progress");
> >>
> >>           dev->device_control(chan, DMA_TERMINATE_ALL, 0);
> >>           rc = -EIO;
> >>       }
> >>
> >>       return rc;
> >> }
> >>
> >> The destination address is PCI memory address returned by
> >> pci_ioremap_bar().
> >> The transfer silently fails, destination buffer doesn't change
> >> contents, but no
> >> error condition is reported.
> >>
> >> What am I doing wrong ?
> >>
> >> Thanks a lot in advance.
> >>
> > Your destination address is wrong. The device_prep_dma_memcpy() routine
> > works in physical addresses only (dma_addr_t type). Your source address
> > looks fine: you're using the result of dma_map_single(), which returns a
> > physical address.
> >
> > Your destination address should be something that comes from struct
> > pci_dev.resource[x].start + offset if necessary. In your lspci output
> > above, that will be 0xc0000000.
> >
> > Another possible problem: AFAIK you must use the _ONSTACK() variants
> > from include/linux/completion.h for struct completion which are on the
> > stack.
> >
> > Hope it helps,
> > Ira
> 
> Thanks for your help. I'm now passing the result of 
> pci_resource_start(pdev, 0)
> as destination address, and destination buffer changes after the 
> transfer. But
> the contents of source and destination buffers are different. What 
> else could
> be wrong ?
> 

After you changed the dst address to pci_resource_start(pdev, 0), I
don't see anything wrong with the code.

Try using memcpy_toio() to copy some bytes to the FPGA. Also try writing
a single byte at a time (writeb()?) in a loop. This should help
establish that your device is working.

If you put some pattern in your src buffer (such as 0x0, 0x1, 0x2, ...
0xff, repeat) does the destination show some pattern after the DMA
completes? (Such as, every 4th byte is correct.)

Ira
