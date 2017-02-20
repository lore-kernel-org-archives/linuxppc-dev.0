Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRf1j1hDczDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:47:36 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1K9hY3x135753
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 04:47:33 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28pgs4j2ky-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 04:47:33 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 19:47:30 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B93C3578058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:47:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1K9lJCK35717360
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:47:27 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1K9ktkc014028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:46:55 +1100
Date: Mon, 20 Feb 2017 15:16:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
 <20170217204254.GH4109@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217204254.GH4109@kernel.org>
Message-Id: <20170220094626.GA12165@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/17 05:42PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 17, 2017 at 07:44:33PM +0900, Masami Hiramatsu escreveu:
> > On Thu, 16 Feb 2017 13:47:37 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > I am posting the powerpc bits in the same thread so as to keep these
> > > changes together. I am not sure how this should be taken upstream as
> > > there are atleast three different trees involved: one for the core
> > > kprobes infrastructure, one for powerpc and one for perf.
> 
> > Hmm, could you make these (and other related) patches and
> > other series in one series? Or wait for the other series
> > are merged correctly.
> 
> Well, patches like these should be done in a way that the tooling parts
> can deal with kernels with or without the kernel changes, so that older
> tools work with new kernels and new tools work with older kernels.
> 
> "work" as in the previous behaviour is kept when a new tool deals with
> an older kernel and an older tool would warn the user that what it needs
> is not present in that kernel.
> 
> Is this the case? I just looked briefly at the patch commit logs.

Thanks, that makes sense.

All the kernel patches here can go in as they are about removing the 
restrictions around use of kretprobes with kprobe_event, except for the 
first patch which hardens use of kretprobes in general by validating 
addresses. None of that should cause issues with the existing tools.

> 
> If it is, then I can pick the tool ones, and the others can be submitted
> to the relevant trees, at some point all will be in, kernels eventually
> gets updated everywhere, ditto for the tooling, all gets well.

Older perf tools with newer kernels will be fine. However, with the 
current perf patches, newer perf will fail with older kernels. I will 
redo the perf patches to address this. So, please don't merge the perf 
bits in this series.


Regards,
Naveen
