Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWjrx4zDqzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 11:54:09 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1R0rZwC040507
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 19:54:07 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28uqvkvpab-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 19:54:06 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Feb 2017 10:54:04 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9F6992CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 11:54:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1R0rqPt40239176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 11:54:00 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1R0rRxr026438
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 11:53:27 +1100
Date: Mon, 27 Feb 2017 11:53:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too
 many TCE levels requested
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170222044359.3663-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170222044359.3663-1-aik@ozlabs.ru>
Message-Id: <20170227005303.GA4780@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2017 at 03:43:59PM +1100, Alexey Kardashevskiy wrote:
>The IODA2 specification says that a 64 DMA address cannot use top 4 bits
>(3 are reserved and one is a "TVE select"); bottom page_shift bits
>cannot be used for multilevel table addressing either.
>
>The existing IODA2 table allocation code aligns the minimum TCE table
>size to PAGE_SIZE so in the case of 64K system pages and 4K IOMMU pages,
>we have 64-4-12=48 bits. Since 64K page stores 8192 TCEs, i.e. needs
>13 bits, the maximum number of levels is 48/13 = 3 so we physically
>cannot address more and EEH happens on DMA accesses.
>
>This adds a check that too many levels were requested.
>
>It is still possible to have 5 levels in the case of 4K system page size.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>---

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
