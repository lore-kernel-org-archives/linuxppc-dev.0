Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnpP41xvzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 21:03:09 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7LAwmkG107730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 07:03:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m0e2prmbf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 07:03:06 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 21 Aug 2018 12:03:04 +0100
Date: Tue, 21 Aug 2018 04:02:58 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] sched/topology: Set correct numa topology type
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
Message-Id: <20180821110258.GA2080@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2018-08-10 22:30:18]:

> With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
> sched domain") scheduler introduces an new numa level. However this
> leads to numa topology on 2 node systems no more marked as NUMA_DIRECT.
> After this commit, it gets reported as NUMA_BACKPLANE. This is because
> sched_domains_numa_level is now 2 on 2 node systems.
> 
> Fix this by allowing setting systems that have upto 2 numa levels as
> NUMA_DIRECT.
> 
> While here remove a code that assumes level can be 0.
> 
> Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---

Hey Peter,

Did you look at these two patches?

-- 
Thanks and Regards
Srikar Dronamraju
