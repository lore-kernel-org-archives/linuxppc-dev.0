Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAF52B7DC1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 03:59:30 +1100 (EST)
In-Reply-To: <20100211163328.GC16348@lisas.de>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	<20100211163328.GC16348@lisas.de>
Subject: Re: Endian/__BYTE_ORDER question
To: Adrian Reber <adrian@lisas.de>
Message-ID: <OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Feb 2010 17:55:25 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adrian Reber <adrian@lisas.de> wrote on 2010/02/11 17:33:29:
>
> On Thu, Feb 11, 2010 at 05:17:37PM +0100, Joakim Tjernlund wrote:
> > I am getting confused about on how to test for Endian in the kernel code. In user
> > space one uses #if __BYTE_ORDER == __LITTLE_ENDIAN or #if __BYTE_ORDER == __BIG_ENDIAN
> >
> > I can see lots of kernel headers using this test too, but it doesn't seem
> > to be an arch specific file #defining __BYTE_ORDER. Instead I find files like:
> >  arch/alpha/math-emu/sfp-util.h
> >  arch/powerpc/include/asm/sfp-machine.h
> >  arch/s390/include/asm/sfp-util.h
> >  arch/sh/math-emu/sfp-util.h
> >
> > How is this supposed to work?
>
> I have no idea how it is actually done in the kernel code... but gcc
> defines it:
>
> gcc -dM -E -x c - <<<'' | grep ENDIAN
> #define __BIG_ENDIAN__ 1
> #define _BIG_ENDIAN 1

That doesn't define __BYTE_ORDER. Try the same gcc command
on a file that #includes <stdlib.h> and you will get both
__BIG_ENDIAN and __LITTLE_ENDIAN

     Jocke
