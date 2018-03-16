Return-Path: <dave.hansen@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030V60ccXzF1HF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:28:29 +1100 (AEDT)
Subject: Re: [PATCH v12 16/22] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <98204562-7c91-23f0-101b-508954020353@intel.com>
Date: Fri, 16 Mar 2018 15:28:19 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> +static inline int arch_reserved_keys(void)
> +{
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	return NR_RESERVED_PKEYS;
> +#elif __powerpc64__ /* arch */
> +	if (sysconf(_SC_PAGESIZE) == 4096)
> +		return NR_RESERVED_PKEYS_4K;
> +	else
> +		return NR_RESERVED_PKEYS_64K;
> +#else /* arch */
> +	NOT SUPPORTED
> +#endif /* arch */
> +}

Yeah, this is hideous.

Please either do it in one header:

#ifdef x86..
static inline int arch_reserved_keys(void)
{
}
...
#elif ppc
static inline int arch_reserved_keys(void)
{
}
...
#else
#error
#endif

Or in multiple:

#ifdef x86..
#include <pkey_x86.h>
#elif ppc
#include <pkey_ppc.h>
#else
#error
#endif
