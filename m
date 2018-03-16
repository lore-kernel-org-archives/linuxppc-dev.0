Return-Path: <dave.hansen@intel.com>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030Rb60VlzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:26:19 +1100 (AEDT)
Subject: Re: [PATCH v12 15/22] selftests/vm: powerpc implementation to check
 support for pkey
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-16-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <dc588e0e-eda5-1267-5806-91b9b95e28bf@intel.com>
Date: Fri, 16 Mar 2018 15:26:09 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-16-git-send-email-linuxram@us.ibm.com>
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
>  #define PAGE_SIZE (0x1UL << 16)
> -static inline int cpu_has_pku(void)
> +static inline bool is_pkey_supported(void)
>  {
> -	return 1;
> +	/*
> +	 * No simple way to determine this.
> +	 * lets try allocating a key and see if it succeeds.
> +	 */
> +	int ret = sys_pkey_alloc(0, 0);
> +
> +	if (ret > 0) {
> +		sys_pkey_free(ret);
> +		return true;
> +	}
> +	return false;
>  }

The point of doing this was to have a test for the CPU that way separate
from the syscalls.

Can you leave cpu_has_pkeys() in place?
