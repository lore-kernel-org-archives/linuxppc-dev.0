Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0125.outbound.protection.outlook.com [207.46.100.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF5941A0CFB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 11:46:20 +1100 (AEDT)
Message-ID: <1421714767.4961.196.camel@freescale.com>
Subject: Re: [PATCH] fsl/smp: add low power boot support to replace spin boot
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Mon, 19 Jan 2015 18:46:07 -0600
In-Reply-To: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
References: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-15 at 14:05 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> U-boot put non-boot cpus into an low power state(PW10/PW20 or DOZE) when cpu
> powered up. To exit low power state kernel will send DOORBELL or MPIC-IPI
> signal to all those CPUs.

U-Boot does not do this yet.  A patch was just posted to propose such a
change.

> @@ -292,11 +315,58 @@ static int smp_85xx_kick_cpu(int nr)
>  		__secondary_hold_acknowledge = -1;
>  	}
>  #endif
> +
>  	flush_spin_table(spin_table);
> -	out_be32(&spin_table->pir, hw_cpu);
> +	/*
> +	 * U-boot will wait kernel send eoi to MPIC, after EOI has send
> +	 * kernel will set PIR for uboot, let uboot know EOI has send.
> +	 */
> +	out_be32(&spin_table->pir, 0);

Why is the kernel sending EOI for an interrupt U-Boot receives?  Why are
you abusing PIR for anything other than setting the desired PIR value?

What happens when you enter the kernel with secondaries having PIR = 0?

> +	/* Let cpu exit low power state, and from u-boot jump to kernel */
> +	arch_send_call_function_single_ipi(kick_cpus);
> +
> +	/*
> +	 * Let we ACK interrput and Send EOI signal to finish INT server
> +	 * U-boot has read EPR to ACK interrput when MPIC work in external
> +	 * proxy mode. Without the external proxy facility, we need to read
> +	 * MPIC ACK register.
> +	 *
> +	 * There just ACK interrput, we don't need to get the interrupt vector
> +	 * and to handle it. Because there just IPI or DOORBELL interrupt to
> +	 * make u-boot exit low power state and jump to kernel.
> +	 */
> +	mpic_cpu_ack(nr);

How do you know the interrupt is ready to be acked at this point?

-Scott
