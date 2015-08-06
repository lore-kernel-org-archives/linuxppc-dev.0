Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C305E1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 15:44:49 +1000 (AEST)
Message-ID: <1438839874.2097.149.camel@freescale.com>
Subject: Re: [PATCH 3/3] PowerPC/mpc85xx: Add hotplug support on E6500 cores
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <b29983@freescale.com>, <b07421@freescale.com>,
 <linux-kernel@vger.kernel.org>, Tang Yuantian <Yuantian.Tang@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 6 Aug 2015 00:44:34 -0500
In-Reply-To: <1438835541.23384.1@remotesmtp.freescale.net>
References: <1438334444-31919-1-git-send-email-b29983@freescale.com>
 <1438334444-31919-3-git-send-email-b29983@freescale.com>
 <1438388531.19345.88.camel@freescale.com>
 <1438772906.21522.2@remotesmtp.freescale.net>
 <1438831004.2097.146.camel@freescale.com>
 <1438835541.23384.1@remotesmtp.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-06 at 12:32 +0800, Chenhui Zhao wrote:
> On Thu, Aug 6, 2015 at 11:16 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Wed, 2015-08-05 at 19:08 +0800, Chenhui Zhao wrote:
> > >  On Sat, Aug 1, 2015 at 8:22 AM, Scott Wood <scottwood@freescale.com>
> > >  wrote:
> > >  > On Fri, 2015-07-31 at 17:20 +0800,  b29983@freescale.comwrote:
> > >  > >  +             /*
> > >  > >  +              * If both threads are offline, reset core to 
> > > start.
> > >  > >  +              * When core is up, Thread 0 always gets up 
> > > first,
> > >  > >  +              * so bind the current logical cpu with Thread 0.
> > >  > >  +              */
> > >  > >  +             if (hw_cpu != cpu_first_thread_sibling(hw_cpu)) {
> > >  > >  +                     int hw_cpu1, hw_cpu2;
> > >  > >  +
> > >  > >  +                     hw_cpu1 = 
> > > get_hard_smp_processor_id(primary);
> > >  > >  +                     hw_cpu2 = 
> > > get_hard_smp_processor_id(primary +
> > >  > > 1);
> > >  > >  +                     set_hard_smp_processor_id(primary, 
> > > hw_cpu2);
> > >  > >  +                     set_hard_smp_processor_id(primary + 1,
> > >  > > hw_cpu1);
> > >  > >  +                     /* get new physical cpu id */
> > >  > >  +                     hw_cpu = get_hard_smp_processor_id(nr);
> > >  >
> > >  > NACK as discussed in http://patchwork.ozlabs.org/patch/454944/
> > >  >
> > >  > -Scott
> > > 
> > >  You said,
> > > 
> > >      There's no need for this. I have booting from a thread1, and 
> > > having
> > >  it
> > >      kick its thread0, working locally without messing with the 
> > > hwid/cpu
> > >      mapping.
> > > 
> > >  I still have questions here. After a core reset, how can you boot
> > >  Thread1
> > >  of the core first. As I know, Thread0 boots up first by default.
> > 
> > So the issue isn't that thread1 comes up first, but that you *want* 
> > thread1
> > to come up first and it won't.  I don't think this remapping is an 
> > acceptable
> > answer, though.  Instead, if you need only thread1 to come up, start 
> > the
> > core, have thread0 start thread1, and then send thread0 into whatever 
> > waiting
> > state it would be in if thread1 had never been offlined.
> > 
> > -Scott
> 
> Remapping is a concise solution. what's the harm of it?
> Keeping things simple is good in my opinion.

Remapping is not simple.  Remapping will make debugging more complicated (I 
see an oops on CPU <n>, which CPU's registers do I dump in the debugger?), 
could expose bugs where smp_processor_id() is used where 
hard_smp_processor_id() is needed, etc.

Having thread0 start thread1 and then go wherever it would have gone if 
thread1 were up the whole time is much more straightforward.

-Scott
