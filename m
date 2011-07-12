Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 55B44B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 03:46:17 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.53])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20110712174116243.PVYX1687@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 17:41:16 +0000
Date: Tue, 12 Jul 2011 12:40:07 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] 4xx: Add check_link to struct ppc4xx_pciex_hwops
Message-ID: <20110712174007.GA26664@crust.elkhashab.com>
References: <20110701064424.GE13483@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110701064424.GE13483@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 01, 2011 at 04:44:24PM +1000, Tony Breeds wrote:
> All current pcie controllers unconditionally use SDR to check the link and
> poll for reset.

I was able to apply this patch and then modify the 460SX to
work correctly, so I think it is fine.  There is only 1
comment below.  So how does one supply a patch atop another
patch?

Best,
Ayman

> +static int __init ppc4xx_pciex_port_reset_sdr(struct ppc4xx_pciex_port *port)
> +{
> +	printk(KERN_INFO "PCIE%d: Checking link...\n",
> +	       port->index);

Its not a functional problem, but this printk belongs in the
check link if anywhere rather than the reset.

> +
> +	/* Wait for reset to complete */
> +	if (ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS, 1 << 20, 0, 10)) {
> +		printk(KERN_WARNING "PCIE%d: PGRST failed\n",
> +		       port->index);
> +		return -1;
> +	}
> +	return 0;
> +}
