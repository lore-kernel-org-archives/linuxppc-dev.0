Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Gt6DFHzDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:15:18 +1100 (AEDT)
In-Reply-To: <1480043229-2363-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: peterz@infradead.org, xinhui.pan@linux.vnet.ibm.com
Subject: Re: powerpc: Fix __cmpxchg() to take a volatile ptr again
Message-Id: <3tS5Gs6KZYz9vFt@ozlabs.org>
Date: Mon, 28 Nov 2016 23:15:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-25 at 03:07:09 UTC, Michael Ellerman wrote:
> In commit d0563a1297e2 ("powerpc: Implement {cmp}xchg for u8 and u16")
> we removed the volatile from __cmpxchg().
> 
> This is leading to warnings such as:
> 
>   drivers/gpu/drm/drm_lock.c: In function ‘drm_lock_take’:
>   arch/powerpc/include/asm/cmpxchg.h:484:37: warning: passing argument 1
>   of ‘__cmpxchg’ discards ‘volatile’ qualifier from pointer target
>      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,   \
> 
> There doesn't seem to be consensus across architectures whether the
> argument is volatile or not, so at least for now put the volatile back.
> 
> Fixes: d0563a1297e2 ("powerpc: Implement {cmp}xchg for u8 and u16")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/da58b23cb976ab83a80d358102e139

cheers
