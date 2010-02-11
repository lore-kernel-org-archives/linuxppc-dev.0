Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B376B7D9E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 03:40:55 +1100 (EST)
Date: Thu, 11 Feb 2010 17:33:29 +0100
From: Adrian Reber <adrian@lisas.de>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Endian/__BYTE_ORDER question
Message-ID: <20100211163328.GC16348@lisas.de>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 11, 2010 at 05:17:37PM +0100, Joakim Tjernlund wrote:
> I am getting confused about on how to test for Endian in the kernel code. In user
> space one uses #if __BYTE_ORDER == __LITTLE_ENDIAN or #if __BYTE_ORDER == __BIG_ENDIAN
> 
> I can see lots of kernel headers using this test too, but it doesn't seem
> to be an arch specific file #defining __BYTE_ORDER. Instead I find files like:
>  arch/alpha/math-emu/sfp-util.h
>  arch/powerpc/include/asm/sfp-machine.h
>  arch/s390/include/asm/sfp-util.h
>  arch/sh/math-emu/sfp-util.h
> 
> How is this supposed to work?

I have no idea how it is actually done in the kernel code... but gcc
defines it:

gcc -dM -E -x c - <<<'' | grep ENDIAN
#define __BIG_ENDIAN__ 1
#define _BIG_ENDIAN 1

		Adrian
