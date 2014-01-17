Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x232.google.com (mail-pb0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D17A42C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 13:21:25 +1100 (EST)
Received: by mail-pb0-f50.google.com with SMTP id rq2so3465495pbb.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 18:21:23 -0800 (PST)
Date: Fri, 17 Jan 2014 10:20:05 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Kernel stack overflows due to  "powerpc: Remove ksp_limit on
 ppc64" with v3.13-rc8 on ppc32 (P2020)
Message-ID: <20140117022005.GA29880@pek-khao-d1.corp.ad.wrs.com>
References: <20140116180532.GA1616@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <20140116180532.GA1616@roeck-us.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 10:05:32AM -0800, Guenter Roeck wrote:
> Hi all,
>=20
> I am getting kernel stack overflows with v3.13-rc8 on a system with P2020=
 CPU.
> The kernel is patched for the target, but I don't think that is related.
> Stack overflows are in different areas, but always in calls from __do_sof=
tirq.
>=20
> Crashes happen reliably either during boot or if I put any kind of load
> onto the system.

How about the following fix:

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index e47d268727a4..52fffe5616b4 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -61,7 +61,7 @@ _GLOBAL(call_do_irq)
 	mflr	r0
 	stw	r0,4(r1)
 	lwz	r10,THREAD+KSP_LIMIT(r2)
-	addi	r11,r3,THREAD_INFO_GAP
+	addi	r11,r4,THREAD_INFO_GAP
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
 	mr	r1,r4
 	stw	r10,8(r1)

Thanks,
Kevin
>=20
> Example:
>=20
> Kernel stack overflow in process eb3e5a00, r1=3Deb79df90
> CPU: 0 PID: 2838 Comm: ssh Not tainted 3.13.0-rc8-juniper-00146-g19eca00 =
#4
> task: eb3e5a00 ti: c0616000 task.ti: ef440000
> NIP: c003a420 LR: c003a410 CTR: c0017518
> REGS: eb79dee0 TRAP: 0901   Not tainted (3.13.0-rc8-juniper-00146-g19eca0=
0)
> MSR: 00029000 <CE,EE,ME>  CR: 24008444  XER: 00000000
> GPR00: c003a410 eb79df90 eb3e5a00 00000000 eb05d900 00000001 65d87646 000=
00000
> GPR08: 00000000 020b8000 00000000 00000000 44008442
> NIP [c003a420] __do_softirq+0x94/0x1ec
> LR [c003a410] __do_softirq+0x84/0x1ec
> Call Trace:
> [eb79df90] [c003a410] __do_softirq+0x84/0x1ec (unreliable)
> [eb79dfe0] [c003a970] irq_exit+0xbc/0xc8
> [eb79dff0] [c000cc1c] call_do_irq+0x24/0x3c
> [ef441f20] [c00046a8] do_IRQ+0x8c/0xf8
> [ef441f40] [c000e7f4] ret_from_except+0x0/0x18
> --- Exception: 501 at 0xfcda524
>     LR =3D 0x10024900
> Instruction dump:
> 7c781b78 3b40000a 3a73b040 543c0024 3a800000 3b3913a0 7ef5bb78 48201bf9
> 5463103a 7d3b182e 7e89b92e 7c008146 <3ba00000> 7e7e9b78 48000014 57fff87f
> Kernel panic - not syncing: kernel stack overflow
> CPU: 0 PID: 2838 Comm: ssh Not tainted 3.13.0-rc8-juniper-00146-g19eca00 =
#4
> Call Trace:
> Rebooting in 180 seconds..
>=20
> Reverting the following commit fixes the problem.
>=20
> cbc9565ee8 "powerpc: Remove ksp_limit on ppc64"
>=20
> Should I submit a patch reverting this commit, or is there a better way t=
o fix
> the problem on short notice (given that 3.13 is close) ?
>=20
> Thanks,
> Guenter
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS2JNVAAoJEJNY7TDerrFx4mIH/0NCGFnzKd2wB9jYylT9s95s
zqjoUQDidcI8QsUGKESx5uxeucBapJSwmjkxiEw66duSaUydB2Sb+bY1K5aDjR8H
krAQ6f8etuvbIrz4V+vHObo47MM82iakLt31WaRxwknBwKdmOsgm0nkNGlwb/afg
MObd12YQuZt7lOg1Vb6SwYAbqitklq869ukHw6Mqr0c7OrjYhl3dg1L61u5orssI
HsYedR/kutyb80Mgu70xka3uf5GpoT6ohu/FGjW1XMGFN4pv7yrtojiEw8RpM8j6
bdziZFfgmaDhHtMrIGTHIj+BeCfVenFODoAwZlkC7rPhaK2RmJJ+wa1xxHoySTk=
=U9L+
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
