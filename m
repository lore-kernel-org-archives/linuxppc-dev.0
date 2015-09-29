Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6F5B1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 18:01:44 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 13:30:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7949B394006C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:30:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T80S1X50659510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:30:28 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T80RqL025801
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:30:27 +0530
Date: Tue, 29 Sep 2015 13:30:10 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf record: Limit --intr-regs to platforms supporting
 PERF_REGS
Message-ID: <20150929080010.GB1060@naverao1-tp.in.ibm.com>
References: <1443096718-11926-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150924125703.GA11857@krava.redhat.com>
 <CABPqkBSaxTm6-7x7VpwRtw6aS2qmHup_VsWK0VYFJVwZSMG10w@mail.gmail.com>
 <20150924164554.GA11493@naverao1-tp.in.ibm.com>
 <20150929053617.GA1060@naverao1-tp.in.ibm.com>
 <20150929065335.GE18363@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150929065335.GE18363@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/09/29 08:53AM, Jiri Olsa wrote:
> On Tue, Sep 29, 2015 at 11:06:17AM +0530, Naveen N. Rao wrote:
> > On 2015/09/24 10:15PM, Naveen N Rao wrote:
> > > On 2015/09/24 08:32AM, Stephane Eranian wrote:
> > > > On Thu, Sep 24, 2015 at 5:57 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Thu, Sep 24, 2015 at 05:41:58PM +0530, Naveen N. Rao wrote:
> > > > > > perf build currently fails on powerpc:
> > > > > >
> > > > > >   LINK     perf
> > > > > > libperf.a(libperf-in.o):(.toc+0x120): undefined reference to
> > > > > > `sample_reg_masks'
> > > > > > libperf.a(libperf-in.o):(.toc+0x130): undefined reference to
> > > > > > `sample_reg_masks'
> > > > > > collect2: error: ld returned 1 exit status
> > > > > > make[1]: *** [perf] Error 1
> > > > > > make: *** [all] Error 2
> > > > > >
> > > > > > This is due to parse-regs-options.c using sample_reg_masks, which is
> > > > > > defined only with CONFIG_PERF_REGS.
> > > > > >
> > > > > > In addition, perf record -I is only useful if the arch supports
> > > > > > PERF_REGS. Hence, let's expose -I conditionally.
> > > > > >
> > > > > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > > >
> > > > > hum, I wonder why we have sample_reg_masks defined as weak in util/perf_regs.c
> > > > > which is also built only via CONFIG_PERF_REGS
> > > > >
> > > > > I wonder we could get rid of the weak definition via attached patch, Stephane?
> > > > >
> > > > But the whole point of having it weak is to avoid this error scenario
> > > > on any arch without support
> > > > and avoid ugly #ifdef HAVE_ in generic files.
> > > > 
> > > > if perf_regs.c is compiled on PPC, then why do we get the undefined?
> > > 
> > > As Jiri Olsa pointed out, powerpc and many other architectures don't 
> > > (yet) have support for perf regs.
> > > 
> > > But, the larger reason to introduce #ifdef is so the user doesn't see 
> > > options (s)he can't use on a specific architecture, along the same lines 
> > > as builtin-probe.c
> > 
> > Stephane, Arnaldo,
> > Suka has also posted a fix for this with a different approach [1]. Can 
> > you please ack/pull one of these versions? Building perf is broken on 
> > v4.3-rc due to this.
> 
> I did not get any answer for additional comments I made to the patch
> (couldnt get marc.info working, sending the patch again)

Hi Jiri,
I concur with the changes you proposed to my patch here (getting rid of 
the weak variant):
http://article.gmane.org/gmane.linux.kernel/2046108

I am aware of the other approach you posted (and the one attached 
below). When I said "please ack/pull one of these versions", I meant one 
of: your version, Suka's and mine.

> 
> > 
> > [1] http://article.gmane.org/gmane.linux.kernel/2046370
> 
> I dont have this last version, which seems to have other changes
> and patch in above link looks mangled, could you please repost it?

Can you please check the raw version:
http://article.gmane.org/gmane.linux.kernel/2046370/raw


Thanks,
Naveen
