Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A7CD8B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 04:34:35 +1100 (EST)
Received: from mail45-am1 (localhost.localdomain [127.0.0.1])	by
 mail45-am1-R.bigfish.com (Postfix) with ESMTP id EA82B12003EF	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 17:34:21 +0000 (UTC)
Received: from AM1EHSMHS003.bigfish.com (unknown [10.3.201.245])	by
 mail45-am1.bigfish.com (Postfix) with ESMTP id 4C91713C005F	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 17:33:45 +0000 (UTC)
Message-ID: <4EB421FD.6010805@freescale.com>
Date: Fri, 4 Nov 2011 12:33:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
References: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 07:29 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> The timebase sync is not only necessary when using KEXEC. It should also
> be used by normal boot up and cpu hotplug. Remove the ifdef added by
> the KEXEC patch.

The KEXEC patch didn't just add the ifdef, it also added the initializers:

> @@ -105,8 +107,64 @@ smp_85xx_setup_cpu(int cpu_nr)
>  
>  struct smp_ops_t smp_85xx_ops = {
>         .kick_cpu = smp_85xx_kick_cpu,
> +#ifdef CONFIG_KEXEC
> +       .give_timebase  = smp_generic_give_timebase,
> +       .take_timebase  = smp_generic_take_timebase,
> +#endif
>  };

U-Boot synchronizes the timebase on 85xx.  With what chip and U-Boot
version are you seeing this not happen?

If you are seeing only a small (around one tick) difference, make sure
you're running a U-Boot that has this commit:

> commit 7afc45ad7d9493208d89072cbb78a5bfc8034b59
> Author: Kumar Gala <galak@kernel.crashing.org>
> Date:   Sun Mar 13 10:55:53 2011 -0500
> 
>     powerpc/85xx: Fix synchronization of timebase on MP boot
>     
>     There is a small ordering issue in the master core in that we need to
>     make sure the disabling of the timebase in the SoC is visible before we
>     set the value to 0.  We can simply just read back the value to
>     synchronizatize the write, before we set TB to 0.
>     
>     Reported-by: Dan Hettena
>     Tested-by: Dan Hettena
>     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>


-Scott
