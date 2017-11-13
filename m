Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZscX2kq1zDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 11:55:08 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD0s0ag017486
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 19:55:05 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e6nyf62bc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 19:55:04 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 12 Nov 2017 17:55:04 -0700
Date: Sun, 12 Nov 2017 16:54:51 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH v9 23/51] powerpc: Enable pkey subsystem
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-24-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509958663-18737-24-git-send-email-linuxram@us.ibm.com>
Message-Id: <20171113005451.GF5546@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 06, 2017 at 12:57:15AM -0800, Ram Pai wrote:
> PAPR defines 'ibm,processor-storage-keys' property. It exports two
> values. The first value holds the number of data-access keys and the
> second holds the number of instruction-access keys.  Due to a bug in
> the  firmware, instruction-access  keys is  always  reported  as zero.
> However any key can be configured to disable data-access and/or disable
> execution-access. The inavailablity of the second value is not a
> big handicap, though it could have been used to determine if the
> platform supported disable-execution-access.
> 
> Non PAPR platforms do not define this property   in the device tree yet.
> Here, we   hardcode   CPUs   that   support  pkey by consulting
> PowerISA3.0
> 
> This patch calculates the number of keys supported by the platform.
> Alsi it determines the platform support for read/write/execution access
> support for pkeys.

> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
> 
....snip...

> +static inline bool pkey_mmu_enabled(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_LPAR))
> +		return pkeys_total;
> +	else
> +		return cpu_has_feature(CPU_FTR_PKEY);
> +}
> +
>  void __init pkey_initialize(void)
>  {
>  	int os_reserved, i;
> @@ -46,14 +54,9 @@ void __init pkey_initialize(void)
>  		     __builtin_popcountl(ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT)
>  				!= (sizeof(u64) * BITS_PER_BYTE));
> 
> -	/*
> -	 * Disable the pkey system till everything is in place. A subsequent
> -	 * patch will enable it.
> -	 */
> -	static_branch_enable(&pkey_disabled);
> -
> -	/* Lets assume 32 keys */
> -	pkeys_total = 32;

vvvvvvvvvvvvvvvvvvvv
> +	/* Let's assume 32 keys if we are not told the number of pkeys. */
> +	if (!pkeys_total)
> +		pkeys_total = 32;
^^^^^^^^^^^^^^^^^^^^

There is a small bug here. 

On a KVM guest or a LPAR, if the device tree
does not expose pkeys, the pkey-subsystem must be disabled.

Unfortunately, the code above blindly sets the pkeys_total to 32.
This confuses pkey_mmu_enabled() into returning true. Because of this
bug the guest errorneously enables pkey-subsystem. 

The fix is to delete the code marked above.

> 
>  	/*
>  	 * Adjust the upper limit, based on the number of bits supported by
> @@ -62,11 +65,19 @@ void __init pkey_initialize(void)
>  	pkeys_total = min_t(int, pkeys_total,
>  			(ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT));
> 
> +	if (!pkey_mmu_enabled() || radix_enabled() || !pkeys_total)
> +		static_branch_enable(&pkey_disabled);
> +	else
> +		static_branch_disable(&pkey_disabled);
> +

RP
