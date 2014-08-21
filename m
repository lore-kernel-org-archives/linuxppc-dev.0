Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B80B61A005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 07:20:12 +1000 (EST)
Message-ID: <1408655996.2395.7.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: fsl_pci: Fix PCI/PCI-X regression
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Thu, 21 Aug 2014 16:19:56 -0500
In-Reply-To: <1335064415.96829.1408578704825.JavaMail.zimbra@xes-inc.com>
References: <1335064415.96829.1408578704825.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-20 at 18:51 -0500, Aaron Sierra wrote:
> @@ -520,9 +520,22 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
>  			goto no_bridge;
>  
>  	} else {
> -		/* For PCI read PROG to identify controller mode */
> -		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
> -		if ((progif & 1) == 1)
> +		u16 master;
> +
> +		/*
> +		 * If the controller is PCI-X, then Host mode refers to a
> +		 * bridge that drives the PCI-X initialization pattern to
> +		 * indicate bus operating mode/frequency to devices on the bus.
> +		 * Some hardware (specifically PrPMC modules) are Agents, since
> +		 * the mezzanine carrier is responsible for driving the
> +		 * pattern, but they still may perform bus enumeration.
> +		 *
> +		 * Allow the bridge to be used for enumeration, if hardware
> +		 * strapping (Host mode) or firmware (Agent mode) has enabled
> +		 * bus mastering.
> +		 */
> +		early_read_config_word(hose, 0, 0, PCI_COMMAND, &master);
> +		if (!(master & PCI_COMMAND_MASTER))
>  			goto no_bridge;
>  	}

Why wouldn't a normal PCI agent be able to bus master?

-Scott
