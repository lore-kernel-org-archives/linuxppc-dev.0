Subject: Re: usb hub problem on 8270
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Nigel Rudgley <nrudgley@consultronics.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <008901c410bd$93e0c0a0$2002a8c0@gadget>
References: <935CBD11-6322-11D8-89E5-000A95B15278@aimsys.nl>
	 <008901c410bd$93e0c0a0$2002a8c0@gadget>
Content-Type: text/plain
Message-Id: <1080062587.8019.82.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 18:23:08 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nigel,

On Tue, 2004-03-23 at 10:59, Nigel Rudgley wrote:
> Hi Jaap-Jan
>
>
> We're trying to bring up UBS host on the PQFADS board (8280 based) and have
> recently got it running on an Adder-II board (870 based)
>
>
> Maybe our experience with 870 can help - your problem looks a lot like what
> we saw with the Adder board, some transmits, detecting a hub, then...
> nothing.
>
> The CPM has been altered slightly from the 823/850 and will now effect a
> graceful stop when it receives a nak or stall response, you now have to
> restart it manually after these are detected.
>
> In original m8xxhci.c, this needs to be done in process_done_txbds()
> around line 2183, inside "if (nak & BD_USB_NAK)"
> around line 2197, inside "if ((nak & BD_USB_STAL))"
> around line 2213, inside "if (nak)"
>
> calling restart_endpoint() at these three points should work to wake up the
> cpm :-)

yes, thanks!
you're right (as stated in 8280 addendum table 7-18)

>
> I can send a complete patch file but other changes won't be so relevant for
> you, they're for 870.
>
>
> On the other hand you look further on with the 8270 than we are with the
> 8280, we're not seeing SOFs :-( Do we need a microcode patch on the 82xx?

No, I didn't needed one. I only connected TOUT3 (from timer3) to DREQ0
and DREQ1.

thanks,

Jaap-Jan

> Do the IDMAs need setting up to get DREQs in the right configuration or does it
> just work with the external wire connected?
>
>
> Cheers
>
> Nigel
> nrudgley@consultronics.co.uk
>
>
> ----- Original Message -----
> From: "Jaap-Jan Boor" <jjboor@aimsys.nl>
> To: <linuxppc-embedded@lists.linuxppc.org>
> Sent: Thursday, February 19, 2004 9:28 PM
> Subject: usb hub problem on 8270
>
>
> >
> > Hi,
> >
> > I found some time to adapt m8xxhci.c (for 823/850) to the 8270 with
> > limited success.
> > We use TOUT3 (from timer3) to DREQ0/1 to enable SOF transmitting which
> > works
> > more or less as one of my hubs is detected but after the host driver
> > received the hub's
> > device description, I get a time-out and, well that's it. Even after
> > resetting the 8270 and cpm
> > I'm unable to communicate to the hub:
--
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
