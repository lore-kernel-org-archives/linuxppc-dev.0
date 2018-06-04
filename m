Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxft6xp6zF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:46 +1000 (AEST)
In-Reply-To: <20180502130729.24077-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [RFC,
 1/4] powerpc/64: Save stack pointer when we hard disable interrupts
Message-Id: <40zxfs5L7Mz9ryk@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 13:07:26 UTC, Michael Ellerman wrote:
> A CPU that gets stuck with interrupts hard disable can be difficult to
> debug, as on some platforms we have no way to interrupt the CPU to
> find out what it's doing.
> 
> A stop-gap is to have the CPU save it's stack pointer (r1) in its paca
> when it hard disables interrupts. That way if we can't interrupt it,
> we can at least trace the stack based on where it last disabled
> interrupts.
> 
> In some cases that will be total junk, but the stack trace code should
> handle that. In the simple case of a CPU that disable interrupts and
> then gets stuck in a loop, the stack trace should be informative.
> 
> We could clear the saved stack pointer when we enable interrupts, but
> that loses information which could be useful if we have nothing else
> to go on.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/7b08729cb272b4cd5c657cd5ac0ddd

cheers
