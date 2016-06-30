Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgG8j1TwdzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:33:08 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UANbHu135585
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:33:06 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23vvccjqhr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:33:06 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 20:33:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF9ED3578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:33:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UAX0Kp7471474
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:33:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UAX0Mq016422
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:33:00 +1000
Date: Thu, 30 Jun 2016 16:02:54 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Andreas Ziegler <andreas.ziegler@fau.de>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 0/7] eBPF JIT for PPC64
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
 <5774E0FC.7010407@fau.de>
 <CAOJe8K0UcDMnj964EKW8M+f=7K3ArgM5xdF9EcyRCFwd4dWY4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K0UcDMnj964EKW8M+f=7K3ArgM5xdF9EcyRCFwd4dWY4g@mail.gmail.com>
Message-Id: <20160630103254.GD14508@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/30 12:34PM, Denis Kirjanov wrote:
> On 6/30/16, Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> > Hi Naveen,
> >
> > this patchset makes a change to arch/powerpc/net/Makefile in order to only
> > compile the previously existing bpf_jit_comp.c if !CONFIG_PPC64, and use
> > bpf_jit_comp64.c if CONFIG_PPC64 is enabled.
> >
> > Inside arch/powerpc/net/bpf_jit_comp.c, however, there is still an #ifdef
> > CONFIG_PPC64 block at line 667 (linux-next of today, i.e., next-20160630):
> >
> >   #ifdef CONFIG_PPC64
> >                   /* Function descriptor nastiness: Address + TOC */
> >                   ((u64 *)image)[0] = (u64)code_base;
> >                   ((u64 *)image)[1] = local_paca->kernel_toc;
> >   #endif
> >
> > From my understanding of the code, this #ifdef can now be removed, as there
> > is
> > no way the file could be compiled with CONFIG_PPC64 enabled. Is this
> > correct?
> 
> That was used for running classic BPF on ppc64. With eBPF on ppc64 the
> whole block can be removed.

Yes, that can be removed and so can the many 64-bit related macros in 
bpf_jit32.h. The reason I didn't remove those just yet was so that we 
could easily try out the classic BPF JIT for ppc64 BE, for 
testing/performance comparison and so on. I think it would be good to 
retain this for one kernel release.

- Naveen
