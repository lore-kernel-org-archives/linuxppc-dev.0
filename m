Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxrD68PTzF0X6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:36 +1100 (AEDT)
In-Reply-To: <20180119085531.7708-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sfr@canb.auug.org.au, npiggin@gmail.com
Subject: Re: powerpc/64s: Fix ps3 build error due to tlbiel_all()
Message-Id: <3zPxrC66FWz9sDB@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-19 at 08:55:31 UTC, Michael Ellerman wrote:
> The recent changes to TLB handling broke the PS3 build:
> 
>   arch/powerpc/include/asm/book3s/64/tlbflush.h:30: undefined reference to `.hash__tlbiel_all'
> 
> Fix it by adding an fallback version of tlbiel_all() for non-native
> builds. It should never be called, due to checks in callers so it
> calls BUG(). We should probably clean it up further but this will
> suffice for now.
> 
> Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/7a074fc08389f43b448ebef74bf56b

cheers
