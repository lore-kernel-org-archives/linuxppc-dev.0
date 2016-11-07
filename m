Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC6LM3KXFzDt1T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 20:18:19 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Larry Finger <Larry.Finger@lwfinger.net>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Petr
 Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
Date: Mon, 7 Nov 2016 09:18:06 +0000
Message-ID: <13471233.iqSeGS5aQ3@np-p-burton>
In-Reply-To: <8737j3n18r.fsf@concordia.ellerman.id.au>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
 <8737j3n18r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1851056.LmjgHU7tfE";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1851056.LmjgHU7tfE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 7 November 2016 19:27:32 GMT Michael Ellerman wrote:
> Paul Burton <paul.burton@imgtec.com> writes:
> > If a device tree specified a preferred device for kernel console output
> > via the stdout-path or linux,stdout-path chosen node properties there's
> > no guarantee that it will have specified a device for which we have a
> > driver. It may also be the case that we do have a driver but it doesn't
> > call of_console_check() to register as a preferred console (eg. offb
> > driver as used on powermac systems).
> > 
> > In these cases try to ensure that we provide some console output by
> > enabling the first usable registered console, which we keep track of
> > with the of_fallback_console variable. Affected systems will enable
> > their console later than they did prior to commit 05fd007e4629
> > ("console: don't prefer first registered if DT specifies stdout-path")
> > but should otherwise produce the same output.
> > 
> > Tested in QEMU with a PowerPC pseries_defconfig kernel.
> 
> Hi Paul,
> 
> This does "work", as in it boots and I get a console. But the delay in
> getting output on the VGA is not workable. I get pretty much no output
> until the machine is booted entirely to userspace, meaning any crash
> prior to that will be undebuggable.
> 
> I also note Andreas reports it doesn't work at all on PowerMac.
> 
> Please send a revert and we can try again next cycle.
> 
> cheers

Hi Michael,

A revert was already submitted by Hans de Goede & is being discussed over 
here:

https://marc.info/?l=linux-kernel&m=147826151427455&w=2

Thanks,
    Paul
--nextPart1851056.LmjgHU7tfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYIEbOAAoJEIIg2fppPBxlNZEP/0OLG7/kcCu6z1s4Z465k7nF
akJvKzD/Dr6lybtntyUN8gaPgJcEAMNDrZ0m1RrGG1s97q2Dh6AUV7zd1E6sUhxK
0aOfkfwC1zTO1Opchfwg+3z6N8pp/KX9ZT0EGECqE7SNB+NXZEgXEEVaNFrej4Zj
fnapY2DS3RMD9HV0e24cKxwYriEQAl9qbOW7pO6uNdY2fonpGJ6Fc5W/kGahxauT
tEa599biaclE4/tE1LWMy+badBjDpgGTNDZTfS813PK0zlChlacK75JLAFYhAjHO
kRMsNZY8I+vs1Br3fSlye9yQ5YfROd8Tk3BDVfW7O7lb4Q155gLTzdPOQ0j7vdI9
CwhcniYDIFqCLzhnWfWCqkzx09FSrbnoLKwYcWsxhHEACJ6eykpKQ64i2QVXw11b
otaxS+tpJNJJuYvDuYHeWAhaJCoByZ8c2KjQNbVEcgljG4Ws35I2cdm5Mvpjpws3
UdeV4RKcsqzZ8nWyN1AMdVm+dt4/2pSq/Sjdh6tEtVTXpoeY5aTro2oWvr4F8vzI
Qy7TPMdoZ8BFR4MVHJH8YF7ojtCeKs9IUmV9iKRtyGwyVoFGM9WtW2K5WZykxbXw
GqCltIDJ0+23HCOnSEYa4V7UKusU/k6ZJ/bLHK+7GCMSqECsCS+flqaSaMvyH9CV
x2TRsPB7BFs0No3bEos0
=BZb9
-----END PGP SIGNATURE-----

--nextPart1851056.LmjgHU7tfE--
