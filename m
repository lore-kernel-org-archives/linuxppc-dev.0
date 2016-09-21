Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfQn97061zDsgj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 02:58:37 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LGwDUB115645
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 12:58:35 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25khtdt8fn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 12:58:30 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 10:58:20 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] powerpc: get hugetlbpage handling more generic
In-Reply-To: <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
 <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
Date: Wed, 21 Sep 2016 22:28:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tulw5p8.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Today there are two implementations of hugetlbpages which are managed
> by exclusive #ifdefs:
> * FSL_BOOKE: several directory entries points to the same single hugepage
> * BOOK3S: one upper level directory entry points to a table of hugepages
>
> In preparation of implementation of hugepage support on the 8xx, we
> need a mix of the two above solutions, because the 8xx needs both cases
> depending on the size of pages:
> * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
> that 2 PGD entries will be necessary to cover an 8M hugepage while a
> single PGD entry will cover 8x 512k hugepages.
> * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
> that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
> hugepages will be covers by one PGD entry.
>
> This patch:
> * removes #ifdefs in favor of if/else based on the range sizes
> * merges the two huge_pte_alloc() functions as they are pretty similar
> * merges the two hugetlbpage_init() functions as they are pretty similar

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

-aneesh
