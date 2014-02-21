Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BBC22C030A
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Feb 2014 07:05:23 +1100 (EST)
Message-ID: <1393013115.6771.98.camel@pasglop>
Subject: Re: [PATCH 5/5] powerpc/powernv: Make PHB diag-data output short
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 22 Feb 2014 07:05:15 +1100
In-Reply-To: <1392983613-10090-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1392983613-10090-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1392983613-10090-5-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-02-21 at 19:53 +0800, Gavin Shan wrote:
> According to Ben's suggestion, the patch makes the PHB diag-data
> dump looks a bit short by printing multiple values in one line
> and outputing "-" for zero fields.
> 
> After the patch applied, the PHB diag-data dump looks like:

Actually, I wouldn't do that "-" thing, I would leave zeros as
zeros but I would remove lines that have all zeros.

Additionally, we might want to consider what if we can get rid
of more fields for INF, or maybe even not dump them by default
and just count them (should we have counters in sysfs ?)

One thing I'm tempted to do is turn the full logs into actual
error logs (sent to FSP) and only display a "analyzed" version
in the kernel, something that decodes the PEST for example
and indicates if it's an DMA or MMIO error, the address, etc...

Cheers,
Ben.

> PHB3 PHB#3 Diag-data (Version: 1)
> 
>   brdgCtl:     00000002
>   UtlSts:      - - -
>   RootSts:     0000000f 00400000 b0830008 00100147 00002000
>   RootErrSts:  - - -
>   RootErrLog:  - - - -
>   RootErrLog1: - - -
>   nFir:        - 0030006e00000000 -
>   PhbSts:      0000001c00000000 -
>   Lem:         0000000000100000 42498e327f502eae -
>   PhbErr:      - - - -
>   OutErr:      - - - -
>   InAErr:      8000000000000000 8000000000000000 0402030000000000 -
>   InBErr:      - - - -
>   PE[  8] A/B: 8480002b00000000 8000000000000000
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c |  238 ++++++++++++++++++++--------------
>  1 file changed, 143 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 67b2254..a5f236a 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -124,67 +124,103 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
>  }
>  #endif /* CONFIG_PCI_MSI */
>  
> +static char *pnv_pci_diag_field(char *buf, int fmt, u64 val64)
> +{
> +	u32 val32 = (u32)val64;
> +
> +	memset(buf, 0, 24);
> +	switch (fmt) {
> +	case 8:
> +		if (val32)
> +			sprintf(buf, "%08x", val32);
> +		else
> +			sprintf(buf, "%s", "-");
> +		break;
> +	case 16:
> +		if (val64)
> +			sprintf(buf, "%016llx", val64);
> +		else
> +			sprintf(buf, "%s", "-");
> +		break;
> +	default:
> +		sprintf(buf, "%s", "-");
> +	}
> +
> +	return buf;
> +}
> +
>  static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
>  					 struct OpalIoPhbErrorCommon *common)
>  {
>  	struct OpalIoP7IOCPhbErrorData *data;
> +	char buf[120];
>  	int i;
>  
>  	data = (struct OpalIoP7IOCPhbErrorData *)common;
>  	pr_info("P7IOC PHB#%d Diag-data (Version: %d)\n\n",
>  		hose->global_number, common->version);
>  
> -	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
> -
> -	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
> -	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
> -	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
> -
> -	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
> -	pr_info("  slotStatus:           %08x\n", data->slotStatus);
> -	pr_info("  linkStatus:           %08x\n", data->linkStatus);
> -	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
> -	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
> -
> -	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
> -	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
> -	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
> -	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
> -	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
> -	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
> -	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
> -	pr_info("  sourceId:             %08x\n", data->sourceId);
> -	pr_info("  errorClass:           %016llx\n", data->errorClass);
> -	pr_info("  correlator:           %016llx\n", data->correlator);
> -	pr_info("  p7iocPlssr:           %016llx\n", data->p7iocPlssr);
> -	pr_info("  p7iocCsr:             %016llx\n", data->p7iocCsr);
> -	pr_info("  lemFir:               %016llx\n", data->lemFir);
> -	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
> -	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
> -	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
> -	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
> -	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
> -	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
> -	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
> -	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
> -	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
> -	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
> -	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
> -	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
> -	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
> -	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
> -	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
> -	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
> -	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
> -	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
> +	pr_info("  brdgCtl:     %s\n",
> +		pnv_pci_diag_field(&buf[0], 8, data->brdgCtl));
> +	pr_info("  UtlSts:      %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->portStatusReg),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->rootCmplxStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->busAgentStatus));
> +	pr_info("  RootSts:     %s %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->deviceStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->slotStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->linkStatus),
> +		pnv_pci_diag_field(&buf[3 * 24], 8, data->devCmdStatus),
> +		pnv_pci_diag_field(&buf[4 * 24], 8, data->devSecStatus));
> +	pr_info("  RootErrSts:  %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->rootErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->uncorrErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->corrErrorStatus));
> +	pr_info("  RootErrLog:  %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->tlpHdr1),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->tlpHdr2),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->tlpHdr3),
> +		pnv_pci_diag_field(&buf[3 * 24], 8, data->tlpHdr4));
> +	pr_info("  RootErrLog1: %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],       8, data->sourceId),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->errorClass),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->correlator));
> +	pr_info("  PhbSts:      %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->p7iocPlssr),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->p7iocCsr));
> +	pr_info("  Lem:         %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->lemFir),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->lemErrorMask),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->lemWOF));
> +	pr_info("  PhbErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->phbErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->phbFirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->phbErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->phbErrorLog1));
> +	pr_info("  OutErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->mmioErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->mmioFirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->mmioErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->mmioErrorLog1));
> +	pr_info("  InAErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->dma0ErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->dma0FirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->dma0ErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->dma0ErrorLog1));
> +	pr_info("  InBErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->dma1ErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->dma1FirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->dma1ErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->dma1ErrorLog1));
>  
>  	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
>  		if ((data->pestA[i] >> 63) == 0 &&
>  		    (data->pestB[i] >> 63) == 0)
>  			continue;
>  
> -		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
> -		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
> +		pr_info("  PE[%3d] A/B: %s %s\n",
> +			i, pnv_pci_diag_field(&buf[0], 16, data->pestA[i]),
> +			pnv_pci_diag_field(&buf[1 * 24], 16, data->pestB[i]));
>  	}
>  }
>  
> @@ -192,67 +228,79 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
>  					struct OpalIoPhbErrorCommon *common)
>  {
>  	struct OpalIoPhb3ErrorData *data;
> -	int i;
> +	char buf[120];
> +	int i = 0;
>  
> +	memset(buf, 0, 120);
>  	data = (struct OpalIoPhb3ErrorData*)common;
>  	pr_info("PHB3 PHB#%d Diag-data (Version: %d)\n\n",
>  		hose->global_number, common->version);
>  
> -	pr_info("  brdgCtl:              %08x\n", data->brdgCtl);
> -
> -	pr_info("  portStatusReg:        %08x\n", data->portStatusReg);
> -	pr_info("  rootCmplxStatus:      %08x\n", data->rootCmplxStatus);
> -	pr_info("  busAgentStatus:       %08x\n", data->busAgentStatus);
> -
> -	pr_info("  deviceStatus:         %08x\n", data->deviceStatus);
> -	pr_info("  slotStatus:           %08x\n", data->slotStatus);
> -	pr_info("  linkStatus:           %08x\n", data->linkStatus);
> -	pr_info("  devCmdStatus:         %08x\n", data->devCmdStatus);
> -	pr_info("  devSecStatus:         %08x\n", data->devSecStatus);
> -
> -	pr_info("  rootErrorStatus:      %08x\n", data->rootErrorStatus);
> -	pr_info("  uncorrErrorStatus:    %08x\n", data->uncorrErrorStatus);
> -	pr_info("  corrErrorStatus:      %08x\n", data->corrErrorStatus);
> -	pr_info("  tlpHdr1:              %08x\n", data->tlpHdr1);
> -	pr_info("  tlpHdr2:              %08x\n", data->tlpHdr2);
> -	pr_info("  tlpHdr3:              %08x\n", data->tlpHdr3);
> -	pr_info("  tlpHdr4:              %08x\n", data->tlpHdr4);
> -	pr_info("  sourceId:             %08x\n", data->sourceId);
> -	pr_info("  errorClass:           %016llx\n", data->errorClass);
> -	pr_info("  correlator:           %016llx\n", data->correlator);
> -
> -	pr_info("  nFir:                 %016llx\n", data->nFir);
> -	pr_info("  nFirMask:             %016llx\n", data->nFirMask);
> -	pr_info("  nFirWOF:              %016llx\n", data->nFirWOF);
> -	pr_info("  PhbPlssr:             %016llx\n", data->phbPlssr);
> -	pr_info("  PhbCsr:               %016llx\n", data->phbCsr);
> -	pr_info("  lemFir:               %016llx\n", data->lemFir);
> -	pr_info("  lemErrorMask:         %016llx\n", data->lemErrorMask);
> -	pr_info("  lemWOF:               %016llx\n", data->lemWOF);
> -	pr_info("  phbErrorStatus:       %016llx\n", data->phbErrorStatus);
> -	pr_info("  phbFirstErrorStatus:  %016llx\n", data->phbFirstErrorStatus);
> -	pr_info("  phbErrorLog0:         %016llx\n", data->phbErrorLog0);
> -	pr_info("  phbErrorLog1:         %016llx\n", data->phbErrorLog1);
> -	pr_info("  mmioErrorStatus:      %016llx\n", data->mmioErrorStatus);
> -	pr_info("  mmioFirstErrorStatus: %016llx\n", data->mmioFirstErrorStatus);
> -	pr_info("  mmioErrorLog0:        %016llx\n", data->mmioErrorLog0);
> -	pr_info("  mmioErrorLog1:        %016llx\n", data->mmioErrorLog1);
> -	pr_info("  dma0ErrorStatus:      %016llx\n", data->dma0ErrorStatus);
> -	pr_info("  dma0FirstErrorStatus: %016llx\n", data->dma0FirstErrorStatus);
> -	pr_info("  dma0ErrorLog0:        %016llx\n", data->dma0ErrorLog0);
> -	pr_info("  dma0ErrorLog1:        %016llx\n", data->dma0ErrorLog1);
> -	pr_info("  dma1ErrorStatus:      %016llx\n", data->dma1ErrorStatus);
> -	pr_info("  dma1FirstErrorStatus: %016llx\n", data->dma1FirstErrorStatus);
> -	pr_info("  dma1ErrorLog0:        %016llx\n", data->dma1ErrorLog0);
> -	pr_info("  dma1ErrorLog1:        %016llx\n", data->dma1ErrorLog1);
> +	pr_info("  brdgCtl:     %s\n",
> +		pnv_pci_diag_field(&buf[0], 8, data->brdgCtl));
> +	pr_info("  UtlSts:      %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->portStatusReg),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->rootCmplxStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->busAgentStatus));
> +	pr_info("  RootSts:     %s %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->deviceStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->slotStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->linkStatus),
> +		pnv_pci_diag_field(&buf[3 * 24], 8, data->devCmdStatus),
> +		pnv_pci_diag_field(&buf[4 * 24], 8, data->devSecStatus));
> +	pr_info("  RootErrSts:  %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->rootErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->uncorrErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->corrErrorStatus));
> +	pr_info("  RootErrLog:  %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      8, data->tlpHdr1),
> +		pnv_pci_diag_field(&buf[1 * 24], 8, data->tlpHdr2),
> +		pnv_pci_diag_field(&buf[2 * 24], 8, data->tlpHdr3),
> +		pnv_pci_diag_field(&buf[3 * 24], 8, data->tlpHdr4));
> +	pr_info("  RootErrLog1: %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],       8, data->sourceId),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->errorClass),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->correlator));
> +	pr_info("  nFir:        %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->nFir),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->nFirMask),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->nFirWOF));
> +	pr_info("  PhbSts:      %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->phbPlssr),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->phbCsr));
> +	pr_info("  Lem:         %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->lemFir),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->lemErrorMask),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->lemWOF));
> +	pr_info("  PhbErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->phbErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->phbFirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->phbErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->phbErrorLog1));
> +	pr_info("  OutErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->mmioErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->mmioFirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->mmioErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->mmioErrorLog1));
> +	pr_info("  InAErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->dma0ErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->dma0FirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->dma0ErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->dma0ErrorLog1));
> +	pr_info("  InBErr:      %s %s %s %s\n",
> +		pnv_pci_diag_field(&buf[0],      16, data->dma1ErrorStatus),
> +		pnv_pci_diag_field(&buf[1 * 24], 16, data->dma1FirstErrorStatus),
> +		pnv_pci_diag_field(&buf[2 * 24], 16, data->dma1ErrorLog0),
> +		pnv_pci_diag_field(&buf[3 * 24], 16, data->dma1ErrorLog1));
>  
>  	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
>  		if ((data->pestA[i] >> 63) == 0 &&
>  		    (data->pestB[i] >> 63) == 0)
>  			continue;
>  
> -		pr_info("  PE[%3d] PESTA:        %016llx\n", i, data->pestA[i]);
> -		pr_info("          PESTB:        %016llx\n", data->pestB[i]);
> +		pr_info("  PE[%3d] A/B: %s %s\n",
> +			i, pnv_pci_diag_field(&buf[0], 16, data->pestA[i]),
> +			pnv_pci_diag_field(&buf[1 * 24], 16, data->pestB[i]));
>  	}
>  }
>  
