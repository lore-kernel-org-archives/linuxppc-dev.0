Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1c3y4sF1zDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:03:26 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A3x1Bl094658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 00:03:15 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29qts5xeyx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 00:03:15 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 14:03:12 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A431u19764916
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:03:09 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A42bca018469
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:02:37 +1000
Subject: Re: [PATCH] powerpc/mm: Dump hash table
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170410020404.11375-1-rashmica.g@gmail.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 09:32:14 +0530
MIME-Version: 1.0
In-Reply-To: <20170410020404.11375-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <3b8a7252-dc80-8c04-2df8-4dca17348f8f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2017 07:34 AM, Rashmica Gupta wrote:
> Current behaviour assumes that memory in RAM is contiguous and
> iterates from the start of RAM to (start + size of memory). When the
> memory isn't physically contiguous, this approach doesn't work.

In dis contiguous platform, we just finish up walking linear
mapping prematurely before the end of the RAM ?

> 
> If memory exists at 0-5 GB and 6-10 GB then the current approach will
> check if entries exist in the hash table from 0GB to 9GB. This patch
> changes the behaviour to iterate up to the end of RAM.

So it fixes the commit which added memblock_phys_mem_size().
Hence needs "Fixes: " tag as well.
