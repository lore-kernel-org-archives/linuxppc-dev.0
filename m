Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vMCw18cnzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 04:05:15 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7KI4A42032262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 14:05:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m021q1abt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 14:05:13 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 19:05:11 +0100
Date: Mon, 20 Aug 2018 11:05:03 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH v7 2/2] powerpc: Use cpu_smallcore_sibling_mask at SMT
 level on bigcores
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
 <1534743704-4760-3-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1534743704-4760-3-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <20180820180503.GB23117@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-20 11:11:44]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Each of the SMT4 cores forming a big-core are more or less independent
> units. Thus when multiple tasks are scheduled to run on the fused
> core, we get the best performance when the tasks are spread across the
> pair of SMT4 cores.
> 
> This patch achieves this by setting the SMT level mask to correspond
> to the smallcore sibling mask on big-core systems. This patch also
> ensures that while checked for shared-caches on big-core system, we
> use the smallcore_sibling_mask to compare with the l2_cache_mask.
> This ensure that the CACHE level sched-domain is created, whose groups
> correspond to the threads of the big-core.
> 
> With this patch, the SMT sched-domain with SMT=8,4,2 on big-core
> systems are as follows:


Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
