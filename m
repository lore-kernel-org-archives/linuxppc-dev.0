Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D8F71A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 16:53:41 +1000 (AEST)
Date: Tue, 29 Sep 2015 08:53:36 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf record: Limit --intr-regs to platforms supporting
 PERF_REGS
Message-ID: <20150929065335.GE18363@krava.redhat.com>
References: <1443096718-11926-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150924125703.GA11857@krava.redhat.com>
 <CABPqkBSaxTm6-7x7VpwRtw6aS2qmHup_VsWK0VYFJVwZSMG10w@mail.gmail.com>
 <20150924164554.GA11493@naverao1-tp.in.ibm.com>
 <20150929053617.GA1060@naverao1-tp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150929053617.GA1060@naverao1-tp.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 29, 2015 at 11:06:17AM +0530, Naveen N. Rao wrote:
> On 2015/09/24 10:15PM, Naveen N Rao wrote:
> > On 2015/09/24 08:32AM, Stephane Eranian wrote:
> > > On Thu, Sep 24, 2015 at 5:57 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 24, 2015 at 05:41:58PM +0530, Naveen N. Rao wrote:
> > > > > perf build currently fails on powerpc:
> > > > >
> > > > >   LINK     perf
> > > > > libperf.a(libperf-in.o):(.toc+0x120): undefined reference to
> > > > > `sample_reg_masks'
> > > > > libperf.a(libperf-in.o):(.toc+0x130): undefined reference to
> > > > > `sample_reg_masks'
> > > > > collect2: error: ld returned 1 exit status
> > > > > make[1]: *** [perf] Error 1
> > > > > make: *** [all] Error 2
> > > > >
> > > > > This is due to parse-regs-options.c using sample_reg_masks, which is
> > > > > defined only with CONFIG_PERF_REGS.
> > > > >
> > > > > In addition, perf record -I is only useful if the arch supports
> > > > > PERF_REGS. Hence, let's expose -I conditionally.
> > > > >
> > > > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > >
> > > > hum, I wonder why we have sample_reg_masks defined as weak in util/perf_regs.c
> > > > which is also built only via CONFIG_PERF_REGS
> > > >
> > > > I wonder we could get rid of the weak definition via attached patch, Stephane?
> > > >
> > > But the whole point of having it weak is to avoid this error scenario
> > > on any arch without support
> > > and avoid ugly #ifdef HAVE_ in generic files.
> > > 
> > > if perf_regs.c is compiled on PPC, then why do we get the undefined?
> > 
> > As Jiri Olsa pointed out, powerpc and many other architectures don't 
> > (yet) have support for perf regs.
> > 
> > But, the larger reason to introduce #ifdef is so the user doesn't see 
> > options (s)he can't use on a specific architecture, along the same lines 
> > as builtin-probe.c
> 
> Stephane, Arnaldo,
> Suka has also posted a fix for this with a different approach [1]. Can 
> you please ack/pull one of these versions? Building perf is broken on 
> v4.3-rc due to this.

I did not get any answer for additional comments I made to the patch
(couldnt get marc.info working, sending the patch again)

> 
> [1] http://article.gmane.org/gmane.linux.kernel/2046370

I dont have this last version, which seems to have other changes
and patch in above link looks mangled, could you please repost it?

thanks,
jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 142eeb341b29..19c8fd22fbe3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1082,9 +1082,11 @@ struct option __record_options[] = {
 		    "sample transaction flags (special events only)"),
 	OPT_BOOLEAN(0, "per-thread", &record.opts.target.per_thread,
 		    "use per-thread mmaps"),
+#ifdef HAVE_PERF_REGS_SUPPORT
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
 		    " use -I ? to list register names", parse_regs),
+#endif
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4bc7a9ab45b1..93c6371405a3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,7 +104,7 @@ libperf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 
 libperf-y += scripting-engines/
 
-libperf-$(CONFIG_PERF_REGS) += perf_regs.o
+libperf-y += perf_regs.o
 libperf-$(CONFIG_ZLIB) += zlib.o
 libperf-$(CONFIG_LZMA) += lzma.o
 
