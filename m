Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0429E6884B
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 05:46:54 +1100 (EST)
Date: Sat, 3 Dec 2005 10:46:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Otavio Salvador <otavio@debian.org>
Message-Id: <20051203104639.4b477dea.akpm@osdl.org>
In-Reply-To: <11336348593561-git-send-email-otavio@debian.org>
References: <11336348593561-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
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

Otavio Salvador <otavio@debian.org> wrote:
>
> Disable declaration of cpu variable in default_idle function when
> building non-SMP kernels.
> 
> --- a/arch/ppc/kernel/idle.c
> +++ b/arch/ppc/kernel/idle.c
> @@ -37,7 +37,9 @@
>  void default_idle(void)
>  {
>  	void (*powersave)(void);
> +#ifdef CONFIG_SMP
>  	int cpu = smp_processor_id();
> +#endif
>  
>  	powersave = ppc_md.power_save;
>  

Surely this would be better?

--- devel/arch/ppc/kernel/idle.c~a	2005-12-03 10:45:37.000000000 -0800
+++ devel-akpm/arch/ppc/kernel/idle.c	2005-12-03 10:46:03.000000000 -0800
@@ -37,7 +37,6 @@
 void default_idle(void)
 {
 	void (*powersave)(void);
-	int cpu = smp_processor_id();
 
 	powersave = ppc_md.power_save;
 
@@ -47,7 +46,8 @@ void default_idle(void)
 #ifdef CONFIG_SMP
 		else {
 			set_thread_flag(TIF_POLLING_NRFLAG);
-			while (!need_resched() && !cpu_is_offline(cpu))
+			while (!need_resched() &&
+					!cpu_is_offline(smp_processor_id()))
 				barrier();
 			clear_thread_flag(TIF_POLLING_NRFLAG);
 		}
_
