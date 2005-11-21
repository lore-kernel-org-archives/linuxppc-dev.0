Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 2A30E687A5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 04:54:28 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 21 Nov 2005 10:47:45 -0700
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20051121174745.GA2654@xyzzy.farnsworth.org>
References: <1132583152.11785.41.camel@mephisto.spb.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1132583152.11785.41.camel@mephisto.spb.rtsoft.ru>
Subject: Re: [PATCH 1/3] ppc32: Fix a few issues in Yucca PCIe functionality
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 21, 2005 at 02:25:52PM +0000, Ruslan V. Sushko wrote:
> This patch includes following changes:
> 
> 1) Fix wrong PCIe config space address calculation for slot #3 (Using an
> signed integer for port numbering will cause wrong address accessing)
> 2) Fix the PCI bus numbering assignment. This will be an issues if more
> than one PCI card is inserted.
> 3) Add verbose error checking.
> 4) Remove commented or unused lines.
> 
> Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

There are a couple of whitespace/style problems in these 3 patches.
Please clean them up and re-submit.

> diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
> --- a/arch/ppc/platforms/4xx/yucca.c
> +++ b/arch/ppc/platforms/4xx/yucca.c
> @@ -280,12 +276,14 @@ yucca_setup_hoses(void)
>  				  IORESOURCE_MEM,
>  				  name);
>  
> -		hose->first_busno = 0;
> -		hose->last_busno  = 15;
> +		hose->first_busno = bus_no;
> +		hose->last_busno  = 0xFF;
>  		hose_type[hose->index] = HOSE_PCIE0 + i;
>  
>  		ppc440spe_setup_pcie(hose, i);
>  		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
> +                bus_no = hose->last_busno + 1;
> +                printk(KERN_INFO "%s: resources allocated\n", name);

The above two lines have leading spaces instead of tabs.  The same
problem exists in several other lines added by the patches.

diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
> @@ -157,33 +162,37 @@ int ppc440spe_init_pcie(void)
>  	/* Set PLL clock receiver to LVPECL */
>  	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) | 1 << 28);
>  
> -	check_error();
> -
> -	printk(KERN_INFO "PCIE initialization OK\n");
> -
> -	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000))
> -		printk(KERN_INFO "PESDR_PLLCT2 resistance calibration failed (0x%08x)\n",
> +	if (check_error()) {
> +                return -1;
> +        }

The above braces aren't needed.

> +
> +	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000)) {
> +		printk(KERN_INFO "PCIE: PESDR_PLLCT2 resistance calibration "
> +                                "failed (0x%08x)\n",
>  		       SDR_READ(PESDR0_PLLLCT2));
> +                return -1;
> +        }
>  
>  	/* De-assert reset of PCIe PLL, wait for lock */
>  	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) & ~(1 << 24));
>  	udelay(3);
> +	printk(KERN_INFO "PCIE initialization OK\n");
>  
>  	return 0;
>  }
>  
> -int ppc440spe_init_pcie_rootport(int port)
> +int ppc440spe_init_pcie_rootport(u32 port)
>  {
>  	static int core_init;
>  	void __iomem *utl_base;
> +        int attempts;
>  	u32 val = 0;
> -	int i;
>  
>  	if (!core_init) {
> +		if(ppc440spe_init_pcie()) {
> +			return -1;
> +                }

Again, the above braces are unnecessary.

Thanks,
-Dale Farnsworth
