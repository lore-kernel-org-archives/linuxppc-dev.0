Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpCfT41swzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 16:05:37 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5F64TZS032917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 02:05:35 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b3gvq0vxt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 02:05:34 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 15 Jun 2017 16:05:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5F65Tu450397438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 16:05:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5F65KK8001503
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 16:05:20 +1000
Date: Wed, 14 Jun 2017 23:05:38 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Gustavo Luiz Duarte <gduarte@redhat.com>, zsun@redhat.com,
 linuxppc-dev@lists.ozlabs.org, Pratyush Anand <panand@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/uprobes: Implement arch_uretprobe_is_alive()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20170614154400.17377-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170614154400.17377-1-naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170615060538.GA56680@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding Oleg and Pratyush to the cc.

> This helper is used to detect if a uprobe'd function has returned
> through a setjmp/longjmp, rather than branching to the LR that was
> updated previously by us. This fixes a SIGSEGV that gets generated when
> programs use setjmp/longjmp with uretprobes.
> 
> We use the arm64 model (arch/arm64/kernel/probes/uprobes.c:
> arch_uretprobe_is_alive()) for detecting when stack frames have been
> removed from under us.
> 
> Reference:
> https://marc.info/?l=linux-kernel&m=143748610330073
> commit 7b868e4802a86 ("uprobes/x86: Reimplement arch_uretprobe_is_alive()")
> commit db087ef69a2b1 ("uprobes/x86: Make arch_uretprobe_is_alive(RP_CHECK_CALL) more
> clever")
> 
> Tested with the test program from:
> https://sourceware.org/git/gitweb.cgi?p=systemtap.git;a=blob;f=testsuite/systemtap.base/bz5274.c;hb=HEAD
> 
> And this script:
>     $ cat test.sh
>     #!/bin/bash
> 
>     perf probe -x ./bz5274 -a bz5274_main_return=main%return
>     perf probe -x ./bz5274 -a bz5274_funca_return=funca%return
>     perf probe -x ./bz5274 -a bz5274_funcb_return=funcb%return
>     perf probe -x ./bz5274 -a bz5274_funcc_return=funcc%return
>     perf probe -x ./bz5274 -a bz5274_funcd_return=funcd%return
> 
>     perf record -e 'probe_bz5274:*' -aR ./bz5274
> 
> Reported-by: Gustavo Luiz Duarte <gduarte@redhat.com>
> Reported-by: zsun@redhat.com
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Looks good to me.

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
