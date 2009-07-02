Return-Path: <emillbrandt@dekaresearch.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D20C0B70F6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 00:05:01 +1000 (EST)
Received: from dekaexchange.deka.local (mail.dekaresearch.com [208.65.175.196])
	by ozlabs.org (Postfix) with ESMTP id DC347DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 00:05:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
Date: Thu, 2 Jul 2009 09:51:07 -0400
Message-ID: <A88094362DE0AE49A118AB9B4EB3612403F9DF6C@dekaexchange.deka.local>
In-Reply-To: <fa686aa40907010744i21beefb2pa088a63fc5bae3d1@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de><9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
	<20090701085633.GB3144@pengutronix.de><9e4733910907010632g10706084o66720d4616e40865@mail.gmail.com>
	<20090701135547.GD3144@pengutronix.de>
	<fa686aa40907010744i21beefb2pa088a63fc5bae3d1@mail.gmail.com>
From: "Eric Millbrandt" <emillbrandt@dekaresearch.com>
To: "Wolfram Sang" <w.sang@pengutronix.de>,
	"Jon Smirl" <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----Original Message-----
From: =
linuxppc-dev-bounces+emillbrandt=3Ddekaresearch.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+emillbrandt=3Ddekaresearch.com@lists.ozlabs.=
o
rg] On Behalf Of Grant Likely
Sent: Wednesday, July 01, 2009 10:45
To: Wolfram Sang
Cc: linuxppc-dev@ozlabs.org; alsa-devel@alsa-project.org;
broonie@sirena.org.uk
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver

On Wed, Jul 1, 2009 at 7:55 AM, Wolfram Sang<w.sang@pengutronix.de>
wrote:
>
>> > Sorry, I didn't get it: Shall I test something specific?
>>
>> I don't own a touchscreen.
>>
>> AFAIK no one has ever plugged a touchscreen into the PCM-973 to see
if
>> works since there hasn't been a driver previously.
>> Just do a general
>> test so that you can tell customers that it works.
>
> I am not sure, we have a suitable touchscreen. Also, I am afraid this
is a bit
> too much to do besides my regular day work right now. Sorry.

I've now tested this on a client's board which uses the pcm030 with a
custom base board (based on the development board) which uses the same
codec.  It works there.  I don't have a discrete touchscreen to wire
up to the PCM-973 though.

g.

--=20

There is a header on the phytec PCM-973 base board (X20) that brings out
aux1, aux2, aux3, aux4 (wiper) ADCs from the wm9712.  The ADCs use chip
registers the same way the touchscreen does.  There is even support for
doing this through the wm97xx-core driver (wm97xx_read_aux_adc).  If you
wanted to test it out I would put a pot or some fixed voltage divider on
one of those inputs and give it a try.  I don't know what the internal
ADC ref is, I think its 1.65V so whatever signal you put in should be
less than that.

Eric


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
