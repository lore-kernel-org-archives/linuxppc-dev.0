Return-Path: <chainsaw@gentoo.org>
Received: from smtp2.irishbroadband.ie (smtp2.irishbroadband.ie [62.231.32.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp2.irishbroadband.ie",
	Issuer "smtp2.irishbroadband.ie" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1C8CD679F9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 05:57:32 +1000 (EST)
Message-ID: <446B721D.8020203@gentoo.org>
Date: Wed, 17 May 2006 19:57:33 +0100
From: Tony Vroon <chainsaw@gentoo.org>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
In-Reply-To: <1147860564.14395.6.camel@johannes>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Berg wrote:
> Hey,
> 
> Currently snd-aoa is known to work on the following machines:
> * PowerBook5,8
> * PowerBook5,7
> * PowerMac8,1
> * PowerMac8,2
> * 17" October 2005 PowerBook (don't know the number)

That would be the PowerBook 5,9 (confirmed working, that's what I have).

> * PowerMac11,2
> * PowerBook6,8
> and my
> * PowerBook5,6

> People with those machines are encouraged to use and stress-test it, it
> also provides much better hardware support than snd-powermac, for
> example it can actually reprogram the hardware if you have a 48KHz file
> instead of having to digitally downsample it to 44.1KHz like required
> with snd-powermac in most cases.

When writing documentation, you might want to add that the ALSA-plugin
in XMMS & Audacious requires a period time of 100ms instead of the
default of 50ms, as otherwise the sou*click*nd is n*click*ot ver*click*y
good.
(A look at the current code of that plugin, to see how the volume
control code can be fixed would be highly appreciated)

> There are apparently some cases where it loses interrupts and then the
> sound is garbled, my brother's investigating that at the moment, it
> doesn't happen with my powerbook nor with my powermac.

Not seen this, although I must say it does not resume from sleep as
gracefully as I have seen you describe it.

> But the other reason for writing this mail is that I finally found the
> last remaining bug that prevented sound module autoloading! :)

Much appreciated, thank you :)

> Now, when you boot, mac-io is already built-in so provides the i2s
> device, which my i2sbus module binds to. Since udev synthesizes events,
> i2sbus gets loaded automatically. Now, i2sbus creates uevents on its
> own, with the layout number given as the MODALIAS. Hence, the layout
> fabric module is loaded because it has an alias for all the layouts it
> handles, and it in turn requests all the codec modules that it requires.
> Also, this means that 'modprobe i2sbus' will suffice to get the driver
> up and running without a reboot, provided that all modules are
> installed.
> 
> Have fun,
> johannes

Regards,
Tony V.
(Chainsaw)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEa3Icp5vW4rUFj5oRAuFXAJwMgzHiZLal33irvZt6qtDbo1L+rQCbBb4d
KF5TAISi/CUHYj+ZqJjPpFE=
=ptuO
-----END PGP SIGNATURE-----
