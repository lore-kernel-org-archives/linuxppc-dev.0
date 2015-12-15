Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E47CD1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 16:12:01 +1100 (AEDT)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C54C414030D
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 16:12:00 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so115930201pac.3
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 21:11:58 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, andrew.donnellan@au1.ibm.com,
 akpm@linux-foundation.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] powerpc: Enable UBSAN support
In-Reply-To: <1450154150.16234.5.camel@ellerman.id.au>
References: <1450151187-24041-1-git-send-email-dja@axtens.net>
 <1450154150.16234.5.camel@ellerman.id.au>
Date: Tue, 15 Dec 2015 16:11:43 +1100
Message-ID: <87zixcqos0.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi Daniel,
>
> Great work thanks for getting this going.
>

> Have you tried running with KVM?
>
> I'm wondering if we should be excluding some of the KVM code that runs in real mode, eg:
>
>   arch/powerpc/kvm/book3s_hv_rm_mmu.c
>   arch/powerpc/kvm/book3s_hv_rm_xics.c
>
> And maybe some other bits.
>
> Also the early setup code, a/p/k/setup*.c might be dicey.

My philosphy was just to copy the GCOV excludes, although you're right
that perhaps we want to be more aggressive in excluding here given that
the UBSAN handlers print a bunch of stuff. I'm happy to respin with
further exclusions - they're really easy to add.

> In all of the above it's probably OK unless you actually hit a warning at the
> wrong point, so testing will probably not find problems. Although I guess we
> could add some deliberatly incorrect code at certain points and check we
> survive the warning.

Yep. I'll run a kvm guest on an instrumented kernel and let you know
what happens!

>
> Is there an easy way to spot the calls to UBSAN in the generated code?

Yes - because of the handler functions, they're *really* easy to spot.
Here's some assembly for GregorianDay():


c00000000002924c:       6d 26 7e 48     bl      c00000000080b8b8 <__ubsan_handle_mul_overflow+0x8>
c000000000029250:       00 00 00 60     nop
c000000000029254:       38 fe ff 4b     b       c00000000002908c <GregorianDay+0xdc>
c000000000029258:       8c ff 62 3c     addis   r3,r2,-116
c00000000002925c:       01 00 a0 38     li      r5,1
c000000000029260:       78 db 64 7f     mr      r4,r27
c000000000029264:       50 9c 63 38     addi    r3,r3,-25520
c000000000029268:       41 26 7e 48     bl      c00000000080b8a8 <__ubsan_handle_sub_overflow+0x8>
c00000000002926c:       00 00 00 60     nop
c000000000029270:       44 fe ff 4b     b       c0000000000290b4 <GregorianDay+0x104>
c000000000029274:       8c ff 62 3c     addis   r3,r2,-116
c000000000029278:       78 d3 45 7f     mr      r5,r26
c00000000002927c:       e0 9c 63 38     addi    r3,r3,-25376
c000000000029280:       19 26 7e 48     bl      c00000000080b898 <__ubsan_handle_add_overflow+0x8>
c000000000029284:       00 00 00 60     nop
c000000000029288:       94 fe ff 4b     b       c00000000002911c <GregorianDay+0x16c>
c00000000002928c:       8c ff 62 3c     addis   r3,r2,-116
c000000000029290:       78 f3 c4 7f     mr      r4,r30
c000000000029294:       68 9c 63 38     addi    r3,r3,-25496
c000000000029298:       b1 21 7e 48     bl      c00000000080b448 <__ubsan_handle_out_of_bounds+0x8>
c00000000002929c:       00 00 00 60     nop
c0000000000292a0:       20 fe ff 4b     b       c0000000000290c0 <GregorianDay+0x110>
c0000000000292a4:       14 4a 24 7d     add     r9,r4,r9
c0000000000292a8:       40 48 a4 7f     cmpld   cr7,r4,r9
c0000000000292ac:       2c fe fd 41     bgt+    cr7,c0000000000290d8 <GregorianDay+0x128>

You can see that there are lots of calls to __ubsan_handle_blah_blah
inserted.

Regards,
Daniel

>
> cheers
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWb6EQAAoJEPC3R3P2I92F8OIP/0Tl82hkmf0nKU/eTDBNrzBT
1ja7HLOGdJKqMdOiS90WdvwnWVhX20bx36UnCnXa/nKBSywOvOAAc8sV+he4E/Vg
z192Bi9ly11AttqoCr4Gbh/+9VVLUrVmGW+IdAa8y8NXp99+aJ1j5ThgepT/Zyje
NO0YTP0ahimx5PVvmMLgaUhavxeOu535AvKFLso8z/2XXyg+q6GOAdI4HaNNjp2y
q6dkqLY+AUUksfgWk/TtAhaE40LaIHPjXPG3jw1cIrg9NWRzw/jnKoSoAU80nor/
l3kr1tXHNMkmIOAxujh4jobhXR91h9c7JoxoLqki8tPo2r/fRZgvBtn8hPhKxaLu
MBxbg7/VLKUb96f/LQ4o4iCkdkHeFKF9CMi8Nue26VhNImRfgruFZYMX0mtvoJup
KmIzX31EauNO5twlHKZKiu53ndvOnnVe0oqy7LMAKfkOIfF3k74Y8rxj4UMnr1vK
dF/JDL6jrbyoBnJZPL/KAk6WM/5UaMvlzUDRFfzkle/0dacYkl560uoQzScw1RtN
0YfzjK0AUsjmWIJD5ZXtpofSP4fxrMpFdxYBuY+fnkUAQwoY+QCAkxxpi5yC3Hp0
pTvBeCyUkCpCDlL2Xd2dax2wuW3Z2QpQgF1p12YidyP5SGWzxDZkOVvn3jHUOORe
j69iVbAccdU/5DZrPdYe
=braT
-----END PGP SIGNATURE-----
--=-=-=--
