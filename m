Return-Path: <linuxppc-dev+bounces-17664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8965AEDEC12
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 06:49:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQjvH4LhCz2xqD;
	Wed, 04 Mar 2026 17:49:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772606955;
	cv=none; b=lQEhH06VyfgpUPdzs2+FVc8DNetHF3eY6yB7nLjt2HljJoy5OfCaV493vdDBXbf+VmMm1T1LqBuL///NrU1PspIM1rQF5hn8OV+KW1jG6F5ELVWMtGzQAfpNyiL060/t/1Pzh+I2es0cC2QP/+yRnFVZD/ueq9rDxURq/mmHIWttQG+C/MPwT9cDh+b4EoJTSLZm4doBm9UPPG2kjwml0vg8s2NreTPQUzz+b8oThs0dxotqbD9cZPN0ZaNyT8rKmThq5Zh2TQ0pd40gLGlX208mU4syBnUd0nl8uehegWlD5lrZyVpAhKtzWQhfGYdRdKsDsuND9/NNU2Rk8Eu6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772606955; c=relaxed/relaxed;
	bh=vcstynsmpn/3EhWigL2osB1971kkWMRhg5mrhqNeLFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVGxQIWzYiVn+x7oNTEZQ2CDFfgubIgsw2VwwLRFdaC7vAXqjciQ/CyYc19Hkn5sGfQuRpHQS77geGIoHd7w5jb0o9W4gSIDUMBCfUTuH5xxC44QwH6IYPuhoK6545fr/8D9fySBiCguNC/bTxnlSJgOU2huRoHc3vqRRdWwOap2c3Kyccf6/04Eft4QeABXM/dARI83qnkoHgSPKvloNQ2AhYx8+pUYx25HI7U1owkfQWujqJ10DVY3HBD8BKtjAgZ8vjvzqWxboEFjCnk1fizmIEqxZAC1byxVkBOQ9AfiM+LaOXfdSQ/GTFEWZEX4qV1iz8QPhJSajJu5XtsYsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhlSWwcf; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uhlSWwcf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQjvG2G6Zz2xT4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 17:49:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D4EAD4053B;
	Wed,  4 Mar 2026 06:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BFBC19423;
	Wed,  4 Mar 2026 06:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772606951;
	bh=vkw4LnA0XFlMxKT8jfERfPg3BPhuJoyRsah8ZNLLEvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uhlSWwcftGMGEbj/w1LtwYnxRNIHUpmox+uxFi5iLTCevojB0c6l26i5DX5QvrgfG
	 CA+idyIZKtnAdR/6UWBZVdMiEBxiL2ZICpVnx0ib/mSS5z43xMkgCV89KE9tGnA48T
	 WJUetqeqR+RDXYXf/aJNFaa/WlOqG5u85P8WOoZbvSXQzlaFp3LTTgfK4sWoUUjC7P
	 ha113sgf5b9n8Lz5A+pq9YWVnpWcm37g6SGLCMckbZ9DPPOtRMGLGA3gJ0Lxonk9kE
	 Yh/BQ6kLOUt2yaC47N+trzSJB3fZoirCNRarMQAXpG45nRLcrB3OyeuA67vSj9egUx
	 0+y2dgiroEcJQ==
Message-ID: <d3aa734c-fed7-4cec-9a39-e1c1d8f8c480@kernel.org>
Date: Wed, 4 Mar 2026 07:49:08 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] powerpc: fix KUAP warning in VMX usercopy path
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com
Cc: aboorvad@linux.ibm.com, sshegde@linux.ibm.com, riteshh@linux.ibm.com,
 hbathini@linux.ibm.com, ming.lei@redhat.com, csander@purestorage.com,
 czhong@redhat.com, venkat88@linux.ibm.com
References: <20260304053506.118632-1-sayalip@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260304053506.118632-1-sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sayali,

