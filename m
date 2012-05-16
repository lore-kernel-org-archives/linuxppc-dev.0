Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78C9AB6FD7
 for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2012 18:47:16 +1000 (EST)
Received: by yhfq11 with SMTP id q11so518317yhf.15
 for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2012 01:47:13 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
Date: Wed, 16 May 2012 10:47:13 +0200
Message-ID: <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.4-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 16, 2012 at 10:30 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.4-rc7 to v3.4-rc6[3], the summaries are:
> =C2=A0- build errors: +15/-14

15 regressions:
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'enum
fsl_diu_monitor_port' declared inside parameter list [-Werror]:  =3D>
70:9, 84:9, 88:36
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'return' with
a value, in function returning void [-Werror]:  =3D> 189:2
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: function
declaration isn't a prototype [-Werror=3Dstrict-prototypes]:  =3D> 69:5,
88:6, 83:6, 187:1
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: its scope is
only this definition or declaration, which is probably not what you
want [-Werror]:  =3D> 70:9
  + drivers/virt/fsl_hypervisor.c: error: 'MSR_GS' undeclared (first
use in this function):  =3D> 799:80

powerpc randconfig

  + arch/x86/include/asm/uaccess_32.h: error: call to
'copy_from_user_overflow' declared with attribute error:
copy_from_user() buffer size is not provably correct:  =3D> 211:26

error in i386-randconfig, warning in i386-defconfig

  + drivers/ptp/ptp_pch.c: error: implicit declaration of function
'kfree' [-Werror=3Dimplicit-function-declaration]:  =3D> 576:2
  + drivers/ptp/ptp_pch.c: error: implicit declaration of function
'kzalloc' [-Werror=3Dimplicit-function-declaration]:  =3D> 587:2

Patch send.

  + error: "handle_edge_irq" [drivers/gpio/gpio-pch.ko] undefined!:  =3D> N=
/A
  + error: "irq_to_desc" [drivers/gpio/gpio-pch.ko] undefined!:  =3D> N/A

Fixed in the mean time, I guess.

  + error: No rule to make target include/config/auto.conf:  =3D> N/A

x86_64-randconfig

  + lib/mpi/generic_mpih-mul1.c: error: inconsistent operand
constraints in an 'asm':  =3D> 50:70
  + lib/mpi/generic_mpih-mul2.c: error: inconsistent operand
constraints in an 'asm':  =3D> 49:70
  + lib/mpi/generic_mpih-mul3.c: error: inconsistent operand
constraints in an 'asm':  =3D> 49:70
  + lib/mpi/mpih-div.c: error: inconsistent operand constraints in an
'asm':  =3D> 135:122, 135:371, 97:122, 106:121, 106:370, 97:371

parisc-allmodconfig

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
