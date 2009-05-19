Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange.deka.local (mail.dekaresearch.com [208.65.175.196])
	by ozlabs.org (Postfix) with ESMTP id 00B81DE142
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 08:18:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: mpc5200 fec error
Date: Tue, 19 May 2009 18:21:45 -0400
Message-ID: <A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
In-Reply-To: <20090519205706.GD27476@pengutronix.de>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519203645.GW19843@pengutronix.de>
	<20090519205706.GD27476@pengutronix.de>
From: "Eric Millbrandt" <emillbrandt@dekaresearch.com>
To: "Wolfram Sang" <w.sang@pengutronix.de>,
	"Robert Schwebel" <r.schwebel@pengutronix.de>
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
From: Wolfram Sang [mailto:w.sang@pengutronix.de]=20
Sent: Tuesday, May 19, 2009 16:57
To: Robert Schwebel
Cc: Eric Millbrandt; linuxppc-dev@ozlabs.org
Subject: Re: mpc5200 fec error

On Tue, May 19, 2009 at 10:36:45PM +0200, Robert Schwebel wrote:
> Wolfram, have you seen this mail? You recently tested -rt on 2.6.29,
> right? Did you only test that on the customer hardware or also on the
> phyCORE-MPC5200B?

So far, I tried only on customer hardware, and that was 2.6.29.2-rt11.
With
that setup, I could work with NFS flawlessly, no real stress-testing
though.
Testing latest .3-rt is on my todo, will check the phyCOREs, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|

I am able to reproduce the error using 2.6.29.2-rt11.  I was able to
mitigate the problem by raising the priority of the transmit irq.
However when running an NFS server on the pcm030 under high cpu load I
now get

[  132.477503] net eth0: FEC_IEVENT_RFIFO_ERROR
[  132.892329] net eth0: FEC_IEVENT_RFIFO_ERROR
[  133.884109] net eth0: FEC_IEVENT_RFIFO_ERROR
[  134.876059] net eth0: FEC_IEVENT_RFIFO_ERROR

Raising the priority of the rx irq does not seem to fix this problem
though.


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
