Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdWmK3KGhzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 22:40:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v28BT4SL043214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 06:40:02 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292g4kb4ee-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 06:40:01 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 17:09:58 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v28Bckd14915306
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 17:08:46 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v28BdspU013124
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 17:09:55 +0530
Date: Wed, 8 Mar 2017 17:09:52 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 5/5] perf: powerpc: choose local entry point with
 kretprobes
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <7445b5334673ef5404ac1d12609bad4d73d2b567.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170308113156.05692fd7a012ca3f647ed594@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308113156.05692fd7a012ca3f647ed594@kernel.org>
Message-Id: <20170308113952.GH11046@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/08 11:31AM, Masami Hiramatsu wrote:
> On Wed,  8 Mar 2017 13:56:10 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > perf now uses an offset from _text/_stext for kretprobes if the kernel
> > supports it, rather than the actual function name. As such, let's choose
> > the LEP for powerpc ABIv2 so as to ensure the probe gets hit. Do it only
> > if the kernel supports specifying offsets with kretprobes.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> This patch is OK. And I found that most of functions in sym-handling.c
> are used only when libelf is supported. (e.g. probe-event.c itself
> is not built when we have no libelf)
> So, for the next cleanup, this file should not be compiled without
> libelf.

There are still a few functions there which work without libelf. But, I 
agree that the file has far too many #ifdefs between ABIv2 and libelf. I 
will see if I can simplify this file.

Thanks,
Naveen
