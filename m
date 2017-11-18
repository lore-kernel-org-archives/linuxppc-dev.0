Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yfHbX1TvJzDrST
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Nov 2017 01:36:07 +1100 (AEDT)
Date: Sat, 18 Nov 2017 15:36:02 +0100
Message-ID: <20171118153602.Horde.MI0OsGbVxajNC565sIjEmw4@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Balbir Singh <bsingharora@gmail.com>, Meelis Roos <mroos@linux.ee>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel list
 <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: STRICT_KERNEL_RWX on PPC32 is broken on PowerMac G4
References: <20171116202839.Horde.gP0ycbGMQpT2Ragrd4TEog1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711162146260.3639@math.ut.ee>
 <20171117090609.Horde.DBRyYUc0XYQixQKoV-_Luw1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171606540.28670@math.ut.ee>
 <20171117161249.Horde.si1lm_DoTH5_kKAdDjlB8Q5@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171727120.29817@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1711171727120.29817@math.ut.ee>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Meelis Roos <mroos@linux.ee> a =C3=A9crit=C2=A0:

>> > > How early does it hang ? Any oops or trace ?
>> >
>> > Very early - instead oif kernel emssages, I see some repeated gibberis=
h
>> > of some characteers, and the background turns white.
>> > I am booting from yaboot, background is normally black.
>>
>> Ok, could you try by replacing #ifdef CONFIG_STRICT_KERNEL_RWX by #if 0
>> in arch/powerpc/lib/code-patching.c
>
> With this change and CONFIG_STRICT_KERNEL_RWX=3Dy, it still boots.
>
> BTW, I get these warnings (sorry for the word wrap from screen paste) -
> may they be related or rather not?
>
>   WRAP    arch/powerpc/boot/zImage.pmac
>   WRAP    arch/powerpc/boot/zImage.coff
>   WRAP    arch/powerpc/boot/zImage.miboot
> INFO: Uncompressed kernel (size 0x5d4c3c) overlaps the address of=20=20
>=20the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x600000)
>

Then i believe there is something wrong with commit=20=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20171115&id=3D37bc3e5fd764fb258ff4fcbb90b6d1b67fb466c1

Balbir, do you have any idea ?

Christophe

>
> And before that:
>
>   HOSTCC  arch/powerpc/boot/addnote
> arch/powerpc/boot/addnote.c: In function =E2=80=98main=E2=80=99:
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of=20macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^
> arch/powerpc/boot/addnote.c:73:23: note: in definition of macro
> =E2=80=98PUT_16BE=E2=80=99
>      buf[(off) + 1] =3D (v) & 0xff)
>                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro
> =E2=80=98PUT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro
> =E2=80=98PUT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:82:39: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>  #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
> arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width
> of type [-Wshift-count-overflow]
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>
> ^
> arch/powerpc/boot/addnote.c:83:25: note: in definition of macro
> =E2=80=98PUT_16LE=E2=80=99
>       buf[(off) + 1] =3D ((v) >> 8) & 0xff)
>                          ^
> arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro
> =E2=80=98PUT_32LE=E2=80=99
>  #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)
>>> 32L))
>                                                  ^~~~~~~~
> arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =E2=80=98PU=
T_64LE=E2=80=99
>      PUT_64LE(off, v))
>      ^~~~~~~~
> arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_FILESZ, nnote2);
>    ^~~~~~
>
>
> --
> Meelis Roos (mroos@linux.ee)
