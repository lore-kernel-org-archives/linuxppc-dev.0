Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CC15DDDF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 02:27:15 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id A06B921D6ED
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 16:27:21 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id A8DCB900A9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 16:27:13 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id VMwtFRz9pd4w for <linuxppc-dev@ozlabs.org>;
	Wed, 19 Mar 2008 16:27:12 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.150.73.ip-pool.NEFkom.net
	[83.171.150.73]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 16:27:12 +0100 (CET)
Date: Wed, 19 Mar 2008 16:27:22 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: crash in init_ipic_sysfs on efika
Message-ID: <20080319152722.GA9208@aepfle.de>
References: <20080317195305.GA13298@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080317195305.GA13298@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, Olaf Hering wrote:

> The global primary_ipic in arch/powerpc/sysdev/ipic.c can remain NULL if
> ipic_init() fails. init_ipic_sysfs() will crash in that case.
> 
> Something like this may fix it:
> 
> Index: linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/arch/powerpc/sysdev/ipic.c
> +++ linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
> @@ -906,7 +906,7 @@ static int __init init_ipic_sysfs(void)
>  {
>         int rc;
>  
> -       if (!primary_ipic->regs)
> +       if (!primary_ipic || !primary_ipic->regs)
>                 return -ENODEV;
>         printk(KERN_DEBUG "Registering ipic with sysfs...\n");

ipic_init() is not called for every board.
This change for the used config fixes the crash as well.

@@ -168,14 +168,14 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_86xx is not set
 CONFIG_CLASSIC32=y
 CONFIG_PPC_CHRP=y
-CONFIG_PPC_MPC512x=y
-CONFIG_PPC_MPC5121=y
-CONFIG_MPC5121_ADS=y
+# CONFIG_PPC_MPC512x is not set
+# CONFIG_PPC_MPC5121 is not set
+# CONFIG_MPC5121_ADS is not set
 CONFIG_PPC_MPC52xx=y
-CONFIG_PPC_MPC5200_SIMPLE=y
+# CONFIG_PPC_MPC5200_SIMPLE is not set
 CONFIG_PPC_EFIKA=y
 # CONFIG_PPC_LITE5200 is not set
-CONFIG_PPC_MPC5200_BUGFIX=y
+# CONFIG_PPC_MPC5200_BUGFIX is not set
 CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
