Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0Wx606PvzDvZL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 14:53:14 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t0Wx45yB4z9s5g
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2016 14:53:12 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 128so7329603pfz.1
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2016 20:53:12 -0700 (PDT)
Subject: Re: [PATCH] powerpc/book3s64: Always build for power4 or later
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1477008111-9160-1-git-send-email-mpe@ellerman.id.au>
Cc: anton@samba.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f63e3720-1d7c-0e40-415a-55c8f07bf10b@gmail.com>
Date: Fri, 21 Oct 2016 14:53:05 +1100
MIME-Version: 1.0
In-Reply-To: <1477008111-9160-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 21/10/16 11:01, Michael Ellerman wrote:
> When we're not compiling for a specific CPU, ie. none of the
> CONFIG_POWERx_CPU options are set, and CONFIG_GENERIC_CPU *is* set, we
> currently don't pass any -mcpu option to the compiler. This means the
> compiler builds for a "generic" Power CPU.
> 
> But back in 2014 we dropped support for pre power4 CPUs in commit
> 468a33028edd ("powerpc: Drop support for pre-POWER4 cpus").
> 
> Given that, there's no point in building the kernel to run on pre power4
> cpus. So update the flags we pass to the compiler when
> CONFIG_GENERIC_CPU is set, to specify -mcpu=power4.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 617dece67924..041fda1e2a5d 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -121,6 +121,7 @@ CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
>  
>  ifeq ($(CONFIG_PPC_BOOK3S_64),y)
>  CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
> +CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power4
>  else
>  CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
>  endif
> 

Acked-by: Balbir Singh <bsingharora@gmail.com>
