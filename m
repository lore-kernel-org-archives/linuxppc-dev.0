Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A63032C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 07:49:55 +1000 (EST)
Message-ID: <1370036984.3928.144.camel@pasglop>
Subject: Re: [PATCH] powerpc/sysfs: disable hotplug for the boot cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Date: Sat, 01 Jun 2013 07:49:44 +1000
In-Reply-To: <1369727984-21505-2-git-send-email-chenhui.zhao@freescale.com>
References: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
 <1369727984-21505-2-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-05-28 at 15:59 +0800, Zhao Chenhui wrote:
> Some features depend on the boot cpu, for instance, hibernate/suspend.
> So disable hotplug for the boot cpu.

Don't we have code to "move" the boot CPU around when that happens ?

Ben.

> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/kernel/sysfs.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index e68a845..294b1c4e 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -655,8 +655,10 @@ static int __init topology_init(void)
>  		 * CPU.  For instance, the boot cpu might never be valid
>  		 * for hotplugging.
>  		 */
> -		if (ppc_md.cpu_die)
> +		if (ppc_md.cpu_die && cpu != boot_cpuid)
>  			c->hotpluggable = 1;
> +		else
> +			c->hotpluggable = 0;
>  
>  		if (cpu_online(cpu) || c->hotpluggable) {
>  			register_cpu(c, cpu);
