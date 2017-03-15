Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjmFt73lyzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 20:17:06 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2F9G3xl117111
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:16:57 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 296ng6tsyv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:16:56 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 15 Mar 2017 19:16:52 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2F9Gf6N43909228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 20:16:49 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2F9GGZI002990
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 20:16:17 +1100
Date: Wed, 15 Mar 2017 14:45:59 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powerpc: kretprobes: override default function
 entry offset
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <87o9xcujzi.fsf@concordia.ellerman.id.au>
 <20170308142412.GI11046@naverao1-tp.localdomain>
 <20170308142916.GA3035@kernel.org>
 <20170308164644.GK11046@naverao1-tp.localdomain>
 <87a88vuf9p.fsf@concordia.ellerman.id.au>
 <20170314131839.GD3089@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314131839.GD3089@kernel.org>
Message-Id: <20170315091559.GF20400@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/14 10:18AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 09, 2017 at 05:37:38PM +1100, Michael Ellerman escreveu:
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > > On 2017/03/08 11:29AM, Arnaldo Carvalho de Melo wrote:
> > >> > I wasn't sure if you were planning on picking up KPROBES_ON_FTRACE for 
> > >> > v4.11. If so, it would be good to take this patch through the powerpc 
> > >> > tree. Otherwise, this can go via Ingo's tree.
> > >> 
> > >> If you guys convince Ingo that this should go _now_, then just cherry
> > >> pick what was merged into tip/perf/core that is needed for the arch
> > >> specific stuff and go from there.
> > >
> > > Ok, in hindsight, I think Michael's concern was actually for v4.12 
> > 
> > Yes I was talking about 4.12, sorry I thought that was implied :)
> > 
> > > itself, in which case this particular patch can go via powerpc tree, 
> > > while the rest of the patches in this series can go via your tree.
> > >
> > > Michael?
> > 
> > Yeah I think that's the easiest option. The function will be temporarily
> > unused until the two trees are merged, but I think that's fine.
> 
> Ok, done that, now compile testing building it in my
> multi-distro/x-build containers.

Thanks, Arnaldo!

I did however notice that you don't seem to have applied Patch 1/5 from 
this series:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1347858.html

That patch is needed to ensure perf continues to work when ftrace README 
advertises support for ref_reloc_sym+offset for kretprobes. Can you 
please apply that as well?

- Naveen
