Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjkY3DPnzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:53:41 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K5paxj057824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:53:39 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btjhmg9an-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:53:39 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 15:53:36 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K5rZ7v28311664
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:53:35 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K5rXAN021956
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:53:35 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, mhocko@kernel.org
Subject: Re: [RFC v6 02/62] powerpc: Free up four 64K PTE bits in 64K backed
 HPTE pages
In-Reply-To: <1500177424-13695-3-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-3-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:23:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a83zr6w9.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> in the 64K backed HPTE pages. This along with the earlier
> patch will  entirely free  up the four bits from 64K PTE.
> The bit numbers are  big-endian as defined in the  ISA3.0
>
> This patch  does  the  following change to 64K PTE backed
> by 64K HPTE.
>
> H_PAGE_F_SECOND (S) which  occupied  bit  4  moves to the
> 	second part of the pte to bit 60.
> H_PAGE_F_GIX (G,I,X) which  occupied  bit 5, 6 and 7 also
> 	moves  to  the   second part of the pte to bit 61,
>        	62, 63, 64 respectively
>
> since bit 7 is now freed up, we move H_PAGE_BUSY (B) from
> bit  9  to  bit  7.
>
> The second part of the PTE will hold
> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> NOTE: None of the bits in the secondary PTE were not used
> by 64k-HPTE backed PTE.
>
> Before the patch, the 64K HPTE backed 64k PTE format was
> as follows
>
>  0 1 2 3 4  5  6  7  8 9 10...........................63
>  : : : : :  :  :  :  : : :                            :
>  v v v v v  v  v  v  v v v                            v
>
> ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> |x|x|x| |S |G |I |X |x|B| |x|x|................|x|x|x|x| <- primary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> | | | | |  |  |  |  | | | | |..................| | | | | <- secondary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
>
> After the patch, the 64k HPTE backed 64k PTE format is
> as follows
>
>  0 1 2 3 4  5  6  7  8 9 10...........................63
>  : : : : :  :  :  :  : : :                            :
>  v v v v v  v  v  v  v v v                            v
>
> ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> |x|x|x| |  |  |  |B |x| | |x|x|................|.|.|.|.| <- primary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> | | | | |  |  |  |  | | | | |..................|S|G|I|X| <- secondary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
>
> The above PTE changes is applicable to hugetlbpages aswell.
>
> The patch does the following code changes:
>
> a) moves  the  H_PAGE_F_SECOND and  H_PAGE_F_GIX to 4k PTE
> 	header   since it is no more needed b the 64k PTEs.
> b) abstracts  out __real_pte() and __rpte_to_hidx() so the
> 	caller  need not know the bit location of the slot.
> c) moves the slot bits the secondary pte.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
With changes suggested for the first patch.

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---


-aneesh
