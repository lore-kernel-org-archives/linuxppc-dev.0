Return-Path: <stern+4b9b024c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 491B5B7D4E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Mar 2010 02:50:26 +1100 (EST)
Date: Tue, 2 Mar 2010 10:50:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
In-Reply-To: <4B8C45DF.50607@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1003021034190.1730-100000@iolanthe.rowland.org>
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

> > 	If transfer_buffer_length is 0 then do nothing.
> > 	Otherwise if num_sgs > 0 then do nothing.
> > 	Otherwise if URB_NO_TRANSFER_DMA_MAP and transfer_dma
> > 		are both set (this avoids your HCD_NO_COHERENT_MEM
> > 		case) then do nothing.
> > 
> 
> I see. This case would include the PIO case too (for which dma_handle
> is set to all 1s).

The test above should be transfer_dma != ~0, not transfer_dma != 0,
since ~0 means the DMA address isn't set.  In fact I forgot to 
include the PIO case; it should be handled by changing the remaining 
tests as follows:

	Otherwise if hcd->self.uses_dma is set then
		If this URB doesn't require PIO then call dma_map_single
	Otherwise if HCD_LOCAL_MEM is set then call hcd_alloc_coherent
	Otherwise do nothing (PIO case).

Currently "this URB doesn't require PIO" is always true, but in the 
future it won't be.

> So this assumes that transfer_dma should be set initially to 0 when
> allocating USB buffers for HCD_NO_COHERENT_MEM.

No, it should be set to ~0, the same as when buffers are allocated for 
a PIO-based controller.

Alan Stern
