Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC1BF1w2czDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 00:25:41 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7EENo19019689
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 10:25:38 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24th1yn8bv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 10:25:38 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 14 Aug 2016 08:25:37 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/6] powerpc/8xx: implementation of huge pages
In-Reply-To: <15e0fa7a312245e681cb9ca18ffb875c7820e5fc.1471020647.git.christophe.leroy@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <15e0fa7a312245e681cb9ca18ffb875c7820e5fc.1471020647.git.christophe.leroy@c-s.fr>
Date: Sun, 14 Aug 2016 19:55:30 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760r3a0md.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The 8xx has 512k and 8M pages. This patch implements hugepages using
> those sizes.
>
> On the 8xx, the size of pages is in the PGD entry,
> using PS field (bits 28-29):
> 00 : Small pages (4k or 16k)
> 01 : 512k pages
> 10 : reserved
> 11 : 8M pages
>
> The implementation uses a mix of what is used on BOOKS and BOOKE,
> as 512k pages are in HUGEPTE tables while for 8M pages we have
> several PGD entries pointing on a leaf HUGEPTE entry
>
> For the time being, we do not support CPU15 ERRATA if HUGETLB is
> selected

Can you also document here the format for linux page table with different
huge page size. ?

>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
