Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 136A1B6EFE
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2012 09:37:55 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 11 Jan 2012 20:37:51 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0BMYFuI3072110
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2012 19:34:16 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0BMbltO023509
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2012 20:37:48 -0200
Date: Wed, 11 Jan 2012 20:37:44 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: cpuidle: Default y for pseries
Message-ID: <20120111223744.GA30947@oc1711230544.ibm.com>
References: <1326243935.23910.85.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1326243935.23910.85.camel@pasglop>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
 linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shaohua Li <shaohua.li@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 10, 2012 at 03:05:35PM -0000, Benjamin Herrenschmidt wrote:
> We just replaced the pseries platform idle loops with a cpuidle backend,
> however that means that you won't get any power saving and won't return
> any unused idle time to the hypervisor unless cpuidle is enabled.
> 
> Thus is should default to y when pseries is enabled. I prefer that to
> a select so we can still make it modular if we want to.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
> Linus, do you want to just pick that up or should I put it into powerpc.git
> and ask you to pull ? I will have 2 or 3 other fixes there later today,
> but I wanted to make sure you were ok with the approach with this
> specific one.

Hi, Ben.

Note that building with CONFIG_PSERIES_IDLE=m fails.

  CC [M]  arch/powerpc/platforms/pseries/processor_idle.o
arch/powerpc/platforms/pseries/processor_idle.c:35: error: redefinition
of ‘update_smt_snooze_delay’
/root/linux/arch/powerpc/include/asm/system.h:230: note: previous
definition of ‘update_smt_snooze_delay’ was here
arch/powerpc/platforms/pseries/processor_idle.c:175: error: redefinition
of ‘pseries_notify_cpuidle_add_cpu’
/root/linux/arch/powerpc/include/asm/system.h:231: note: previous
definition of ‘pseries_notify_cpuidle_add_cpu’ was here
make[2]: *** [arch/powerpc/platforms/pseries/processor_idle.o] Error 1
make[1]: *** [arch/powerpc/platforms/pseries] Error 2
make: *** [arch/powerpc/platforms] Error 2

asm/system.h has empty inline implementations for
update_smt_snooze_delay and pseries_notify_cpuidle_add_cpu, which are
used when CONFIG_PSERIES_IDLE is undefined. Since those two functions
are used in core power architecture functions (store_smt_snooze_delay
at kernel/sysfs.c and smp_xics_setup_cpu at platforms/pseries/smp.c),
this requires some rework in these interactions or we should simply
disable PSERIES_IDLE to be built as a module for now.

Regards.
Cascardo.

> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 7dbc4a8..62ca70d 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -1,7 +1,8 @@
>  
>  config CPU_IDLE
>  	bool "CPU idle PM support"
> -	default ACPI
> +	default y if ACPI
> +	default y if PPC_PSERIES
>  	help
>  	  CPU idle is a generic framework for supporting software-controlled
>  	  idle processor power management.  It includes modular cross-platform
