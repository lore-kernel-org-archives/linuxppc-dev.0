Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 592571A028B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 05:05:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 17 Oct 2014 04:05:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6F29C2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 05:05:17 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9GI5Eh027721810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 05:05:14 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9GI5Fss014088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 05:05:16 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATCH 1/2] mm: Update generic gup implementation to handle
 hugepage directory
In-Reply-To: <20141016154228.GA12995@linaro.org>
References: <1413390888-4934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141016092529.GA1524@linaro.org> <871tq8kpqb.fsf@linux.vnet.ibm.com>
 <20141016154228.GA12995@linaro.org>
Date: Thu, 16 Oct 2014 23:35:10 +0530
Message-ID: <87ppdrki09.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux@arm.linux.org.uk, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steve Capper <steve.capper@linaro.org> writes:

> Can we not just add a:
> #define pgd_huge(pgd)		(0)
> above the "#endif /* CONFIG_HUGETLB_PAGE */" line in the second patch?
> (or, more precisely, prevent the second patch from removing this line).
>
> That way we get a clearer code overall?

it is strange to have both pmd_huge and pud_huge in hugetlb.h and
pgd_huge in page.h. But if that is what we want then we may need.


diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index aa430ec14895..aeca81947dc6 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -383,6 +383,7 @@ static inline int hugepd_ok(hugepd_t hpd)
 int pgd_huge(pgd_t pgd);
 #else /* CONFIG_HUGETLB_PAGE */
 #define is_hugepd(pdep)			0
+#define pgd_huge(pgd)			0
 #endif /* CONFIG_HUGETLB_PAGE */
 #define __hugepd(x) ((hugepd_t) { (x) })
 
