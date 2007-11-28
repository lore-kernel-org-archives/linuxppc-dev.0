Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 715ABDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 11:16:01 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAS0Hcr5004198
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 19:17:38 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAS0FvUl486334
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 19:15:57 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAS0FvWH002995
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 19:15:57 -0500
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20071120012815.GB7969@austin.ibm.com>
References: <20071120012815.GB7969@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 27 Nov 2007 18:15:59 -0600
Message-Id: <1196208960.11297.26.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(resending with the proper "from" addr this time). 


I'm seeing some funky behavior on power5/power6 partitions with this
patch.    A "/sbin/reboot" is now behaving much more like a
"/sbin/halt".

Anybody else seeing this, or is it time for me to call an exorcist for
my boxes? 

-Will

On Mon, 2007-11-19 at 19:28 -0600, Linas Vepstas wrote:
> The rtas_os_term() routine was being called at the wrong time.
> The actual rtas call "os-term" will not ever return, and so
> calling it from the panic notifier is too early.  Instead,
> call it from the machine_reset() call.
> 
> The patch splits the rtas_os_term() routine into two: one 
> part to capture the kernel panic message, invoked during
> the panic notifier, and another part that is invoked during 
> machine_reset().
> 
> Prior to this patch, the os-term call was never being made,
> because panic_timeout was always non-zero. Calling os-term 
> helps keep the hypervisor happy! We have to keep the hypervisor
> happy to avoid service, dump and error reporting problems.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> ----
> One could make a strong argument to move all of this code 
> from kernel/rtas.c to platforms/pseries/setup.c  I did not
> do this, just so as to make the changes minimal.
> 
>  arch/powerpc/kernel/rtas.c             |   12 ++++++------
>  arch/powerpc/platforms/pseries/setup.c |    3 ++-
>  include/asm-powerpc/rtas.h             |    3 ++-
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.24-rc2-git4/arch/powerpc/kernel/rtas.c
> ===================================================================
> --- linux-2.6.24-rc2-git4.orig/arch/powerpc/kernel/rtas.c	2007-11-19 18:58:53.000000000 -0600
> +++ linux-2.6.24-rc2-git4/arch/powerpc/kernel/rtas.c	2007-11-19 19:01:10.000000000 -0600
> @@ -631,18 +631,18 @@ void rtas_halt(void)
>  /* Must be in the RMO region, so we place it here */
>  static char rtas_os_term_buf[2048];
> 
> -void rtas_os_term(char *str)
> +void rtas_panic_msg(char *str)
>  {
> -	int status;
> +	snprintf(rtas_os_term_buf, 2048, "OS panic: %s", str);
> +}
> 
> -	if (panic_timeout)
> -		return;
> +void rtas_os_term(void)
> +{
> +	int status;
> 
>  	if (RTAS_UNKNOWN_SERVICE == rtas_token("ibm,os-term"))
>  		return;
> 
> -	snprintf(rtas_os_term_buf, 2048, "OS panic: %s", str);
> -
>  	do {
>  		status = rtas_call(rtas_token("ibm,os-term"), 1, 1, NULL,
>  				   __pa(rtas_os_term_buf));
> Index: linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- linux-2.6.24-rc2-git4.orig/arch/powerpc/platforms/pseries/setup.c	2007-11-19 18:58:53.000000000 -0600
> +++ linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/setup.c	2007-11-19 19:01:10.000000000 -0600
> @@ -507,7 +507,8 @@ define_machine(pseries) {
>  	.restart		= rtas_restart,
>  	.power_off		= pSeries_power_off,
>  	.halt			= rtas_halt,
> -	.panic			= rtas_os_term,
> +	.panic			= rtas_panic_msg,
> +	.machine_shutdown	= rtas_os_term,
>  	.get_boot_time		= rtas_get_boot_time,
>  	.get_rtc_time		= rtas_get_rtc_time,
>  	.set_rtc_time		= rtas_set_rtc_time,
> Index: linux-2.6.24-rc2-git4/include/asm-powerpc/rtas.h
> ===================================================================
> --- linux-2.6.24-rc2-git4.orig/include/asm-powerpc/rtas.h	2007-11-19 18:58:53.000000000 -0600
> +++ linux-2.6.24-rc2-git4/include/asm-powerpc/rtas.h	2007-11-19 19:01:10.000000000 -0600
> @@ -164,7 +164,8 @@ extern int rtas_call(int token, int, int
>  extern void rtas_restart(char *cmd);
>  extern void rtas_power_off(void);
>  extern void rtas_halt(void);
> -extern void rtas_os_term(char *str);
> +extern void rtas_panic_msg(char *str);
> +extern void rtas_os_term(void);
>  extern int rtas_get_sensor(int sensor, int index, int *state);
>  extern int rtas_get_power_level(int powerdomain, int *level);
>  extern int rtas_set_power_level(int powerdomain, int level, int *setlevel);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
