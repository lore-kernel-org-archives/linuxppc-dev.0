Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66D2A2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 18:03:27 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 13 May 2013 13:28:27 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5283B3940057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 13:33:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D83D9q2818394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 13:33:13 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D83In6000764
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 18:03:19 +1000
Message-ID: <1368432193.2618.30.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH v3 0/5] powerpc: Support context tracking for Power
 pSeries
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 13 May 2013 16:03:13 +0800
In-Reply-To: <1368424306.19924.20.camel@pasglop>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424306.19924.20.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-13 at 15:51 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-13 at 13:21 +0800, Li Zhong wrote:
> > These patches try to support context tracking for Power arch, beginning with
> > 64-bit pSeries. The codes are ported from that of the x86_64, and in each
> > patch, I listed the corresponding patch for x86.
> 
> So that's yet another pile of bloat on all syscall entry/exit and
> exception entry/exit. What is it used for ? (I haven't followed on
> x86_64 side).

To my understanding, it is used to enable RCU user extended quiescent
state, so RCU on that cpu doesn't need scheduler ticks. And together
with some other code(already in 3.10), we are able to remove the ticks
in some cases (e.g. only 1 task running on the cpu, with some other
limitations).

Maybe Paul, or Frederic could give some better descriptions. 

Thanks, Zhong

> 
> Cheers,
> Ben.
> 
> > v3:
> > 
> > This version is mainly a rebasing, against 3.10-rc1, also as the common code 
> > to handle the exception are pulled into 3.10, so there is no dependency on 
> > tip tree. So patch #2 and #6 in previous version_2 is merged together. 
> > 
> > Li Zhong (5):
> >   powerpc: Syscall hooks for context tracking subsystem
> >   powerpc: Exception hooks for context tracking subsystem
> >   powerpc: Exit user context on notify resume
> >   powerpc: Use the new schedule_user API on userspace preemption
> >   powerpc: select HAVE_CONTEXT_TRACKING for pSeries
> > 
> >  arch/powerpc/include/asm/context_tracking.h |   10 +++
> >  arch/powerpc/include/asm/thread_info.h      |    7 ++-
> >  arch/powerpc/kernel/entry_64.S              |    3 +-
> >  arch/powerpc/kernel/ptrace.c                |    5 ++
> >  arch/powerpc/kernel/signal.c                |    5 ++
> >  arch/powerpc/kernel/traps.c                 |   91 ++++++++++++++++++++-------
> >  arch/powerpc/mm/fault.c                     |   16 ++++-
> >  arch/powerpc/mm/hash_utils_64.c             |   38 ++++++++---
> >  arch/powerpc/platforms/pseries/Kconfig      |    1 +
> >  9 files changed, 140 insertions(+), 36 deletions(-)
> >  create mode 100644 arch/powerpc/include/asm/context_tracking.h
> > 
> 
> 
