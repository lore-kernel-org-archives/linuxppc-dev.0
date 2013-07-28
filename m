Return-Path: <glikely@secretlab.ca>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4E902C0120
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2013 14:49:49 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id bg4so4652932pad.18
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 21:49:45 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: Feed entire flattened device tree into the random pool
To: Anton Blanchard <anton@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20130725143031.16af0a96@kryten>
References: <20130725125122.78accf44@kryten>
 <20130725031717.GB15673@concordia> <20130725143031.16af0a96@kryten>
Date: Sat, 27 Jul 2013 22:49:42 -0600
Message-Id: <20130728044942.A58793E0A24@localhost>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Jul 2013 14:30:31 +1000, Anton Blanchard <anton@samba.org> wrote:
> 
> Hi Michael,
> 
> > But why not put the initcall in drivers/of/fdt.c, that way it's not
> > early but it's still common ?
> 
> Good idea! How does this look? So long as it happens before
> module_init(rand_initialize) we should be good.
> 
> Anton
> --
> 
> We feed the entire DMI table into the random pool to provide
> better random data during early boot, so do the same with the
> flattened device tree.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> v2: move to drivers/of/fdt.c as suggested by Michael Ellerman
> 
> Index: b/drivers/of/fdt.c
> ===================================================================
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
> +#include <linux/random.h>
>  
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #ifdef CONFIG_PPC
> @@ -714,3 +715,14 @@ void __init unflatten_device_tree(void)
>  }
>  
>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> +
> +/* Feed entire flattened device tree into the random pool */
> +static int __init add_fdt_randomness(void)
> +{
> +	if (initial_boot_params)
> +		add_device_randomness(initial_boot_params,
> +				      initial_boot_params->totalsize);

be32_to_cpu(initial_boot_params->totalsize);

g.
