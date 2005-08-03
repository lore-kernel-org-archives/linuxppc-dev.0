Return-Path: <frankvm@frankvm.com>
Received: from janus.localdomain (frankvm.xs4all.nl [80.126.170.174])
	by ozlabs.org (Postfix) with ESMTP id 0BEBA67E94
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2005 23:18:51 +1000 (EST)
Date: Wed, 3 Aug 2005 15:18:48 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050803131848.GA10954@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: bug in arch/ppc/boot/common/util.S: cmplwi  cr0,r3,r4 ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I think "cmplwi" expects an immediate vale as last operand
around line 255 of arch/ppc/boot/common/util.S:

	addi	r4,r4,_etext@l		# r8 = &_etext
1:	dcbf	r0,r3			# Flush the data cache
	icbi	r0,r3			# Invalidate the instruction cache
	addi	r3,r3,0x10		# Increment by one cache line
	cmplwi	cr0,r3,r4		# Are we at the end yet?
	               ^^
	blt	1b			# No, keep flushing and invalidating

I guess it should have been:

	cmplw	cr0,r3,r4		# Are we at the end yet?

-- 
Frank
