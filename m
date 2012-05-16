Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
 [209.85.213.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 38C45B6F86
 for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2012 02:00:00 +1000 (EST)
Received: by yenm2 with SMTP id m2so845423yen.15
 for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2012 08:59:58 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1337179563.2985.80.camel@dabdike.int.hansenpartnership.com>
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337179563.2985.80.camel@dabdike.int.hansenpartnership.com>
Date: Wed, 16 May 2012 17:59:56 +0200
Message-ID: <CAMuHMdX13f4-3_Oe8bwZAnZpwDSV11Oxdgh--njiNGJ2KLAAww@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.4-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset=UTF-8
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, James Morris <jmorris@namei.org>,
 linux-kernel@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Dmitry Kasatkin <dmitry.kasatkin@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 16, 2012 at 4:46 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2012-05-16 at 10:47 +0200, Geert Uytterhoeven wrote:
>> On Wed, May 16, 2012 at 10:30 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> =C2=A0 + lib/mpi/generic_mpih-mul1.c: error: inconsistent operand
>> constraints in an 'asm': =C2=A0=3D> 50:70
>> =C2=A0 + lib/mpi/generic_mpih-mul2.c: error: inconsistent operand
>> constraints in an 'asm': =C2=A0=3D> 49:70
>> =C2=A0 + lib/mpi/generic_mpih-mul3.c: error: inconsistent operand
>> constraints in an 'asm': =C2=A0=3D> 49:70
>> =C2=A0 + lib/mpi/mpih-div.c: error: inconsistent operand constraints in =
an
>> 'asm': =C2=A0=3D> 135:122, 135:371, 97:122, 106:121, 106:370, 97:371
>>
>> parisc-allmodconfig
>
> Wow, lib/mpi/ is a complete horror: it's full of hand crafted asm code.
> The error in this case appears to be that umul_ppm() is implemented as
> an xmpyu instruction. =C2=A0That's a floating point instruction. =C2=A0We
> deliberately compile the kernel with floating point disabled because we
> don't want to save and restore the floating point register file on each
> context switch, hence the operand constraints are unsatisfiable.

It also does fishy things on m68k, cfr. https://lkml.org/lkml/2012/3/11/22

> It appears to be completely untested on non-x86 and to have been
> imported via the security tree ... what are we supposed to do with this?
> I thought the general principle was that asm code was really supposed to
> be confined to the arch directories?

Kick it out again, or contain it in staging?

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
