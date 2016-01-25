Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BFF31A05D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:04:35 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47683140557
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 11:04:33 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n128so6035753pfn.3
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jan 2016 16:04:33 -0800 (PST)
Date: Mon, 25 Jan 2016 11:04:23 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [PATCH v3 4/9] powerpc: Explicitly disable math features when
 copying thread
Message-ID: <20160125110423.3b0a5ae3@cotter.ozlabs.ibm.com>
In-Reply-To: <1453337749-15506-5-git-send-email-cyrilbur@gmail.com>
References: <1453337749-15506-1-git-send-email-cyrilbur@gmail.com>
 <1453337749-15506-5-git-send-email-cyrilbur@gmail.com>
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

On Thu, 21 Jan 2016 11:55:44 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> Currently when threads get scheduled off they always giveup the FPU,
> Altivec (VMX) and Vector (VSX) units if they were using them. When they are
> scheduled back on a fault is then taken to enable each facility and load
> registers. As a result explicitly disabling FPU/VMX/VSX has not been
> necessary.
> 
> Future changes and optimisations remove this mandatory giveup and fault
> which could cause calls such as clone() and fork() to copy threads and run
> them later with FPU/VMX/VSX enabled but no registers loaded.
> 
> This patch starts the process of having MSR_{FP,VEC,VSX} mean that a
> threads registers are hot while not having MSR_{FP,VEC,VSX} means that the
> registers must be loaded. This allows for a smarter return to userspace.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index dccc87e..e0c3d2d 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1307,6 +1307,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  
>  		f = ret_from_fork;
>  	}
> +	childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);

Ideally you want to use __msr_check_and_clear()

Basically we start with these bits off and then take an exception on use?

>  	sp -= STACK_FRAME_OVERHEAD;
>  
>  	/*
