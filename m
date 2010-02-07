Return-Path: <albert_herranz@yahoo.es>
Received: from smtp121.mail.ukl.yahoo.com (smtp121.mail.ukl.yahoo.com
	[77.238.184.52]) by ozlabs.org (Postfix) with SMTP id A7FD8B7CA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 05:10:59 +1100 (EST)
Message-ID: <4B6F0229.5070604@yahoo.es>
Date: Sun, 07 Feb 2010 19:10:49 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller driver
	flag
References: <Pine.LNX.4.44L0.1002031429430.1321-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1002031429430.1321-100000@iolanthe.rowland.org>
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
>On a 64-bit processor, some of the accesses will be 64 bits wide
>instead of 32.  Does that matter for your purposes?
>

The wii uses a 32-bit processor, so this is safe in this case.

>What about ohci-hcd and uhci-hcd?  They both use non-32-bit accesses to 
>structures in coherent memory.
>

The wii has no uhci, but has 2 ohci controllers.
For ohci we need a similar approach as done for ehci.

>If you do it as described above then the buffers you're worried about
>won't be allocated in coherent memory to begin with, so no problems 
>will arise.

It turns out that we have more limitations.
The wii has 2 discontiguous memory areas (usually called MEM1 and MEM2). I have checked that the ehci controller doesn't work properly when performing dma to buffers allocated in MEM1 (it corrupts part of the data) but has no problems if the buffers sit within MEM2.
So usb buffers will need to be bounced anyway if they are part of MEM1.

This worked in the original patch as buffers were always bounced to MEM2 buffers. Sigh.

>Alan Stern
>

Thanks,
Albert

PS: Your reply didn't get to me. I looked at the ML and found it (I'm not subscribed). Sorry for the late answer.
