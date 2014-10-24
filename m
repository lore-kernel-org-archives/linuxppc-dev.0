Return-Path: <James.Hogan@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id A5E1F1A009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 21:03:25 +1100 (AEDT)
Message-ID: <544A2017.7020804@imgtec.com>
Date: Fri, 24 Oct 2014 10:47:03 +0100
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/47] kernel: Move pm_power_off to common code
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1413864783-3271-9-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux@openrisc.net,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guenter,

On 21/10/14 05:12, Guenter Roeck wrote:
> pm_power_off is defined for all architectures. Move it to common code.
> 
> Have all architectures call do_kernel_power_off instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_power_off from machine_power_off instead.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Richard Weinberger <richard@nod.at>
> Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>

For metag:
Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c
> index 483dff9..8d95773 100644
> --- a/arch/metag/kernel/process.c
> +++ b/arch/metag/kernel/process.c
> @@ -67,9 +67,6 @@ void arch_cpu_idle_dead(void)
>  }
>  #endif
>  
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void (*soc_restart)(char *cmd);
>  void (*soc_halt)(void);
>  
> @@ -90,8 +87,7 @@ void machine_halt(void)
>  
>  void machine_power_off(void)
>  {
> -	if (pm_power_off)
> -		pm_power_off();
> +	do_kernel_power_off();
>  	smp_send_stop();
>  	hard_processor_halt(HALT_OK);
>  }
