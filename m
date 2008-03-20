Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7661DE39F
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 02:16:00 +1100 (EST)
Message-Id: <63858171-157B-4726-94F2-E64B85A0D8D5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20080317195305.GA13298@aepfle.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: crash in init_ipic_sysfs on efika
Date: Thu, 20 Mar 2008 10:15:52 -0500
References: <20080317195305.GA13298@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 17, 2008, at 2:53 PM, Olaf Hering wrote:
>
> I cant reproduce this bug on my board, but:
>
> The global primary_ipic in arch/powerpc/sysdev/ipic.c can remain  
> NULL if
> ipic_init() fails. init_ipic_sysfs() will crash in that case.
>
> Something like this may fix it:
>
> Index: linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/arch/powerpc/sysdev/ipic.c
> +++ linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
> @@ -906,7 +906,7 @@ static int __init init_ipic_sysfs(void)
> {
>        int rc;
>
> -       if (!primary_ipic->regs)
> +       if (!primary_ipic || !primary_ipic->regs)
>                return -ENODEV;
>        printk(KERN_DEBUG "Registering ipic with sysfs...\n");

We should look and see if we can change init_ipic_sysfs() from a  
subsys_initcall() to just getting called at the end of ipic_init().

- k
