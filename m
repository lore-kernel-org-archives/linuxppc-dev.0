Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD6FG40LzzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 16:17:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R6EIUs137532
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 02:17:42 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a34vqv13j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 02:17:42 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 16:17:39 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R6HSHg53739620
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 16:17:36 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R6H38V018752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 16:17:04 +1000
Date: Thu, 27 Apr 2017 11:46:45 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] powerpc: build out kprobes blacklist
References: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170427112459.c45b6b1e2d6889c5dadabc3f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427112459.c45b6b1e2d6889c5dadabc3f@kernel.org>
Message-Id: <20170427061645.GA3313@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/27 11:24AM, Masami Hiramatsu wrote:
> Hello Naveen,
> 
> On Tue, 25 Apr 2017 22:04:05 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > This is the second in the series of patches to build out an appropriate
> > kprobes blacklist. This series blacklists system_call() and functions
> > involved when handling the trap itself. Not everything is covered, but
> > this is the first set of functions that I have tested with. More
> > patches to follow once I expand my tests.
> 
> OK, btw, have you tested to put kprobes on these functions and
> saw kernel panic happened?

Thanks for the question! I re-checked and I just realized I hadn't 
tested the PAPR case (stolen time accounting). On testing, I just found 
that those functions are not a problem since they are only invoked when 
we are coming in from user-space and not when we take a trap in-kernel.  
I will re-spin patch 3/4. Other functions have been tested to cause 
issues with kprobes.

There are still a few more functions involved (especially with 
CONFIG_PREEMPT) where I couldn't reproduce an issue, so I haven't 
included those in this series.  I am continuing to test this further and 
will post subsequent patches once I work out which other functions are 
problematic.

> 
> > I have converted many labels into private -- these are labels that I
> > felt are not necessary to read stack traces. If any of those are
> > important to have, please let me know.
> 
> At least from the viewpoint of kprobe-blacklist macros, it seems
> good to me :)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for this series.
> 
> Thank you,

Thanks for the review!
- Naveen
