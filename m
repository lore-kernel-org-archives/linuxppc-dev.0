Return-Path: <albert_herranz@yahoo.es>
Received: from smtp108.mail.ukl.yahoo.com (smtp108.mail.ukl.yahoo.com
	[77.238.184.40]) by ozlabs.org (Postfix) with SMTP id 44DB5B7D01
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 10:38:31 +1100 (EST)
Message-ID: <4B6F4EF0.1030303@yahoo.es>
Date: Mon, 08 Feb 2010 00:38:24 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller driver
	flag
References: <Pine.LNX.4.44L0.1002071523350.10952-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1002071523350.10952-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: USB list <linux-usb@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Stern wrote:
> On Sun, 7 Feb 2010, Albert Herranz wrote:
> 
>> The wii has no uhci, but has 2 ohci controllers.
>> For ohci we need a similar approach as done for ehci.
> 
> So you'll need to write a patch splitting up the OHCI data structures 
> in the same way the EHCI qh was split up.
> 

Yes.

>> It turns out that we have more limitations.
>> The wii has 2 discontiguous memory areas (usually called MEM1 and MEM2). I have checked that the ehci controller doesn't work properly when performing dma to buffers allocated in MEM1 (it corrupts part of the data) but has no problems if the buffers sit within MEM2.
>> So usb buffers will need to be bounced anyway if they are part of MEM1.
> 
> This sounds like the sort of restriction that dma_map_single() should 
> be capable of handling.
> 

On powerpc you can have per-device specific dma ops.
I'll work on that direction and create a special dma ops set for devices which need their dma buffers on mem2, and then use those for ehci-hlwd.

> Alan Stern
> 

Thanks,
Albert
