Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s43L46dhbzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 16:38:20 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u736XsnR135765
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 02:38:19 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24k0bmp1k3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 02:38:18 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 16:38:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E0BCE3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 16:38:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u736cClq26804228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 16:38:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u736cBas027504
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 16:38:12 +1000
Date: Wed, 3 Aug 2016 12:08:08 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 mahesh@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] mm: Allow disabling deferred struct page
 initialisation
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1470143947-24443-2-git-send-email-srikar@linux.vnet.ibm.com>
 <57A0E1D1.8020608@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <57A0E1D1.8020608@intel.com>
Message-Id: <20160803063808.GI6310@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Dave Hansen <dave.hansen@intel.com> [2016-08-02 11:09:21]:

> On 08/02/2016 06:19 AM, Srikar Dronamraju wrote:
> > Kernels compiled with CONFIG_DEFERRED_STRUCT_PAGE_INIT will initialise
> > only certain size memory per node. The certain size takes into account
> > the dentry and inode cache sizes. However such a kernel when booting a
> > secondary kernel will not be able to allocate the required amount of
> > memory to suffice for the dentry and inode caches. This results in
> > crashes like the below on large systems such as 32 TB systems.
> 
> What's a "secondary kernel"?
> 

I mean the kernel thats booted to collect the crash, On fadump, the
first kernel acts as the secondary kernel i.e the same kernel is booted
to collect the crash.

-- 
Thanks and Regards
Srikar Dronamraju
