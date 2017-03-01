Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYJn143cMzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 02:11:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21F4M5B119973
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:11:15 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxray6m1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 10:11:14 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 20:41:11 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 801EC125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 20:41:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21FA1Kq19333190
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:40:01 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21FB6sn014446
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:41:07 +0530
Date: Wed, 1 Mar 2017 20:41:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 2/2] perf: kretprobes: offset from reloc_sym if kernel
 supports it
References: <b580465c7a4dcd5d3b40fdf8568e6be45d0a6333.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
 <2f4181ecccf794d05065cb10648badc290aa4c28.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170225021208.3bb8f7810ae1c5644df3ae6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225021208.3bb8f7810ae1c5644df3ae6a@kernel.org>
Message-Id: <20170301151105.GL4212@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/25 02:12AM, Masami Hiramatsu wrote:
> On Thu, 23 Feb 2017 17:07:24 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > We indicate support for accepting sym+offset with kretprobes through a
> > line in ftrace README. Parse the same to identify support and choose the
> > appropriate format for kprobe_events.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/probe-event.c | 49 ++++++++++++++++++++++++++++++++++++-------
> >  tools/perf/util/probe-event.h |  2 ++
> >  2 files changed, 44 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 35f5b7b7715c..dd6b9ce0eef3 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -737,6 +737,43 @@ post_process_module_probe_trace_events(struct probe_trace_event *tevs,
> >  	return ret;
> >  }
> >  
> > +bool is_kretprobe_offset_supported(void)
> > +{
> > +	FILE *fp;
> > +	char *buf = NULL;
> > +	size_t len = 0;
> > +	bool target_line = false;
> > +	static int supported = -1;
> > +	int fd;
> > +
> > +	if (supported >= 0)
> > +		return !!supported;
> > +
> > +	fd = open_trace_file("README", false);
> > +	if (fd < 0)
> > +		return false;
> > +
> > +	fp = fdopen(fd, "r");
> > +	if (!fp) {
> > +		close(fd);
> > +		return false;
> > +	}
> > +
> > +	while (getline(&buf, &len, fp) > 0) {
> > +		target_line = !!strstr(buf, "place (kretprobe): ");
> > +		if (!target_line)
> > +			continue;
> > +		supported = 1;
> > +	}
> > +	if (supported == -1)
> > +		supported = 0;
> > +
> > +	fclose(fp);
> > +	free(buf);
> > +
> > +	return !!supported;
> > +}
> 
> Hmm, I think you can do more than that. 
> Can you reuse probe_type_is_available() to scan README?
> I think we can have something like scan_ftrace_readme() in probe-file.c
> to scan all the options and cache the results. 
> 
> probe_type_is_available() and kreprobe_offset_is_available()
> just returns cached result or scan it in first call.(I would like to
> ask you to do it in probe-file.c too)

Ok sure, that makes sense. I see that we only ever care about support 
for hex type, so I will add a separate routine to only look for that and 
the newly added kretprobe offset support.

- Naveen
