Return-Path: <ntl@pobox.com>
Received: from thorn.pobox.com (api.pobox.com [208.210.124.75])
	by ozlabs.org (Postfix) with ESMTP id 4356A68864
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 06:24:22 +1100 (EST)
Date: Sat, 3 Dec 2005 14:00:27 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Otavio Salvador <otavio@debian.org>
Message-ID: <20051203190026.GA29537@localhost.localdomain>
References: <11336348593561-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11336348593561-git-send-email-otavio@debian.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] arch/ppc/kernel/idle.c: don't declare cpu variable in
	non-SMP kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
> index 821a75e..b23a979 100644
> --- a/arch/ppc/kernel/idle.c
> +++ b/arch/ppc/kernel/idle.c
> @@ -37,7 +37,9 @@
>  void default_idle(void)
>  {
>  	void (*powersave)(void);
> +#ifdef CONFIG_SMP
>  	int cpu = smp_processor_id();
> +#endif

Better to just move the declaration of cpu down to the ifdef'd else
block further down in the function as that's the only place it is
used.
