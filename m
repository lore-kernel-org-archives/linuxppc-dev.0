Return-Path: <heiko.carstens@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdxXH0XJxzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 17:00:30 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5S6wUYj119115
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 03:00:27 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23spg833mt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 03:00:27 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Tue, 28 Jun 2016 08:00:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE8E1219005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:59:51 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5S70LV817301936
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:00:21 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5S70GO1010401
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 01:00:21 -0600
Date: Tue, 28 Jun 2016 09:00:13 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
 mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, Waiman.Long@hpe.com, boqun.feng@gmail.com,
 will.deacon@arm.com, dave@stgolabs.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/3] kernel/sched: introduce vcpu preempted check interface
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160627140043.GO30921@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160627140043.GO30921@twins.programming.kicks-ass.net>
Message-Id: <20160628070013.GC3784@osiris>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2016 at 04:00:43PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 27, 2016 at 01:41:28PM -0400, Pan Xinhui wrote:
> > +++ b/include/linux/sched.h
> > @@ -3293,6 +3293,15 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
> >  
> >  #endif /* CONFIG_SMP */
> >  
> > +#ifdef arch_vcpu_is_preempted
> > +static inline bool vcpu_is_preempted(int cpu)
> > +{
> > +	return arch_vcpu_is_preempted(cpu);
> > +}
> > +#else
> > +#define vcpu_is_preempted(cpu)	false
> > +#endif
> 
> #ifndef vcpu_is_preempted
> #define vcpu_is_preempted(cpu)		(false)
> #endif
> 
> Is so much simpler...
> 
> Also, please Cc the virt list so that other interested parties can
> comment, and maybe also the s390 folks.

The s390 implementation would be to simply use cpu_is_preempted() from
arch/s390/lib/spinlock.c.
It's nice that there will be a common code function for this!
