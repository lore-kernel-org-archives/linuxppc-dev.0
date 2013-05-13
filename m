Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 690BA2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 15:52:08 +1000 (EST)
Message-ID: <1368424306.19924.20.camel@pasglop>
Subject: Re: [RFC PATCH v3 0/5] powerpc: Support context tracking for Power
 pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Mon, 13 May 2013 15:51:46 +1000
In-Reply-To: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
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

On Mon, 2013-05-13 at 13:21 +0800, Li Zhong wrote:
> These patches try to support context tracking for Power arch, beginning with
> 64-bit pSeries. The codes are ported from that of the x86_64, and in each
> patch, I listed the corresponding patch for x86.

So that's yet another pile of bloat on all syscall entry/exit and
exception entry/exit. What is it used for ? (I haven't followed on
x86_64 side).

Cheers,
Ben.

> v3:
> 
> This version is mainly a rebasing, against 3.10-rc1, also as the common code 
> to handle the exception are pulled into 3.10, so there is no dependency on 
> tip tree. So patch #2 and #6 in previous version_2 is merged together. 
> 
> Li Zhong (5):
>   powerpc: Syscall hooks for context tracking subsystem
>   powerpc: Exception hooks for context tracking subsystem
>   powerpc: Exit user context on notify resume
>   powerpc: Use the new schedule_user API on userspace preemption
>   powerpc: select HAVE_CONTEXT_TRACKING for pSeries
> 
>  arch/powerpc/include/asm/context_tracking.h |   10 +++
>  arch/powerpc/include/asm/thread_info.h      |    7 ++-
>  arch/powerpc/kernel/entry_64.S              |    3 +-
>  arch/powerpc/kernel/ptrace.c                |    5 ++
>  arch/powerpc/kernel/signal.c                |    5 ++
>  arch/powerpc/kernel/traps.c                 |   91 ++++++++++++++++++++-------
>  arch/powerpc/mm/fault.c                     |   16 ++++-
>  arch/powerpc/mm/hash_utils_64.c             |   38 ++++++++---
>  arch/powerpc/platforms/pseries/Kconfig      |    1 +
>  9 files changed, 140 insertions(+), 36 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/context_tracking.h
> 
