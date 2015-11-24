Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB3DA1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 05:19:53 +1100 (AEDT)
Received: by ykdv3 with SMTP id v3so28646490ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 10:19:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448335593-27862-1-git-send-email-ruscur@russell.cc>
References: <1448335593-27862-1-git-send-email-ruscur@russell.cc>
Date: Tue, 24 Nov 2015 21:19:50 +0300
Message-ID: <CAOJe8K23ZD3VXB2ubuajvmB=-b9v_FpBmZVTV2mxr8mY_Mc0PQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Add a kmsg_dumper that flushes console
 output on panic
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/15, Russell Currey <ruscur@russell.cc> wrote:
> On BMC machines, console output is controlled by the OPAL firmware and is
> only flushed when its pollers are called.  When the kernel is in a panic
> state, it no longer calls these pollers and thus console output does not
> completely flush, causing some output from the panic to be lost.
>
> This patch adds a new kmsg_dumper which gets called at panic time to ensure
> panic output is not lost.  It accomplishes this by calling
> OPAL_CONSOLE_FLUSH
> in the OPAL API, and if that is not available, the pollers are called enough
> times to (hopefully) completely flush the buffer.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Some minor nits below.

> ---
> A patch to add the preferred OPAL call for flushing the console buffer,
> OPAL_CONSOLE_FLUSH, was recently sent upstream to Skiboot.  You can track
> its progress here: https://patchwork.ozlabs.org/patch/547379/
> ---
>  arch/powerpc/include/asm/opal-api.h            |  3 +-
>  arch/powerpc/include/asm/opal.h                |  3 ++
>  arch/powerpc/platforms/powernv/Makefile        |  1 +
>  arch/powerpc/platforms/powernv/opal-kmsg.c     | 70
> ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
>  arch/powerpc/platforms/powernv/opal.c          |  3 ++
>  6 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-kmsg.c
>
> diff --git a/arch/powerpc/include/asm/opal-api.h
> b/arch/powerpc/include/asm/opal-api.h
> index 8374afe..f8faaae 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -157,7 +157,8 @@
>  #define OPAL_LEDS_GET_INDICATOR			114
>  #define OPAL_LEDS_SET_INDICATOR			115
>  #define OPAL_CEC_REBOOT2			116
> -#define OPAL_LAST				116
> +#define OPAL_CONSOLE_FLUSH			117
> +#define OPAL_LAST				117
>
>  /* Device tree flags */
>
> diff --git a/arch/powerpc/include/asm/opal.h
> b/arch/powerpc/include/asm/opal.h
> index 8001159..a5fd407 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -35,6 +35,7 @@ int64_t opal_console_read(int64_t term_number, __be64
> *length,
>  			  uint8_t *buffer);
>  int64_t opal_console_write_buffer_space(int64_t term_number,
>  					__be64 *length);
> +void opal_console_flush(void);
>  int64_t opal_rtc_read(__be32 *year_month_day,
>  		      __be64 *hour_minute_second_millisecond);
>  int64_t opal_rtc_write(uint32_t year_month_day,
> @@ -262,6 +263,8 @@ extern int opal_resync_timebase(void);
>
>  extern void opal_lpc_init(void);
>
> +extern void opal_kmsg_init(void);
> +
>  extern int opal_event_request(unsigned int opal_event_nr);
>
>  struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
> diff --git a/arch/powerpc/platforms/powernv/Makefile
> b/arch/powerpc/platforms/powernv/Makefile
> index 1c8cdb6..b9de7ef 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -2,6 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
> idle.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> +obj-y			+= opal-kmsg.o
>
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
> diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c
> b/arch/powerpc/platforms/powernv/opal-kmsg.c
> new file mode 100644
> index 0000000..904f123
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
> @@ -0,0 +1,70 @@
> +/*
> + * kmsg dumper that ensures the OPAL console fully flushes panic messages
> + *
> + * Author: Russell Currey <ruscur@russell.cc>
> + *
> + * Copyright 2015 IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/kmsg_dump.h>
> +
> +#include <asm/opal.h>
> +#include <asm/opal-api.h>
> +
> +/*
> + * Console output is controlled by OPAL firmware.  The kernel regularly
> calls
> + * OPAL_POLL_EVENTS, which flushes some console output.  In a panic state,
> + * however, the kernel no longer calls OPAL_POLL_EVENTS and the panic
> message
> + * may not be completely printed.  This function does not actually dump the
> + * message, it just ensures that OPAL completely flushes the console
> buffer.
> + */
> +static void force_opal_console_flush(struct kmsg_dumper *dumper,
> +				     enum kmsg_dump_reason reason)
> +{
> +	int i;
> +
> +	/*
> +	 * Outside of a panic context the pollers will continue to run,
> +	 * so we don't need to do any special flushing.
> +	 */
> +	if (reason != KMSG_DUMP_PANIC) {
> +		return;
> +	}
We don't need the brackets with one-line block
> +
> +	if (opal_check_token(OPAL_CONSOLE_FLUSH)) {
> +		opal_console_flush();
> +	} else {
> +		/*
> +		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
> +		 * the console can still be flushed by calling the polling
> +		 * function enough times to flush the buffer.  We don't know
> +		 * how much output still needs to be flushed, but we can be
> +		 * generous since the kernel is in panic and doesn't need
> +		 * to do much else.
> +		 */
> +		printk(KERN_NOTICE "opal: OPAL_CONSOLE_FLUSH missing.\n");
> +		for (i = 0; i < 1024; i++) {
> +			opal_poll_events(NULL);
> +		}
> +	}
> +}
> +
> +static struct kmsg_dumper opal_kmsg_dumper = {
> +	.dump = force_opal_console_flush
> +};
> +
> +void __init opal_kmsg_init(void)
> +{
> +	int rc;
> +
> +	/* Add our dumper to the list */
> +	rc = kmsg_dump_register(&opal_kmsg_dumper);
> +	if (rc != 0) {
> +		pr_err("opal: kmsg_dump_register failed; returned %d\n", rc);
> +	}
ditto.
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S
> b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index b7a464f..e45b88a 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -301,3 +301,4 @@ OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
>  OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
>  OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
>  OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
> +OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
> diff --git a/arch/powerpc/platforms/powernv/opal.c
> b/arch/powerpc/platforms/powernv/opal.c
> index 4296d55..a94a85c 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -758,6 +758,9 @@ static int __init opal_init(void)
>  	opal_pdev_init(opal_node, "ibm,opal-flash");
>  	opal_pdev_init(opal_node, "ibm,opal-prd");
>
> +	/* Initialise OPAL kmsg dumper for flushing console on panic */
> +	opal_kmsg_init();
> +
>  	return 0;
>  }
>  machine_subsys_initcall(powernv, opal_init);
> --
> 2.6.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
