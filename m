Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcbbj4H6zzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 00:29:53 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UESjs1145922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 10:29:48 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2as03rs670-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 10:29:47 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 31 May 2017 00:29:44 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4UETXSr7668160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 00:29:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4UET8wp025289
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 00:29:09 +1000
Date: Tue, 30 May 2017 19:58:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 ananth@linux.vnet.ibm.com
Subject: Re: [RFC 2/2] powerpc/kprobes: Move kprobes over to patch_instruction
References: <20170516034913.21163-1-bsingharora@gmail.com>
 <20170516034913.21163-3-bsingharora@gmail.com>
 <20170516133532.GA19390@naverao1-tp.localdomain>
 <1494985204.30802.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494985204.30802.4.camel@gmail.com>
Message-Id: <20170530142850.GN19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/17 11:40AM, Balbir Singh wrote:
> On Tue, 2017-05-16 at 19:05 +0530, Naveen N. Rao wrote:
> > On 2017/05/16 01:49PM, Balbir Singh wrote:
> > > arch_arm/disarm_probe use direct assignment for copying
> > > instructions, replace them with patch_instruction
> > 
> > Thanks for doing this!
> > 
> > We will also have to convert optprobes and ftrace to use 
> > patch_instruction, but that can be done once the basic infrastructure is 
> > in.
> >
> 
> I think these patches can go in without even patch 1. I looked quickly at
> optprobes and ftrace and thought they were already using patch_instruction
> (ftrace_modify_code() and arch_optimize_kprobes()), are there other paths
> I missed?

[Sorry for the delay...]

Yes, all the patch_*_insns() functions need to be converted since the 
area they patch comes from .text. There is also a memcpy() where we copy 
the instruction template in, so perhaps a patch_instructions() helper 
may be useful too.

- Naveen
