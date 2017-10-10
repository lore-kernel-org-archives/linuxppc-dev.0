Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBMkw6hy4zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 03:19:35 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9AGFvN9034196
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 12:19:32 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dgyvmx7j4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 12:19:32 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 10 Oct 2017 10:19:31 -0600
Date: Tue, 10 Oct 2017 11:19:25 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH] powerpc/memkey: fix compilation error caused by upstream
 changes
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1507565506-17040-1-git-send-email-linuxram@us.ibm.com>
 <87zi8zwf6c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zi8zwf6c.fsf@concordia.ellerman.id.au>
Message-Id: <20171010161925.GB5334@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2017 at 08:00:27PM +1100, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > "commit df3735c5 -- x86,mpx: make mpx depend on x86-64 to free up VMA flag"
> > added the same vm highmem flag we had introduced for PKEY4. That broke
> > some of the definitions in pkeys.h
> >
> > This patch fixes the issue.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/pkeys.h |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> Thanks.

Oops. this bug is already fixed in my latest branch. Balbir had
commented about it. the issue is that Kconfig is configued to depend on
PPC64 instead of PPC_BOOK3S_64. Will send a fix that applies to your
tree, right away.

RP

> 
> Next problem is pmac32, corenet32/corenet64_smp defconfigs:
> 
>   arch/powerpc/include/asm/pkeys.h:19:23: error: 'VM_HIGH_ARCH_BIT_0' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:20:22: error: 'VM_HIGH_ARCH_0' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:21:22: error: 'VM_HIGH_ARCH_1' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:22:22: error: 'VM_HIGH_ARCH_2' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:23:22: error: 'VM_HIGH_ARCH_3' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:24:22: error: 'VM_HIGH_ARCH_4' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:50:39: error: 'H_PAGE_PKEY_BIT4' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:51:32: error: 'H_PAGE_PKEY_BIT3' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:52:32: error: 'H_PAGE_PKEY_BIT2' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:53:32: error: 'H_PAGE_PKEY_BIT1' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:54:32: error: 'H_PAGE_PKEY_BIT0' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:77:23: error: 'H_PAGE_PKEY_BIT0' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:77:43: error: 'HPTE_R_KEY_BIT0' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:78:16: error: 'H_PAGE_PKEY_BIT1' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:78:36: error: 'HPTE_R_KEY_BIT1' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:79:16: error: 'H_PAGE_PKEY_BIT2' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:79:36: error: 'HPTE_R_KEY_BIT2' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:80:16: error: 'H_PAGE_PKEY_BIT3' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:80:36: error: 'HPTE_R_KEY_BIT3' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:81:16: error: 'H_PAGE_PKEY_BIT4' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:81:36: error: 'HPTE_R_KEY_BIT4' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:89:23: error: 'H_PAGE_PKEY_BIT0' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:90:16: error: 'H_PAGE_PKEY_BIT1' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:91:16: error: 'H_PAGE_PKEY_BIT2' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:92:16: error: 'H_PAGE_PKEY_BIT3' undeclared (first use in this function)
>   arch/powerpc/include/asm/pkeys.h:93:16: error: 'H_PAGE_PKEY_BIT4' undeclared (first use in this function)
>   arch/powerpc/include/asm/mmu_context.h:199:19: error: redefinition of 'vma_pkey'
>   arch/powerpc/include/asm/mmu_context.h:204:19: error: redefinition of 'pte_to_hpte_pkey_bits'
>   arch/powerpc/include/asm/pkeys.h:102:48: error: 'mm_context_t' has no member named 'pkey_allocation_map'
>   arch/powerpc/include/asm/pkeys.h:224:13: error: 'mm_context_t' has no member named 'execute_only_pkey'
> 
> cheers

-- 
Ram Pai
