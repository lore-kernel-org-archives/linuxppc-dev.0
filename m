Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vlW2B43YWzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 16:28:02 +1100 (AEDT)
Message-ID: <1489814882.5616.11.camel@neuling.org>
Subject: Re: [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
From: Michael Neuling <mikey@neuling.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sat, 18 Mar 2017 16:28:02 +1100
In-Reply-To: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
References: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
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

Vaidy,

Thanks for fixing this.

> drv->cpumask defaults to cpu_possible_mask in __cpuidle_driver_init().
> This breaks cpuidle on powernv where sysfs files are not created for
> cpus in cpu_possible_mask that cannot be hot-added.

I think I prefer the longer description below than this.

> This patch fixes the issue by passing correct cpumask from
> powernv-cpuidle driver.

Any reason the correct fix isn't to change __cpuidle_driver_init() to use
present mask?  Seems like any arch where present < possible is going to hit
this.

> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Can we CC stable too.  This breaks at least v4.10.

> ---
> =C2=A0drivers/cpuidle/cpuidle-powernv.c | 22 ++++++++++++++++++++++
> =C2=A01 file changed, 22 insertions(+)
>=20
