Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 171D71A0A70
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:42:33 +1100 (AEDT)
In-Reply-To: <20151021050314.GA17764@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/2] Revert "Use the POWER8 Micro Partition Prefetch Engine in
 KVM HV on POWER8"
Message-Id: <20151021114232.E770A14076E@ozlabs.org>
Date: Wed, 21 Oct 2015 22:42:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-21-10 at 05:03:14 UTC, Paul Mackerras wrote:
> This reverts commit 9678cdaae93932473f696fdea5debf3eee1e1260 because
> the original commit had multiple, partly self-cancelling bugs, that
> could cause occasional memory corruption.  In fact the logmpp instruction
> was using register r0 as the source of the buffer address and operation
> code, and depending on what was in r0, it would either do nothing or
> corrupt the 64k page pointed to by r0.  The logmpp instruction encoding
> and the operation code definitions could be corrected, but then there is
> the problem that there is no clearly defined way to know when the
> hardware has finished writing to the buffer.  The original commit
> attempted to work around this by aborting the write-out before starting
> the prefetch, but this is ineffective in the case where the virtual
> core is now executing on a different physical core from the one where
> the write-out was initiated.
> 
> These problems plus advice from the hardware designers not to use the
> function (since the measured performance improvement from using the
> feature was actually mostly negative), mean that reverting the code is
> the best option.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/23316316c1af0677a041c81f

cheers
