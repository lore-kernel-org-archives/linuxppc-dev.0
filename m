Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (mailhost6-1.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yf6hN1j92zDrSP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 18:54:41 +1100 (AEDT)
Date: Sat, 18 Nov 2017 09:54:33 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: LEROY Christophe <christophe.leroy@c-s.fr>
cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: STRICT_KERNEL_RWX on PPC32 is broken on PowerMac G4
In-Reply-To: <20171117161249.Horde.si1lm_DoTH5_kKAdDjlB8Q5@messagerie.c-s.fr>
Message-ID: <alpine.LRH.2.21.1711171727120.29817@math.ut.ee>
References: <20171116202839.Horde.gP0ycbGMQpT2Ragrd4TEog1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711162146260.3639@math.ut.ee>
 <20171117090609.Horde.DBRyYUc0XYQixQKoV-_Luw1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171606540.28670@math.ut.ee>
 <20171117161249.Horde.si1lm_DoTH5_kKAdDjlB8Q5@messagerie.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > How early does it hang ? Any oops or trace ?
> >=20
> > Very early - instead oif kernel emssages, I see some repeated gibberi=
sh
> > of some characteers, and the background turns white.
> > I am booting from yaboot, background is normally black.
>=20
> Ok, could you try by replacing #ifdef CONFIG_STRICT_KERNEL_RWX by #if 0
> in arch/powerpc/lib/code-patching.c

With this change and CONFIG_STRICT_KERNEL_RWX=3Dy, it still boots.

BTW, I get these warnings (sorry for the word wrap from screen paste) -=20
may they be related or rather not?

  WRAP    arch/powerpc/boot/zImage.pmac
  WRAP    arch/powerpc/boot/zImage.coff
  WRAP    arch/powerpc/boot/zImage.miboot
INFO: Uncompressed kernel (size 0x5d4c3c) overlaps the address of the wra=
pper(0x400000)
INFO: Fixing the link_address of wrapper to (0x600000)


And before that:

  HOSTCC  arch/powerpc/boot/addnote
arch/powerpc/boot/addnote.c: In function =A1main=A2:
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:188:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:206:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro=20
=A1PUT_16BE=A2
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro=20
=A1PUT_16BE=A2
     buf[(off) + 1] =3D (v) & 0xff)
                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro=20
=A1PUT_32BE=A2
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro=20
=A1PUT_64BE=A2
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : =
\
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:82:39: note: in definition of macro=20
=A1PUT_16LE=A2
 #define PUT_16LE(off, v) (buf[off] =3D (v) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~
arch/powerpc/boot/addnote.c:85:73: warning: right shift count >=3D width=20
of type [-Wshift-count-overflow]
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                                        =20
^
arch/powerpc/boot/addnote.c:83:25: note: in definition of macro=20
=A1PUT_16LE=A2
      buf[(off) + 1] =3D ((v) >> 8) & 0xff)
                         ^
arch/powerpc/boot/addnote.c:85:49: note: in expansion of macro=20
=A1PUT_32LE=A2
 #define PUT_64LE(off, v) (PUT_32LE((off), (v)), PUT_32LE((off) + 4, (v)=20
>> 32L))
                                                 ^~~~~~~~
arch/powerpc/boot/addnote.c:95:5: note: in expansion of macro =A1PUT_64LE=
=A2
     PUT_64LE(off, v))
     ^~~~~~~~
arch/powerpc/boot/addnote.c:211:3: note: in expansion of macro =A1PUT_64=A2
   PUT_64(ph + PH_FILESZ, nnote2);
   ^~~~~~


--=20
Meelis Roos (mroos@linux.ee)
