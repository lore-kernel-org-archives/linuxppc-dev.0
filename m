Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
 [74.125.82.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419jKH1kkBzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 21:29:22 +1000 (AEST)
Received: by mail-ot0-f169.google.com with SMTP id l15-v6so3289637oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 04:29:22 -0700 (PDT)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 20 Jun 2018 13:29:08 +0200
Message-ID: <CA+7wUsykhuU5bFBY1BpLSeJE+hnE0DKmS8TXNmVKqL1-5CqeuA@mail.gmail.com>
Subject: arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=
 width of type [-Wshift-count-overflow]
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

For some reason I am seeing some new warning (W=3D0) on some old code.
Anyone else seeing them ?

  HOSTCC  arch/powerpc/boot/addnote
arch/powerpc/boot/addnote.c: In function =E2=80=98main=E2=80=99:
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:72:39: note: in definition of macro =E2=80=98PU=
T_16BE=E2=80=99
 #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
                                       ^
arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro =E2=80=98PUT=
_32BE=E2=80=99
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                           ^~~~~~~~
arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro =E2=80=98PUT=
_64BE=E2=80=99
 #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : \
                                                  ^~~~~~~~
arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98PUT=
_64=E2=80=99
   PUT_64(ph + PH_OFFSET, ns);
   ^~~~~~
arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width
of type [-Wshift-count-overflow]
 #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
                                               ^
arch/powerpc/boot/addnote.c:73:23: note: in definition of macro =E2=80=98PU=
T_16BE=E2=80=99
     buf[(off) + 1] =3D (v) & 0xff)
