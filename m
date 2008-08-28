Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id BEC7EDE349
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 07:11:56 +1000 (EST)
Message-ID: <48B71497.30500@harris.com>
Date: Thu, 28 Aug 2008 17:11:51 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
References: <Pine.LNX.4.44L0.0808281558320.3844-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808281558320.3844-100000@iolanthe.rowland.org>
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
> Your original post mentioned that the 440EPx has only one USB 2.0 host
> port.  Then how can you use a keyboard and memory stick at the same
> time?  You'd have to plug them into a hub -- in which case only one
> controller would be needed, the one driving the hub.  The patch would 
> be unnecessary.
I have one of these processors on a Sequoia board.  What happens is that
if you build the kernel with both EHCI and OHCI support, then plug in
a modern USB memory stick, it initially tries EHCI, the driver fails, and
the whole thing falls back to OHCI.  So you wind up running at 12 Mbps.
The only way to make high speed work is to turn off the OHCI driver, and
then you cannot support slow devices with that kernel.

So, hile you cannot plug two devices in at one time, you can plug in
different speed devices at different times, and my understanding is that
this patch will let that work seamlessly.
> 
>>> I doubt this will interact properly with usbcore and the rest of
>>> ohci-hcd.  They do not expect the root hub to be suspended unless they
>>> know about it.
>> I need to reemphasize, that upper is not "normal", but unfortunately
>> the only way to have both full and hi-speed usb live in peace with
>> 44xEPX family. Quirks are not going to be executed on other chip
>> anyway, and on chip in question, it was tested and works stable enough.
>>
>> I can add an explicit warning, that workaround is being utilised, to
>> make things clear if it will be considered appropriate.
> 
> Do these systems support CONFIG_PM?  If they do then your patch
> shouldn't be needed, because then ohci-hcd will automatically suspend
> the OHCI root hub 1 second after the last full/low-speed device is
> unplugged.  You could reduce that 1 second value if you wanted to 
> decrease the probability of conflicts.
> 
> Alan Stern
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
