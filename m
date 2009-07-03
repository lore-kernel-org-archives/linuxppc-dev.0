Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 42328B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jul 2009 06:05:54 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 14E81DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2009 06:05:52 +1000 (EST)
Received: by fxm22 with SMTP id 22so2701310fxm.9
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2009 13:05:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090703174031.GA12410@cynthia.pants.nu>
References: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
	<20090703174031.GA12410@cynthia.pants.nu>
Date: Sat, 4 Jul 2009 01:35:50 +0530
Message-ID: <abe8a1fd0907031305r5cb9e2e8pec170bffb1c497ff@mail.gmail.com>
Subject: Re: Inline assembly queries [2]
From: kernel mailz <kernelmailz@googlemail.com>
To: Brad Boyer <flar@allandria.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Brad,
Thanks for responding.
My query was more on %U1%X1, I guess it is specifying U and/or X for %1 rig=
ht ?
what does U/X stand for (is it similar to u - unsigned and x for a hex addr=
ess)
are there any more literals like U/X/...

-Manish

On Fri, Jul 3, 2009 at 11:10 PM, Brad Boyer<flar@allandria.com> wrote:
> On Fri, Jul 03, 2009 at 12:14:41PM +0530, kernel mailz wrote:
>> Thanks for responding to my previous mail. A few more queries
>>
>> a. What is the use of adding format specifiers in inline assembly
>> like
>> asm volatile("ld%U1%X1 %0,%1":"=3Dr"(ret) : "m"(*ptr) : "memory");
>
> The format specifiers limit which registers or addressing modes will
> be chosen to access that parameter. For example, if you're using an
> instruction that treats r0 as a literal 0 value, you can't use the
> "r" specifier for that or you may see problems if it happens to allocate
> r0 for that particular argument. For memory access, the "m" lets you
> use any of the normal load/store patterns (which is why this particular
> choice also requires the "%U1%X1" part to allow changing the instruction)=
.
> The system was setup for an older style chip like x86 or 68k with many
> restrictions on which registers can be used where and large numbers of
> different addressing modes for accessing memory. It's a little clumsy
> for ppc by comparison to most other chips, but it's a fundamental part
> of inline assembly processing in gcc.
>
>> b. using m or Z =A0with a memory address. I tried replacing m/Z but no c=
hange
>> Is there some guideline ?
>> gcc documentation says Z is obsolete. Is m/Z replaceable ?
>
> No idea. I don't remember ever seeing 'Z' used in anything. Maybe somebod=
y
> else remembers what it used to mean.
>
> =A0 =A0 =A0 =A0Brad Boyer
> =A0 =A0 =A0 =A0flar@allandria.com
>
>
