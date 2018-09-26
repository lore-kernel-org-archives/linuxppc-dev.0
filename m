Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KnWN3YhjzF110
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 16:06:24 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8Q5wWaF073081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:06:22 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mr3qehydf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:06:22 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 26 Sep 2018 00:06:21 -0600
Date: Wed, 26 Sep 2018 11:36:13 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: ego@linux.vnet.ibm.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
 <20180922110340.GA1402@in.ibm.com>
 <f2ac8eb0-b28e-a930-0160-09720f73a297@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f2ac8eb0-b28e-a930-0160-09720f73a297@intel.com>
Message-Id: <20180926060613.GA22139@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dave,

On Tue, Sep 25, 2018 at 03:16:30PM -0700, Dave Hansen wrote:
> On 09/22/2018 04:03 AM, Gautham R Shenoy wrote:
> > Without this patchset, the SMT domain would be defined as the group of
> > threads that share L2 cache.
> 
> Could you try to make a more clear, concise statement about the current
> state of the art vs. what you want it to be?  Right now, the sched
> domains do something like this in terms of ordering:
> 
> 1. SMT siblings
> 2. Caches
> 3. NUMA

Yes. you are right. The state of art on POWER9 machines having SMT8
cores is as you described above with

1. SMT siblings sharing L2-cache, called the SMT domain
2. Cores on the same die, called the DIE domain
3. NUMA

> 
> It sounds like you don't want SMT siblings to be the things that we use,
> right?  Because some siblings share caches and some do not.  Right?  You
> want something like this:
> 
> 1. SMT siblings (sharing L1)
> 2. SMT siblings (sharing L2)
> 3. Other caches
> 4. NUMA
>

Yes, with the patchset the sched-domain hierarchy on POWER9 machines
having SMT8 will be:

1. SMT siblings sharing L1 cache, called the SMT domain
2. SMT siblings sharing L2 cache, called the CACHE domain (introduced in
   commit 96d91431d691 "powerpc/smp: Add Power9 scheduler topology")
3. Cores on the same die, called the DIE domain.
4. NUMA

--
Thanks and Regards
gautham.
