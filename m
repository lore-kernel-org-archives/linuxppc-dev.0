Return-Path: <dave.hansen@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419p940P8WzF0wy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 01:07:35 +1000 (AEST)
Subject: Re: [PATCH v13 16/24] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-17-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0b534ee8-5747-2811-745c-d87b3e720955@intel.com>
Date: Wed, 20 Jun 2018 08:07:31 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-17-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -577,7 +577,8 @@ int sys_pkey_free(unsigned long pkey)
>  	int ret = syscall(SYS_pkey_free, pkey);
>  
>  	if (!ret)
> -		shadow_pkey_reg &= clear_pkey_flags(pkey, PKEY_DISABLE_ACCESS);
> +		shadow_pkey_reg &= clear_pkey_flags(pkey,
> +				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

Why did you introduce this code earlier and then modify it now?

BTW, my original aversion to this code still stands.
