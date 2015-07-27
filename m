Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 186241A0065
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 17:39:00 +1000 (AEST)
Received: by pacan13 with SMTP id an13so48113932pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 00:38:59 -0700 (PDT)
Message-ID: <1437982623.6262.56.camel@axtens.net>
Subject: eeh-powernv.c: Unbalanced IRQ warning
From: Daniel Axtens <dja@axtens.net>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 27 Jul 2015 17:37:03 +1000
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-8FO0u+jML0FpeBXuuoxq"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8FO0u+jML0FpeBXuuoxq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

I've just rebased some CAPI patches on top of 4.2-rc4 and I'm getting a
new WARN relating to IRQs in EEH, which I believe is related to your
patch 79231448c929 ("powernv/eeh: Update the EEH code to use the opal
irq domain").

This is what I see after injecting a PHB fence on a CAPI card.

[  126.022390] EEH: Notify device driver to resume
[  126.022421] Unbalanced enable for IRQ 17
[  126.022432] ------------[ cut here ]------------
[  126.022440] WARNING: at /scratch/dja/linux-capi/kernel/irq/manage.c:511
[  126.022451] Modules linked in: cxl
[  126.022465] CPU: 3 PID: 123 Comm: eehd Not tainted 4.2.0-rc4-00013-g86ca=
a74-dirty #86
[  126.022479] task: c000000751b0af50 ti: c000000751b94000 task.ti: c000000=
751b94000
[  126.022493] NIP: c0000000000f1760 LR: c0000000000f175c CTR: c00000000060=
00c0
[  126.022509] REGS: c000000751b97710 TRAP: 0700   Not tainted  (4.2.0-rc4-=
00013-g86caa74-dirty)
[  126.022522] MSR: 9000000100029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 22008022  =
XER: 20000000
[  126.022560] CFAR: c0000000008a8680 SOFTE: 0=20
GPR00: c0000000000f175c c000000751b97990 c000000000e80c00 000000000000001c=
=20
GPR04: 0000000000000000 000000000000002c 00000000000000ff 000000000000001f=
=20
GPR08: c000000000d86cc0 c000000000d86cb8 c000000000d86cc0 0000000000000000=
=20
GPR12: 0000000042008028 c00000000fdc0d80 c0000000000bb460 c000000758162580=
=20
GPR16: 0000000000000000 0000000000000000 c00000074d3a1000 c000000000b35240=
=20
GPR20: c000000000b35210 c000000000b35278 c000000000b352e8 c000000000b2e2a8=
=20
GPR24: c0000000008d35b8 c0000000008d3510 c000000000efa408 c000000751b97c10=
=20
GPR28: 0000000000000000 c000000000d7a330 0000000000000011 c000000751eaec00=
=20
[  126.022735] NIP [c0000000000f1760] .__enable_irq+0x30/0xd0
[  126.022747] LR [c0000000000f175c] .__enable_irq+0x2c/0xd0
[  126.022756] Call Trace:
[  126.022764] [c000000751b97990] [c0000000000f175c] .__enable_irq+0x2c/0xd=
0 (unreliable)
[  126.022780] [c000000751b97a20] [c0000000000f1848] .enable_irq+0x48/0x90
[  126.022796] [c000000751b97ab0] [c00000000006ab00] .pnv_eeh_next_error+0x=
1f0/0x6f0
[  126.022812] [c000000751b97ba0] [c000000000035908] .eeh_handle_event+0xb8=
/0x2f0
[  126.022827] [c000000751b97c70] [c000000000035cf8] .eeh_event_handler+0x1=
b8/0x1c0
[  126.022844] [c000000751b97d30] [c0000000000bb564] .kthread+0x104/0x130
[  126.022860] [c000000751b97e30] [c0000000000095a4] .ret_from_kernel_threa=
d+0x58/0xb4
[  126.022874] Instruction dump:
[  126.022882] 7c0802a6 fbe1fff8 7c7f1b78 f8010010 f821ff71 81230170 2f8900=
00 409e0034=20
[  126.022915] 3c62ffcd 3863a730 487b6ec9 60000000 <0fe00000> 38210090 e801=
0010 ebe1fff8=20
[  126.022935] ---[ end trace 26e6323a0534e98d ]---

manage.c:511 suggests that this is probably the result of the IRQ being
enabled when it's already enabled.

Do you know what might be causing this and how it might be fixed?
Thanks in advance!

--=20
Regards,
Daniel

--=-8FO0u+jML0FpeBXuuoxq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVtd+gAAoJEPC3R3P2I92FdP4QAIg3LXJ3f6vgbtyVWJEju4sr
etJvA0XI8SK9XP8nniGfi+iknvIWrVKmpDSe6pRIbR3Tfh4e9XwG5Fqx5Y0ddjsX
TFzbR9J4525CHEJkfuKHoKInuPkOI0EY5/sr+Q4/2tw7QzKGSAWCfVp9mt+hqDU6
/hKD7uENlXbKBZcQ4ClfZoXR9YY7+8x7xios0jObAKnbHTfW/KeuKIX+K0cQmGT6
hMMA94e+lQ8iuv8p2i8yWN847Cv656uOow1qJJuwnFu8zMgPU1pAdtkW989GqODR
6G0zxuJlOS/Xv30FGYiTRZ7GInyPAkUfa3tpPopG9p9DOUY0jIwOvGcMHr/F5Sk3
aqMZ43g4TUh0lmLPrr2sLitwBMz4O37BhW9kCRgbqm1yRIMo1J6/iEHUWivgAE17
0xuxbp1MQxwjRnxhxRlwTmfc67vN3PdAxTczVgEywgp8yWvi1ROs4gP6D30r12X9
vFDy6Tz0FiPmILy6puTyXMadIUHtNZ/F+bWhRg92RiTPkK/ukq8oCgxdarveT/h5
mDPgrp70JgvAlYPd3NZvFiPOw1S7qIs3QmZtGdRhoZli4852k5ySQPMIxI1e7+/w
FdvZvyG5d71Eg3YHxDQ2JC8VuY338HoukwgEHBsML2ISWhpUcpj4hfWkmpqSjv89
/Ez7p2uFLdygBKtvaJ8u
=P1Ad
-----END PGP SIGNATURE-----

--=-8FO0u+jML0FpeBXuuoxq--
