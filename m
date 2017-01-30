Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBb1y5Kc2zDq96
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 14:47:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/5] cpuidle:powernv: Add helper function to populate
 powernv idle states.
In-Reply-To: <1485333389-5752-4-git-send-email-ego@linux.vnet.ibm.com>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
 <1485333389-5752-4-git-send-email-ego@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 14:47:31 +1100
Message-ID: <871svlxl7w.fsf@concordia.ellerman.id.au>
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

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> In the current code for powernv_add_idle_states, there is a lot of code
> duplication while initializing an idle state in powernv_states table.
>
> Add an inline helper function to populate the powernv_states[] table
> for a given idle state. Invoke this for populating the "Nap",
> "Fastsleep" and the stop states in powernv_add_idle_states.
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 89 +++++++++++++++++++++++----------------
>  include/linux/cpuidle.h           |  1 +

I was going to merge this, but I see you've touched cpuidle.h, so I feel
like I should get an ACK from the cpuidle folks.

It's a fairly uncontroversial change, but it's their API.

cheers


> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index da346f2..fc1e5d7 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -62,6 +62,7 @@ struct cpuidle_state {
>  };
>  
>  /* Idle State Flags */
> +#define CPUIDLE_FLAG_NONE       (0x00)
>  #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
>  
> -- 
> 1.9.4
