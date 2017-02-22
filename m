Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSz561q1mzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:40:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MDdK1V126866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:40:05 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28s6qencg8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:40:05 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 19:10:01 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B384E3940060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:09:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MDdw5p10551418
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:09:58 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MDdvbT025462
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:09:58 +0530
Date: Wed, 22 Feb 2017 19:09:56 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
 <20170217204254.GH4109@kernel.org>
 <20170219134211.0a43dfb2534563af5b6d440d@kernel.org>
 <20170220095024.GB12165@naverao1-tp.localdomain>
 <20170221220754.19e38e3728e235325b9385c3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221220754.19e38e3728e235325b9385c3@kernel.org>
Message-Id: <20170222133956.GD12165@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/21 10:07PM, Masami Hiramatsu wrote:
> On Mon, 20 Feb 2017 15:20:24 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/02/19 01:42PM, Masami Hiramatsu wrote:
> > > On Fri, 17 Feb 2017 17:42:54 -0300
> > > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > 
> > > > Em Fri, Feb 17, 2017 at 07:44:33PM +0900, Masami Hiramatsu escreveu:
> > > > > On Thu, 16 Feb 2017 13:47:37 +0530
> > > > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > > > 
> > > > > > I am posting the powerpc bits in the same thread so as to keep these
> > > > > > changes together. I am not sure how this should be taken upstream as
> > > > > > there are atleast three different trees involved: one for the core
> > > > > > kprobes infrastructure, one for powerpc and one for perf.
> > > > 
> > > > > Hmm, could you make these (and other related) patches and
> > > > > other series in one series? Or wait for the other series
> > > > > are merged correctly.
> > > > 
> > > > Well, patches like these should be done in a way that the tooling parts
> > > > can deal with kernels with or without the kernel changes, so that older
> > > > tools work with new kernels and new tools work with older kernels.
> > > > 
> > > > "work" as in the previous behaviour is kept when a new tool deals with
> > > > an older kernel and an older tool would warn the user that what it needs
> > > > is not present in that kernel.
> > > > 
> > > > Is this the case? I just looked briefly at the patch commit logs.
> > > 
> > > Thanks Arnaldo,
> > > 
> > > Naveen, I think this one and your previous series are incompatible
> > > with older kernel. So those should be merged in one series and
> > > at least (1) update ftrace's README special file to show explicitly
> > > which can accept text+offset style for kretprobes, and 
> > 
> > Sure - do you mean Documentation/trace/kprobetrace.txt? And, do you want 
> > me to include kernel version where this changed?
> 
> No, I meant /sys/kernel/debug/tracing/README. For some reasons, perf
> probe already parse it in util/probe-file.c. 
> Please see commit 180b20616ce57e93eb692170c793be94c456b1e2 and 
> 864256255597aad86abcecbe6c53da8852ded15b

Got it.

Thanks,
Naveen
