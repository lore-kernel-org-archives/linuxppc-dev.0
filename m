Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id A0289DDFFB
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:12:47 +1100 (EST)
Date: Thu, 10 Jan 2008 19:12:21 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Fix CPU hotplug when using the SLB shadow buffer
Message-ID: <20080111011221.GW14201@localdomain>
References: <23336.1199947743@neuling.org> <26792.1199949114@neuling.org>
	<28640.1200012427@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28640.1200012427@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> @@ -58,6 +59,7 @@ static void pseries_mach_cpu_die(void)
>  	local_irq_disable();
>  	idle_task_exit();
>  	xics_teardown_cpu(0);
> +	unregister_slb_shadow(smp_processor_id(), __pa(get_slb_shadow()));
                                     ^
Should that not be hard_smp_processor_id()?

(sorry for not commenting earlier)
