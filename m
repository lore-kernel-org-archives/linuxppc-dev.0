Return-Path: <dzu@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AAF18DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 May 2008 02:39:00 +1000 (EST)
From: Detlev Zundel <dzu@denx.de>
To: rodolfo <rodolfo@lesc.ufc.br>
Subject: Re: Predefined Compiler Flag for CROSS_COMPILE in ELDK
References: <m2tzhjxorq.fsf@ohwell.denx.de>
	<8b6b0af3278e2fe8a9355b1e053e1419@lesc.ufc.br>
Date: Thu, 08 May 2008 18:38:11 +0200
In-Reply-To: <8b6b0af3278e2fe8a9355b1e053e1419@lesc.ufc.br>
	(rodolfo@lesc.ufc.br's message of "Thu, 8 May 2008 08:46:17 -0300")
Message-ID: <m24p98sqdo.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rodolfo,

> -mcpu is deprecated:
>
> HOSTCC  scripts/basic/fixdep
> `-mcpu=' is deprecated. Use `-mtune=' or '-march=' instead.
> scripts/basic/fixdep.c:1: error: bad value (405) for -mtune= switch
> make[1]: ** [scripts/basic/fixdep] Erro 1
> make: ** [scripts_basic] Erro 2

Uhu - HOSTCC is the native compiler, which very likely does not know
anything about 405 cpus...

> then I put -march=405 and give this errors:
>
> scripts/basic/fixdep.c:1: error: bad value (405) for -march= switch
> scripts/basic/fixdep.c:1: error: bad value (405) for -mtune= switch
> make[1]: ** [scripts/basic/fixdep] Erro 1
> make: ** [scripts_basic] Erro 2

Still, same problem - you want to use the flag for the cross compiler.

> See a piece of my Makefile:
>
> HOSTCC       = gcc
> HOSTCXX      = g++
> HOSTCFLAGS   = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> -march=405
> HOSTCXXFLAGS = -O2

Again, this is the host compiler.

> How can I do this?

If we are only talking about compiling a recent linux kernel, then the
easiest way is to simply override CFLAGS_KERNEL from the commandline,
i.e.:

make CFLAGS_KERNEL=-mcpu=405 uImage

If you want to check that this works, do a

make CFLAGS_KERNEL=-mcpu=405 V=1 uImage

and check the generated command lines.

Cheers
  Detlev

-- 
Alisa Sherer (AMD) suggested that consumer demand will not follow
faster clock speeds. Marketing might help with this problem, she
added.                                            -- 2004/02/20
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
