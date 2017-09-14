Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtDcn0lYHzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 20:03:20 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8E9wxIL005808
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:03:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cyq8m1p5k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:03:15 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 20:03:11 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8EA37SB42991686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 20:03:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8EA3786016701
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 20:03:07 +1000
Date: Thu, 14 Sep 2017 15:33:04 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powerpc/kprobes: Do not suppress instruction
 emulation if a single run failed
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <a3a2ddbd004f0410943edb998011cfd31b97384e.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170913165359.475cb23ca0f76f88c3626d31@kernel.org>
 <20170914063807.6cmvisfiwfeluuv3@naverao1-tp.localdomain>
 <20170914024527.c5e52b918372e00061371014@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914024527.c5e52b918372e00061371014@kernel.org>
Message-Id: <20170914100304.loobdbpt6swg4t4m@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/09/14 02:45AM, Masami Hiramatsu wrote:
> On Thu, 14 Sep 2017 12:08:07 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/09/13 04:53PM, Masami Hiramatsu wrote:
> > > On Thu, 14 Sep 2017 02:50:33 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > 
> > > > Currently, we disable instruction emulation if emulate_step() fails for
> > > > any reason. However, such failures could be transient and specific to a
> > > > particular run. Instead, only disable instruction emulation if we have
> > > > never been able to emulate this. If we had emulated this instruction
> > > > successfully at least once, then we single step only this probe hit and
> > > > continue to try emulating the instruction in subsequent probe hits.
> > > 
> > > Hmm, would this mean that the instruction is emulatable or not depends
> > > on context? What kind of situation is considerable?
> > 
> > Yes, as an example, a load/store instruction can cause exceptions 
> > depending on the address. In some of those cases, we will have to single 
> > step the instruction, but we will be able to emulate in most scenarios.
> 
> OK, I got it.
> Could you add this example as comment in the code so that readers can
> easily understand?

Sure.

Thanks,
Naveen
