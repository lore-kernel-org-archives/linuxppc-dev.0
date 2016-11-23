Return-Path: <mpe@ellerman.id.au>
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
 Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <skiboot@lists.ozlabs.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/3] cpuidle:powernv: Add helper function to populate
 powernv idle states.
In-Reply-To: <9c2b5cae68b54ec5dcb2651f352f740f1d09051c.1478760806.git.ego@linux.vnet.ibm.com>
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <9c2b5cae68b54ec5dcb2651f352f740f1d09051c.1478760806.git.ego@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2016 20:49:08 +1100
Message-ID: <87vavettkb.fsf@concordia.ellerman.id.au>
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

> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 7fe442c..9240e08 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -243,28 +262,31 @@ static int powernv_add_idle_states(void)
>  		 */
>  		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
>  			continue;
> +		/*
> +		 * Firmware passes residency and latency values in ns.
> +		 * cpuidle expects it in us.
> +		 */
> +		exit_latency = ((unsigned int)latency_ns[i]) / 1000;
> +		target_residency = (!rc) ? ((unsigned int)residency_ns[i]) : 0;
> +		target_residency /= 1000;

Urk.

Can you just do it normally:

		if (rc == 0)
			target_residency = (unsigned int)residency_ns[i] / 1000;

I also don't see why you need the cast?

cheers
