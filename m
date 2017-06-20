Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsPnX1XTtzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 20:52:47 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KAmvbD042994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 06:52:45 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6ykwy61a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 06:52:45 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 20:52:43 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5KAqX6e721306
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 20:52:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5KAq9SK017415
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 20:52:09 +1000
Subject: Re: [RFC v2 02/12] powerpc: Free up four 64K PTE bits in 64K backed
 hpte pages.
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 16:21:45 +0530
MIME-Version: 1.0
In-Reply-To: <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <ff6fe458-6539-e237-4556-41872385815a@linux.vnet.ibm.com>
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
> in the 64K backed hpte pages. This along with the earlier
> patch will entirely free up the four bits from 64K PTE.
> 
> This patch does the following change to 64K PTE that is
> backed by 64K hpte.
> 
> H_PAGE_F_SECOND which occupied bit 4 moves to the second part
>         of the pte.
> H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
>         second part of the pte.
> 
> since bit 7 is now freed up, we move H_PAGE_BUSY from bit 9
> to bit 7. Trying to minimize gaps so that contiguous bits
> can be allocated if needed in the future.
> 
> The second part of the PTE will hold
> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.

I still dont understand how we freed up the 5th bit which is
used in the 5th patch. Was that bit never used for any thing
on 64K page size (64K and 4K mappings) ?

+#define _RPAGE_RSV5		0x00040UL

+#define H_PAGE_PKEY_BIT0	_RPAGE_RSV1
+#define H_PAGE_PKEY_BIT1	_RPAGE_RSV2
+#define H_PAGE_PKEY_BIT2	_RPAGE_RSV3
+#define H_PAGE_PKEY_BIT3	_RPAGE_RSV4
+#define H_PAGE_PKEY_BIT4	_RPAGE_RSV5
