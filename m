Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zpsg1x7zzF0tP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 19:04:38 +1000 (AEST)
Message-ID: <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: stewart@linux.vnet.ibm.com
Date: Mon, 04 Jun 2018 19:04:14 +1000
In-Reply-To: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-04 at 13:47 +0530, Abhishek Goel wrote:
> +       if (of_property_read_string_array(power_mgt,
> +               "ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
> +               of_property_read_string_array(power_mgt,
> +                               "ibm,cpu-idle-state-names", descs, dt_idle_states);
> +               pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n"
> +                       "Name will be used for description\n");
> +       }
>  
>         /*

Is this a new property ? I'm not fan of adding yet another of those
silly arrays.

I would say this is the right time now to switch over to a node per
state instead, as we discussed with Vaidy.

Additionally, while doing that, we can provide the versioning mechanism
I proposed so we can deal with state specific issues and erratas.

Cheers,
Ben.
