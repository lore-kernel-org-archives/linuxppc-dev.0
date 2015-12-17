Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 691041A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:31 +1100 (AEDT)
In-Reply-To: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/5] powerpc/rtas: Add rtas_call_unlocked()
Message-Id: <20151217115731.401DD1402C0@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-24-11 at 11:26:08 UTC, Michael Ellerman wrote:
> Most users of RTAS (Run-Time Abstraction Services) use rtas_call(),
> which deals with locking as well as endian handling.
> 
> However we have two users outside of rtas.c that can't use rtas_call()
> because they have different locking requirements.
> 
> The hotplug CPU code can't take the RTAS lock because the CPU would go
> offline with the lock held and no other CPUs would be able to call RTAS
> until the CPU came back online.
> 
> The xmon code doesn't want to take the lock because it would risk dead
> locking when we are trying to recover from a crash.
> 
> Both sites required multiple patches when we added little endian
> support, proving that programmers can't do endian right.
> 
> Although that ship has sailed, we can still clean the code up by
> providing an unlocked version of rtas_call() which avoids the need to
> open code the logic elsewhere.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/209eb4e5cbaba53ab555f3e7b4

cheers
