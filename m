Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjm0X2McMzDqcG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 20:05:32 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2F8s0au011718
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:05:25 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296ng0j23x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:05:24 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 15 Mar 2017 14:35:21 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2F95IPu17825830
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 14:35:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2F95GHD012882
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 14:35:18 +0530
Date: Wed, 15 Mar 2017 14:35:16 +0530
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
 <20170310160853.GD20400@naverao1-tp.localdomain>
 <20170310115445.4f7e4a2b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170310115445.4f7e4a2b@gandalf.local.home>
Message-Id: <20170315090516.GE20400@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/10 11:54AM, Steven Rostedt wrote:
> On Fri, 10 Mar 2017 21:38:53 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/03/10 10:45AM, Steven Rostedt wrote:
> > > On Thu, 02 Mar 2017 20:38:53 +1100
> > > Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > > > So if we drop that we're left with ftrace.S - which seems perfect to me.  
> > > 
> > > Yeah, I agree. But then there's the problem that ftrace.c and ftrace.S
> > > will get the same ftrace.o. Maybe make it ftrace-hook.S ?  
> > 
> > I've avoided that issue by naming the files ftrace_32.S and ftrace_64.S 
> > (which gets further split up).
> 
> That's what I looked at doing for x86 as well. But not all archs have
> 32 / 64 splits. Should we look to have something that all archs can be
> consistent with?

I don't have a strong opinion about this, but I feel that x86 can simply 
use ftrace_64.S, seeing as the current name is mcount_64.S.

Other architectures could do something similar too, or fall back to 
ftrace_hook.S. That way, all ftrace low-level code can simply be 
referred to as arch/*/ftrace_*.S

- Naveen
