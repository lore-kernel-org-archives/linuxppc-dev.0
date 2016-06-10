Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR4ZY23cBzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:39:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5AEd8q3135560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:39:46 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23fm51rgwh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:39:46 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 11 Jun 2016 00:39:43 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D5D6C2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:39:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5AEdPp866650138
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:39:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5AEdJmI011176
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 00:39:20 +1000
Date: Fri, 10 Jun 2016 20:08:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 He Kuang <hekuang@huawei.com>
Subject: Re: [PATCH 2/2] perf annotate: add powerpc support
References: <6c96da46e8a3b44a3fdb2670897fae7a35c76460.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <21173b25482dd19f85416f02bc8050324fe5eb76.1465563491.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160610133644.GB3826@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160610133644.GB3826@kernel.org>
Message-Id: <20160610143822.GT18654@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/10 10:36AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 10, 2016 at 06:32:51PM +0530, Naveen N. Rao escreveu:
> > Convert ins__find() to a __weak function for generic functionality,
> > while adding a powerpc-specific variant. We look at the function name
> > for branch instructions and classify the instructions to one among a
> > branch, a function call (branch with LR update) or a function return
> > (branch to LR).
> 
> How would this allow one to get a perf.data collected on a powerpc
> system, transfer it to a x86-64 (or aarch64, to mention another
> workstation wannabe chip) system and then try annotating it?
> 
> There was a previous discussion about this, and it involved having all
> yout ppc tables available as well as other arches tables, and then
> choosing which one to use based on:
> 
> 	normalize_arch(thread->mg->machine->env->arch)
> 
> just like was done for support cross unwinding, see recent patch kit by
> He Kuang, CCed.

Nice. This would be good to have. I will look at adding powerpc support 
for cross-architecture unwind.

However, for cross-architecture annotation, I think there will be a lot 
more dependencies since perf currently uses objdump to obtain the 
disassembly. In addition, the actual binaries will also be needed.


- Naveen
