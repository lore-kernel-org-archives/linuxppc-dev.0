Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39A7367C2B
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 21:41:33 +1100 (EST)
In-Reply-To: <20061218161429.4ffeec4e.sfr@canb.auug.org.au>
References: <20061218161429.4ffeec4e.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AAD83AF0-5271-47AA-B278-E96A4E691F74@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] iSeries: supress lparmap.c warning
Date: Mon, 18 Dec 2006 11:41:08 +0100
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> lparmap.c: Assembler messages:
> lparmap.c:43: Warning: ignoring changed section attributes for .text
>
> We do not need the .section ops in the generated .s file, so
> just remove them.

Nasty stuff.

const struct LparMap __attribute__((__section__(".text"))) xLparMap = {

This will declare the .text section as non-executable.  Whoops.

Another way around this, which is perhaps a bit hacky but
doesn't require your post-processing, is to use

__section__(".text #")

which will cut off the compiler-generated "a" (where the assembler
wants "ax", which is the default)  :-)


Segher
