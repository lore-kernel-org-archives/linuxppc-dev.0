Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30E0C2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 09:18:00 +1100 (EST)
Message-ID: <1395353868.12479.342.camel@snotra.buserror.net>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 20 Mar 2014 17:17:48 -0500
In-Reply-To: <20140320114735.GD10182@pek-khao-d1.corp.ad.wrs.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
 <1394646185.13761.145.camel@snotra.buserror.net>
 <20140313074613.GD26692@pek-khao-d1.corp.ad.wrs.com>
 <1394835987.12479.119.camel@snotra.buserror.net>
 <20140316045801.GA32188@pek-khao-d1.corp.ad.wrs.com>
 <1395184734.12479.250.camel@snotra.buserror.net>
 <20140320114735.GD10182@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Jason.Jin@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-20 at 19:47 +0800, Kevin Hao wrote:
> OK, so the intention of 'twi, isync' following the load is not to order the
> following storage access, but order the following delay loop instructions,
> right? But according to the e6500 manual, the instructions complete in order.
> The following is the definition of 'complete':
>   Complete—An instruction is eligible to complete after it finishes executing
>   and makes its results available for subsequent instructions. Instructions
>   must complete in order from the bottom two entries of the
>   completion queue (CQ). The completion unit coordinates how instructions (which
>   may have executed out of order) affect architected registers to ensure the
>   appearance of serial execution. This guarantees that the completed instruction
>   and all previous instructions can cause no exceptions. An instruction completes
>   when it is retired, that is, deleted from the CQ.
> 
> So the following delay loop instructions should never complete before the
> complete of the load instruction.

We don't want the delay loop instructions to *start* until the load has
completed.  Completion of the loop only matters when ordering the loop
versus post-loop actions (and again, there we'd want the loop to
complete before subsequent actions start).

> > > > > So if we want to order all the storage access as well
> > > > > as execution synchronization, we should choose sync here.
> > > > 
> > > > Do we need execution synchronization or context synchronization?
> > > 
> > > There is no context-altering instruction here, so I think an execution
> > > synchronizing instruction should be enough here.
> > 
> > Is the ISA ever explicit about what constitutes "context"?
> 
> The following is the definition of context-altering instruction:
>   An instruction that alters the context in which data
>   addresses or instruction addresses are interpreted, or
>   in which instructions are executed or data accesses are
>   performed, is called a context-altering instruction.
> 
> So the context should be:
>   - in which data addresses or instruction addresses are interpreted
>   - in which instructions are executed
>   - in which data accesses are performed

By that definition, a store to CCSR could easily change the context in
which data accesses are performed, by changing a mapping.

But still, nothing in the above defines "context" -- or rather, it does
so circularly.  While it makes intuitive sense that it would be limited
to context that lives within the core, rather than the rest of the
system, I don't think the ISA generally distinguishes between the two.

-Scott
