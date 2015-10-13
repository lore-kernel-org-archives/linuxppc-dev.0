Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D52C1A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 14:47:15 +1100 (AEDT)
In-Reply-To: <1444262666-6942-1-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc: Fix checkstop in native_hpte_clear() with lockdep
Message-Id: <20151013034715.43765140FDB@ozlabs.org>
Date: Tue, 13 Oct 2015 14:47:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-10 at 00:04:26 UTC, Cyril Bur wrote:
> native_hpte_clear() is called in real mode from two places:
> - Early in boot during htab initialisation if firmware assisted dump is
>   active.
> - Late in the kexec path.
> 
> In both contexts there is no need to disable interrupts are they are
> already disabled. Furthermore, locking around the tlbie() is only required
> for pre POWER5 hardware.
> 
> On POWER5 or newer hardware concurrent tlbie()s work as expected and on pre
> POWER5 hardware concurrent tlbie()s could result in deadlock. This code
> would only be executed at crashdump time, during which all bets are off,
> concurrent tlbie()s are unlikely and taking locks is unsafe therefore the
> best course of action is to simply do nothing. Concurrent tlbie()s are not
> possible in the first case as secondary CPUs have not come up yet.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fdf880a60835cd1dec256346

cheers
