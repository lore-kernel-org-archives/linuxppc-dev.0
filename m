Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3sHN5lLrzDr5N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 21:06:24 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v67B5lpU045757
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 07:06:22 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bj0wq09ua-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 07:06:21 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 7 Jul 2017 21:06:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v67B6FPd10551718
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 21:06:15 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v67B66P3031666
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 21:06:07 +1000
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Paul McKenney <Paul.McKenney@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-next
 <linux-next@vger.kernel.org>, paulus@samba.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 07 Jul 2017 16:36:10 +0530
In-Reply-To: <20170630172802.6d4ddca2@roar.ozlabs.ibm.com>
References: <1498728106.19484.21.camel@abdul>
 <20170629193614.376e27e6@roar.ozlabs.ibm.com>
 <20170629202305.6187367f@roar.ozlabs.ibm.com>
 <20170630004534.228f7c08@roar.ozlabs.ibm.com>
 <1498800138.19484.25.camel@abdul>
 <20170630172802.6d4ddca2@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1499425570.19784.38.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-30 at 17:28 +1000, Nicholas Piggin wrote:
> On Fri, 30 Jun 2017 10:52:18 +0530
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> 
> > On Fri, 2017-06-30 at 00:45 +1000, Nicholas Piggin wrote:
> > > On Thu, 29 Jun 2017 20:23:05 +1000
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > > On Thu, 29 Jun 2017 19:36:14 +1000
> > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > > > I don't *think* the replay-wakeup-interrupt patch is directly involved, but
> > > > > it's likely to be one of the idle patches.  
> > > 
> > > Okay this turned out to be misconfigured sleep states I added for the
> > > simulator, sorry for the false alarm.
> > > 
> > > > Although you have this in the backtrace. I wonder if that's a stuck
> > > > lock in rcu_process_callbacks?
> > > 
> > > So this spinlock becomes top of the list of suspects. Can you try
> > > enabling lockdep and try to reproduce it?
> > 
> > Yes, recreated again with CONFIG_LOCKDEP=y & CONFIG_DEBUG_LOCKDEP=y set.
> > I do not see any difference in trace messages with and without LOCKDEP
> > enabled.
> > 
> > Please find the attached log file.
> 
> Can you get an rcu_invoke_callback event trace that Paul suggested?

Yes, I was able to collect the perf data for rcu_invoke_callback event
on recent next kernel (4.12.0-next-20170705). the issue is rare to hit.

After booting the next kernel, I started this command 'perf record  -e
rcu:rcu_invoke_callback -a -g -- cat' and waited for 30 minutes.

five minutes after seeing the stalls messages, I did CTRL-C to end the
perf command.

@Nicholas : the perf.data report is too huge to attach here, shall I
ping you the internal location of file on slack/mail ? Also the machine
is in the same state if you want to use it ?

> 
> Does this bug show up with just the powerpc next branch?
> 
> Thanks,
> Nick
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
