Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcpDR2rb2zF18Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 06:29:43 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w18JS3rO081414
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 14:29:40 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g0vcprwrf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 14:29:40 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 8 Feb 2018 19:29:39 -0000
Date: Thu, 8 Feb 2018 11:29:30 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm: Fix crashes with PUD level hugetlb config
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180208103442.22045-1-aneesh.kumar@linux.vnet.ibm.com>
 <87r2pvfr5g.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2pvfr5g.fsf@linux.vnet.ibm.com>
Message-Id: <20180208192930.GB5559@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2018 at 08:46:27PM +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > To support memory keys, we moved the hash pte slot information to the second
> > half of the page table. This was ok with PTE entries at level 4 and level 3.
> > We already allocate larger page table pages at those level to accomodate extra
> > details. For level 4 we already have the extra space which was used to track
> > 4k hash page table entry details and at pmd level the extra space was allocated
> > to track the THP details.
> >
> > With hugetlbfs PTE, we used this extra space at the PMD level to store the
> > slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
> > didn't allocate extra space. This resulted in memory corruption.
> >
> > Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
> > may need further changes to allocate larger space at PMD level when we enable
> > HUGETLB. That will be done in next patch.
> >
> > Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Another fix, I still get random memory corruption with hugetlb test with
> 16G hugepage config.

this fix may not be needed. It random corruption may be artifact of the typo you
had in your first patch?

RP
