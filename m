Return-Path: <neko@genesi-usa.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id 99520DE16F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 01:42:39 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so5051491fkz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:42:37 -0700 (PDT)
Message-ID: <4810AA6B.9010102@genesi-usa.com>
Date: Thu, 24 Apr 2008 16:42:35 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: missing current-speed property prevents autoconsole on pegasos
References: <20080423152206.GA10935@aepfle.de>
In-Reply-To: <20080423152206.GA10935@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why not just have users who wish to use console serial port autodetection
add 3 lines to their nvramrc?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> Pegasos2 has no current-speed property in
> /pci@80000000/isa@C/serial@i2F8. As a result, console=ttyS0,115200 is
> still required unless the patch below is used.
> 
> What is the correct way to restore console detection on pegasos2?
> 
> Index: linux-2.6.25-pegasos/arch/powerpc/platforms/chrp/setup.c
> ===================================================================
> --- linux-2.6.25-pegasos.orig/arch/powerpc/platforms/chrp/setup.c
> +++ linux-2.6.25-pegasos/arch/powerpc/platforms/chrp/setup.c
> @@ -302,7 +305,7 @@ static void chrp_init_early(void)
>         if (!property)
>                 goto out_put;
>         if (!strcmp(property, "failsafe") || !strcmp(property, "serial"))
> -               add_preferred_console("ttyS", 0, NULL);
> +               add_preferred_console("ttyS", 0, "115200");
>  out_put:
>         of_node_put(node);
>  }
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
