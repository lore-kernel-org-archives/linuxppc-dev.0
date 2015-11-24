Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2EFAD1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:58:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id EF8391401E7
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2015 22:58:11 +1100 (AEDT)
Message-ID: <1448366286.32654.4.camel@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc/rtas: Add rtas_call_unlocked()
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Date: Tue, 24 Nov 2015 22:58:06 +1100
In-Reply-To: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
References: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-24 at 22:26 +1100, Michael Ellerman wrote:

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
> 
> commit 98bd678fc89575d0f4026a3ced3de19d90d1fe72
> Author: Michael Ellerman <mpe@ellerman.id.au>
> Date:   Fri May 15 16:40:48 2015 +1000
> 
>     powerpc/rtas: Add rtas_call_unlocked(), make enter_rtas() private

... wut.

Obviously I fubared the commit message a bit here while rebasing.

cheers
