Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xVzr129ZzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 16:02:15 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7O5xjYR114622
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 02:02:13 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m27bes9d2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 02:02:13 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 24 Aug 2018 00:02:12 -0600
Subject: Re: [PATCH V3 1/6] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 24 Aug 2018 11:32:04 +0530
MIME-Version: 1.0
In-Reply-To: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2112b519-3df5-d45a-b6d6-3fcc805bc0ef@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2018 11:30 AM, Aneesh Kumar K.V wrote:
> With this patch we use 0x8000000000000000UL (_PAGE_PRESENT) to indicate a valid
> pgd/pud/pmd entry. We also switch the p**_present() to look at this bit.
> 
> With pmd_present, we have a special case. We need to make sure we consider a
> pmd marked invalid during THP split as present. Right now we clear the
> _PAGE_PRESENT bit during a pmdp_invalidate. Inorder to consider this special
> case we add a new pte bit _PAGE_INVALID (mapped to _RPAGE_SW0). This bit is
> only used with _PAGE_PRESENT cleared. Hence we are not really losing a pte bit
> for this special case. pmd_present is also updated to look at _PAGE_INVALID.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Changese from V2:
* Rebased to mpe/merge
* Also fixup new WARN_ON with pte_present looking at _PAGE_INVALID now.

-aneesh