Le 04/03/2026 à 06:35, Sayali Patil a écrit :
> On powerpc with PREEMPT_FULL or PREEMPT_LAZY and function tracing enabled,
> KUAP warnings can be triggered from the VMX usercopy path under memory
> stress workloads.
> 
> KUAP requires that no subfunctions are called once userspace access has
> been enabled. The existing VMX copy implementation violates this
> requirement by invoking enter_vmx_usercopy() from the assembly path after
> userspace access has already been enabled. If preemption occurs
> in this window, the AMR state may not be preserved correctly,
> leading to unexpected userspace access state and resulting in
> KUAP warnings.
> 
> Fix this by restructuring the VMX usercopy flow so that VMX selection
> and VMX state management are centralized in raw_copy_tofrom_user(),
> which is invoked by the raw_copy_{to,from,in}_user() wrappers.
> 
> The new flow is:
> 
>    - raw_copy_{to,from,in}_user() calls raw_copy_tofrom_user()
>    - raw_copy_tofrom_user() decides whether to use the VMX path
>      based on size and CPU capability
>    - Call enter_vmx_usercopy() before enabling userspace access
>    - Enable userspace access as per the copy direction
>      and perform the VMX copy
>    - Disable userspace access as per the copy direction
>    - Call exit_vmx_usercopy()
>    - Fall back to the base copy routine if the VMX copy faults
> 
> With this change, the VMX assembly routines no longer perform VMX state
> management or call helper functions; they only implement the
> copy operations.
> The previous feature-section based VMX selection inside
> __copy_tofrom_user_power7() is removed, and a dedicated
> __copy_tofrom_user_power7_vmx() entry point is introduced.
> 
> This ensures correct KUAP ordering, avoids subfunction calls
> while KUAP is unlocked, and eliminates the warnings while preserving
> the VMX fast path.
> 
> Fixes: de78a9c42a79 ("powerpc: Add a framework for Kernel Userspace Access Protection")
> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20260109064917.777587-2-sshegde@linux.ibm.com/
> Suggested-by: Christophe Leroy <chleroy@kernel.org>
> Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>

That looks almost good, some editorial comments below.

With those fixed, you can add  Reviewed-by: Christophe Leroy (CS GROUP) 
<chleroy@kernel.org>

> ---
> 
> v2->v3
>    - Addressd as per review feedback by removing usercopy_mode enum
>      and using the copy direction directly for KUAP permission handling.
>    - Integrated __copy_tofrom_user_vmx() functionality into
>      raw_copy_tofrom_user() in uaccess.h as a static __always_inline
>      implementation.
>    - Exported enter_vmx_usercopy() and exit_vmx_usercopy()
>      to support VMX usercopy handling from the common path.
> 
> v2: https://lore.kernel.org/all/20260228135319.238985-1-sayalip@linux.ibm.com/
> 
> ---
>   arch/powerpc/include/asm/uaccess.h | 66 ++++++++++++++++++++++--------
>   arch/powerpc/lib/copyuser_64.S     |  1 +
>   arch/powerpc/lib/copyuser_power7.S | 45 +++++++-------------
>   arch/powerpc/lib/vmx-helper.c      |  2 +
>   4 files changed, 66 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index ba1d878c3f40..8fd412671025 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -15,6 +15,9 @@
>   #define TASK_SIZE_MAX		TASK_SIZE_USER64
>   #endif
>   
> +/* Threshold above which VMX copy path is used */
> +#define VMX_COPY_THRESHOLD 3328
> +
>   #include <asm-generic/access_ok.h>
>   
>   /*
> @@ -326,40 +329,67 @@ do {								\
>   extern unsigned long __copy_tofrom_user(void __user *to,
>   		const void __user *from, unsigned long size);
>   
> -#ifdef __powerpc64__
> -static inline unsigned long
> -raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
> +unsigned long __copy_tofrom_user_base(void __user *to,
> +		const void __user *from, unsigned long size);
> +
> +unsigned long __copy_tofrom_user_power7_vmx(void __user *to,
> +		const void __user *from, unsigned long size);
> +
> +

Remove one line.

> +static __always_inline bool will_use_vmx(unsigned long n)
> +{
> +	return IS_ENABLED(CONFIG_ALTIVEC) &&
> +		cpu_has_feature(CPU_FTR_VMX_COPY) &&
> +		n > VMX_COPY_THRESHOLD;

Avoid too many line when possible. Nowadays up to 100 chars per line are 
allowed.

Take care of alignment of second line, the second line should start at 
same position as IS_ENABLED, meaning you have to insert 7 spaces instead 
of a tab.

> +}
> +
> +static __always_inline unsigned long raw_copy_tofrom_user(void __user *to,
> +		const void __user *from, unsigned long n,
> +		unsigned long dir)

Subsequent lines should start at same position as the ( of the first 
line, therefore I'd suggest following form instead:

static __always_inline unsigned long
raw_copy_tofrom_user(void __user *to,const void __user *from, unsigned 
long n, unsigned long dir)

>   {
>   	unsigned long ret;
>   
> -	barrier_nospec();
> -	allow_user_access(to, KUAP_READ_WRITE);
> +	if (will_use_vmx(n) && enter_vmx_usercopy()) {
> +		allow_user_access(to, dir);
> +		ret = __copy_tofrom_user_power7_vmx(to, from, n);
> +		prevent_user_access(dir);
> +		exit_vmx_usercopy();
> +
> +		if (unlikely(ret)) {
> +			allow_user_access(to, dir);
> +			ret = __copy_tofrom_user_base(to, from, n);
> +			prevent_user_access(dir);
> +		}
> +		return ret;
> +	}
> +
> +	allow_user_access(to, dir);
>   	ret = __copy_tofrom_user(to, from, n);
> -	prevent_user_access(KUAP_READ_WRITE);
> +	prevent_user_access(dir);
>   	return ret;
>   }
> +
> +#ifdef __powerpc64__

I know it was already there before, but checkpatch is not happy about 
__power64__. It should be replaced by CONFIG_PPC64.

> +static inline unsigned long
> +raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
> +{
> +	barrier_nospec();
> +	return raw_copy_tofrom_user(to, from, n, KUAP_READ_WRITE);
> +}
>   #endif /* __powerpc64__ */
>   
>   static inline unsigned long raw_copy_from_user(void *to,
>   		const void __user *from, unsigned long n)

