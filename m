Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3mJS3n4JzDt4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:21:12 +1100 (AEDT)
In-Reply-To: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: markus@trippelsdorf.de, amodra@gmail.com
Subject: Re: powerpc: cmp -> cmpd for 64-bit
Message-Id: <3t3mJS0hfYz9sxS@ozlabs.org>
Date: Wed, 26 Oct 2016 21:21:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-10 at 13:42:19 UTC, Segher Boessenkool wrote:
> PowerPC's "cmp" instruction has four operands.  Normally people write
> "cmpw" or "cmpd" for the second cmp operand 0 or 1.  But, frequently
> people forget, and write "cmp" with just three operands.
> 
> With older binutils this is silently accepted as if this was "cmpw",
> while often "cmpd" is wanted.  With newer binutils GAS will complain
> about this for 64-bit code.  For 32-bit code it still silently assumes
> "cmpw" is what is meant.
> 
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

Applied to powerpc fixes, thanks.

I added:
  Fixes: 948cf67c4726 ("powerpc: Add NAP mode support on Power7 in HV mode")
  Cc: stable@vger.kernel.org # v3.0

https://git.kernel.org/powerpc/c/80f23935cadb1c654e81951f5a8b7c

cheers
