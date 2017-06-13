Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmy7X21SdzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 14:52:56 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5D4mtVP132653
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:52:54 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b27p751qv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:52:53 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 14:52:51 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5D4qm6K786940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 14:52:48 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5D4qljN016655
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 14:52:48 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC PATCH 1/7 v1]powerpc: Free up four PTE bits to accommodate
 memory keys
In-Reply-To: <1496711109-4968-2-git-send-email-linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-2-git-send-email-linuxram@us.ibm.com>
Date: Tue, 13 Jun 2017 10:22:43 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw3k1obo.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Rearrange  PTE   bits to  free  up  bits 3, 4, 5  and  6  for
> memory keys. Bit 3, 4, 5, 6 and 57  shall  be used for memory
> keys.
>
> The patch does the following change to the 64K PTE format
>
> H_PAGE_BUSY moves from bit 3 to bit 7
> H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> 	of the pte.
> H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> 	second part of the pte.
>
> The second part of the PTE will hold
>    a (H_PAGE_F_SECOND|H_PAGE_F_GIX)  for  64K page backed pte,
>    and sixteen (H_PAGE_F_SECOND|H_PAGE_F_GIX)  for 4k  backed
> 	pte.
>
> the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
> is initialized to 0xF indicating a invalid slot. if a hashpage does
> get  allocated  to  the  0xF  slot, it is released and not used. In
> other words, even  though  0xF  is  a valid slot we discard it  and
> consider it as invalid slot(HPTE_SOFT_INVALID). This  gives  us  an
> opportunity to  not  depend on a bit in the primary PTE in order to
> determine the validity of a slot.
>
> When  we  release  a  0xF slot we also release a legitimate primary
> slot  and  unmap  that  entry. This  is  to  ensure  that we do get
> a legimate non-0xF slot the next time we retry for a slot.
>
> Though treating 0xF slot as invalid reduces the number of available
> slots and make have a effect on the performance, the probabilty
> of hitting a 0xF is extermely low.
>
> Compared  to the current scheme, the above described scheme reduces
> the number of false hash table updates  significantly  and  has the
> added  advantage  of  releasing  four  valuable  PTE bits for other
> purpose.
>
> This idea was jointly developed by Paul Mackerras, Aneesh, Michael
> Ellermen and myself.
>
> 4K PTE format remain unchanged currently.
>

Can you also split this patch into two. One which changes
__hash_page_4k() ie, linux pte format w.r.t 4k hash pte. Second patch
with changes w.r.t __hash_page_64k() ie, pte format w.r.t 64k hash pte.

-aneesh
