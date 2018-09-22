Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42HSK567qXzF3Nk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 21:04:25 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8MB4MLj104675
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 07:04:23 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mnk5fj9m6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 07:04:22 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sat, 22 Sep 2018 05:03:50 -0600
Date: Sat, 22 Sep 2018 16:33:40 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
Message-Id: <20180922110340.GA1402@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

On Thu, Sep 20, 2018 at 11:04:54AM -0700, Dave Hansen wrote:
> On 09/20/2018 10:22 AM, Gautham R. Shenoy wrote:
> >  	   -------------------------
> > 	   |  	    L1 Cache       |
> >        ----------------------------------
> >        |L2|     |     |     |      |
> >        |  |  0  |  2  |  4  |  6   |Small Core0
> >        |C |     |     |     |      |
> > Big    |a --------------------------
> > Core   |c |     |     |     |      |
> >        |h |  1  |  3  |  5  |  7   | Small Core1
> >        |e |     |     |     |      |
> >        -----------------------------
> > 	  |  	    L1 Cache       |
> > 	  --------------------------
> 
> The scheduler already knows about shared caches.  Could you elaborate on
> how this is different from the situation today where we have multiple
> cores sharing an L2/L3?

The issue is not so much about the threads in the core sharing L2
cache. But the two group of threads in the core, each of which has its
own L1-cache. This patchset (the second patch in the series) informs
the scheduler of this distinction by defining the SMT sched-domain
have groups correspond to the threads that share L1 cache. With this
the scheduler will treat a pair of threads {1,2} differently from
{1,3} when threads 1 and 3 share the L1 cache, while 1 and 2 don't.

The next sched-domain (CACHE domain) is defined as the group of
threads that share the L2 cache, which happens to be the entire big
core.

Without this patchset, the SMT domain would be defined as the group of
threads that share L2 cache. Thus, the scheduler would treat any two
threads in the big-core in the same way, resulting in run-to-run
variance when the software threads are placed on pair of threads
within the same L1-cache group or on separate ones.

> 
> Adding the new sysfs stuff seems like overkill if that's all that you
> are trying to do.
>

The sysfs attributes are to inform the users that we have a big-core
configuration comprising of two small cores, thereby allowing them to
make informed choices should they want to pin the tasks to the CPUs.

--
Thanks and Regards
gautham.
