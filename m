Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6r5FxdzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:56 +1100 (AEDT)
In-Reply-To: <20170302064124.26342-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>
Subject: Re: [kernel] powerpc/powernv: Fix clobbered MSR
Message-Id: <3vdQ6r3q57z9sN6@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-02 at 06:41:24 UTC, Alexey Kardashevskiy wrote:
> If CONFIG_DEBUG_INFO_SPLIT is not set but CONFIG_DEBUG_INFO is,
> the kernel makefile just adds "-g" and the scripts/gcc-goto.sh test for
> the "asm goto ("" :::: entry)" support succedes and adds
> -DCC_HAVE_ASM_GOTO to KBUILD_CFLAGS/KBUILD_AFLAGS. This effectively
> makes OPAL_BRANCH() a noop (or something similar).
> 
> With CONFIG_DEBUG_INFO_SPLIT=y, the makefile adds "-gsplit-dwarf" which
> somehow makes the scripts/gcc-goto.sh test fail and not have
> CC_HAVE_ASM_GOTO defined so the alternative OPAL_BRANCH() is used
> and this particular chunk clobbers r12 where the parenting code -
> OPAL_CALL() - stores MSR; as the result, the kernel oops'es right after
> early_setup() because of broken MSR.
> 
> This replaces r12 with r11 which is overwritten right after
> OPAL_BRANCH(opal_tracepoint_entry) anyway.
> 
> I used gcc 5.4.1 20161205 built from sha1 ffadbf3ae29.
> 
> Fixes: ab9bad0ead9a ("powerpc/powernv: Remove separate entry for OPAL real mode calls")
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2a9c4f40ab2c281f95d41577ff0f7f

cheers
