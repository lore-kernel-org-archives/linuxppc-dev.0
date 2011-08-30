Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C269B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 16:04:44 +1000 (EST)
Subject: Re: [PATCH] PSeries: Cancel RTAS event scan before firmware flash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ravi K. Nittala" <ravi.nittala@in.ibm.com>
In-Reply-To: <20110727120801.10429.7276.stgit@localhost6.localdomain6>
References: <20110727120801.10429.7276.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 16:03:57 +1000
Message-ID: <1314684237.2488.77.camel@pasglop>
Mime-Version: 1.0
Cc: antonb@au1.ibm.com, sbest@us.ibm.com, mikey@neuling.org,
	subrata.modak@in.ibm.com, suzuki@in.ibm.com,
	ranittal@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	divya.vikas@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-07-27 at 17:39 +0530, Ravi K. Nittala wrote:
> The firmware flash update is conducted using an RTAS call, that is serialized
> by lock_rtas() which uses spin_lock. rtasd keeps scanning for the RTAS events
> generated on the machine. This is performed via a delayed workqueue, invoking
> an RTAS call to scan the events.
> 
> The flash update takes a while to complete and during this time, any other
> RTAS call has to wait. In this case, rtas_event_scan() waits for a long time
> on the spin_lock resulting in a soft lockup.
> 
> Approaches to fix the issue :
> 
> Approach 1: Stop all the other CPUs before we start flashing the firmware.
> 
> Before the rtas firmware update starts, all other CPUs should be stopped.
> Which means no other CPU should be in lock_rtas(). We do not want other CPUs
> execute while FW update is in progress and the system will be rebooted anyway
> after the update.

Shouldn't we resume the event scan after the flash ?

Appart from that, no objection with the approach.

Cheers,
Ben.

> --- arch/powerpc/kernel/setup-common.c.orig    2011-07-01 22:41:12.952507971 -0400
> +++ arch/powerpc/kernel/setup-common.c    2011-07-01 22:48:31.182507915 -0400
> @@ -109,11 +109,12 @@ void machine_shutdown(void)
>   void machine_restart(char *cmd)
>   {
>       machine_shutdown();
> -    if (ppc_md.restart)
> -        ppc_md.restart(cmd);
>   #ifdef CONFIG_SMP
> -    smp_send_stop();
> +        smp_send_stop();
>   #endif
> +    if (ppc_md.restart)
> +        ppc_md.restart(cmd);
> +
>       printk(KERN_EMERG "System Halted, OK to turn off power\n");
>       local_irq_disable();
>       while (1) ;
> 
> Problems with this approach:
> Stopping the CPUs suddenly may cause other serious problems depending on what
> was running on them. Hence, this approach cannot be considered.
> 
> 
> Approach 2: Cancel the rtas_scan_event work before starting the firmware flash.
> 
> Just before the flash update is performed, the queued rtas_event_scan() work
> item is cancelled from the work queue so that there is no other RTAS call
> issued while the flash is in progress. After the flash completes, the system
> reboots and the rtas_event_scan() is rescheduled.
> 
> Approach 2 looks to be a better solution than Approach 1. Kindly let us know
> your thoughts. Patch attached.
> 
> 
> Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> Signed-off-by: Ravi Nittala <ravi.nittala@in.ibm.com>
> 
> 
> ---
>  arch/powerpc/include/asm/rtas.h  |    2 ++
>  arch/powerpc/kernel/rtas_flash.c |    6 ++++++
>  arch/powerpc/kernel/rtasd.c      |    6 ++++++
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 58625d1..3f26f87 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -245,6 +245,8 @@ extern int early_init_dt_scan_rtas(unsigned long node,
>  
>  extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
>  
> +extern bool rtas_cancel_event_scan(void);
> +
>  /* Error types logged.  */
>  #define ERR_FLAG_ALREADY_LOGGED	0x0
>  #define ERR_FLAG_BOOT		0x1 	/* log was pulled from NVRAM on boot */
> diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
> index e037c74..4174b4b 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -568,6 +568,12 @@ static void rtas_flash_firmware(int reboot_type)
>  	}
>  
>  	/*
> +	 * Just before starting the firmware flash, cancel the event scan work
> +	 * to avoid any soft lockup issues.
> +	 */
> +	rtas_cancel_event_scan();
> +
> +	/*
>  	 * NOTE: the "first" block must be under 4GB, so we create
>  	 * an entry with no data blocks in the reserved buffer in
>  	 * the kernel data segment.
> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> index 481ef06..e8f03fa 100644
> --- a/arch/powerpc/kernel/rtasd.c
> +++ b/arch/powerpc/kernel/rtasd.c
> @@ -472,6 +472,12 @@ static void start_event_scan(void)
>  				 &event_scan_work, event_scan_delay);
>  }
>  
> +/* Cancel the rtas event scan work */
> +bool rtas_cancel_event_scan(void)
> +{
> +	return cancel_delayed_work_sync(&event_scan_work);
> +}
> +
>  static int __init rtas_init(void)
>  {
>  	struct proc_dir_entry *entry;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
