Return-Path: <dave.hansen@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W2y73ql7zF3Hf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 02:42:55 +1000 (AEST)
Subject: Re: [PATCH v14 15/22] selftests/vm: powerpc implementation to check
 support for pkey
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-16-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3b84550e-482d-5576-d17e-b5e5c877ee0c@intel.com>
Date: Wed, 18 Jul 2018 09:42:46 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-16-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> -static inline int cpu_has_pku(void)
> +static inline bool is_pkey_supported(void)
>  {
> -	return 1;
> +	/*
> +	 * No simple way to determine this.
> +	 * Lets try allocating a key and see if it succeeds.
> +	 */
> +	int ret = sys_pkey_alloc(0, 0);
> +
> +	if (ret > 0) {
> +		sys_pkey_free(ret);
> +		return true;
> +	}
> +	return false;
>  }

This actually works on x86 too.

>  static inline int arch_reserved_keys(void)
> diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
> index f5d0ff2..887acf2 100644
> --- a/tools/testing/selftests/vm/pkey-x86.h
> +++ b/tools/testing/selftests/vm/pkey-x86.h
> @@ -105,7 +105,7 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
>  #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
>  #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
>  
> -static inline int cpu_has_pku(void)
> +static inline bool is_pkey_supported(void)
>  {
>  	unsigned int eax;
>  	unsigned int ebx;
> @@ -118,13 +118,13 @@ static inline int cpu_has_pku(void)
>  
>  	if (!(ecx & X86_FEATURE_PKU)) {
>  		dprintf2("cpu does not have PKU\n");
> -		return 0;
> +		return false;
>  	}
>  	if (!(ecx & X86_FEATURE_OSPKE)) {
>  		dprintf2("cpu does not have OSPKE\n");
> -		return 0;
> +		return false;
>  	}
> -	return 1;
> +	return true;
>  }



>  #define XSTATE_PKEY_BIT	(9)
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 18e1bb7..d27fa5e 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -1389,8 +1389,8 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
>  	int size = PAGE_SIZE;
>  	int sret;
>  
> -	if (cpu_has_pku()) {
> -		dprintf1("SKIP: %s: no CPU support\n", __func__);
> +	if (is_pkey_supported()) {
> +		dprintf1("SKIP: %s: no CPU/kernel support\n", __func__);
>  		return;
>  	}

I actually wanted a kernel-independent check, based entirely on CPUID.
That's specifically why I said "no CPU support".

If you want to do this, please do:

/* powerpc has no enumeration, just assume it has support: */
static inline bool cpu_has_cpu(void) { return true; };

	if (cpu_has_pku()) {
		dprintf1("SKIP: %s: no CPU support\n", __func__);
		return
	}

	if (kernel_pkey_supported()) {
		dprintf1("SKIP: %s: no kernel support\n", __func__);
		return;
  	}
