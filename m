Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNhS26Y85zDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 22:27:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9RBOL4F130554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 07:27:27 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2duyq15nw9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 07:27:26 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 27 Oct 2017 12:27:25 +0100
Date: Fri, 27 Oct 2017 16:57:18 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] powerpc/kprobes: Disable preemption before invoking
 probe handler for optprobes
References: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
 <20171025111844.ec59221e18f43f7d7d56b283@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171025111844.ec59221e18f43f7d7d56b283@kernel.org>
Message-Id: <20171027112718.ehnms36py6qrblbs@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/25 02:18AM, Masami Hiramatsu wrote:
> On Mon, 23 Oct 2017 22:07:38 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Per Documentation/kprobes.txt, probe handlers need to be invoked with
> > preemption disabled. Update optimized_callback() to do so. Also move
> > get_kprobe_ctlblk() invocation post preemption disable, since it
> > accesses pre-cpu data.
> > 
> > This was not an issue so far since optprobes wasn't selected if
> > CONFIG_PREEMPT was enabled. Commit a30b85df7d599f ("kprobes: Use
> > synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y") changes
> > this.
> 
> Actually, if you local_irq_save(), it also disables preempt. So unless you
> enables irqs, it should be safe.

I think we still need to disable preemption explicitly (at least on 
powerpc, disabling irqs doesn't increment preempt count).  See commit 
6baea433bc84cd ("powerpc/jprobes: Disable preemption when triggered 
through ftrace") for example.

We need to ensure preempt count is properly balanced for our usage 
across KPROBES_ON_FTRACE, OPTPROBES and POTS (plain old trap system ;-)

> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for the review!
- Naveen
