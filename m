Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSdQM0lnDzDqrP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:24:26 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7A6Nino020223
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 02:24:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c8hek20jn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 02:24:23 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 02:24:23 -0400
Date: Thu, 10 Aug 2017 11:54:18 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 10/13] powerpc/64s: idle simplify KVM idle on POWER9
Reply-To: ego@linux.vnet.ibm.com
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-11-npiggin@gmail.com>
 <20170808103643.GA9107@in.ibm.com>
 <20170808224257.720e85d6@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808224257.720e85d6@roar.ozlabs.ibm.com>
Message-Id: <20170810062418.GA10611@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2017 at 10:42:57PM +1000, Nicholas Piggin wrote:
> On Tue, 8 Aug 2017 16:06:43 +0530
> Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> 
> > Hi Nicholas,
> > 
> > On Sun, Aug 06, 2017 at 03:02:38AM +1000, Nicholas Piggin wrote:
> > > POWER9 CPUs have independent MMU contexts per thread so KVM
> > > does not have to bring sibling threads into real-mode when
> > > switching MMU mode to guest. This can simplify POWER9 sleep/wake
> > > paths and avoids hwsyncs.
> > > @@ -2858,11 +2883,13 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
> > > 
> > >  	/* Let secondaries go back to the offline loop */
> > >  	for (i = 0; i < controlled_threads; ++i) {
> > > -		kvmppc_release_hwthread(pcpu + i);
> > >  		if (sip && sip->napped[i])
> > >  			kvmppc_ipi_thread(pcpu + i);
> > >  		cpumask_clear_cpu(pcpu + i, &vc->kvm->arch.cpu_in_guest);
> > >  	}  
> > 
> > We are sending an IPI to the thread that has exited the guest and is
> > currently napping. The IPI wakes it up so that it can executes
> > offline loop. But we haven't released the hwthread yet, which means
> > that hwthread_req for this thread is still set.
> > 
> > The thread wakes up from nap, executes the pnv_powersave_wakeup code
> > where it can enter kvm_start_guest. Is this a legitimate race or am I
> > missing something?
> 
> Oh I think it's just a silly mistake in my patch, good catch.

Ah,np!

> Would moving this loop below the one below solve it? I wasn't
> completely happy with uglifying these loops by making the
> primary release different than secondary... maybe I will just
> move the difference into kvmppc_release_hwthread and which is
> less intrusive to callers.

I think moving it to kvmppc_release_hwthread is a good idea.

> 
> Thanks,
> Nick
> 

--
Thanks and Regards
gautham.
