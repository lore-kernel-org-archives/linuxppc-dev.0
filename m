Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBB0F12D6zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 20:00:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH] powerpc/memkey: fix compilation error caused by upstream
 changes
In-Reply-To: <1507565506-17040-1-git-send-email-linuxram@us.ibm.com>
References: <1507565506-17040-1-git-send-email-linuxram@us.ibm.com>
Date: Tue, 10 Oct 2017 20:00:27 +1100
Message-ID: <87zi8zwf6c.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> "commit df3735c5 -- x86,mpx: make mpx depend on x86-64 to free up VMA flag"
> added the same vm highmem flag we had introduced for PKEY4. That broke
> some of the definitions in pkeys.h
>
> This patch fixes the issue.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Thanks.

Next problem is pmac32, corenet32/corenet64_smp defconfigs:

  arch/powerpc/include/asm/pkeys.h:19:23: error: 'VM_HIGH_ARCH_BIT_0' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:20:22: error: 'VM_HIGH_ARCH_0' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:21:22: error: 'VM_HIGH_ARCH_1' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:22:22: error: 'VM_HIGH_ARCH_2' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:23:22: error: 'VM_HIGH_ARCH_3' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:24:22: error: 'VM_HIGH_ARCH_4' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:50:39: error: 'H_PAGE_PKEY_BIT4' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:51:32: error: 'H_PAGE_PKEY_BIT3' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:52:32: error: 'H_PAGE_PKEY_BIT2' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:53:32: error: 'H_PAGE_PKEY_BIT1' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:54:32: error: 'H_PAGE_PKEY_BIT0' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:77:23: error: 'H_PAGE_PKEY_BIT0' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:77:43: error: 'HPTE_R_KEY_BIT0' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:78:16: error: 'H_PAGE_PKEY_BIT1' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:78:36: error: 'HPTE_R_KEY_BIT1' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:79:16: error: 'H_PAGE_PKEY_BIT2' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:79:36: error: 'HPTE_R_KEY_BIT2' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:80:16: error: 'H_PAGE_PKEY_BIT3' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:80:36: error: 'HPTE_R_KEY_BIT3' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:81:16: error: 'H_PAGE_PKEY_BIT4' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:81:36: error: 'HPTE_R_KEY_BIT4' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:89:23: error: 'H_PAGE_PKEY_BIT0' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:90:16: error: 'H_PAGE_PKEY_BIT1' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:91:16: error: 'H_PAGE_PKEY_BIT2' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:92:16: error: 'H_PAGE_PKEY_BIT3' undeclared (first use in this function)
  arch/powerpc/include/asm/pkeys.h:93:16: error: 'H_PAGE_PKEY_BIT4' undeclared (first use in this function)
  arch/powerpc/include/asm/mmu_context.h:199:19: error: redefinition of 'vma_pkey'
  arch/powerpc/include/asm/mmu_context.h:204:19: error: redefinition of 'pte_to_hpte_pkey_bits'
  arch/powerpc/include/asm/pkeys.h:102:48: error: 'mm_context_t' has no member named 'pkey_allocation_map'
  arch/powerpc/include/asm/pkeys.h:224:13: error: 'mm_context_t' has no member named 'execute_only_pkey'

cheers
