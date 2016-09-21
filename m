Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfQnt6cyKzDslW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 02:59:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LGw5fi082441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 12:59:12 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kkqbdn6a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 12:59:12 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 10:58:55 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powerpc/8xx: Implement support of hugepages
In-Reply-To: <b59c1fce3f5e5f95fd7e70874278ce3602d571aa.1474441302.git.christophe.leroy@c-s.fr>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
 <b59c1fce3f5e5f95fd7e70874278ce3602d571aa.1474441302.git.christophe.leroy@c-s.fr>
Date: Wed, 21 Sep 2016 22:28:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760ppw5od.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> 8xx uses a two level page table with two different linux page size
> support (4k and 16k). 8xx also support two different hugepage sizes
> 512k and 8M. In order to support them on linux we define two different
> page table layout.
>
> The size of pages is in the PGD entry, using PS field (bits 28-29):
> 00 : Small pages (4k or 16k)
> 01 : 512k pages
> 10 : reserved
> 11 : 8M pages
>
> For 512K hugepage size a pgd entry have the below format
> [<hugepte address >0101] . The hugepte table allocated will contain 8
> entries pointing to 512K huge pte in 4k pages mode and 64 entries in
> 16k pages mode.
>
> For 8M in 16k mode, a pgd entry have the below format
> [<hugepte address >1101] . The hugepte table allocated will contain 8
> entries pointing to 8M huge pte.
>
> For 8M in 4k mode, multiple pgd entries point to the same hugepte
> address and pgd entry will have the below format
> [<hugepte address>1101]. The hugepte table allocated will only have one
> entry.
>
> For the time being, we do not support CPU15 ERRATA when HUGETLB is
> selected
>

For the generic bits
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: This v1 was split in two parts. This part focuses on adding the
> support on 8xx. It also fixes an error in TLBmiss handlers in the
> case of 8M hugepages in 16k pages mode.
>

-aneesh
