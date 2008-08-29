Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id F1174DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 23:25:43 +1000 (EST)
Message-ID: <48B7F8D1.3030500@harris.com>
Date: Fri, 29 Aug 2008 09:25:37 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
References: <Pine.LNX.4.44L0.0808281727090.4308-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808281727090.4308-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@amcc.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Stern wrote:
> On Thu, 28 Aug 2008, Steven A. Falco wrote:
> 
>> Alan Stern wrote:
>>> Your original post mentioned that the 440EPx has only one USB 2.0 host
>>> port.  Then how can you use a keyboard and memory stick at the same
>>> time?  You'd have to plug them into a hub -- in which case only one
>>> controller would be needed, the one driving the hub.  The patch would 
>>> be unnecessary.
>> I have one of these processors on a Sequoia board.  What happens is that
>> if you build the kernel with both EHCI and OHCI support, then plug in
>> a modern USB memory stick, it initially tries EHCI, the driver fails, and
>> the whole thing falls back to OHCI.  So you wind up running at 12 Mbps.
>> The only way to make high speed work is to turn off the OHCI driver, and
>> then you cannot support slow devices with that kernel.
>>
>> So, hile you cannot plug two devices in at one time, you can plug in
>> different speed devices at different times, and my understanding is that
>> this patch will let that work seamlessly.
> 
> Is there some reason why it doesn't work already?  All the patch does
> is suspend the OHCI root hub when you plug in the memory stick -- but
> the root hub should already be suspended.
> 
> Unless the memory stick is already plugged in when the kernel boots.  
> In which case the root hub won't be suspended -- it won't suspend until 
> 1 second after ohci-hcd initializes the controller.  Is that the 
> scenario you're worried about?
Not sure about other users, but in my case, yes.  I was using a USB stick
as the root filesystem.  When the kernel first came up, it would try the
EHCI driver, which would fail.  Then the drive would be recognized by the
OHCI driver, but would only run at full (12 Mbps) speed rather than high
speed.

I've since gone to a directly attached CF card on the processor external
bus, and I'm not using USB anymore.  But I think the patch is still
desirable to work around the processor bug.

	Steve

> 
> Alan Stern
> 
> 
