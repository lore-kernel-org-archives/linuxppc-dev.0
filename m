Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsrzZ62LyzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 05:18:18 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DJFPij100753
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 15:18:15 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cy5jj9478-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 15:18:14 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 05:18:12 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8DJGsQA37486768
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 05:16:54 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8DJGrgU011932
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 05:16:54 +1000
Date: Thu, 14 Sep 2017 00:46:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobe: Warn if unable to install breakpoint
References: <20170831183215.4306-1-naveen.n.rao@linux.vnet.ibm.com>
 <87r2vr57jq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2vr57jq.fsf@concordia.ellerman.id.au>
Message-Id: <20170913191650.f57qytp7ztvwihy6@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/09/01 03:09PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > When we try to install a uprobe breakpoint in uprobe_mmap(), we ignore
> > all errors encountered in the process per this comment at the top of
> > the function:
> >     /*
> >      * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
> >      *
> >      * Currently we ignore all errors and always return 0, the callers
> >      * can't handle the failure anyway.
> >      */
> >
> > However, this is very confusing for users since no probe hits are
> > recorded nor is an error logged in dmesg.
> >
> > Fix this by logging an error in dmesg so that users can discover that
> > there was an issue with the uprobe. To facilitate use of uprobe_warn(),
> > we move that function to the top of the file.
> >
> > With this patch, we see a message similar to this in dmesg:
> >     [  201.449213] uprobe: uprobe_t:9740 failed to setup probe at 0x95c (-524)
> >
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  kernel/events/uprobes.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 0e137f98a50c..587c591a535c 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -112,6 +112,12 @@ struct xol_area {
> >  	unsigned long 			vaddr;		/* Page(s) of instruction slots */
> >  };
> >  
> > +static void uprobe_warn(struct task_struct *t, const char *msg)
> > +{
> > +	pr_warn("uprobe: %s:%d failed to %s\n",
> > +			current->comm, current->pid, msg);
> 
> That should probably be ratelimited no?

Uprobes can only be installed by root today, so it is not as bad. But, I 
do agree that it is good to ratelimit. I will send a subsequent patch to 
do this.

Thanks for the review,
- Naveen
