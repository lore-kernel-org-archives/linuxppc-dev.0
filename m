Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 753111A1A2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 22:17:29 +1000 (AEST)
Date: Wed, 22 Jul 2015 07:17:15 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 mikey@neuling.org
Subject: Re: [RFC 5/8] powerpc/slb: Add documentation to runtime patching of
 SLB encoding
Message-ID: <20150722121715.GC11682@gate.crashing.org>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1437461926-8908-5-git-send-email-khandual@linux.vnet.ibm.com>
 <1437544263.16792.12.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437544263.16792.12.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 22, 2015 at 03:51:03PM +1000, Michael Ellerman wrote:
> How about:
> 
> 	/*
> 	 * This function patches either an li or a cmpldi instruction with
> 	 * a new immediate value. This relies on the fact that both li
> 	 * (which is actually ori) and cmpldi both take a 16-bit immediate
> 	 * value, and it is situated in the same location in the instruction,
> 	 * ie. bits 0-15.
> 	 * To patch the value we read the existing instruction, clear the
> 	 * immediate value, and or in our new value, then write the instruction
> 	 * back.
> 	 */

As Gabriel says, li is addi.  It takes a 16-bit sign-extended immediate,
while cmpldi takes a 16-bit zero-extended immediate.  This function
doesn't deal with that difference, it probably should (I didn't check if
the callers take care; there should be an assertion somewhere).


Segher
