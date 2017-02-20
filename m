Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRf6F4MzSzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:51:33 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1K9mbat003775
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 04:51:30 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28qshc2g06-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 04:51:30 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 19:51:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D6E4D2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:51:18 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1K9pASt16580726
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:51:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1K9okuJ008393
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:50:46 +1100
Date: Mon, 20 Feb 2017 15:20:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
 <20170217204254.GH4109@kernel.org>
 <20170219134211.0a43dfb2534563af5b6d440d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170219134211.0a43dfb2534563af5b6d440d@kernel.org>
Message-Id: <20170220095024.GB12165@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/19 01:42PM, Masami Hiramatsu wrote:
> On Fri, 17 Feb 2017 17:42:54 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Fri, Feb 17, 2017 at 07:44:33PM +0900, Masami Hiramatsu escreveu:
> > > On Thu, 16 Feb 2017 13:47:37 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > 
> > > > I am posting the powerpc bits in the same thread so as to keep these
> > > > changes together. I am not sure how this should be taken upstream as
> > > > there are atleast three different trees involved: one for the core
> > > > kprobes infrastructure, one for powerpc and one for perf.
> > 
> > > Hmm, could you make these (and other related) patches and
> > > other series in one series? Or wait for the other series
> > > are merged correctly.
> > 
> > Well, patches like these should be done in a way that the tooling parts
> > can deal with kernels with or without the kernel changes, so that older
> > tools work with new kernels and new tools work with older kernels.
> > 
> > "work" as in the previous behaviour is kept when a new tool deals with
> > an older kernel and an older tool would warn the user that what it needs
> > is not present in that kernel.
> > 
> > Is this the case? I just looked briefly at the patch commit logs.
> 
> Thanks Arnaldo,
> 
> Naveen, I think this one and your previous series are incompatible
> with older kernel. So those should be merged in one series and
> at least (1) update ftrace's README special file to show explicitly
> which can accept text+offset style for kretprobes, and 

Sure - do you mean Documentation/trace/kprobetrace.txt? And, do you want 
me to include kernel version where this changed?

> (2) update
> perf probe side to ensure that (and fallback to previous logic if not).

Sure. I am trying out an approach and will post it as soon as it's 
ready.

Thanks!
- Naveen
