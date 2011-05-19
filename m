Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AE20B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 13:09:29 +1000 (EST)
Subject: Re: [PATCH] PPC_47x SMP fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
In-Reply-To: <1305712631-21690-1-git-send-email-kerstin.jonsson@ericsson.com>
References: <1305712631-21690-1-git-send-email-kerstin.jonsson@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 13:09:12 +1000
Message-ID: <1305774552.7481.26.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Will Schmidt <will_schmidt@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 11:57 +0200, Kerstin Jonsson wrote:
> commit c56e58537d504706954a06570b4034c04e5b7500 breaks SMP support in PPC_47x chip.
>  secondary_ti must be set to current thread info before callin kick_cpu or else
>  start_secondary_47x will jump into void when trying to return to c-code.
>  In the current setup secondary_ti is initialized before the CPU idle task is started
>  and only the boot core will start. I am not sure this is the correct solution, but it
>  makes SMP possible in my chip.
>  Note! The HOTPLUG support probably need some fixing to, There is no trampoline code
>  available in head_44x.S - start_secondary_resume?

Sending to Linus now. I've also committed a fix for the later, moving
the 32-bit definition of start_secondary_resume to misc_32.S

Thanks !

Cheers,
Ben. 
> 
> Signed-off-by: Kerstin Jonsson <kerstin.jonsson@ericsson.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Will Schmidt <will_schmidt@vnet.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index cbdbb14..f2dcab7 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -410,8 +410,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
>  {
>  	int rc, c;
>  
> -	secondary_ti = current_set[cpu];
> -
>  	if (smp_ops == NULL ||
>  	    (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
>  		return -EINVAL;
> @@ -421,6 +419,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
>  	if (rc)
>  		return rc;
>  
> +	secondary_ti = current_set[cpu];
> +
>  	/* Make sure callin-map entry is 0 (can be leftover a CPU
>  	 * hotplug
>  	 */
