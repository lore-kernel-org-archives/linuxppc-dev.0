Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTkWQ2VsJzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 06:17:05 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1NJ9OEY116178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:17:03 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28t39sxtd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:17:02 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 05:17:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8BE173578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 06:16:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1NJGoOh48824518
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 06:16:58 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1NJGPAN026544
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 06:16:26 +1100
Date: Fri, 24 Feb 2017 00:46:08 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <75bafc91e9d381636f68ab9923ce3d52f9157a09.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
Message-Id: <20170223191608.GC4212@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/23 06:10PM, Masami Hiramatsu wrote:
> On Wed, 22 Feb 2017 19:23:40 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > We indicate support for accepting sym+offset with kretprobes through a
> > line in ftrace README. Parse the same to identify support and choose the
> > appropriate format for kprobe_events.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/probe-event.c | 47 ++++++++++++++++++++++++++++++++++++-------
> >  tools/perf/util/probe-event.h |  2 ++
> >  2 files changed, 42 insertions(+), 7 deletions(-)
> > 

[snip]

> 
> Could you reuse (refactoring) probe_type_is_available() in probe-file.c to share
> opening README file?

Done. I've sent patches to do that, please review.

> 
> Others looks good to me :)

Thanks. I hope that's an Ack for this patchset?

If so, and if Ingo/Michael agree, would it be ok to take the kernel bits 
through the powerpc tree like we did for kprobe_exceptions_notify() 
cleanup?


Regards,
Naveen
