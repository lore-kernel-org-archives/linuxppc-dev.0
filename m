Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id B7264DE093
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 09:27:46 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so71245anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 16:27:45 -0700 (PDT)
Message-ID: <fa686aa40805221627u4c4580bane16f3c3e23c8e9f5@mail.gmail.com>
Date: Thu, 22 May 2008 17:27:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Emil Medve" <Emilian.Medve@freescale.com>
Subject: Re: [PATCH] [POWERPC] Add the PC speaker only when requested so
In-Reply-To: <1211496016-30311-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211496016-30311-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 4:40 PM, Emil Medve <Emilian.Medve@freescale.com> wrote:
> This will cause this minor boot-time debugging error message to go away:
>
> [    1.316451] calling  add_pcspkr+0x0/0x84
> [    1.316478] initcall add_pcspkr+0x0/0x84 returned -19 after 0 msecs

What situation are you hitting this in?  The code should only run if
there is a "pnpPNP,100" compatible node in the device tree.

Also, where is CONFIG_PCSPKR_PLATFORM defined?  I don't see it
anywhere in powerpc code and only a reference to it in an x86
Makefile.  As it stands, it looks like this patch unconditionally
disables the pcspkr code.

Cheers,
g.

>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>
>> scripts/checkpatch.pl 0001--POWERPC-Add-the-PC-speaker-only-when-requested-so.patch
> total: 0 errors, 0 warnings, 14 lines checked
>
> 0001--POWERPC-Add-the-PC-speaker-only-when-requested-so.patch has no obvious style problems and is ready for submission.
>
>  arch/powerpc/kernel/setup-common.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index db540ea..61a3f41 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -500,6 +500,7 @@ void __init smp_setup_cpu_sibling_map(void)
>  }
>  #endif /* CONFIG_SMP */
>
> +#ifdef CONFIG_PCSPKR_PLATFORM
>  static __init int add_pcspkr(void)
>  {
>        struct device_node *np;
> @@ -522,6 +523,7 @@ static __init int add_pcspkr(void)
>        return ret;
>  }
>  device_initcall(add_pcspkr);
> +#endif /* CONFIG_PCSPKR_PLATFORM */
>
>  void probe_machine(void)
>  {
> --
> 1.5.5.GIT
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
