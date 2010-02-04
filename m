Return-Path: <stern+4b6f04d4@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 4BD4FB7D49
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Feb 2010 05:58:20 +1100 (EST)
Date: Thu, 4 Feb 2010 13:58:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller
	driver flag
In-Reply-To: <4B6B1089.6070708@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1002041345150.1261-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: USB list <linux-usb@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 4 Feb 2010, Albert Herranz wrote:

> Hi Alan,
> 
> Alan Stern wrote:
> > This description sounds hopelessly confused.  Maybe you're just
> > misusing the term "coherent".  The patch itself doesn't affect the
> > coherent DMA mappings anyway; it affects the streaming mappings.  Or to
> > put it another way, what's the justification for replacing a call to
> > dma_map_single() with a call to dma_alloc_coherent()?
> > 
> > Since the patch doesn't affect any of the coherent mappings (see for 
> > example the calls to dma_pool_create() in ehci-mem.c), I don't see how 
> > it can possibly do what you claim.
> > 
> 
> Thanks for your comments. Let's try to hopefully clarify this a bit.
> 
> I've used the term "coherent" as described in Documentation/DMA-API.txt (aka "consistent" as used in PCI-related functions).
> I've tried to describe first the limitations of the platform that I'm working on. Basically, one of the annoying things of that platform is that writes to uncached memory (as used in "coherent" memory) can only be reliably performed in 32-bit accesses.
> 
> The USB subsystem ends up using "coherent" memory for buffers and/or other structures in different ways.
> 
> The "coherent" memory allocated in dma_pool_create() in ehci-mem.c that you report is not a problem at all because it is always accessed in 32-bit chunks (it hasn't been always like that but since commit 3807e26d69b9ad3864fe03224ebebc9610d5802e "USB: EHCI: split ehci_qh into hw and sw parts" this got addressed as a side effect, so I didn't need to post another patch for that).

On a 64-bit processor, some of the accesses will be 64 bits wide
instead of 32.  Does that matter for your purposes?

What about ohci-hcd and uhci-hcd?  They both use non-32-bit accesses to 
structures in coherent memory.

> Other possible interactions with "coherent" memory are those involving buffers used in USB transactions, which may be allocated via the USB subsystem (at usb_buffer_alloc() or when bounced via hcd_alloc_coherent()) or which may come already allocated and ready for use (URB_NO_{SETUP,TRANSFER}_DMA_MAP).

Ah yes, quite correct.  And this indicates that you need to concentrate
on usb_buffer_alloc().  On your system (or rather, whenever the
HCD_NO_COHERENT_MEM flag is set) it should allocate normal memory and
set the DMA pointer to NULL.

Then map_urb_for_dma() should check the urb->setup_dma and
urb->transfer_dma pointers; if a pointer is NULL then the
corresponding urb->URB_NO_SETUP_DMA_MAP or urb->NO_TRANSFER_DMA_MAP
flag should be ignored (and probably should be cleared so as to 
avoid confusing unmap_urb_for_dma()).

> The patch, as posted, allocates normal memory for USB buffers _within_ the USB subsystem and invariably bounces all buffers to new "coherent" buffers.
> So, basically, what the patch claims (avoid 32-bit writes for "coherent" memory within the USB subsystem) is "done" (hey, it actually works ;-).
> 
> But I think you have raised valid points here :)
> 
> If the "coherent" memory is already allocated and passed (as already dma-mapped) to the USB subsystem then there is no gain in bouncing the buffer:
> - if a non-32 bit write was done to that "coherent" memory the damage is already done
> - if the "coherent" memory was written always in 32-bit accesses then we can just safely use it
> So bouncing here should be avoided as it is unneeded.
> 
> On the other hand, we can control USB buffers managed by the USB subsystem itself.
> That's what the patch "does". It avoids access restrictions to USB buffers by allocating them from normal memory (leaving USB drivers free to access those buffers in whatever bus width they need, as they do today) ... and bouncing them.
> The thing here is that it makes no sense to bounce them to "coherent" memory if they can be dma-mapped directly (as you point in your dma_map_single-vs-dma_alloc_coherent comment).
> 
> So... that's what RFCs are for :)

If you do it as described above then the buffers you're worried about
won't be allocated in coherent memory to begin with, so no problems 
will arise.

Alan Stern
