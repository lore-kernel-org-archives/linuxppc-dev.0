Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange.deka.local (mail.dekaresearch.com [208.65.175.196])
	by ozlabs.org (Postfix) with ESMTP id 41B8FDE18A
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 03:22:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: mpc5200 fec error
Date: Wed, 20 May 2009 13:26:00 -0400
Message-ID: <A88094362DE0AE49A118AB9B4EB3612403F9DEC1@dekaexchange.deka.local>
In-Reply-To: <fa686aa40905200949q1fbeee8fy4b3a06d8e44d7c6b@mail.gmail.com>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
	<20090520064218.GA29102@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
	<9e4733910905200814p63915ff8pf65614dbb8dc9adf@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBF@dekaexchange.deka.local>
	<9e4733910905200829o423bf483h5b0b6dd202367872@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEC0@dekaexchange.deka.local>
	<fa686aa40905200949q1fbeee8fy4b3a06d8e44d7c6b@mail.gmail.com>
From: "Eric Millbrandt" <emillbrandt@dekaresearch.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----Original Message-----
From: Grant Likely [mailto:grant.likely@secretlab.ca]=20
Sent: Wednesday, May 20, 2009 12:49
To: Eric Millbrandt
Cc: Jon Smirl; Wolfram Sang; linuxppc-dev@ozlabs.org
Subject: Re: mpc5200 fec error

On Wed, May 20, 2009 at 10:41 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> It looks like the phy is never getting reset properly after the =
FEC_IEVENT_RFIFO_ERROR.  I threw some printk's into the fec mdio driver

Yes, that sounds familiar.  Most likely, the value of the MDIO bus
control register got clobbered and not reset when the FEC was reset.
Try adding this line to the beginning of mpc52xx_fec_mdio_transfer():

out_be32(&fec->mii_speed, 0x7e);

It's a dirty ugly hack, but it should help.  If that works, then I can
come up with a better solution.  Part of the problem is that the MDIO
handling in the current code really isn't very good.  I've got changes
queued up in -next which cleans it up quite a bit which should make it
easier to fix properly.

g.

That worked!  I'm still getting the fifo receive errors, but at least =
now the fec recovers.

[  127.761365] net eth0: FEC_IEVENT_RFIFO_ERROR=20
[  129.274341] PHY: f0003000:00 - Link is Down
[  130.274266] PHY: f0003000:00 - Link is Up - 100/Full
[  134.955324] net eth0: FEC_IEVENT_RFIFO_ERROR
[  136.273959] PHY: f0003000:00 - Link is Down
[  137.274090] PHY: f0003000:00 - Link is Up - 100/Full
[  140.521462] net eth0: FEC_IEVENT_RFIFO_ERROR
[  142.273955] PHY: f0003000:00 - Link is Down
[  143.273954] PHY: f0003000:00 - Link is Up - 100/Full
[  148.471582] net eth0: FEC_IEVENT_RFIFO_ERROR
[  150.273984] PHY: f0003000:00 - Link is Down
[  151.273901] PHY: f0003000:00 - Link is Up - 100/Full

Thanks Grant.


_________________________________________________________________________=
________________

This e-mail and the information, including any attachments, it contains =
are intended to be a confidential communication only to the person or =
entity to whom it is addressed and may contain information that is =
privileged. If the reader of this message is not the intended recipient, =
you are hereby notified that any dissemination, distribution or copying =
of this communication is strictly prohibited. If you have received this =
communication in error, please immediately notify the sender and destroy =
the original message.

Thank you.

Please consider the environment before printing this email.
