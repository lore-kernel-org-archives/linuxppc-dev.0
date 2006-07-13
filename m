Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 4FB8567BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 04:20:37 +1000 (EST)
Date: Thu, 13 Jul 2006 13:20:17 -0500
From: Nathan Lynch <ntl@pobox.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] reorg RTAS delay code
Message-ID: <20060713182016.GH19076@localdomain>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
	<1149177349.9812.16.camel@sinatra.austin.ibm.com>
	<1149200718.15158.0.camel@sinatra.austin.ibm.com>
	<1149280229.18052.3.camel@sinatra.austin.ibm.com>
	<20060602213308.GP8934@localdomain>
	<1149543108.17307.6.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149543108.17307.6.camel@sinatra.austin.ibm.com>
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi folks-

John Rose wrote:
> This patch attempts to handle RTAS "busy" return codes in a more simple
> and consistent manner.  Typical callers of RTAS shouldn't have to
> manage wait times and delay calls.
> 
> This patch also changes the kernel to use msleep() rather than udelay()
> when a runtime delay is necessary.  This will avoid CPU soft lockups
> for extended delay conditions.

...

> +/* For an RTAS busy status code, perform the hinted delay. */
> +unsigned int rtas_busy_delay(int status)
> +{
> +	unsigned int ms;
>  
> -	/* Use microseconds for reasonable accuracy */
> -	for (ms = 1; order > 0; order--)
> -		ms *= 10;
> +	might_sleep();
> +	ms = rtas_busy_delay_time(status);
> +	if (ms)
> +		msleep(ms);
>  
> -	return ms; 
> +	return ms;
>  }

So I managed to test this with cpu hotplug recently and the
might_sleep warning triggers in the cpu offline path (I had to
reconstruct this from xmon due to the kernel crashing later on for a
different reason, so it might be a little off):

BUG: sleeping function called from invalid context at arch/powerpc/kernel/rtas.c:463.
in_atomic():1, irqs_disabled():1.
Call Trace:
[C0000000AAD379A0] [C000000000010ADC] .show_stack+0x68/0x1b4 (unreliable)
[C0000000AAD37A50] [C000000000050C98] .__might_sleep+0xd0/0xec
[C0000000AAD37AE0] [C00000000001DF5C] .rtas_busy_delay+0x20/0x54
[C0000000AAD37B70] [C00000000001E2D0] .rtas_set_indicator+0x70/0xd4
[C0000000AAD37C10] [C0000000000491C8] .xics_migrate_irqs_away+0x78/0x228
[C0000000AAD37CD0] [C000000000047C14] .pSeries_cpu_disable+0x98/0xb4
[C0000000AAD37D50] [C000000000029A5C] .__cpu_disable+0x4c/0x60
[C0000000AAD37DC0] [C000000000080834] .take_cpu_down+0x10/0x38
[C0000000AAD37E40] [C00000000008D1C0] .do_stop+0x198/0x248
[C0000000AAD37EE0] [C000000000078124] .kthread+0x124/0x174
[C0000000AAD37F90] [C000000000026568] .kernel_thread+0x4c/0x68


As it turns out, set-indicator is not allowed to return a busy delay
in this context, so we're actually safe here.  Maybe we need an
rtas_set_indicator_fast which could take that into account, e.g.

int rtas_set_indicator_fast(int indicator, int index, int new_value)
{
	int token = rtas_token("set-indicator");
	int rc;

	rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);

	WARN_ON(rc == -2 || rc >= 9000 || rc <= 9005);

	if (rc < 0)
		return rtas_error_rc(rc);
	return rc;
}
