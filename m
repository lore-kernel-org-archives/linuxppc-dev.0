Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsBxY4VWFzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 22:43:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 2/4] powernv:smp: Add busy-wait loop as fall back for
 CPU-Hotplug
In-Reply-To: <261607d15ec471d88a8d31ee50614c64a4018b90.1490194710.git.ego@linux.vnet.ibm.com>
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
 <261607d15ec471d88a8d31ee50614c64a4018b90.1490194710.git.ego@linux.vnet.ibm.com>
Date: Mon, 27 Mar 2017 22:43:44 +1100
Message-ID: <87fuhzdjwv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 419edff..f335e0f 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -283,8 +283,16 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
>  		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
>  		srr1 = power7_sleep();
> -	} else {
> +	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
>  		srr1 = power7_nap(1);
> +	} else {
> +		/* This is the fallback method. We emulate snooze */
> +		while (!generic_check_cpu_restart(cpu)) {

Breaks the SMP=n build :/

arch/powerpc/platforms/powernv/idle.c:299:11: error: implicit declaration of function 'generic_check_cpu_restart' [-Werror=implicit-function-declaration]

cheers
