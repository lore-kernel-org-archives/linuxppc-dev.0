Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ylcFv4zkvzDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 17:24:19 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] 44x/fsp2: add irq error handlers
Date: Mon, 27 Nov 2017 17:11:51 +1100
Message-ID: <30237399.hfuS3XnA5U@new-mexico>
In-Reply-To: <20171102130706.76056-5-ivan@de.ibm.com>
References: <20171102130706.76056-5-ivan@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, 2 November 2017 4:07:06 PM AEDT Ivan Mikhaylov wrote:
> * add irq error handlers for cmu, plb, opb, mcue, conf
>   with debug information output in case of problem.
> 
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
> ---
>  arch/powerpc/platforms/44x/fsp2.c |  204 ++++++++++++++++++++++++++++++++++++-
>  1 files changed, 203 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
> index 4e12490..2bbf9ea 100644
> --- a/arch/powerpc/platforms/44x/fsp2.c
> +++ b/arch/powerpc/platforms/44x/fsp2.c
> @@ -29,6 +29,15 @@
>  #include <asm/ppc4xx.h>
>  #include <asm/fsp2_reg.h>
>  #include <asm/dcr.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
> +
> +#define FSP2_BUS_ERR	"ibm,bus-error-irq"
> +#define FSP2_CMU_ERR	"ibm,cmu-error-irq"
> +#define FSP2_CONF_ERR	"ibm,conf-error-irq"
> +#define FSP2_OPBD_ERR	"ibm,opbd-error-irq"
> +#define FSP2_MCUE	"ibm,mc-ue-irq"
> +#define FSP2_RST_WRN	"ibm,reset-warning-irq"
>  
>  static __initdata struct of_device_id fsp2_of_bus[] = {
>  	{ .compatible = "ibm,plb4", },
> @@ -37,6 +46,193 @@
>  	{},
>  };
>  
> +static void l2regs(void)
> +{
> +	pr_err("L2 Controller:\n");
> +	pr_err("MCK:      0x%08x\n", mfl2(L2MCK));
> +	pr_err("INT:      0x%08x\n", mfl2(L2INT));
> +	pr_err("PLBSTAT0: 0x%08x\n", mfl2(L2PLBSTAT0));
> +	pr_err("PLBSTAT1: 0x%08x\n", mfl2(L2PLBSTAT1));
> +	pr_err("ARRSTAT0: 0x%08x\n", mfl2(L2ARRSTAT0));
> +	pr_err("ARRSTAT1: 0x%08x\n", mfl2(L2ARRSTAT1));
> +	pr_err("ARRSTAT2: 0x%08x\n", mfl2(L2ARRSTAT2));
> +	pr_err("CPUSTAT:  0x%08x\n", mfl2(L2CPUSTAT));
> +	pr_err("RACSTAT0: 0x%08x\n", mfl2(L2RACSTAT0));
> +	pr_err("WACSTAT0: 0x%08x\n", mfl2(L2WACSTAT0));
> +	pr_err("WACSTAT1: 0x%08x\n", mfl2(L2WACSTAT1));
> +	pr_err("WACSTAT2: 0x%08x\n", mfl2(L2WACSTAT2));
> +	pr_err("WDFSTAT:  0x%08x\n", mfl2(L2WDFSTAT));
> +	pr_err("LOG0:     0x%08x\n", mfl2(L2LOG0));
> +	pr_err("LOG1:     0x%08x\n", mfl2(L2LOG1));
> +	pr_err("LOG2:     0x%08x\n", mfl2(L2LOG2));
> +	pr_err("LOG3:     0x%08x\n", mfl2(L2LOG3));
> +	pr_err("LOG4:     0x%08x\n", mfl2(L2LOG4));
> +	pr_err("LOG5:     0x%08x\n", mfl2(L2LOG5));
> +}
> +
> +static void show_plbopb_regs(u32 base, int num)
> +{
> +	pr_err("\nPLBOPB Bridge %d:\n", num);
> +	pr_err("GESR0: 0x%08x\n", mfdcr(base + PLB4OPB_GESR0));
> +	pr_err("GESR1: 0x%08x\n", mfdcr(base + PLB4OPB_GESR1));
> +	pr_err("GESR2: 0x%08x\n", mfdcr(base + PLB4OPB_GESR2));
> +	pr_err("GEARU: 0x%08x\n", mfdcr(base + PLB4OPB_GEARU));
> +	pr_err("GEAR:  0x%08x\n", mfdcr(base + PLB4OPB_GEAR));
> +}
> +
> +static irqreturn_t error_irq_handler(int irq, void *data)
> +{
> +	u32 crcs;
> +	struct device_node *np = data;
> +
> +	if (of_device_is_compatible(np, FSP2_BUS_ERR)) {

Rather than duplicating the logic of irg# -> compatible in a big if/else block
it might be better to have each of these blocks in a seperate irq handler. You
could then just use your node_irq_request() function to take an argument for the
handler to make sure each node has the right debug info printed. Eg:

	node_irq_request(FSP2_CMU_ERR, cmu_err_handler);
	node_irq_request(FSP2_BUS_ERR, bus_err_handler);
	node_irq_request(FSP2_CONF_ERR, conf_err_handler);
	node_irq_request(FSP2_OPBD_ERR, opbd_err_handler);
	node_irq_request(FSP2_MCUE, mcue_handler);
	node_irq_request(FSP2_RST_WRN, rst_wrn_handler);

Where *_handler contains the approriate prints. Then you could also drop the
#define's for the compatible properties and have them directly inline which is
also a little neater.

- Alistair

> +		pr_err("Bus Error\n");
> +
> +		l2regs();
> +
> +		pr_err("\nPLB6 Controller:\n");
> +		pr_err("BC_SHD: 0x%08x\n", mfdcr(DCRN_PLB6_SHD));
> +		pr_err("BC_ERR: 0x%08x\n", mfdcr(DCRN_PLB6_ERR));
> +
> +		pr_err("\nPLB6-to-PLB4 Bridge:\n");
> +		pr_err("ESR:  0x%08x\n", mfdcr(DCRN_PLB6PLB4_ESR));
> +		pr_err("EARH: 0x%08x\n", mfdcr(DCRN_PLB6PLB4_EARH));
> +		pr_err("EARL: 0x%08x\n", mfdcr(DCRN_PLB6PLB4_EARL));
> +
> +		pr_err("\nPLB4-to-PLB6 Bridge:\n");
> +		pr_err("ESR:  0x%08x\n", mfdcr(DCRN_PLB4PLB6_ESR));
> +		pr_err("EARH: 0x%08x\n", mfdcr(DCRN_PLB4PLB6_EARH));
> +		pr_err("EARL: 0x%08x\n", mfdcr(DCRN_PLB4PLB6_EARL));
> +
> +		pr_err("\nPLB6-to-MCIF Bridge:\n");
> +		pr_err("BESR0: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BESR0));
> +		pr_err("BESR1: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BESR1));
> +		pr_err("BEARH: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BEARH));
> +		pr_err("BEARL: 0x%08x\n", mfdcr(DCRN_PLB6MCIF_BEARL));
> +
> +		pr_err("\nPLB4 Arbiter:\n");
> +		pr_err("P0ESRH 0x%08x\n", mfdcr(DCRN_PLB4_P0ESRH));
> +		pr_err("P0ESRL 0x%08x\n", mfdcr(DCRN_PLB4_P0ESRL));
> +		pr_err("P0EARH 0x%08x\n", mfdcr(DCRN_PLB4_P0EARH));
> +		pr_err("P0EARH 0x%08x\n", mfdcr(DCRN_PLB4_P0EARH));
> +		pr_err("P1ESRH 0x%08x\n", mfdcr(DCRN_PLB4_P1ESRH));
> +		pr_err("P1ESRL 0x%08x\n", mfdcr(DCRN_PLB4_P1ESRL));
> +		pr_err("P1EARH 0x%08x\n", mfdcr(DCRN_PLB4_P1EARH));
> +		pr_err("P1EARH 0x%08x\n", mfdcr(DCRN_PLB4_P1EARH));
> +
> +		show_plbopb_regs(DCRN_PLB4OPB0_BASE, 0);
> +		show_plbopb_regs(DCRN_PLB4OPB1_BASE, 1);
> +		show_plbopb_regs(DCRN_PLB4OPB2_BASE, 2);
> +		show_plbopb_regs(DCRN_PLB4OPB3_BASE, 3);
> +
> +		pr_err("\nPLB4-to-AHB Bridge:\n");
> +		pr_err("ESR:   0x%08x\n", mfdcr(DCRN_PLB4AHB_ESR));
> +		pr_err("SEUAR: 0x%08x\n", mfdcr(DCRN_PLB4AHB_SEUAR));
> +		pr_err("SELAR: 0x%08x\n", mfdcr(DCRN_PLB4AHB_SELAR));
> +
> +		pr_err("\nAHB-to-PLB4 Bridge:\n");
> +		pr_err("\nESR: 0x%08x\n", mfdcr(DCRN_AHBPLB4_ESR));
> +		pr_err("\nEAR: 0x%08x\n", mfdcr(DCRN_AHBPLB4_EAR));
> +		panic("Bus Error\n");
> +	} else if (of_device_is_compatible(np, FSP2_CMU_ERR)) {
> +		pr_err("CMU Error\n");
> +		pr_err("FIR0: 0x%08x\n", mfcmu(CMUN_FIR0));
> +		panic("CMU Error\n");
> +	} else if (of_device_is_compatible(np, FSP2_CONF_ERR)) {
> +		pr_err("Configuration Logic Error\n");
> +		pr_err("CONF_FIR: 0x%08x\n", mfdcr(DCRN_CONF_FIR_RWC));
> +		pr_err("RPERR0:   0x%08x\n", mfdcr(DCRN_CONF_RPERR0));
> +		pr_err("RPERR1:   0x%08x\n", mfdcr(DCRN_CONF_RPERR1));
> +		panic("Configuration Logic Error\n");
> +	} else if (of_device_is_compatible(np, FSP2_OPBD_ERR)) {
> +		panic("OPBD Error\n");
> +	} else if (of_device_is_compatible(np, FSP2_MCUE)) {
> +		pr_err("DDR: Uncorrectable Error\n");
> +		pr_err("MCSTAT:            0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_MCSTAT));
> +		pr_err("MCOPT1:            0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_MCOPT1));
> +		pr_err("MCOPT2:            0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_MCOPT2));
> +		pr_err("PHYSTAT:           0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_PHYSTAT));
> +		pr_err("CFGR0:             0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR0));
> +		pr_err("CFGR1:             0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR1));
> +		pr_err("CFGR2:             0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR2));
> +		pr_err("CFGR3:             0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_CFGR3));
> +		pr_err("SCRUB_CNTL:        0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_SCRUB_CNTL));
> +		pr_err("ECCERR_PORT0:      0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECCERR_PORT0));
> +		pr_err("ECCERR_ADDR_PORT0: 0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECCERR_ADDR_PORT0));
> +		pr_err("ECCERR_CNT_PORT0:  0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECCERR_COUNT_PORT0));
> +		pr_err("ECC_CHECK_PORT0:   0x%08x\n",
> +			mfdcr(DCRN_DDR34_BASE + DCRN_DDR34_ECC_CHECK_PORT0));
> +
> +		pr_err("MCER0:            0x%08x\n",
> +			mfdcr(DCRN_CW_BASE + DCRN_CW_MCER0));
> +		pr_err("MCER1:            0x%08x\n",
> +			mfdcr(DCRN_CW_BASE + DCRN_CW_MCER1));
> +
> +		pr_err("BESR:             0x%08x\n",
> +			mfdcr(DCRN_PLB6MCIF_BESR0));
> +		pr_err("BEARL:            0x%08x\n",
> +			mfdcr(DCRN_PLB6MCIF_BEARL));
> +		pr_err("BEARH:            0x%08x\n",
> +			mfdcr(DCRN_PLB6MCIF_BEARH));
> +		panic("DDR: Uncorrectable Error\n");
> +	} else if (of_device_is_compatible(np, FSP2_RST_WRN)) {
> +		crcs = mfcmu(CMUN_CRCS);
> +		switch (crcs & CRCS_STAT_MASK) {
> +		case CRCS_STAT_CHIP_RST_B:
> +			panic("Received chassis-initiated reset request");
> +		default:
> +			panic("Unknown external reset: CRCS=0x%x", crcs);
> +		}
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static void node_irq_request(const char *compat)
> +{
> +	struct device_node *np;
> +	irq_handler_t handler = error_irq_handler;
> +	unsigned int irq;
> +	int32_t rc;
> +
> +	for_each_compatible_node(np, NULL, compat) {
> +		irq = irq_of_parse_and_map(np, 0);
> +		if (irq == NO_IRQ) {
> +			pr_err("device tree node %s is missing a interrupt",
> +			      np->name);
> +			return;
> +		}
> +
> +		rc = request_irq(irq, handler, 0, np->name, np);
> +		if (rc) {
> +			pr_err("fsp_of_probe: request_irq failed: np=%s rc=%d",
> +			      np->full_name, rc);
> +			return;
> +		}
> +	}
> +}
> +
> +static void critical_irq_setup(void)
> +{
> +	node_irq_request(FSP2_CMU_ERR);
> +	node_irq_request(FSP2_BUS_ERR);
> +	node_irq_request(FSP2_CONF_ERR);
> +	node_irq_request(FSP2_OPBD_ERR);
> +	node_irq_request(FSP2_MCUE);
> +	node_irq_request(FSP2_RST_WRN);
> +}
> +
>  static int __init fsp2_device_probe(void)
>  {
>  	of_platform_bus_probe(NULL, fsp2_of_bus, NULL);
> @@ -105,11 +301,17 @@ static int __init fsp2_probe(void)
>  	return 1;
>  }
>  
> +static void __init fsp2_irq_init(void)
> +{
> +	uic_init_tree();
> +	critical_irq_setup();
> +}
> +
>  define_machine(fsp2) {
>  	.name			= "FSP-2",
>  	.probe			= fsp2_probe,
>  	.progress		= udbg_progress,
> -	.init_IRQ		= uic_init_tree,
> +	.init_IRQ		= fsp2_irq_init,
>  	.get_irq		= uic_get_irq,
>  	.restart		= ppc4xx_reset_system,
>  	.calibrate_decr		= generic_calibrate_decr,
> 
