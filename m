Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSnRg4K8gzDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 07:25:51 +1000 (AEST)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Borislav Petkov <bp@alien8.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 ioread32/iowrite32
Date: Wed, 17 May 2017 21:16:47 +0000
Message-ID: <7c7bfec63342409ebd58913836a0739a@svr-chch-ex1.atlnz.lc>
References: <20170512042002.18524-1-chris.packham@alliedtelesis.co.nz>
 <20170512042002.18524-4-chris.packham@alliedtelesis.co.nz>
 <20170517181021.yfctrok7f25d5bu5@pd.tnic>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/05/17 06:18, Borislav Petkov wrote:=0A=
> Top-posting so that the PPC list can see the whole patch below.=0A=
>=0A=
> Since I don't know PPC, let me add PPC ML to CC for a confirmation this=
=0A=
> change is correct.=0A=
>=0A=
> Which brings me to the tangential: this driver is from 2006-ish and=0A=
> is for some "Marvell MV64x60 Memory Controller kernel module for PPC=0A=
> platforms".=0A=
=0A=
Many of the peripherals from the PPC MV64x60 were brought through to the =
=0A=
ARM Orion, Kirkwood, and Armada SoCs (e.g. mv643xx_eth.c, =0A=
i2c-mv64xxx.c). I believe the memory controller ECC is also in the same =0A=
category.=0A=
=0A=
I haven't looked into the cache/pci controller aspects of the =0A=
mv64x60_edac.c driver yet.=0A=
=0A=
> If you're going to touch it, then you should test on the PPC=0A=
> hardware too, so that you don't break the driver there.=0A=
=0A=
I don't disagree. I however don't have access to any such hardware (I've =
=0A=
got 2 armada variant boards that have ECC). Maybe someone on the PPC =0A=
list can help me out?=0A=
=0A=
One thing I would like confirmation on is is in_le32 -> ioread32 the =0A=
correct change? I tossed up between ioread32 and readl. Looking at =0A=
mv643xx_eth.c which supports both the MV643XX and Orion it's using readl =
=0A=
so perhaps I should be using that.=0A=
=0A=
> Unless that hardware is obsolete now and we don't care and, and ..?=0A=
=0A=
MV64x60 is pretty old. I considered gutting mv64x60_edac.c to make a =0A=
separate driver but that would just be more code to maintain.=0A=
=0A=
> Maybe someone has some insights...=0A=
>=0A=
> On Fri, May 12, 2017 at 04:20:02PM +1200, Chris Packham wrote:=0A=
>> To allow this driver to be used on non-powerpc platforms it needs to use=
=0A=
>> io accessors suitable for all platforms.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>  drivers/edac/mv64x60_edac.c | 84 ++++++++++++++++++++++----------------=
-------=0A=
>>  1 file changed, 42 insertions(+), 42 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c=
=0A=
>> index ddc5082f7577..102ec29f864b 100644=0A=
>> --- a/drivers/edac/mv64x60_edac.c=0A=
>> +++ b/drivers/edac/mv64x60_edac.c=0A=
>> @@ -32,21 +32,21 @@ static void mv64x60_pci_check(struct edac_pci_ctl_in=
fo *pci)=0A=
>>  	struct mv64x60_pci_pdata *pdata =3D pci->pvt_info;=0A=
>>  	u32 cause;=0A=
>>=0A=
>> -	cause =3D in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);=0A=
>> +	cause =3D ioread32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);=0A=
>>  	if (!cause)=0A=
>>  		return;=0A=
>>=0A=
>>  	printk(KERN_ERR "Error in PCI %d Interface\n", pdata->pci_hose);=0A=
>>  	printk(KERN_ERR "Cause register: 0x%08x\n", cause);=0A=
>>  	printk(KERN_ERR "Address Low: 0x%08x\n",=0A=
>> -	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_LO));=0A=
>> +	       ioread32(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_LO));=0A=
>>  	printk(KERN_ERR "Address High: 0x%08x\n",=0A=
>> -	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_HI));=0A=
>> +	       ioread32(pdata->pci_vbase + MV64X60_PCI_ERROR_ADDR_HI));=0A=
>>  	printk(KERN_ERR "Attribute: 0x%08x\n",=0A=
>> -	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_ATTR));=0A=
>> +	       ioread32(pdata->pci_vbase + MV64X60_PCI_ERROR_ATTR));=0A=
>>  	printk(KERN_ERR "Command: 0x%08x\n",=0A=
>> -	       in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CMD));=0A=
>> -	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE, ~cause);=0A=
>> +	       ioread32(pdata->pci_vbase + MV64X60_PCI_ERROR_CMD));=0A=
>> +	iowrite32(~cause, pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);=0A=
>>=0A=
>>  	if (cause & MV64X60_PCI_PE_MASK)=0A=
>>  		edac_pci_handle_pe(pci, pci->ctl_name);=0A=
>> @@ -61,7 +61,7 @@ static irqreturn_t mv64x60_pci_isr(int irq, void *dev_=
id)=0A=
>>  	struct mv64x60_pci_pdata *pdata =3D pci->pvt_info;=0A=
>>  	u32 val;=0A=
>>=0A=
>> -	val =3D in_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);=0A=
>> +	val =3D ioread32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);=0A=
>>  	if (!val)=0A=
>>  		return IRQ_NONE;=0A=
>>=0A=
>> @@ -93,7 +93,7 @@ static int __init mv64x60_pci_fixup(struct platform_de=
vice *pdev)=0A=
>>  	if (!pci_serr)=0A=
>>  		return -ENOMEM;=0A=
>>=0A=
>> -	out_le32(pci_serr, in_le32(pci_serr) & ~0x1);=0A=
>> +	iowrite32(ioread32(pci_serr) & ~0x1, pci_serr);=0A=
>>  	iounmap(pci_serr);=0A=
>>=0A=
>>  	return 0;=0A=
>> @@ -161,10 +161,10 @@ static int mv64x60_pci_err_probe(struct platform_d=
evice *pdev)=0A=
>>  		goto err;=0A=
>>  	}=0A=
>>=0A=
>> -	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE, 0);=0A=
>> -	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_MASK, 0);=0A=
>> -	out_le32(pdata->pci_vbase + MV64X60_PCI_ERROR_MASK,=0A=
>> -		 MV64X60_PCIx_ERR_MASK_VAL);=0A=
>> +	iowrite32(0, pdata->pci_vbase + MV64X60_PCI_ERROR_CAUSE);=0A=
>> +	iowrite32(0, pdata->pci_vbase + MV64X60_PCI_ERROR_MASK);=0A=
>> +	iowrite32(MV64X60_PCIx_ERR_MASK_VAL,=0A=
>> +		  pdata->pci_vbase + MV64X60_PCI_ERROR_MASK);=0A=
>>=0A=
>>  	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {=0A=
>>  		edac_dbg(3, "failed edac_pci_add_device()\n");=0A=
>> @@ -233,23 +233,23 @@ static void mv64x60_sram_check(struct edac_device_=
ctl_info *edac_dev)=0A=
>>  	struct mv64x60_sram_pdata *pdata =3D edac_dev->pvt_info;=0A=
>>  	u32 cause;=0A=
>>=0A=
>> -	cause =3D in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);=0A=
>> +	cause =3D ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);=0A=
>>  	if (!cause)=0A=
>>  		return;=0A=
>>=0A=
>>  	printk(KERN_ERR "Error in internal SRAM\n");=0A=
>>  	printk(KERN_ERR "Cause register: 0x%08x\n", cause);=0A=
>>  	printk(KERN_ERR "Address Low: 0x%08x\n",=0A=
>> -	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_LO));=0A=
>> +	       ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_LO));=0A=
>>  	printk(KERN_ERR "Address High: 0x%08x\n",=0A=
>> -	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_HI));=0A=
>> +	       ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_ADDR_HI));=0A=
>>  	printk(KERN_ERR "Data Low: 0x%08x\n",=0A=
>> -	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_LO));=0A=
>> +	       ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_LO));=0A=
>>  	printk(KERN_ERR "Data High: 0x%08x\n",=0A=
>> -	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_HI));=0A=
>> +	       ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_DATA_HI));=0A=
>>  	printk(KERN_ERR "Parity: 0x%08x\n",=0A=
>> -	       in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_PARITY));=0A=
>> -	out_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE, 0);=0A=
>> +	       ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_PARITY));=0A=
>> +	iowrite32(0, pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);=0A=
>>=0A=
>>  	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);=0A=
>>  }=0A=
>> @@ -260,7 +260,7 @@ static irqreturn_t mv64x60_sram_isr(int irq, void *d=
ev_id)=0A=
>>  	struct mv64x60_sram_pdata *pdata =3D edac_dev->pvt_info;=0A=
>>  	u32 cause;=0A=
>>=0A=
>> -	cause =3D in_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);=0A=
>> +	cause =3D ioread32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);=0A=
>>  	if (!cause)=0A=
>>  		return IRQ_NONE;=0A=
>>=0A=
>> @@ -322,7 +322,7 @@ static int mv64x60_sram_err_probe(struct platform_de=
vice *pdev)=0A=
>>  	}=0A=
>>=0A=
>>  	/* setup SRAM err registers */=0A=
>> -	out_le32(pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE, 0);=0A=
>> +	iowrite32(0, pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);=0A=
>>=0A=
>>  	edac_dev->mod_name =3D EDAC_MOD_STR;=0A=
>>  	edac_dev->ctl_name =3D pdata->name;=0A=
>> @@ -398,7 +398,7 @@ static void mv64x60_cpu_check(struct edac_device_ctl=
_info *edac_dev)=0A=
>>  	struct mv64x60_cpu_pdata *pdata =3D edac_dev->pvt_info;=0A=
>>  	u32 cause;=0A=
>>=0A=
>> -	cause =3D in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &=0A=
>> +	cause =3D ioread32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &=0A=
>>  	    MV64x60_CPU_CAUSE_MASK;=0A=
>>  	if (!cause)=0A=
>>  		return;=0A=
>> @@ -406,16 +406,16 @@ static void mv64x60_cpu_check(struct edac_device_c=
tl_info *edac_dev)=0A=
>>  	printk(KERN_ERR "Error on CPU interface\n");=0A=
>>  	printk(KERN_ERR "Cause register: 0x%08x\n", cause);=0A=
>>  	printk(KERN_ERR "Address Low: 0x%08x\n",=0A=
>> -	       in_le32(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_LO));=0A=
>> +	       ioread32(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_LO));=0A=
>>  	printk(KERN_ERR "Address High: 0x%08x\n",=0A=
>> -	       in_le32(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_HI));=0A=
>> +	       ioread32(pdata->cpu_vbase[0] + MV64x60_CPU_ERR_ADDR_HI));=0A=
>>  	printk(KERN_ERR "Data Low: 0x%08x\n",=0A=
>> -	       in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_LO));=0A=
>> +	       ioread32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_LO));=0A=
>>  	printk(KERN_ERR "Data High: 0x%08x\n",=0A=
>> -	       in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_HI));=0A=
>> +	       ioread32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_DATA_HI));=0A=
>>  	printk(KERN_ERR "Parity: 0x%08x\n",=0A=
>> -	       in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_PARITY));=0A=
>> -	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE, 0);=0A=
>> +	       ioread32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_PARITY));=0A=
>> +	iowrite32(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE);=0A=
>>=0A=
>>  	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);=0A=
>>  }=0A=
>> @@ -426,7 +426,7 @@ static irqreturn_t mv64x60_cpu_isr(int irq, void *de=
v_id)=0A=
>>  	struct mv64x60_cpu_pdata *pdata =3D edac_dev->pvt_info;=0A=
>>  	u32 cause;=0A=
>>=0A=
>> -	cause =3D in_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &=0A=
>> +	cause =3D ioread32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE) &=0A=
>>  	    MV64x60_CPU_CAUSE_MASK;=0A=
>>  	if (!cause)=0A=
>>  		return IRQ_NONE;=0A=
>> @@ -515,9 +515,9 @@ static int mv64x60_cpu_err_probe(struct platform_dev=
ice *pdev)=0A=
>>  	}=0A=
>>=0A=
>>  	/* setup CPU err registers */=0A=
>> -	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE, 0);=0A=
>> -	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK, 0);=0A=
>> -	out_le32(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK, 0x000000ff);=0A=
>> +	iowrite32(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE);=0A=
>> +	iowrite32(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK);=0A=
>> +	iowrite32(0x000000ff, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_MASK);=0A=
>>=0A=
>>  	edac_dev->mod_name =3D EDAC_MOD_STR;=0A=
>>  	edac_dev->ctl_name =3D pdata->name;=0A=
>> @@ -596,13 +596,13 @@ static void mv64x60_mc_check(struct mem_ctl_info *=
mci)=0A=
>>  	u32 comp_ecc;=0A=
>>  	u32 syndrome;=0A=
>>=0A=
>> -	reg =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);=0A=
>> +	reg =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);=0A=
>>  	if (!reg)=0A=
>>  		return;=0A=
>>=0A=
>>  	err_addr =3D reg & ~0x3;=0A=
>> -	sdram_ecc =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_RCVD);=
=0A=
>> -	comp_ecc =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CALC);=0A=
>> +	sdram_ecc =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_RCVD);=
=0A=
>> +	comp_ecc =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CALC);=
=0A=
>>  	syndrome =3D sdram_ecc ^ comp_ecc;=0A=
>>=0A=
>>  	/* first bit clear in ECC Err Reg, 1 bit error, correctable by HW */=
=0A=
>> @@ -620,7 +620,7 @@ static void mv64x60_mc_check(struct mem_ctl_info *mc=
i)=0A=
>>  				     mci->ctl_name, "");=0A=
>>=0A=
>>  	/* clear the error */=0A=
>> -	out_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR, 0);=0A=
>> +	iowrite32(0, pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);=0A=
>>  }=0A=
>>=0A=
>>  static irqreturn_t mv64x60_mc_isr(int irq, void *dev_id)=0A=
>> @@ -629,7 +629,7 @@ static irqreturn_t mv64x60_mc_isr(int irq, void *dev=
_id)=0A=
>>  	struct mv64x60_mc_pdata *pdata =3D mci->pvt_info;=0A=
>>  	u32 reg;=0A=
>>=0A=
>> -	reg =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);=0A=
>> +	reg =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);=0A=
>>  	if (!reg)=0A=
>>  		return IRQ_NONE;=0A=
>>=0A=
>> @@ -664,7 +664,7 @@ static void mv64x60_init_csrows(struct mem_ctl_info =
*mci,=0A=
>>=0A=
>>  	get_total_mem(pdata);=0A=
>>=0A=
>> -	ctl =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);=0A=
>> +	ctl =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);=0A=
>>=0A=
>>  	csrow =3D mci->csrows[0];=0A=
>>  	dimm =3D csrow->channels[0]->dimm;=0A=
>> @@ -753,7 +753,7 @@ static int mv64x60_mc_err_probe(struct platform_devi=
ce *pdev)=0A=
>>  		goto err;=0A=
>>  	}=0A=
>>=0A=
>> -	ctl =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);=0A=
>> +	ctl =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_CONFIG);=0A=
>>  	if (!(ctl & MV64X60_SDRAM_ECC)) {=0A=
>>  		/* Non-ECC RAM? */=0A=
>>  		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);=0A=
>> @@ -779,10 +779,10 @@ static int mv64x60_mc_err_probe(struct platform_de=
vice *pdev)=0A=
>>  	mv64x60_init_csrows(mci, pdata);=0A=
>>=0A=
>>  	/* setup MC registers */=0A=
>> -	out_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR, 0);=0A=
>> -	ctl =3D in_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL);=0A=
>> +	iowrite32(0, pdata->mc_vbase + MV64X60_SDRAM_ERR_ADDR);=0A=
>> +	ctl =3D ioread32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL);=0A=
>>  	ctl =3D (ctl & 0xff00ffff) | 0x10000;=0A=
>> -	out_le32(pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL, ctl);=0A=
>> +	iowrite32(ctl, pdata->mc_vbase + MV64X60_SDRAM_ERR_ECC_CNTL);=0A=
>>=0A=
>>  	res =3D edac_mc_add_mc(mci);=0A=
>>  	if (res) {=0A=
>> --=0A=
>> 2.11.0.24.ge6920cf=0A=
>>=0A=
>=0A=
=0A=
