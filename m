Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtbMS4QCBzDr0Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:07:48 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5M948Hl057881
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 05:07:45 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b89yyugrm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 05:07:44 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 19:07:37 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5M97WEF61341808
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:07:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5M97UAr010214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:07:31 +1000
Subject: Re: [RFC v2 01/12] powerpc: Free up four 64K PTE bits in 4K backed
 hpte pages.
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-2-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 14:37:27 +0530
MIME-Version: 1.0
In-Reply-To: <1497671564-20030-2-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7348e178-b79e-421a-8dd5-4cfbcd56027a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2017 09:22 AM, Ram Pai wrote:
> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> in the 4K backed hpte pages. These bits continue to be used
> for 64K backed hpte pages in this patch, but will be freed
> up in the next patch.
> 
> The patch does the following change to the 64K PTE format
> 
> H_PAGE_BUSY moves from bit 3 to bit 9
> H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> 	of the pte.
> H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> 	second part of the pte.
> 
> the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
> is  initialized  to  0xF  indicating  an invalid  slot.  If  a hpte
> gets cached in a 0xF  slot(i.e  7th  slot  of  secondary),  it   is
> released immediately. In  other  words, even  though   0xF   is   a
> valid slot we discard  and consider it as an invalid
> slot;i.e hpte_soft_invalid(). This  gives  us  an opportunity to not
> depend on a bit in the primary PTE in order to determine the
> validity of a slot.
> 
> When  we  release  a    hpte   in the 0xF   slot we also   release a
> legitimate primary   slot  and    unmap    that  entry. This  is  to
> ensure  that we do get a   legimate   non-0xF  slot the next time we
> retry for a slot.
> 
> Though treating 0xF slot as invalid reduces the number of available
> slots  and  may  have an effect  on the performance, the probabilty
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

Scanned through the PTE format again for hash 64K and 4K. It seems
to me that there might be 5 free bits already present on the PTE
format. I might have seriously mistaken something here :) Please
correct me if that is not the case. _RPAGE_RPN* I think is applicable
only for hash page table format and will not be available for radix
later.

+#define _PAGE_FREE_1           0x0000000000000040UL /* Not used */
+#define _RPAGE_SW0             0x2000000000000000UL /* Not used */
+#define _RPAGE_SW1             0x0000000000000800UL /* Not used */
+#define _RPAGE_RPN42           0x0040000000000000UL /* Not used */
+#define _RPAGE_RPN41           0x0020000000000000UL /* Not used */
