Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3mJM4DXDzDt1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:21:07 +1100 (AEDT)
In-Reply-To: <20161021090417.GB3809@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [2/2] powerpc/64: Fix race condition in setting lock bit in
 idle/wakeup code
Message-Id: <3t3mJM26lwz9svs@ozlabs.org>
Date: Wed, 26 Oct 2016 21:21:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-21-10 at 09:04:17 UTC, Paul Mackerras wrote:
> This fixes a race condition where one thread that is entering or
> leaving a power-saving state can inadvertently ignore the lock bit
> that was set by another thread, and potentially also clear it.
> The core_idle_lock_held function is called when the lock bit is
> seen to be set.  It polls the lock bit until it is clear, then
> does a lwarx to load the word containing the lock bit and thread
> idle bits so it can be updated.  However, it is possible that the
> value loaded with the lwarx has the lock bit set, even though an
> immediately preceding lwz loaded a value with the lock bit clear.
> If this happens then we go ahead and update the word despite the
> lock bit being set, and when called from pnv_enter_arch207_idle_mode,
> we will subsequently clear the lock bit.
> 
> No identifiable misbehaviour has been attributed to this race.
> 
> This fixes it by checking the lock bit in the value loaded by the
> lwarx.  If it is set then we just go back and keep on polling.
> 
> Fixes: b32aadc1a8ed
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

I added: Cc: stable@vger.kernel.org # v4.2+

https://git.kernel.org/powerpc/c/09b7e37b18eecc1e347f4b1a3bc863

cheers
