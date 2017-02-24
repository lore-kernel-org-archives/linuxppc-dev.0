Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsHD58ffzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:22:00 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3vTsHD1MqTz9s78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:22:00 +1100 (AEDT)
Message-ID: <1487895722.16514.8.camel@neuling.org>
Subject: Re: [PATCH] powerpc/xics: Adjust interrupt receive priority for
 offline cpus
From: Michael Neuling <mikey@neuling.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 24 Feb 2017 11:22:02 +1100
In-Reply-To: <20170223105443.22029-1-svaidy@linux.vnet.ibm.com>
References: <20170223105443.22029-1-svaidy@linux.vnet.ibm.com>
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

On Thu, 2017-02-23 at 16:24 +0530, Vaidyanathan Srinivasan wrote:
> Offline CPUs need to receive IPIs through XIVE when they are
> in stop state and wakeup from that state.
>=20
> Reduce interrupt receive priority in order to receive XIVE
> wakeup interrupts when in offline state.
>=20
> LOWEST_PRIORITY would allow all interrupts to be delivered
> as wakeup events.

This needs to be expanded to explain why "DEFAULT" doesn't work in this cas=
e.

This also needs an explicit statement that "It fixes onlining of CPUs on
POWER9".  I'd even advocate for making that the patch subject.=20

Also if it's the right fix, it needs a cc:stable.

Mikey


> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
> =C2=A0arch/powerpc/sysdev/xics/xics-common.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/sysdev/xics/xics-common.c
> b/arch/powerpc/sysdev/xics/xics-common.c
> index 69d858e..c674a9d 100644
> --- a/arch/powerpc/sysdev/xics/xics-common.c
> +++ b/arch/powerpc/sysdev/xics/xics-common.c
> @@ -199,7 +199,7 @@ void xics_migrate_irqs_away(void)
> =C2=A0	xics_set_cpu_giq(xics_default_distrib_server, 0);
> =C2=A0
> =C2=A0	/* Allow IPIs again... */
> -	icp_ops->set_priority(DEFAULT_PRIORITY);
> +	icp_ops->set_priority(LOWEST_PRIORITY);
> =C2=A0
> =C2=A0	for_each_irq_desc(virq, desc) {
> =C2=A0		struct irq_chip *chip;
