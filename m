Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 788C067A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 07:48:26 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 11 Mar 2005 13:48:23 -0700
To: Sylvain Munaut <tnt@246tNt.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050311204823.GA11928@xyzzy>
References: <4231F9F9.5080506@246tNt.com> <4231FABA.2030809@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4231FABA.2030809@246tNt.com>
Subject: Re: [PATCH 2/2] MPC52xx updates : PCI Support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The first hunk of arch/ppc/platforms/lite5200.c looks corrupted.
See the line beginning "fdef CONFIG_PCI".

-Dale

On Fri, Mar 11, 2005 at 08:08:26PM +0000, Sylvain Munaut wrote:
> And here's the second patch :

[ deleted lines ]

> diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
> --- a/arch/ppc/platforms/lite5200.c     2005-03-11 20:41:56 +01:00
> +++ b/arch/ppc/platforms/lite5200.c     2005-03-11 20:41:56 +01:00
> @@ -35,6 +35,8 @@
> #include <asm/ocp.h>
> #include <asm/mpc52xx.h>
> 
> +#include <syslib/mpc52xx_pci.h>
> +
> 
> extern int powersave_nap;
> 
> fdef CONFIG_PCI
> +static int
> +lite5200_map_irq(struct pci_dev *dev, unsigned char idsel,
> +                 unsigned char pin) {
> +       return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
> +}
> +#endif

[ more deleted lines ]
