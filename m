Return-Path: <stern+4b9b024c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 40548B7DBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 06:23:23 +1100 (EST)
Date: Mon, 1 Mar 2010 14:23:22 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
In-Reply-To: <4B8C099B.30504@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1003011356040.1341-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 1 Mar 2010, Albert Herranz wrote:

> > Also, I can't help thinking that the corresponding *_map() and 
> > *_unmap() routines are so similar, it ought to be possible to combine 
> > them.  The only difference is a check for a NULL DMA address, and it's 
> > not clear to me why it is present.  It's also not clear why the test 
> > for a DMA address of all ones is present.  Maybe they both can be 
> > removed.
> > 
> 
> I think too that I can simplify that logic.
> I added those checks in a defensive way seeking robustness while I
> familiarize with the USB stack innards. So far, those cases are just
> avoiding mappings when
> urb_needs_transfer_dma_map()/urb_needs_transfer_dma_unmap() are
> called with urb->transfer_buffer == 0 and urb->transfer_dma == 0.
> 
> I guess that those cases are related to scatterlist-based urb requests.
> What should be the correct way to check if a urb has already been
> scatter/gather-mapped?

If urb->num_sgs > 0 then urb has been s-g mapped.  Although we don't
currently check for it, quite a few URBs have transfer_buffer_length ==
0 (a number of control requests are like this, for example) so they
don't need a mapping either.

> The final logic would be something like:
> - map if URB_NO_TRANSFER_DMA_MAP is cleared
> - otherwise (URB_TRANSFER_NO_DMA_MAP is set so) map if
> HCD_NO_COHERENT_MEM is set _and_ it's not a scatter/gather request
> (as that should have been mapped already by usb_buffer_map_sg())
> 
> Am I on the right path?

More or less.  I would do it somewhat differently:

	If URB_NO_TRANSFER_DMA_MAP is set then no map is needed.
	Otherwise if num_sgs > 0 then no map is needed.
	Otherwise if HCD_NO_COHERENT_MEM is set then use
		hcd_alloc_coherent().
	Otherwise if transfer_buffer_length > 0 then use
		dma_map_single().

Similar logic is needed for the setup buffer mapping, but you can 
assume that control URBs never use scatter-gather so there's no need to 
check num_sgs (and there's no need to check the transfer length, since 
setup packets are always 8 bytes long).

In fact, I think URB_NO_SETUP_DMA_MAP doesn't really offer any
worthwhile advantages.  (About the only place where multiple control
requests are used in rapid succession is during firmware transfers, and
those aren't time-constrained.)  It is currently used in a few
drivers, but we ought to be able to remove it without too much effort.  
That might make a good project.

Alan Stern
