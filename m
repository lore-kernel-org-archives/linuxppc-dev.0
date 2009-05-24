Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 8E456DE047
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:10:54 +1000 (EST)
Received: by qyk34 with SMTP id 34so4850295qyk.17
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 13:10:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090524185509.GA3561@pengutronix.de>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231305.17919.12239.stgit@terra>
	<20090524185509.GA3561@pengutronix.de>
Date: Sun, 24 May 2009 16:10:52 -0400
Message-ID: <9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200 audio DMA code
From: Jon Smirl <jonsmirl@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 2:55 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
>> Rewrite the mpc5200 audio DMA code to support both I2S and AC97. Make it=
 more robust.
>
> Why is it more robust?

I've implemented retries for when the AC97 hardware doesn't reset on
first try. About 10% of the time both the Efika and pcm030 AC97 codecs
don't reset on first try and need to be poked multiple times.  Failure
is indicated by not having the link clock start ticking. Every once in
a while even five pokes won't get the link started and I have to power
cycle.

I don't have an oscilloscope, after I get these basic drivers in maybe
someone can put a scope on this and figure out why reset is failing.
I've read the various datasheets and I believe my reset pulses have
the correct timings.

>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkoZmA0ACgkQD27XaX1/VRvugwCgsluxfp1rJH2MVFMTH6Yqo8bX
> dnIAn1z0QRIFEUJa0XpGFE937siwf8Cy
> =3DM0wP
> -----END PGP SIGNATURE-----
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
