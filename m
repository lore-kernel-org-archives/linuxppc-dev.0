Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D54B26855F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 08:44:11 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Noah yan <noah.yan@gmail.com>
In-Reply-To: <59521b110510270605k6e098826w2d37c50e82ddd758@mail.gmail.com>
References: <59521b110510270605k6e098826w2d37c50e82ddd758@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 08:37:10 +1000
Message-Id: <1130452630.29054.77.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How the linux use BAT
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-10-27 at 08:05 -0500, Noah yan wrote:
> I am studying source code for power mac. I am curious how linux use
> the BAT MMU. 
> The address translation of BAT MMU is parallel with that of
> segment/page MMU. BAT MMU is known as superpages in other
> architecture. 
> I am not good at the kernel coding part, hope that my questions share
> the common fundermental with you and no stupid. 
> 
> Here  is my questions:
> Is the kernel turn BAT MMU on? if so, a BAT array have been setup for
> that, which part of the kernel code does this? 
> If BAT MMU is used, how about segment/page address translation in
> kernel, is this also enabled and page table is setup? 
> 
> If both BAT and seg/page are enabled, how the kernel make sure that
> the correct one is used in adress translation?

Both are used and they don't overlap (well, they can overlap but if they
do, the BAT takes over).

> Is kernel really use the segment MMU of the powerpc, I have an
> impression that most kernel only use the page MMU?

page MMU vs. segment MMU ? hrm... what do you mean ? :) There is one MMU
in the "classsic" PowerPC and it does segment and hash table, you have to
use both, you can't just use one or the other :) You virtual addresses
go through the segments first to get the vsid which is then used along
with the remaining bits of the address to hash into the hash table in
order to get to the translations.

The way linux uses BATs is for the kernel linear mapping. Linux uses by
default (though that can be configued differently) a 3G/1G split, that
is the low 3G of address space are used by userland (and covered by the
user page tables) and the high 1G are used by the kernel. That kernel
space itself is split into a bottom part up to 768Mb (by default, that
can also be configured differently) which is the linear mapping, that is
a single linear mapping of all RAM from 0xc0000000. The rest of the
kernel space is mapped with page tables and known as the kernel virtual
space, used for vmalloc and ioremap.

The BATs are used for the linear mapping. They "override" the page
tables over it if any (though we usually don't bother setting up PTEs
over the space that is BAT mapped). They basically improve performances
by not requiring to go through the hash trasnslation for most kernel
accesses to memory and not using space in the TLB/ERAT.

Ben.
