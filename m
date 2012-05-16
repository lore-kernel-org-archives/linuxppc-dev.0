Return-Path: <dmitry.kasatkin@intel.com>
Received: from fmsmga102.fm.intel.com (mga10.intel.com [192.55.52.92])
 by ozlabs.org (Postfix) with ESMTP id 7AA16B6FFE
 for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2012 02:09:25 +1000 (EST)
Received: by pbbro8 with SMTP id ro8so1344673pbb.25
 for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2012 08:59:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337179563.2985.80.camel@dabdike.int.hansenpartnership.com>
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337179563.2985.80.camel@dabdike.int.hansenpartnership.com>
Date: Wed, 16 May 2012 18:59:33 +0300
Message-ID: <CALLzPKbEC0zwa0uRiLAkDYkRkL4EM8ZgSEn1DagqhZsT4MXgdQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.4-rc7
From: "Kasatkin, Dmitry" <dmitry.kasatkin@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset=UTF-8
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org,
 James Morris <jmorris@namei.org>, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 16, 2012 at 5:46 PM, James Bottomley
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
>
> It appears to be completely untested on non-x86 and to have been
> imported via the security tree ... what are we supposed to do with this?
> I thought the general principle was that asm code was really supposed to
> be confined to the arch directories?
>
> James
>
>

Yes.. it is suxx.
But it is only longlong.h and inherited from gpg..
And now there is a stuff such as /include/math-emu/soft-fp and
<stdlib/longlong.h>
I planned to look to that but now I will start doing it right away.

- Dmitry
