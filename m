Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ0Nx4tbmzDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:56:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v22HhcAB016290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:56:15 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xpbpdwqp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 12:56:14 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 3 Mar 2017 03:56:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A15D82BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:56:09 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v22Hu12K45416572
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 04:56:09 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v22HtagN007237
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 04:55:37 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
Date: Thu,  2 Mar 2017 23:25:04 +0530
In-Reply-To: <20170224201103.GO3595@kernel.org>
References: <20170224201103.GO3595@kernel.org>
Message-Id: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/24 05:11PM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Feb 25, 2017 at 02:29:17AM +0900, Masami Hiramatsu escreveu:
> > On Fri, 24 Feb 2017 00:46:08 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > Thanks. I hope that's an Ack for this patchset?
> > 
> > OK, for 1/5, 2/5, 3/5, and 5/5;
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > And could you make v4 series including all patches? (Not only updates)
> 
> So, to make progress I processed these:
> 
> [acme@jouet linux]$ git log --oneline -3
> eb55608340b7 perf probe: Generalize probe event file open routine
> 859d718fac06 trace/kprobes: Allow return probes with offsets and absolute addresses
> a10489121c81 kretprobes: Ensure probe location is at function entry
> [acme@jouet linux]$
> 
> Waiting for Naveen to react to these last minute considerations from
> Masami and for the Ack from the PPC guys about "[PATCH v2 2/5] powerpc:
> kretprobes: override default function entry offset".

Arnaldo,
I am posting the remaining three patches in this series. These three
patches are on top of the above 3 patches you have processed and the
other powerpc kretprobes patch (v2 2/5).

Masami,
Kindly review and let me know if this is fine.


Thanks,
Naveen

---
Naveen N. Rao (3):
  perf: probe: factor out the ftrace README scanning
  perf: kretprobes: offset from reloc_sym if kernel supports it
  perf: powerpc: choose local entry point with kretprobes

 tools/perf/arch/powerpc/util/sym-handling.c | 10 ++--
 tools/perf/util/probe-event.c               | 12 ++---
 tools/perf/util/probe-file.c                | 77 ++++++++++++++++-------------
 tools/perf/util/probe-file.h                |  1 +
 4 files changed, 56 insertions(+), 44 deletions(-)

-- 
2.11.1
