Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 669992C02EC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 17:13:05 +1000 (EST)
Message-ID: <1369638775.3557.12.camel@pasglop>
Subject: Re: [PATCH] powerpc/32bit,PREEMPT:Load TI_FLAGS to check NEED_RESCHED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Date: Mon, 27 May 2013 17:12:55 +1000
In-Reply-To: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
References: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, "tiejun.chen" <tiejun.chen@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-27 at 11:57 +0530, Priyanka Jain wrote:
> Add instruction to load TI_FLAGS in r8
>     
> While returning from exception handling in case of PREEMPT enabled,
> _TIF_NEED_RESCHED bit is checked in TI_FLAGS (thread_info flag) of
> current
> task. Only if this bit is set, it should continue with the process of
> calling preempt_schedule_irq() to schedule highest priority task if
> available.
>
> Current code assumes that r8 contains TI_FLAGS and check this for
> _TIF_NEED_RESCHED, but as r8 is modified in the code which executes
> before
> this check, r8 no longer contains the expected TI_FLAGS information.

Hrm, the code was supposed to still have TI_FLAGS in r8 and mostly does
until the 

	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h

Was added which clobbers it.

Can't we just fix the above to use a different destination register ?
r0 looks fair game at this point...
 
> As a result check for comparison with _TIF_NEED_RESCHED was failing
> even if
> NEED_RESCHED bit is set in the current thread_info flag. Due to this,
> preempt_schedule_irq() and in turn scheduler was not getting called
> even if
> highest priority task is ready for execution.

Ben.
