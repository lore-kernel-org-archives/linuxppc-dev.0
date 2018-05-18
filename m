Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nSq64PcqzF2B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 22:56:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, mikey@neuling.org
Subject: Re: [PATCH 2/2] powerpc/ptrace: Fix setting 512B aligned breakpoints
 with PTRACE_SET_DEBUGREG
In-Reply-To: <20180517053715.24011-2-mikey@neuling.org>
References: <20180517053715.24011-1-mikey@neuling.org>
 <20180517053715.24011-2-mikey@neuling.org>
Date: Fri, 18 May 2018 22:56:30 +1000
Message-ID: <87po1txgu9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:
> In this change:
>   e2a800beac powerpc/hw_brk: Fix off by one error when validating DAWR region end
>
> We fixed setting the DAWR end point to its max value via
> PPC_PTRACE_SETHWDEBUG. Unfortunately we broke PTRACE_SET_DEBUGREG when
> setting a 512 byte aligned breakpoint.
>
> PTRACE_SET_DEBUGREG currently sets the length of the breakpoint to
> zero (memset() in hw_breakpoint_init()).  This worked with
> arch_validate_hwbkpt_settings() before the above patch was applied but
> is now broken if the breakpoint is 512byte aligned.
>
> This sets the length of the breakpoint to 8 bytes when using
> PTRACE_SET_DEBUGREG.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: stable@vger.kernel.org # 3.10+

If this is "fixing" e2a800beac then I think v3.11 is right for the
stable tag?

$ git describe --contains --long e2a800beaca1
v3.11-rc1~94^2~4

cheers
