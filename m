Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D8731A06ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 16:40:20 +1100 (AEDT)
In-Reply-To: <1417149402-5493-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V4] powerpc, xmon: Enable HW instruction breakpoint on POWER8
Message-Id: <20141201054020.2E47A140160@ozlabs.org>
Date: Mon,  1 Dec 2014 16:40:20 +1100 (AEDT)
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-28-11 at 04:36:42 UTC, Anshuman Khandual wrote:
> This patch enables support for hardware instruction breakpoint in
> xmon on POWER8 platform with the help of a new register called the
> CIABR (Completed Instruction Address Breakpoint Register). With this
> patch, a single hardware instruction breakpoint can be added and
> cleared during any active xmon debug session. The hardware based
> instruction breakpoint mechanism works correctly with the existing
> TRAP based instruction breakpoint available on xmon.
> 
> There are no powerpc CPU with CPU_FTR_IABR feature any more. This
> patch has re-purposed all the existing IABR related code to work
> with CIABR register based HW instruction breakpoint.

OK I think I'm happy with this, I am going to add this to the changelog though:

    This has one odd feature, which is that when we hit a breakpoint xmon
    doesn't tell us we have hit the breakpoint. This is because xmon is
    expecting bp->address == regs->nip. Because CIABR fires on completition
    regs->nip points to the instruction after the breakpoint. We could fix
    that, but it would then confuse other parts of the xmon code which think
    we need to emulate the instruction. [mpe]

cheers
