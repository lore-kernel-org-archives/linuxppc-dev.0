Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8BA9B6F65
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 18:20:43 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id CE92E25855B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 10:13:35 +0200 (CEST)
Subject: [RFC] Optimize __arch_swab32 and __arch_swab16
To: linuxppc-dev@ozlabs.org
Message-ID: <OF9F5D0B06.A12659DA-ONC12578E9.002B23BB-C12578E9.002D304C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Aug 2011 10:13:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


PPC __arch_swab32 and __arch_swab16 generates non optimal code.
It doesn't schedule very well, need to copy its input register and
and swab16 needs an extra insn to clear its upper bits. I have improved
these functions(see my__xx). Any problem with the new asm? If
not I will send a patch.

Below some example code to illustrate:

#include <stdio.h>

unsigned long __arch_swab32(unsigned long value)
{
	unsigned long result;

	__asm__("rlwimi %0,%1,24,16,23\n\t"
	    "rlwimi %0,%1,8,8,15\n\t"
	    "rlwimi %0,%1,24,0,7"
	    : "=r" (result)
	    : "r" (value), "0" (value >> 24));
	return result;
}

unsigned long my__arch_swab32(unsigned long value)
{
	unsigned long tmp;

	__asm__("rlwimi %0,%0,24,0xffffffff"
		: "+r" (value));
	__asm__("rlwinm %0,%1,16,0xffffffff"
		: "=r" (tmp), "+r" (value));
	__asm__("rlwimi %0,%1,0,0x00ff0000"
		: "+r" (value), "+r" (tmp));
	__asm__("rlwimi %0,%1,0,0x000000ff"
		: "+r" (value), "+r" (tmp));
	return value;
}

unsigned short __arch_swab16(unsigned short value)
{
	unsigned short result;

	__asm__("rlwimi %0,%1,8,16,23"
	    : "=r" (result)
	    : "r" (value), "0" (value >> 8));
	return result;
}

unsigned short my__arch_swab16(unsigned short value)
{
	__asm__("rlwimi %0,%0,16,0x00ff0000"
		: "+r" (value));
	__asm__("rlwinm %0,%0,24,0x0000ffff"
		: "+r"(value));
	return value;
}

main()
{
	unsigned long x=0x12345678, y;

	y = my__arch_swab32(x);
	printf("swab32 x:%x, y:%x\n", x, y);
	y = my__arch_swab16(x);
	printf("swab16 x:%x, y:%x\n", x, y);
}

Generated asm:

	.file	"tst.c"
	.section	".text"
	.align 2
	.globl __arch_swab32
	.type	__arch_swab32, @function
__arch_swab32:
	mr %r0,%r3
	srwi %r3,%r3,24
#APP
	rlwimi %r3,%r0,24,16,23
	rlwimi %r3,%r0,8,8,15
	rlwimi %r3,%r0,24,0,7
#NO_APP
	blr
	.size	__arch_swab32, .-__arch_swab32
	.align 2
	.globl my__arch_swab32
	.type	my__arch_swab32, @function
my__arch_swab32:
#APP
	rlwimi %r3,%r3,24,0xffffffff
	rlwinm %r0,%r3,16,0xffffffff
	rlwimi %r3,%r0,0,0x00ff0000
	rlwimi %r3,%r0,0,0x000000ff
#NO_APP
	blr
	.size	my__arch_swab32, .-my__arch_swab32
	.align 2
	.globl __arch_swab16
	.type	__arch_swab16, @function
__arch_swab16:
	mr %r0,%r3
	srwi %r3,%r3,8
#APP
	rlwimi %r3,%r0,8,16,23
#NO_APP
	rlwinm %r3,%r3,0,0xffff
	blr
	.size	__arch_swab16, .-__arch_swab16
	.align 2
	.globl my__arch_swab16
	.type	my__arch_swab16, @function
my__arch_swab16:
#APP
	rlwimi %r3,%r3,16,0x00ff0000
	rlwinm %r3,%r3,24,0x0000ffff
#NO_APP
	blr
	.size	my__arch_swab16, .-my__arch_swab16
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 2
.LC0:
	.string	"swab32 x:%x, y:%x\n"
	.align 2
.LC1:
	.string	"swab16 x:%x, y:%x\n"
	.section	".text"
	.align 2
	.globl main
	.type	main, @function
main:
	mflr %r0
	lis %r3,0x1234
	stwu %r1,-16(%r1)
	ori %r3,%r3,22136
	stw %r0,20(%r1)
	bl my__arch_swab32
	mr %r5,%r3
	lis %r4,0x1234
	lis %r3,.LC0@ha
	ori %r4,%r4,22136
	la %r3,.LC0@l(%r3)
	bl printf
	li %r3,22136
	bl my__arch_swab16
	lis %r4,0x1234
	mr %r5,%r3
	lis %r3,.LC1@ha
	la %r3,.LC1@l(%r3)
	ori %r4,%r4,22136
	bl printf
	lwz %r0,20(%r1)
	addi %r1,%r1,16
	mtlr %r0
	blr
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.9)"
