Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78D5CB70E8
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2012 05:57:02 +1000 (EST)
Received: by obbuo13 with SMTP id uo13so6897815obb.15
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2012 12:56:59 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 17 Jun 2012 21:56:59 +0200
Message-ID: <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, Chris Zankel <chris@zankel.net>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 17, 2012 at 9:46 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.5-rc3 to v3.5-rc2[3], the summaries are:
> =C2=A0- build errors: +235/-10

Truckloads of powerpc "Unrecognized opcode" breakage, and

  + arch/mips/include/asm/bitops.h: error: static declaration of 'fls'
follows non-static declaration:  =3D> 615:50
  + include/asm-generic/bitops/fls64.h: error: static declaration of
'fls64' follows non-static declaration:  =3D> 26:81, 18:81
  + include/linux/bitops.h: error: conflicting types for 'fls_long':  =3D> =
160:55

various mips

  + drivers/edac/mpc85xx_edac.c: error: too few arguments to function
'edac_mc_alloc':  =3D> 983:90

powerpc-randconfig

  + drivers/net/ethernet/dlink/de600.c: error: expected expression
before 'do':  =3D> 146:2, 301:3, 210:3, 150:2, 468:2, 404:2, 208:3,
495:3, 328:2, 138:2, 499:2, 217:3, 417:2, 136:2, 300:3, 464:2, 501:2,
493:2, 206:2, 216:3, 254:4, 350:2, 196:3, 137:2, 405:2, 463:2
  + drivers/scsi/pcmcia/sym53c500_cs.c: error: expected expression
before 'do':  =3D> 453:4, 434:4, 574:2, 371:2
  + drivers/scsi/qlogicfas408.c: error: expected expression before
'do':  =3D> 234:2, 221:2, 312:3, 583:2, 535:2, 324:3, 85:2, 406:2,
316:5, 569:9, 89:3, 230:2, 546:2
  + drivers/staging/wlags49_h2/hcf.c: error: expected expression
before 'do':  =3D> 3375:4, 3592:3, 4378:3, 1135:3, 1203:3, 3593:3,
4731:3, 3653:3, 704:4, 3802:3, 1150:2, 1209:2, 3645:10, 4178:2,
3699:5, 3007:5, 4033:2, 787:3, 2646:4, 1190:2, 3797:3, 717:3, 2630:3,
4732:3, 703:4, 3582:2, 751:5, 2629:3, 755:5, 3507:3, 1153:2, 750:5,
3057:4, 781:4, 2654:4, 3700:5
  + drivers/staging/wlags49_h25/../wlags49_h2/hcf.c: error: expected
expression before 'do':  =3D> 3375:4, 3592:3, 4378:3, 1135:3, 1203:3,
3593:3, 4731:3, 3653:3, 704:4, 3802:3, 1150:2, 1209:2, 3645:10,
3699:5, 4033:2, 787:3, 2646:4, 1190:2, 717:3, 2630:3, 4732:3, 703:4,
3582:2, 751:5, 2629:3, 755:5, 3507:3, 1153:2, 750:5, 3057:4, 781:4,
2654:4, 3700:5

sh-allyesconfig/sh-allmodconfig

  + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
declaration of function 'pci_iomap'
[-Werror=3Dimplicit-function-declaration]:  =3D> 90:3
  + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
declaration of function 'pci_iounmap'
[-Werror=3Dimplicit-function-declaration]:  =3D> 142:2

xtensa

  + error: "__ashrdi3" [fs/ntfs/ntfs.ko] undefined!:  =3D> N/A
  + error: "__lshrdi3" [fs/ntfs/ntfs.ko] undefined!:  =3D> N/A

sh4/landisk_defconfig

  + error: "__ashrdi3" [fs/xfs/xfs.ko] undefined!:  =3D> N/A
  + error: "__lshrdi3" [drivers/mtd/mtd.ko] undefined!:  =3D> N/A
  + error: "__lshrdi3" [fs/xfs/xfs.ko] undefined!:  =3D> N/A

sh4/titan_defconfig

  + error: No rule to make target include/config/auto.conf:  =3D> N/A

x86_64-randconfig

  + kernel/sys.c: error: 'mmap_min_addr' undeclared (first use in this
function):  =3D> 1864:34, 1864:2
  + security/security.c: error: 'BDI_CAP_EXEC_MAP' undeclared (first
use in this function):  =3D> 688:16, 688:3
  + security/security.c: error: dereferencing pointer to incomplete
type:  =3D> 687:36

sh-allyesconfig/sh-allmodconfig/sh-randconfig

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
