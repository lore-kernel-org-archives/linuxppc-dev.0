Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdRv14Fv2zDqms
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 00:46:21 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7OEhdeO042746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 10:46:19 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chwu5jtku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 10:46:18 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 10:46:17 -0400
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
 <874lsxw90h.fsf@concordia.ellerman.id.au>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 09:46:14 -0500
MIME-Version: 1.0
In-Reply-To: <874lsxw90h.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <68bf36f4-299c-bbc0-06ea-e8e614812167@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2017 05:33 AM, Michael Ellerman wrote:
> John Allen <jallen@linux.vnet.ibm.com> writes:
> 
>> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
>> order to avoid any unnecessary rtas calls. This substantially reduces the
>> running time of memory hot add on lpars with large amounts of memory.
>>
>> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
> 
> I'll add:
> 
>   Fixes: c21f515c7436 ("powerpc/pseries: Make the acquire/release of the drc for memory a seperate step")
> 
> ?

Yes, thanks.

> 
> How bad is the slow down, do we need to backport to stable/distros?

On an lpar with 16 TB of memory assigned, I observed that adding 1 GB of
memory took several minutes without this fix and improved to several
seconds with this fix. Yep, this will need to be backported. Memory hotplug
performance is a hot issue for our team right now and we'll want to have
solid performance improvement to give to customers relatively soon.

> 
> cheers
> 
> 
