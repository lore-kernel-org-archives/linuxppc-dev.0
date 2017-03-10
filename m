Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfsdY633QzDqXf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 03:09:04 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2AG8wpR049453
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 11:09:02 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 293f4uyk3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 11:09:02 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 10 Mar 2017 21:38:59 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2AG8uqx18743296
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 21:38:56 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2AG8sph030511
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 21:38:55 +0530
Date: Fri, 10 Mar 2017 21:38:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227103650.0955c5eb@gandalf.local.home>
 <87wpcbota8.fsf@concordia.ellerman.id.au>
 <20170228091147.69b836a8@gandalf.local.home>
 <871sugkogi.fsf@concordia.ellerman.id.au>
 <20170310104530.357213c1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170310104530.357213c1@gandalf.local.home>
Message-Id: <20170310160853.GD20400@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/10 10:45AM, Steven Rostedt wrote:
> On Thu, 02 Mar 2017 20:38:53 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Steven Rostedt <rostedt@goodmis.org> writes:
> > 
> > > On Tue, 28 Feb 2017 15:04:15 +1100
> > > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > kernel/trace/ftrace.c more obvious.  
> > >> 
> > >> I don't know if it's really worth keeping the names the same across
> > >> arches, especially as we already have:
> > >> 
> > >>   arch/arm64/kernel/entry-ftrace.S
> > >>   arch/arm/kernel/entry-ftrace.S
> > >>   arch/blackfin/kernel/ftrace-entry.S
> > >>   arch/metag/kernel/ftrace_stub.S
> > >> 
> > >> But we can rename it if you feel strongly about it.  
> > >
> > > Hmm, perhaps "entry-ftrace.S" would be the better name. I never liked
> > > the "mcount.S" name.  
> > 
> > Except what does the "entry" part mean?
> > 
> > Traditionally entry.S has been for the code that "enters" the kernel,
> > ie. from userspace or elsewhere. But that's not the case with any of the
> > ftrace code, it's kernel code called from the kernel. So using "entry"
> > is a bit wrong IMHO.
> > 
> > So if we drop that we're left with ftrace.S - which seems perfect to me.
> 
> Yeah, I agree. But then there's the problem that ftrace.c and ftrace.S
> will get the same ftrace.o. Maybe make it ftrace-hook.S ?

I've avoided that issue by naming the files ftrace_32.S and ftrace_64.S 
(which gets further split up).

Thanks,
Naveen
