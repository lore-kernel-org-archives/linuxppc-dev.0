Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BC192C0340
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 05:30:07 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 04:22:19 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C63A42CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 05:30:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r25ITwsf7799154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 05:29:58 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r25ITxgE031535
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 05:30:01 +1100
Message-ID: <51363920.3040906@linux.vnet.ibm.com>
Date: Tue, 05 Mar 2013 23:57:44 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <CANN689F9S7c1M8+cEpz3tsxGF34+NTRBLvxgPUOtbvav5u+RRA@mail.gmail.com>
 <5122551E.1080703@linux.vnet.ibm.com>	<51226B46.9080707@linux.vnet.ibm.com>
 <CANN689FSxOz+0Cu7EG_yKD8ZE1OpT4kyT+ybLfXSqaifodJRpw@mail.gmail.com>
 <51226F91.7000108@linux.vnet.ibm.com>
 <CACvQF53bdh4_BxF0y1fnTVR+T2OmRc0jmWQYftsvx92-fg-Lug@mail.gmail.com>
 <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130EA6B.6030901@cn.fujitsu.com>
 <513105DD.8010908@linux.vnet.ibm.com> <51361C71.5060502@cn.fujitsu.com>
In-Reply-To: <51361C71.5060502@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Cc: Lai Jiangshan <eag0628@gmail.com>, linux-doc@vger.kernel.org,
 peterz@infradead.org, fweisbec@gmail.com, oleg@redhat.com,
 Michel Lespinasse <walken@google.com>, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lai,

On 03/05/2013 09:55 PM, Lai Jiangshan wrote:
> Hi, Srivatsa,
> 
> I'm sorry again, I delayed your works.
>

No, you didn't :-) I have been busy with some internal work lately,
so I haven't been able to go through the recent discussions and
review the new code carefully.. I'll get to it as soon as I can.
 
> I have some thinkings about the way how to get this work done.
> 
> First step: (2~3 patches)
> Use preempt_disable() to implement get_online_cpu_atomic(), and add lockdep for it.
> 
> Second step:
> Conversion patches.
> 
> We can send the patchset of the above steps at first.
> {
> It does not change any behavior of the kernel.
> and it is annotation(instead of direct preempt_diable() without comments sometimes),
> so I expected they can be merged very early.
> }
> 
> Third step:
> After all people confide the conversion patches covered all cases and cpuhotplug site is ready for it,
> we will implement get_online_cpu_atomic() via locks and remove stop_machine() from cpuhotplug.
> 
> Any thought?
> 

That sounds like a good plan. It might involve slightly more churn
than just directly changing the locking scheme, but it is safer.
And the extra churn is anyway limited only to the implementation of
get/put_online_cpus_atomic().. so that should be fine IMHO.

> 
> If I have time, I will help you for the patches of the first step.
> (I was assigned bad job in office-time, I can only do kernel-dev work in night.)
> 
> And for step2, I will write a checklist or spatch-script.
> 

Do look at the conversion already done in this v6 as well. In
addition to that, we will have to account for the new kernel
code that went in recently.

I'll get back to working on the above mentioned aspects soon.

Regards,
Srivatsa S. Bhat
