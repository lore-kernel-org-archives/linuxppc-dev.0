Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E6CA9B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 14:36:01 +1100 (EST)
Message-ID: <1331264145.3105.56.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/44x: Fix PCI MSI support for Maui APM821xx
 SoC and Bluestone board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mai La <mla@apm.com>
Date: Fri, 09 Mar 2012 14:35:45 +1100
In-Reply-To: <1331263072-9612-1-git-send-email-mla@apm.com>
References: <1331263072-9612-1-git-send-email-mla@apm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, open-source-review@apm.com,
 Tirumala R Marri <tmarri@apm.com>, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-09 at 10:17 +0700, Mai La wrote:
> This patch consists of:
> - Enable PCI MSI as default for Bluestone board
> - Define number of MSI interrupt for Maui APM821xx SoC using in Bluestone board
> - Fix returning ENODEV as finding MSI node
> - Fix MSI physical high and low address
> - Keep MSI data logically
> 
> Signed-off-by: Mai La <mla@apm.com>
> ---

> index 7b4df37..c86231e 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -20,6 +20,12 @@ config PPC_MSI_BITMAP
>  	default y if FSL_PCI
>  	default y if PPC4xx_MSI
>  
> +config PPC4xx_NR_MSI_IRQS
> +	int "Number of PCI MSI interrupts"
> +	depends on PCI_MSI && PPC4xx_MSI
> +	default "4" if !APM821xx
> +	default "8" if APM821xx
> +

 .../...

> +#define NR_MSI_IRQS CONFIG_PPC4xx_NR_MSI_IRQS

ARGH.

We asked to -NOT MAKE THIS A COMPILE TIME OPTION-

CONFIG_foo is as bad as your previous ifdef, in fact you just added a
useless config option here.

Make that number dynamic. Count the entries in the device-tree (or add
a property with the number in it, whatever you fancy the most) but make
it something detected at RUNTIME !!!!!

Ben.
