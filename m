Return-Path: <dave.hansen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030552r1nzF1V7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:10:17 +1100 (AEDT)
Subject: Re: [PATCH v12 08/22] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-9-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a884e9eb-4da6-54af-e09e-acac7ceee397@intel.com>
Date: Fri, 16 Mar 2018 15:10:07 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-9-git-send-email-linuxram@us.ibm.com>
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
> When a key is freed, the  key  is  no  more  effective.
> Clear the bits corresponding to the pkey in the shadow
> register. Otherwise  it  will carry some spurious bits
> which can trigger false-positive asserts.
...
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index ca54a95..aaf9f09 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -582,6 +582,9 @@ int alloc_pkey(void)
>  int sys_pkey_free(unsigned long pkey)
>  {
>  	int ret = syscall(SYS_pkey_free, pkey);
> +
> +	if (!ret)
> +		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

Did this cause problems for you in practice?

On x86, sys_pkey_free() does not affect PKRU, so this isn't quite right.
 I'd much rather have the actual tests explicitly clear the PKRU bits
and also in the process clear the shadow bits.
