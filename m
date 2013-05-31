Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2001:4d88:1ffa:82:880:aa0:9009:64ae])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1BCE52C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 21:36:19 +1000 (EST)
Date: Fri, 31 May 2013 13:07:17 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/32bit:Store temporary result in r0 instead of r8
Message-ID: <20130531110717.GA2941@breakpoint.cc>
References: <1369639817-2856-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369639817-2856-1-git-send-email-Priyanka.Jain@freescale.com>
Cc: scottwood@freescale.com, tiejun.chen@windriver.com,
 linuxppc-dev@lists.ozlabs.org, Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 27, 2013 at 01:00:17PM +0530, Priyanka Jain wrote:
> While returning from exception handling in case of PREEMPT enabled,
> _TIF_NEED_RESCHED bit is checked in TI_FLAGS (thread_info flag) of current
> task. Only if this bit is set, it should continue with the process of
> calling preempt_schedule_irq() to schedule highest priority task if
> available.

This is broken since a9c4e541 ("powerpc/kprobe: Complete kprobe 
and migrate exception frame") and this commit joined Linus' tree in 
v3.7-rc1.
Ben, please add
  Cc: <stable@vger.kernel.org> # 3.7+

so it gets into the stable tree.

Sebastian
