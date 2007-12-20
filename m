Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 6F4F2DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 09:29:23 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so84757wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 14:29:23 -0800 (PST)
Message-ID: <9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
Date: Thu, 20 Dec 2007 17:29:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <11981089894052-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/19/07, Timur Tabi <timur@freescale.com> wrote:

> +static struct of_device_id mpc8610_ids[] = {
> +       { .type = "soc", },
> +       {}
> +};
> +
> +static int __init mpc8610_declare_of_platform_devices(void)
> +{
> +       if (!machine_is(mpc86xx_hpcd))
> +               return 0;
> +
> +       /* Without this call, the SSI device driver won't get probed. */
> +       of_platform_bus_probe(NULL, mpc8610_ids, NULL);
> +
> +       return 0;
> +}
> +device_initcall(mpc8610_declare_of_platform_devices);

How is of_platform_bus_probe() supposed to be called? mpc5200/virtex
call it with three NULLs. Is it necessary to name all of the buses in
a of_device_id? If it's not necessary to list the buses the
of_platform_bus_probe() call could be moved to common code.

Are these buses?
        { .compatible = "ibm,plb4", },
        { .compatible = "ibm,opb", },
        { .compatible = "ibm,ebc", },

Could of_platform_bus_probe() be simplified? No one uses the first and
third parameters.

-- 
Jon Smirl
jonsmirl@gmail.com
