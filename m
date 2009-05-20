Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 9BAF2DE1CA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 03:42:16 +1000 (EST)
Received: by gxk20 with SMTP id 20so893881gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 10:42:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <A88094362DE0AE49A118AB9B4EB3612403F9DEC1@dekaexchange.deka.local>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
	<20090520064218.GA29102@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
	<9e4733910905200814p63915ff8pf65614dbb8dc9adf@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBF@dekaexchange.deka.local>
	<9e4733910905200829o423bf483h5b0b6dd202367872@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEC0@dekaexchange.deka.local>
	<fa686aa40905200949q1fbeee8fy4b3a06d8e44d7c6b@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEC1@dekaexchange.deka.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 11:41:55 -0600
Message-ID: <fa686aa40905201041v101a6f18icf62620a035386b9@mail.gmail.com>
Subject: Re: mpc5200 fec error
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ed: quoting repaired]
On Wed, May 20, 2009 at 11:26 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> Grant Likely wrote:
> > Yes, that sounds familiar. =A0Most likely, the value of the MDIO bus
> > control register got clobbered and not reset when the FEC was reset.
> > Try adding this line to the beginning of mpc52xx_fec_mdio_transfer():
> >
> > out_be32(&fec->mii_speed, 0x7e);
> >
> > It's a dirty ugly hack, but it should help. =A0If that works, then I ca=
n
> > come up with a better solution. =A0Part of the problem is that the MDIO
> > handling in the current code really isn't very good. =A0I've got change=
s
> > queued up in -next which cleans it up quite a bit which should make it
> > easier to fix properly.
>
> That worked! =A0I'm still getting the fifo receive errors, but at least n=
ow the fec recovers.

Okay, I'll see if I can work that into a cleaner patch.  In fact, I
should look into reworking it so that the PHY doesn't get reset on a
FIFO error.  It shouldn't need to be reset at all AFAIKT.  That way
even when FIFO errors occur, they should not cause an expensive
renegotiate time.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
