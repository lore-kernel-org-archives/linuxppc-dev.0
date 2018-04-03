Return-Path: <prvs=06317446eb=vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FnKq3XRvzF26f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 21:43:43 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33BhbSG024684
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 07:43:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h45bek5gf-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 07:43:37 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 12:43:34 +0100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: ldufour@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] cxl: Fix possible deadlock when processing page faults
 from cxllib
In-Reply-To: <20180403094311.331-1-fbarrat@linux.vnet.ibm.com>
References: <20180403094311.331-1-fbarrat@linux.vnet.ibm.com>
Date: Tue, 03 Apr 2018 17:13:27 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <876058o6qo.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> cxllib_handle_fault() is called by an external driver when it needs to
> have the host process page faults for a buffer which may cover several
> pages. Currently the function holds the mm->mmap_sem semaphore with
> read access while iterating over the buffer, since it could spawn
> several VMAs. When calling a lower-level function to handle the page
> fault for a single page, the semaphore is accessed again in read
> mode. That is wrong and can lead to deadlocks if a writer tries to
> sneak in while a buffer of several pages is being processed.
>
> The fix is to release the semaphore once cxllib_handle_fault() got the
> information it needs from the current vma. The address space/VMAs
> could evolve while we iterate over the full buffer, but in the
> unlikely case where we miss a page, the driver will raise a new page
> fault when retrying.
>
> Fixes: 3ced8d730063 ("cxl: Export library to support IBM XSL")
> Cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
