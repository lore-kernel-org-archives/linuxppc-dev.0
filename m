Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DdMW3zf6zF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 06:41:42 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8HKcpDC133082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 16:41:40 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mjj3vkmxt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 16:41:39 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 17 Sep 2018 14:41:39 -0600
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 17 Sep 2018 13:41:34 -0700
MIME-Version: 1.0
In-Reply-To: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <17857078-f634-4d57-0711-de25b9f61c4d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/17/2018 12:14 PM, Nathan Fontenot wrote:
> When performing partition migrations all present CPUs must be online
> as all present CPUs must make the H_JOIN call as part of the migration
> process. Once all present CPUs make the H_JOIN call, one CPU is returned
> to make the rtas call to perform the migration to the destination system.
> 
> During testing of migration and changing the SMT state we have found
> instances where CPUs are offlined, as part of the SMT state change,
> before they make the H_JOIN call. This results in a hung system where
> every CPU is either in H_JOIN or offline.
> 
> To prevent this this patch disables CPU hotplug during the migration
> process.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
