Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdbPr51ZYzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 01:24:32 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v28EOE1v137431
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 09:24:22 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292j7v4esj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 09:24:21 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 19:54:17 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v28EOGev12976322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:54:16 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v28EOE2c023325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:54:15 +0530
Date: Wed, 8 Mar 2017 19:54:12 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powerpc: kretprobes: override default function
 entry offset
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <87o9xcujzi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87o9xcujzi.fsf@concordia.ellerman.id.au>
Message-Id: <20170308142412.GI11046@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 2017/03/08 09:43PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > With ABIv2, we offset 8 bytes into a function to get at the local entry
> > point.
> >
> > Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/kprobes.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> I'm OK with this change, and I'm happy for it to go with the rest of the
> series via acme's tree:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 
> But, you've also sent a series to do KPROBES_ON_FTRACE, and that also
> touches this function, see the 2nd to last hunk at:
> 
>   https://patchwork.ozlabs.org/patch/730675/
> 
> 
> If this goes via acme's tree it will be awkward for me to merge the
> series above via the powerpc tree.

Ah yes, indeed.

> 
> So we could do topic branches and so on, or we could just drop this
> patch from this series, and I'll merge it as part of the other series.
> It won't do anything useful until it's merged with a tree that also has
> the rest of this series. Or something else I haven't thought of.

The arch-independent change that this depends on has been picked up by 
Arnaldo and pushed to Ingo:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg115211.html

I'm guessing this will go into v4.11? In which case, this powerpc patch 
should also go in. Otherwise kretprobes will be broken on powerpc64le.

I wasn't sure if you were planning on picking up KPROBES_ON_FTRACE for 
v4.11. If so, it would be good to take this patch through the powerpc 
tree. Otherwise, this can go via Ingo's tree.


Thanks,
Naveen
