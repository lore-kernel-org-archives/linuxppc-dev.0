Return-Path: <stern+4b6f04d4@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id E3547B7CF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 07:26:38 +1100 (EST)
Date: Sun, 7 Feb 2010 15:26:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller
	driver flag
In-Reply-To: <4B6F0229.5070604@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1002071523350.10952-100000@netrider.rowland.org>
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

On Sun, 7 Feb 2010, Albert Herranz wrote:

> The wii has no uhci, but has 2 ohci controllers.
> For ohci we need a similar approach as done for ehci.

So you'll need to write a patch splitting up the OHCI data structures 
in the same way the EHCI qh was split up.

> >If you do it as described above then the buffers you're worried about
> >won't be allocated in coherent memory to begin with, so no problems 
> >will arise.
> 
> It turns out that we have more limitations.
> The wii has 2 discontiguous memory areas (usually called MEM1 and MEM2). I have checked that the ehci controller doesn't work properly when performing dma to buffers allocated in MEM1 (it corrupts part of the data) but has no problems if the buffers sit within MEM2.
> So usb buffers will need to be bounced anyway if they are part of MEM1.

This sounds like the sort of restriction that dma_map_single() should 
be capable of handling.

Alan Stern
