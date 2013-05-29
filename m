Return-Path: <fweisbec@gmail.com>
Received: from mail-we0-x22c.google.com (mail-we0-x22c.google.com
 [IPv6:2a00:1450:400c:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62E052C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 07:29:16 +1000 (EST)
Received: by mail-we0-f172.google.com with SMTP id w62so6899203wes.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 14:29:11 -0700 (PDT)
Date: Wed, 29 May 2013 23:29:09 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 0/5] powerpc: Support context tracking for Power
 pSeries
Message-ID: <20130529212907.GC17419@somewhere>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424306.19924.20.camel@pasglop>
 <1368432193.2618.30.camel@ThinkPad-T5421>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368432193.2618.30.camel@ThinkPad-T5421>
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 paulus@samba.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 04:03:13PM +0800, Li Zhong wrote:
> On Mon, 2013-05-13 at 15:51 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2013-05-13 at 13:21 +0800, Li Zhong wrote:
> > > These patches try to support context tracking for Power arch, beginning with
> > > 64-bit pSeries. The codes are ported from that of the x86_64, and in each
> > > patch, I listed the corresponding patch for x86.
> > 
> > So that's yet another pile of bloat on all syscall entry/exit and
> > exception entry/exit. What is it used for ? (I haven't followed on
> > x86_64 side).
> 
> To my understanding, it is used to enable RCU user extended quiescent
> state, so RCU on that cpu doesn't need scheduler ticks. And together
> with some other code(already in 3.10), we are able to remove the ticks
> in some cases (e.g. only 1 task running on the cpu, with some other
> limitations).
> 
> Maybe Paul, or Frederic could give some better descriptions. 

That's pretty much it. It helps RCU and cputime accounting infrastructure
to know when we enter/exit userspace. This way we can:

* Consider the CPU as idle from an RCU point of view when we run in userspace,
so RCU won't need the tick to stay alive.

* Account cputime (utime/stime/...) without using the tick. Ok powerpc already
has CONFIG_VIRT_CPU_ACCOUNTING_NATIVE but making it working with full dynticks
would require some tweaks.

All in one this is to support full dynticks.

Thanks.
