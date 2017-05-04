Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMfX5G6szDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:36:04 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444XxFK138500
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:35:56 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a73gxftsj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:35:56 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:35:53 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444ZgSA64553078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:35:50 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444ZIKf005878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:35:18 +1000
Date: Thu, 4 May 2017 10:05:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/8] powerpc/kprobes: Pause function_graph tracing during
 jprobes handling
References: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
 <92bb3fa1bd428d8f556f9a90ff97752c2e8f8dfa.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170503155819.0cbd04e5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503155819.0cbd04e5@gandalf.local.home>
Message-Id: <20170504043500.GA9733@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Copying linuxppc-dev list which I missed cc'ing initially]

On 2017/05/03 03:58PM, Steven Rostedt wrote:
> On Wed,  3 May 2017 23:43:41 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > This fixes a crash when function_graph and jprobes are used together.
> > This is essentially commit 237d28db036e ("ftrace/jprobes/x86: Fix
> > conflict between jprobes and function graph tracing"), but for powerpc.
> > 
> > Jprobes breaks function_graph tracing since the jprobe hook needs to use
> > jprobe_return(), which never returns back to the hook, but instead to
> > the original jprobe'd function. The solution is to momentarily pause
> > function_graph tracing before invoking the jprobe hook and re-enable it
> > when returning back to the original jprobe'd function.
> 
> I wonder if any of this code could be made arch agnostic?

I don't see a way to do that as the jprobe handlers are all 
arch-specific.

> 
> Anyway, Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks,
- Naveen
