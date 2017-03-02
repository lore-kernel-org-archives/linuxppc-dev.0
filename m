Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ5Jk4qBRzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 08:37:58 +1100 (AEDT)
Message-ID: <1488490657.2870.74.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/powernv: Fix clobbered MSR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Date: Fri, 03 Mar 2017 08:37:37 +1100
In-Reply-To: <20170302064124.26342-1-aik@ozlabs.ru>
References: <20170302064124.26342-1-aik@ozlabs.ru>
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

On Thu, 2017-03-02 at 17:41 +1100, Alexey Kardashevskiy wrote:
> With CONFIG_DEBUG_INFO_SPLIT=y, the makefile adds "-gsplit-dwarf" which
> somehow makes the scripts/gcc-goto.sh test fail and not have
> CC_HAVE_ASM_GOTO defined so the alternative OPAL_BRANCH() is used

This needs to be fixed too though. That alternative path has much more
overhead accross the board. Losing "asm goto" because of a broken test
is nasty.

Cheers,
Ben.
