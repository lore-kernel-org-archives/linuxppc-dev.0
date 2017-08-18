Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYqF24Wt1zDrCp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 03:04:22 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7IH1HhB074226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 13:04:20 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ce3x7985e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 13:04:20 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 18 Aug 2017 13:04:19 -0400
Date: Fri, 18 Aug 2017 10:04:10 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com>
 <87a836csdl.fsf@concordia.ellerman.id.au>
 <20170817171408.GF5505@ram.oc3035372033.ibm.com>
 <878tihqy5c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878tihqy5c.fsf@concordia.ellerman.id.au>
Message-Id: <20170818170410.GC5545@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2017 at 02:48:31PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > On Fri, Aug 11, 2017 at 08:26:30PM +1000, Michael Ellerman wrote:
> >> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> >> 
> >> > Ram Pai <linuxram@us.ibm.com> writes:
> >> >
> >> >> The value of the AMR register at the time of exception
> >> >> is made available in gp_regs[PT_AMR] of the siginfo.
> ...
> >> 
> >> I don't understand why we are putting it in there at all?
> >> 
> >> Is there some special handling of the actual register on signals? I
> >> haven't seen it. In which case the process can get the value of AMR by
> >> reading the register. ??
> >
> > The value of AMR register at the time of the key-exception may not be
> > the same when the signal handler is invoked. 
> 
> Why not?

Assume two threads of a task.

T1:  mprotect_key(foo, PAGE_SIZE, pkey=4);
T1:  set AMR to disable access for pkey 4;
T1:  key fault
    T2: set AMR to enable access to pkey 4;
T1:  fault handler called.
	This fault handler will see the new AMR and not the
	one at the time of the fault.

RP
