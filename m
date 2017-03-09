Return-Path: <srs0=sgd/=2s=linux.vnet.ibm.com=sachinp@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf0c06Lf9zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 17:19:44 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vf0c05k2Yz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 17:19:44 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vf0c01Xtvz9sNX
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2017 17:19:43 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v296JGLV073846
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 01:19:42 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292gf1x5k9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Mar 2017 01:19:41 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 16:19:39 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v296JTo424772678
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 17:19:37 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v296J5pD009215
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 17:19:05 +1100
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [FIX PATCH v1] powerpc/pseries: Fix reference count leak during
 CPU unplug
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <1489034268-24888-1-git-send-email-bharata@linux.vnet.ibm.com>
Date: Thu, 9 Mar 2017 11:48:39 +0530
Cc: linuxppc-dev@ozlabs.org, nfont@linux.vnet.ibm.com
References: <1489034268-24888-1-git-send-email-bharata@linux.vnet.ibm.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Message-Id: <F4FE280B-9F47-4ABF-85BC-A166710CF47B@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Fix this by ensuring that of_node_put() is called only from the
> error path in dlpar_cpu_remove_by_index(). In the normal path,
> of_node_put() happens as part of dlpar_detach_node().
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
> Changes in v1:
> - Fixed the refcount problem in the userspace driven unplug path
>  in addition to in-kernel unplug path. (Sachin Sant)
> 
> v0: https://patchwork.ozlabs.org/patch/736547/
> 

Thanks Bharata.
Tested cpu hotplug/unplug with this fix on a PowrVM LPAR. 

Tested-by : Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks
-Sachin
