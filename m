Return-Path: <neko@genesi-usa.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id DEAEADDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 22:28:49 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so904286pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 04:28:48 -0700 (PDT)
Message-ID: <47E24B69.2080607@genesi-usa.com>
Date: Thu, 20 Mar 2008 11:32:57 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in init_ipic_sysfs on efika
References: <20080317195305.GA13298@aepfle.de>
	<20080319152722.GA9208@aepfle.de>
In-Reply-To: <20080319152722.GA9208@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This was a good catch. IPIC is the controller on the MPC83xx type boards (and
MPC5121E) so building a kernel with this controller code in there, but without
the controller present, should gladly fail.

However removing the boards from the config does not fix this obvious error. I
like your patch better than changing the config options to disable entire
swathes of board support :D

What I'm concerned about is that the IPIC code is registering with sysfs even
though there is no controller present. How on EARTH does it even get that far?
If ipic_init fails, no further code should be run from this file, in my view.

subsys_initcall(init_ipic_sysfs); <-- this, in my eyes, is the culprit. If
init_ipic() runs, init_ipic_sysfs should be called from that, not left for
some further subsystem to blindly try and register sysfs nodes for devices
which may not even be present..

I'd love someone to explain to me how this works and why, and why it isn't
braindead? :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Olaf Hering wrote:
> On Mon, Mar 17, Olaf Hering wrote:
> 
>> The global primary_ipic in arch/powerpc/sysdev/ipic.c can remain NULL if
>> ipic_init() fails. init_ipic_sysfs() will crash in that case.
>>
>> Something like this may fix it:
>>
>> Index: linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
>> ===================================================================
>> --- linux-2.6.25-rc6.orig/arch/powerpc/sysdev/ipic.c
>> +++ linux-2.6.25-rc6/arch/powerpc/sysdev/ipic.c
>> @@ -906,7 +906,7 @@ static int __init init_ipic_sysfs(void)
>>  {
>>         int rc;
>>  
>> -       if (!primary_ipic->regs)
>> +       if (!primary_ipic || !primary_ipic->regs)
>>                 return -ENODEV;
>>         printk(KERN_DEBUG "Registering ipic with sysfs...\n");
> 
> ipic_init() is not called for every board.
> This change for the used config fixes the crash as well.
> 
> @@ -168,14 +168,14 @@ CONFIG_PPC_MULTIPLATFORM=y
>  # CONFIG_PPC_86xx is not set
>  CONFIG_CLASSIC32=y
>  CONFIG_PPC_CHRP=y
> -CONFIG_PPC_MPC512x=y
> -CONFIG_PPC_MPC5121=y
> -CONFIG_MPC5121_ADS=y
> +# CONFIG_PPC_MPC512x is not set
> +# CONFIG_PPC_MPC5121 is not set
> +# CONFIG_MPC5121_ADS is not set
>  CONFIG_PPC_MPC52xx=y
> -CONFIG_PPC_MPC5200_SIMPLE=y
> +# CONFIG_PPC_MPC5200_SIMPLE is not set
>  CONFIG_PPC_EFIKA=y
>  # CONFIG_PPC_LITE5200 is not set
> -CONFIG_PPC_MPC5200_BUGFIX=y
> +# CONFIG_PPC_MPC5200_BUGFIX is not set
>  CONFIG_PPC_PMAC=y
>  # CONFIG_PPC_CELL is not set
>  # CONFIG_PPC_CELL_NATIVE is not set
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