Same problem with alignment of second line. Prefer the form used for 
raw_copy_in_user() or raw_copy_to_user(), ie:

static inline unsigned long
raw_copy_from_user(void *to, const void __user *from, unsigned long n)

>   {
> -	unsigned long ret;
> -
> -	allow_user_access(NULL, KUAP_READ);
> -	ret = __copy_tofrom_user((__force void __user *)to, from, n);
> -	prevent_user_access(KUAP_READ);
> -	return ret;
> +	return raw_copy_tofrom_user((__force void __user *)to, from,
> +					n, KUAP_READ);

100 chars are allowed per line, this should fit on a single line.

>   }
>   
>   static inline unsigned long
>   raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>   {
> -	unsigned long ret;
> -
> -	allow_user_access(to, KUAP_WRITE);
> -	ret = __copy_tofrom_user(to, (__force const void __user *)from, n);
> -	prevent_user_access(KUAP_WRITE);
> -	return ret;
> +	return raw_copy_tofrom_user(to, (__force const void __user *)from,
> +					n, KUAP_WRITE);

100 chars are allowed per line, this should fit on a single line.

>   }
>   
>   unsigned long __arch_clear_user(void __user *addr, unsigned long size);


Run checkpatch before submitting patches:

$ ./scripts/checkpatch.pl --strict -g HEAD~
CHECK: Alignment should match open parenthesis
#83: FILE: arch/powerpc/include/asm/uaccess.h:333:
+unsigned long __copy_tofrom_user_base(void __user *to,
+		const void __user *from, unsigned long size);

CHECK: Alignment should match open parenthesis
#86: FILE: arch/powerpc/include/asm/uaccess.h:336:
+unsigned long __copy_tofrom_user_power7_vmx(void __user *to,
+		const void __user *from, unsigned long size);

CHECK: Please don't use multiple blank lines
#88: FILE: arch/powerpc/include/asm/uaccess.h:338:
+
+

CHECK: Alignment should match open parenthesis
#97: FILE: arch/powerpc/include/asm/uaccess.h:347:
+static __always_inline unsigned long raw_copy_tofrom_user(void __user *to,
+		const void __user *from, unsigned long n,

CHECK: architecture specific defines should be avoided
#125: FILE: arch/powerpc/include/asm/uaccess.h:372:
+#ifdef __powerpc64__

total: 0 errors, 0 warnings, 5 checks, 212 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

Commit 3a44f6614d88 ("powerpc: fix KUAP warning in VMX usercopy path") 
has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.


