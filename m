Return-Path: <dave.hansen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6VZz5nQyzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 04:14:03 +1000 (AEST)
Subject: Re: [RFC v5 13/38] x86: disallow pkey creation with
 PKEY_DISABLE_EXECUTE
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-14-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1692f8f5-456c-dc4a-4502-a2ea63ede094@intel.com>
Date: Tue, 11 Jul 2017 11:12:37 -0700
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-14-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 02:21 PM, Ram Pai wrote:
> x86 does not support disabling execute permissions on a pkey.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/x86/kernel/fpu/xstate.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c24ac1e..d582631 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -900,6 +900,9 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>  		return -EINVAL;
>  
> +	if (init_val & PKEY_DISABLE_EXECUTE)
> +		return -EINVAL;

I'd really rather that we define a supported mask instead of having each
architecture go through and list which ones it supports.
