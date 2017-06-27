Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxkLs1TJ1zDqjJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:33:09 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id j186so3990443pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 04:33:09 -0700 (PDT)
Message-ID: <1498563132.7935.15.camel@gmail.com>
Subject: Re: [RFC v4 03/17] x86: key creation with PKEY_DISABLE_EXECUTE
 disallowed
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org,  x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org,  corbet@lwn.net, mingo@redhat.com
Date: Tue, 27 Jun 2017 21:32:12 +1000
In-Reply-To: <1498558319-32466-4-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
 <1498558319-32466-4-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-27 at 03:11 -0700, Ram Pai wrote:
> x86 does not support disabling execute permissions on a pkey.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 3 +++
>  1 file changed, 3 insertions(+)
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
> +
>  	/* Set the bits we need in PKRU:  */
>  	if (init_val & PKEY_DISABLE_ACCESS)
>  		new_pkru_bits |= PKRU_AD_BIT;

I am not an x86 expert. IIUC, execute disable is done via allocating an
execute_only_pkey and checking vma_key via AD + vma_flags against VM_EXEC.

Your patch looks good to me

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
