Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXWYT5LnqzDrHN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 00:14:05 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7GEAWKP085332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 10:14:03 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccmqx3rhx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 10:14:02 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 00:14:00 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7GEDoEJ34799812
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 00:13:58 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7GEDPD9010947
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 00:13:26 +1000
Date: Wed, 16 Aug 2017 19:43:04 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xmon: Exclude all of xmon/ from ftrace
References: <20170802182538.26526-1-naveen.n.rao@linux.vnet.ibm.com>
 <87wp6emj5w.fsf@concordia.ellerman.id.au>
 <87y3qltadw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y3qltadw.fsf@concordia.ellerman.id.au>
Message-Id: <20170816141304.yqs6evlo3fk2hvss@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
Sorry -- was off since last week.

On 2017/08/15 08:04PM, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> >
> >> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> >> index 0b2f771593eb..5f95af64cb8f 100644
> >> --- a/arch/powerpc/xmon/Makefile
> >> +++ b/arch/powerpc/xmon/Makefile
> >> @@ -7,6 +7,19 @@ UBSAN_SANITIZE := n
> >>  
> >>  ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
> >>  
> >> +ifdef CONFIG_FUNCTION_TRACER
> >> +CFLAGS_REMOVE_xmon.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
> >> +CFLAGS_REMOVE_nonstdio.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
> >> +ifdef CONFIG_XMON_DISASSEMBLY
> >> +CFLAGS_REMOVE_ppc-dis.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
> >> +CFLAGS_REMOVE_ppc-opc.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
> >> +ifdef CONFIG_SPU_BASE
> >> +CFLAGS_REMOVE_spu-dis.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
> >> +CFLAGS_REMOVE_spu-opc.o	= -mno-sched-epilog $(CC_FLAGS_FTRACE)
> >> +endif
> >> +endif
> >> +endif
> >
> > Urk.
> >
> > We want to disable it for everything in the directory, so can you do
> > something like:
> >
> >   ORIG_CFLAGS := $(KBUILD_CFLAGS)
> >   KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> 
> Yes:
> 
>   # Disable ftrace for the entire directory
>   ORIG_CFLAGS := $(KBUILD_CFLAGS)
>   KBUILD_CFLAGS = $(subst -mno-sched-epilog,,$(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS)))
> 
> Seems to work.

Nice -- I had looked for a generic CFLAGS_REMOVE variant, but didn't 
find that. This is much nicer.

Thanks,
Naveen
