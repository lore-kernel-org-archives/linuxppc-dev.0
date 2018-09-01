Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422WlL0brpzF2X2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 19:53:49 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id d4-v6so6617919pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Sep 2018 02:53:49 -0700 (PDT)
Date: Sat, 1 Sep 2018 19:53:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Make possible for user to force a full
 ipl cec reboot
Message-ID: <20180901195337.3080204b@roar.ozlabs.ibm.com>
In-Reply-To: <20180901081745.2165-1-vaibhav@linux.ibm.com>
References: <20180901081745.2165-1-vaibhav@linux.ibm.com>
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

On Sat,  1 Sep 2018 13:47:45 +0530
Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> Ever since fast reboot is enabled by default in opal,
> opal_cec_reboot() will use fast-reset instead of full IPL to perform
> system reboot. This leaves the user with no direct way to force a full
> IPL reboot except changing an nvram setting that persistently disables
> fast-reset for all subsequent reboots.
> 
> This patch provides a more direct way for the user to force a one-shot
> full IPL reboot by passing the command line argument 'full' to the
> reboot command. So the user will be able to tweak the reboot behavior
> via:
> 
>   $ sudo reboot full	# Force a full ipl reboot skipping fast-reset
> 
>   or
>   $ sudo reboot  	# default reboot path (usually fast-reset)
> 
> The reboot command passes the un-parsed command argument to the kernel
> via the 'Reboot' syscall which is then passed on to the arch function
> pnv_restart(). The patch updates pnv_restart() to handle this cmd-arg
> and issues opal_cec_reboot2 with OPAL_REBOOT_FULL_IPL to force a full
> IPL reset.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

This is nice but I wonder if the default should be IPL and fast
should be the option.

> ---
>  arch/powerpc/include/asm/opal-api.h    | 1 +
>  arch/powerpc/platforms/powernv/setup.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 8365353330b4..870fb7b239ea 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -1050,6 +1050,7 @@ enum OpalSysCooling {
>  enum {
>  	OPAL_REBOOT_NORMAL		= 0,
>  	OPAL_REBOOT_PLATFORM_ERROR	= 1,
> +	OPAL_REBOOT_FULL_IPL		= 2,
>  };
>  
>  /* Argument to OPAL_PCI_TCE_KILL */
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index adddde023622..33d2faeacff8 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -224,7 +224,13 @@ static void  __noreturn pnv_restart(char *cmd)
>  	pnv_prepare_going_down();
>  
>  	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
> -		rc = opal_cec_reboot();
> +
> +		/* See if we need to do a full IPL reboot */
> +		if (cmd && strcmp(cmd, "full") == 0)
> +			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);
> +		else
> +			rc = opal_cec_reboot();
> +
>  		if (rc == OPAL_BUSY_EVENT)
>  			opal_poll_events(NULL);
>  		else
> -- 
> 2.17.1
> 
