Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC1032C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 20:41:30 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Sat, 16 Feb 2013 19:35:57 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BADBF357804E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 20:41:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1G9T1po62390408
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 20:29:01 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1G9fNiH013021
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 20:41:24 +1100
Message-ID: <1361007679.2580.10.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH 2/5] powerpc: Exception hooks for context tracking
 subsystem
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 16 Feb 2013 17:41:19 +0800
In-Reply-To: <CAFTL4hzfXfCGDjwjW=Frcs5+jS_i3U_JHytNOEhEF5X7_Fw6Sg@mail.gmail.com>
References: <1359714465-6297-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1359714465-6297-3-git-send-email-zhong@linux.vnet.ibm.com>
 <CAFTL4hzfXfCGDjwjW=Frcs5+jS_i3U_JHytNOEhEF5X7_Fw6Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-02-10 at 15:10 +0100, Frederic Weisbecker wrote:
> 2013/2/1 Li Zhong <zhong@linux.vnet.ibm.com>:
> > This is the exception hooks for context tracking subsystem, including
> > data access, program check, single step, instruction breakpoint, machine check,
> > alignment, fp unavailable, altivec assist, unknown exception, whose handlers
> > might use RCU.
> >
> > This patch corresponds to
> > [PATCH] x86: Exception hooks for userspace RCU extended QS
> >   commit 6ba3c97a38803883c2eee489505796cb0a727122
> >
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> 
> Looks good!
> 
> I guess we should move exception_enter/exit definition to the generic
> code. They should be the same for all archs after all. 

Indeed.

> Also we are
> relying on user_mode(regs) but this may be buggy with some corner
> cases. For example if an exception happen after a call to user_exit()

I guess you mean user_enter() here, or am I confused?

> (on syscall exit) but before we actually resume in userspace, the
> exception will exit in kernel mode from the context tracking POV.
> 
> So instead on relying on the regs, which are not sync with the context
> tracking state, we should use something like:
> 
> prev_state = exception_enter();
> ...
> exception_exit(prev_state);
> 
> Also preempt_schedule_irq() is concerned as well by this problem. So I
> should convert it to that scheme as well. I'm going to prepare some
> patches.
> 
> Feel free to merge this patch in the powerpc tree, I'll do the
> conversion along the way.

Or if your patches gets merged earlier than these, I can update my code
according to yours.

Thanks, Zhong

> 
> Thanks.
> 
