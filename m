Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 687BFDDE08
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 00:28:37 +1000 (EST)
In-Reply-To: <20070616000618.314570319@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.314570319@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91EBCC0C-48B7-4748-A936-E74CEB7685E0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 2/9] autoselect optimal -mcpu= flag by platform
Date: Sun, 17 Jun 2007 09:29:14 -0500
To: arnd@arndb.de
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 15, 2007, at 7:05 PM, arnd@arndb.de wrote:

> We can choose the -mcpu= gcc flags for compiling the kernel
> based on the platform that we build for. In case of multiplatform
> kernels, this chooses a setting for a common subset.
>
> When using a platform type that can use different CPUs, a
> new option CONFIG_PPC_CPU_SELECTION can be enabled to select
> more specifically which CPUs the kernel will be able to
> run on.
>
> This replaces the CONFIG_POWER4_ONLY option with an much more
> generic approach.
>
> Also, when CONFIG_PPC_CPU_SELECTION is set, it is now possible
> to select a CPU to tune for by means of the -mtune= option.
>
> I tried to be very careful when coding the specific rules into
> the Kconfig language, but it would be good to have a few
> people sanity-checking them.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Is there a reason we don't distinguish between 7400/7410 and 74{4,5} 
x?  Is it because we dont have any discrete systems with just a 7400  
on it?

Also I'd suggest we have the config options be a 1:1 matching for the  
-mcpu/-mtune options in gcc for the following cases:

> +	default "-mcpu=750" if CPU_7xx
> +	default "-mcpu=7450" if CPU_74xx
> +	default "-mcpu=860" if PPC_8xx
> +	default "-mcpu=8540" if PPC_85xx

So if in the future we have code scheduling for 8599 or some other  
variant we don't have to go change the Kconfig just add to it.

- k
