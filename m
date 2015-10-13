Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72C001A08DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:18:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 15:18:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5E2C82BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:18:33 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D5IKbw44564658
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:18:28 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D5I0UT023087
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:18:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 10/31] powerpc/mm: Don't use pmd_val,
 pud_val and pgd_val as lvalue
In-Reply-To: <1444713006.29347.2.camel@ellerman.id.au>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1444675215-19484-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1444713006.29347.2.camel@ellerman.id.au>
Date: Tue, 13 Oct 2015 10:47:40 +0530
Message-ID: <878u77tki3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Tue, 2015-10-13 at 00:09 +0530, Aneesh Kumar K.V wrote:
>> We convert them static inline function here as we did with pte_val in
>> the previous patch
>
> This breaks ppc40x_defconfig & 40x/ep405_defconfig with:
>
>   arch/powerpc/mm/40x_mmu.c: In function 'mmu_mapin_ram':
>   arch/powerpc/mm/40x_mmu.c:113:20: error: lvalue required as left operand of assignment
>   arch/powerpc/mm/40x_mmu.c:114:20: error: lvalue required as left operand of assignment
>   arch/powerpc/mm/40x_mmu.c:115:20: error: lvalue required as left operand of assignment
>   arch/powerpc/mm/40x_mmu.c:116:20: error: lvalue required as left operand of assignment
>   arch/powerpc/mm/40x_mmu.c:128:18: error: lvalue required as left operand of assignment
>
> Which is mainly:
>
> 	pmd_val(*pmdp++) = val;
>
>
> The obvious patch to use pmd_set() doesn't work, I think because there's no
> pmd_set() defined for 32-bit nohash?
>

That should be

     *pmdp++ = __pmd(val);

-aneesh
