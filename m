Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vctfN16M7zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 21:47:55 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27Ai3XX093316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 05:47:52 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2917mvhee5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 05:47:52 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 16:17:49 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A6FB13940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 16:17:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27All1T17367066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27AlkCj020209
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/3] perf: kretprobes: offset from reloc_sym if kernel
Date: Tue,  7 Mar 2017 16:17:35 +0530
In-Reply-To: <20170306220638.e7db155d44e14325c5c0174b@kernel.org>
References: <20170306220638.e7db155d44e14325c5c0174b@kernel.org>
Message-Id: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/06 10:06PM, Masami Hiramatsu wrote:
> On Mon,  6 Mar 2017 23:19:09 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Masami,
> > Your patch works, thanks! However, I felt we could refactor and reuse
> > some of the code across kprobes.c for this purpose. Can you please see
> > if the below patch is fine?
> 
> OK, looks good to me:)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for the review, Masami!
I ended up adding one more patch to this series (patch 5/6) to move the
ftrace README scanning out of probe-file.c, as it doesn't need libelf.
Patch 6 fails to build without libelf otherwise. Please take a look.

Arnaldo,
I am re-sending the remaining patches in this series which apply on top
of the 4 patches you sent to Ingo, so as to keep this simple. All the
patches have been acked, except the new patch 5/6. Kindly take a look.

Thanks,
Naveen

--
Naveen N. Rao (6):
  trace/kprobes: fix check for kretprobe offset within function entry
  powerpc: kretprobes: override default function entry offset
  perf: probe: factor out the ftrace README scanning
  perf: kretprobes: offset from reloc_sym if kernel supports it
  perf: probes: move ftrace README parsing logic into
    trace-event-parse.c
  perf: powerpc: choose local entry point with kretprobes

 arch/powerpc/kernel/kprobes.c               |  9 +++
 include/linux/kprobes.h                     |  1 +
 kernel/kprobes.c                            | 40 ++++++++-----
 kernel/trace/trace_kprobe.c                 |  2 +-
 tools/perf/arch/powerpc/util/sym-handling.c | 10 ++--
 tools/perf/util/probe-event.c               | 12 ++--
 tools/perf/util/probe-file.c                | 80 +++-----------------------
 tools/perf/util/probe-file.h                |  1 -
 tools/perf/util/trace-event-parse.c         | 89 +++++++++++++++++++++++++++++
 tools/perf/util/trace-event.h               |  4 ++
 10 files changed, 149 insertions(+), 99 deletions(-)

-- 
2.11.1
