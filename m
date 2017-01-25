Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7XsD6xrDzDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 15:59:28 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0P4wuoK086780
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 23:59:25 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286dq3pr8q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 23:59:25 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 14:59:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0AED52BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 15:59:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0P4xCvt35717226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 15:59:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0P4wl4S030573
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 15:58:48 +1100
Date: Wed, 25 Jan 2017 15:58:22 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170125035744.GB12855@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170125035744.GB12855@localhost.localdomain>
Message-Id: <20170125045822.GA10566@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 09:27:44AM +0530, Balbir Singh wrote:
>On Tue, Jan 24, 2017 at 10:32:28AM +1100, Gavin Shan wrote:
>> When @node_reclaim_mode ("/proc/sys/vm/zone_reclaim_mode") is enabled,
>> the nodes in the specified distance (< RECLAIM_DISTANCE) to the preferred
>> one will be checked for page direct reclaim in the fast path, as below
>> function call chain indicates. Currently, RECLAIM_DISTANCE is set to 10,
>> equal to LOCAL_DISTANCE. It means no nodes, including the preferred one,
>> don't match the conditions. So no nodes are checked for direct reclaim
>> in the fast path.
>> 
>>    __alloc_pages_nodemask
>>    get_page_from_freelist
>>    zone_allows_reclaim
>> 
>> This fixes it by setting RECLAIM_DISTANCE to 30. With it, the preferred
>> node and its directly adjacent nodes will be checked for page direct
>> reclaim. The comments explaining RECLAIM_DISTANCE is out of date. This
>> updates and makes it correct.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>
>I spoke about this at length with Anton and the larger kernel team.
>We need performance data before we can commit to the change. Do we
>benchmarks to show that the change does not introduce regression
>w.r.t runtime cost?
>

Thanks for review. I just found the problem when studying the code
last year. It sounds reasonable not to rely on the slow path for page
reclaim if the fast path can reclaim enough pages. From this point,
I believe the performance should be improved. In the meanwhile, the
page cache/buffer could be released, as part of the output of page
reclaim. It's going to affect fs's performance for sure. So do you
have recommended test examples to measure the improved performance
because of this?

Thanks,
Gavin
