Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6nVd2HbwzDqg3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 15:26:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id q85so1767763pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:26:17 -0700 (PDT)
Date: Wed, 12 Jul 2017 15:26:01 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 15/38] powerpc: helper function to read,write
 AMR,IAMR,UAMOR registers
Message-ID: <20170712152601.3b2f52ed@firefly.ozlabs.ibm.com>
In-Reply-To: <1499289735-14220-16-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-16-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  5 Jul 2017 14:21:52 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Implements helper functions to read and write the key related
> registers; AMR, IAMR, UAMOR.
> 
> AMR register tracks the read,write permission of a key
> IAMR register tracks the execute permission of a key
> UAMOR register enables and disables a key
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |   60 ++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 85bc987..435d6a7 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -428,6 +428,66 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
>  }
>  
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +
> +#include <asm/reg.h>
> +static inline u64 read_amr(void)
> +{
> +	return mfspr(SPRN_AMR);
> +}
> +static inline void write_amr(u64 value)
> +{
> +	mtspr(SPRN_AMR, value);
> +}
> +static inline u64 read_iamr(void)
> +{
> +	return mfspr(SPRN_IAMR);
> +}
> +static inline void write_iamr(u64 value)
> +{
> +	mtspr(SPRN_IAMR, value);
> +}
> +static inline u64 read_uamor(void)
> +{
> +	return mfspr(SPRN_UAMOR);
> +}
> +static inline void write_uamor(u64 value)
> +{
> +	mtspr(SPRN_UAMOR, value);
> +}
> +
> +#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
> +static inline u64 read_amr(void)
> +{
> +	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
> +	return -1;
> +}

Why do we need to have a version here if we are going to WARN(), why not
let the compilation fail if called from outside of CONFIG_PPC64_MEMORY_PROTECTION_KEYS?
Is that the intention?

Balbir Singh
