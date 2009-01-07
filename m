Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
	[212.227.17.6]) by ozlabs.org (Postfix) with ESMTP id 9B43B47514
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:17:15 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Building current git for 405 is broken
Date: Wed, 7 Jan 2009 15:10:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901071510.45923.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Benjamin,

commit 2a4aca114439 (powerpc/mm: Split low level tlb invalidate for nohash processors)
breaks building for 40x CPUs. This is what I get when building for the walnut board:

  CC      arch/powerpc/kernel/prom.o
In file included from arch/powerpc/kernel/prom.c:56:
arch/powerpc/mm/mmu_decl.h: In function '_tlbil_all':
arch/powerpc/mm/mmu_decl.h:34: error: expected ';' before '}' token
arch/powerpc/mm/mmu_decl.h:36: error: invalid storage class for function '_tlbil_pid'
arch/powerpc/mm/mmu_decl.h: In function '_tlbil_pid':
arch/powerpc/mm/mmu_decl.h:38: error: expected ';' before '}' token
arch/powerpc/mm/mmu_decl.h:53: warning: ISO C90 forbids mixed declarations and code
arch/powerpc/mm/mmu_decl.h:62: error: invalid storage class for function '_tlbivax_bcast'
arch/powerpc/kernel/prom.c:90: error: invalid storage class for function 'find_flat_dt_string'

Seems to be a result of some missing types or whatever. I suppose you are 
more familiar with that code than I am ;-)

Matthias
