Return-Path: <thuth@redhat.com>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51D5A1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 22:13:20 +1000 (AEST)
Date: Wed, 29 Jul 2015 08:13:12 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com, mpe@ellerman.id.au
Cc: paulus@samba.org, anton@samba.org, kvm-ppc@vger.kernel.org
Message-ID: <215321757.310885.1438171992415.JavaMail.zimbra@redhat.com>
In-Reply-To: <1437130018-3430-1-git-send-email-thuth@redhat.com>
References: <1437130018-3430-1-git-send-email-thuth@redhat.com>
Subject: Re: [PATCH] powerpc/rtas: Introduce rtas_get_sensor_fast() for IRQ
 handlers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- Original Message -----
> The EPOW interrupt handler uses rtas_get_sensor(), which in turn
> uses rtas_busy_delay() to wait for RTAS becoming ready in case it
> is necessary. But rtas_busy_delay() is annotated with might_sleep()
> and thus may not be used by interrupts handlers like the EPOW handler!
> This leads to the following BUG when CONFIG_DEBUG_ATOMIC_SLEEP is
> enabled:
> 
>  BUG: sleeping function called from invalid context at
>  arch/powerpc/kernel/rtas.c:496
>  in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
>  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-rc2-thuth #6
>  Call Trace:
>  [c00000007ffe7b90] [c000000000807670] dump_stack+0xa0/0xdc (unreliable)
>  [c00000007ffe7bc0] [c0000000000e1f14] ___might_sleep+0x134/0x180
>  [c00000007ffe7c20] [c00000000002aec0] rtas_busy_delay+0x30/0xd0
>  [c00000007ffe7c50] [c00000000002bde4] rtas_get_sensor+0x74/0xe0
>  [c00000007ffe7ce0] [c000000000083264] ras_epow_interrupt+0x44/0x450
>  [c00000007ffe7d90] [c000000000120260] handle_irq_event_percpu+0xa0/0x300
>  [c00000007ffe7e70] [c000000000120524] handle_irq_event+0x64/0xc0
>  [c00000007ffe7eb0] [c000000000124dbc] handle_fasteoi_irq+0xec/0x260
>  [c00000007ffe7ef0] [c00000000011f4f0] generic_handle_irq+0x50/0x80
>  [c00000007ffe7f20] [c000000000010f3c] __do_irq+0x8c/0x200
>  [c00000007ffe7f90] [c0000000000236cc] call_do_irq+0x14/0x24
>  [c00000007e6f39e0] [c000000000011144] do_IRQ+0x94/0x110
>  [c00000007e6f3a30] [c000000000002594] hardware_interrupt_common+0x114/0x180
> 
> Fix this issue by introducing a new rtas_get_sensor_fast() function
> that does not use rtas_busy_delay() - and thus can only be used for
> sensors that do not cause a BUSY condition (which should be the case
> for the sensor that is queried by the EPOW IRQ handler).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/powerpc/include/asm/rtas.h      |  1 +
>  arch/powerpc/kernel/rtas.c           | 17 +++++++++++++++++
>  arch/powerpc/platforms/pseries/ras.c |  3 ++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h
> b/arch/powerpc/include/asm/rtas.h
> index 7a4ede1..b77ef36 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -343,6 +343,7 @@ extern void rtas_power_off(void);
>  extern void rtas_halt(void);
>  extern void rtas_os_term(char *str);
>  extern int rtas_get_sensor(int sensor, int index, int *state);
> +extern int rtas_get_sensor_fast(int sensor, int index, int *state);
>  extern int rtas_get_power_level(int powerdomain, int *level);
>  extern int rtas_set_power_level(int powerdomain, int level, int *setlevel);
>  extern bool rtas_indicator_present(int token, int *maxindex);
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 7a488c1..caffb10 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -584,6 +584,23 @@ int rtas_get_sensor(int sensor, int index, int *state)
>  }
>  EXPORT_SYMBOL(rtas_get_sensor);
>  
> +int rtas_get_sensor_fast(int sensor, int index, int *state)
> +{
> +	int token = rtas_token("get-sensor-state");
> +	int rc;
> +
> +	if (token == RTAS_UNKNOWN_SERVICE)
> +		return -ENOENT;
> +
> +	rc = rtas_call(token, 2, 2, state, sensor, index);
> +	WARN_ON(rc == RTAS_BUSY || (rc >= RTAS_EXTENDED_DELAY_MIN &&
> +				    rc <= RTAS_EXTENDED_DELAY_MAX));
> +
> +	if (rc < 0)
> +		return rtas_error_rc(rc);
> +	return rc;
> +}
> +
>  bool rtas_indicator_present(int token, int *maxindex)
>  {
>  	int proplen, count, i;
> diff --git a/arch/powerpc/platforms/pseries/ras.c
> b/arch/powerpc/platforms/pseries/ras.c
> index 02e4a17..3b6647e 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -189,7 +189,8 @@ static irqreturn_t ras_epow_interrupt(int irq, void
> *dev_id)
>  	int state;
>  	int critical;
>  
> -	status = rtas_get_sensor(EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX, &state);
> +	status = rtas_get_sensor_fast(EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX,
> +				      &state);
>  
>  	if (state > 3)
>  		critical = 1;		/* Time Critical */
> --
> 1.8.3.1

*ping*

Michael, do you think this patch is OK for fixing this problem?
Or shall I rather send a patch to simply revert 587f83e8dd50d instead?

 Thomas
