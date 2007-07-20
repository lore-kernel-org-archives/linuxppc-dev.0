Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D0B3DDEEB
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:10:02 +1000 (EST)
In-Reply-To: <20070720031110.GP3925@crusty.rchland.ibm.com>
References: <20070720031110.GP3925@crusty.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <A2827AAE-077D-4DEC-A4FD-2E2CD8B4B809@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix ARCH=ppc builds
Date: Thu, 19 Jul 2007 22:10:36 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2007, at 10:11 PM, Josh Boyer wrote:

> The recent signal rework broke ARCH=3Dppc builds with the following =20=

> error:
>
> CC      arch/powerpc/kernel/signal.o
> arch/powerpc/kernel/signal.c: In function =91do_signal=92:
> arch/powerpc/kernel/signal.c:142: error: implicit declaration of =20
> function =91set_dabr=92
> make[1]: *** [arch/powerpc/kernel/signal.o] Error 1
>
> The patch below fixes it by including a function prototype in
> asm-ppc/system.h
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

(Bet me to posting this :)

> diff --git a/include/asm-ppc/system.h b/include/asm-ppc/system.h
> index f1311a8..cc45780 100644
> --- a/include/asm-ppc/system.h
> +++ b/include/asm-ppc/system.h
> @@ -54,6 +54,7 @@ extern void show_regs(struct pt_regs * regs);
>  extern void flush_instruction_cache(void);
>  extern void hard_reset_now(void);
>  extern void poweroff_now(void);
> +extern int set_dabr(unsigned long dabr);
>  #ifdef CONFIG_6xx
>  extern long _get_L2CR(void);
>  extern long _get_L3CR(void);
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
