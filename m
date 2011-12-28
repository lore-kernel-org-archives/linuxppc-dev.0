Return-Path: <dpervushin@gmail.com>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C89C5B6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2011 00:30:36 +1100 (EST)
Received: by obcwm4 with SMTP id wm4so8348331obc.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 05:30:33 -0800 (PST)
Subject: Re: [PATCH 1/2][v2] Integrated Flash Controller support
From: dmitry pervushin <dpervushin@gmail.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
In-Reply-To: <1324987753-30318-1-git-send-email-prabhakar@freescale.com>
References: <1324987753-30318-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Dec 2011 17:30:52 +0400
Message-ID: <1325079052.12535.22.camel@mrki-medvjed.diimka.lan>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Dipen Dudhat <Dipen.Dudhat@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Liu Shuo <b35362@freescale.com>
Reply-To: dpervushin@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-12-27 at 17:39 +0530, Prabhakar Kushwaha wrote:
[...]
> +/*
> + * IFC Controller NAND Machine registers
> + */
> +struct fsl_ifc_nand {
> +	__be32 ncfgr;
> +	u32 res1[0x4];
> +	__be32 nand_fcr0;
> +	__be32 nand_fcr1;
> +	u32 res2[0x8];
> +	__be32 row0;
> +	u32 res3;
> +	__be32 col0;
> +	u32 res4;
> +	__be32 row1;
> +	u32 res5;
> +	__be32 col1;
> +	u32 res6;
> +	__be32 row2;
> +	u32 res7;
> +	__be32 col2;
> +	u32 res8;
> +	__be32 row3;
> +	u32 res9;
> +	__be32 col3;
> +	u32 res10[0x24];
> +	__be32 nand_fbcr;
> +	u32 res11;
> +	__be32 nand_fir0;
> +	__be32 nand_fir1;
> +	__be32 nand_fir2;
> +	u32 res12[0x10];
> +	__be32 nand_csel;
> +	u32 res13;
> +	__be32 nandseq_strt;
> +	u32 res14;
> +	__be32 nand_evter_stat;
> +	u32 res15;
> +	__be32 pgrdcmpl_evt_stat;
> +	u32 res16[0x2];
> +	__be32 nand_evter_en;
> +	u32 res17[0x2];
> +	__be32 nand_evter_intr_en;
> +	u32 res18[0x2];
> +	__be32 nand_erattr0;
> +	__be32 nand_erattr1;
> +	u32 res19[0x10];
> +	__be32 nand_fsr;
> +	u32 res20;
> +	__be32 nand_eccstat[4];
> +	u32 res21[0x20];
> +	__be32 nanndcr;
> +	u32 res22[0x2];
> +	__be32 nand_autoboot_trgr;
> +	u32 res23;
> +	__be32 nand_mdr;
> +	u32 res24[0x5C];
> +};
If you're using memory-mapped structure, shouldn't it be announced with
__attribute__(packed) ?
> +
> +/*
> + * IFC controller NOR Machine registers
> + */
> +struct fsl_ifc_nor {
> +	__be32 nor_evter_stat;
> +	u32 res1[0x2];
> +	__be32 nor_evter_en;
> +	u32 res2[0x2];
> +	__be32 nor_evter_intr_en;
> +	u32 res3[0x2];
> +	__be32 nor_erattr0;
> +	__be32 nor_erattr1;
> +	__be32 nor_erattr2;
> +	u32 res4[0x4];
> +	__be32 norcr;
> +	u32 res5[0xEF];
> +};
> +
> +/*
> + * IFC controller GPCM Machine registers
> + */
> +struct fsl_ifc_gpcm {
> +	__be32 gpcm_evter_stat;
> +	u32 res1[0x2];
> +	__be32 gpcm_evter_en;
> +	u32 res2[0x2];
> +	__be32 gpcm_evter_intr_en;
> +	u32 res3[0x2];
> +	__be32 gpcm_erattr0;
> +	__be32 gpcm_erattr1;
> +	__be32 gpcm_erattr2;
> +	__be32 gpcm_stat;
> +	u32 res4[0x1F3];
> +};
...here too...
> +
> +/*
> + * IFC Controller Registers
> + */
> +struct fsl_ifc_regs {
> +	__be32 ifc_rev;
> +	u32 res1[0x3];
> +	struct {
> +		__be32 cspr;
> +		u32 res2[0x2];
> +	} cspr_cs[FSL_IFC_BANK_COUNT];
> +	u32 res3[0x18];
> +	struct {
> +		__be32 amask;
> +		u32 res4[0x2];
> +	} amask_cs[FSL_IFC_BANK_COUNT];
> +	u32 res5[0x18];
> +	struct {
> +		__be32 csor;
> +		u32 res6[0x2];
> +	} csor_cs[FSL_IFC_BANK_COUNT];
> +	u32 res7[0x18];
> +	struct {
> +		__be32 ftim[4];
> +		u32 res8[0x8];
> +	} ftim_cs[FSL_IFC_BANK_COUNT];
> +	u32 res9[0x60];
> +	__be32 rb_stat;
> +	u32 res10[0x2];
> +	__be32 ifc_gcr;
> +	u32 res11[0x2];
> +	__be32 cm_evter_stat;
> +	u32 res12[0x2];
> +	__be32 cm_evter_en;
> +	u32 res13[0x2];
> +	__be32 cm_evter_intr_en;
> +	u32 res14[0x2];
> +	__be32 cm_erattr0;
> +	__be32 cm_erattr1;
> +	u32 res15[0x2];
> +	__be32 ifc_ccr;
> +	__be32 ifc_csr;
> +	u32 res16[0x2EB];
> +	struct fsl_ifc_nand ifc_nand;
> +	struct fsl_ifc_nor ifc_nor;
> +	struct fsl_ifc_gpcm ifc_gpcm;
> +};
...and here.
> +
> +extern unsigned int convert_ifc_address(phys_addr_t addr_base);
> +extern int fsl_ifc_find(phys_addr_t addr_base);
> +
> +/* overview of the fsl ifc controller */
> +
> +struct fsl_ifc_ctrl {
> +	/* device info */
> +	struct device			*dev;
> +	struct fsl_ifc_regs __iomem	*regs;
> +	int				irq;
> +	int				nand_irq;
> +	spinlock_t			lock;
> +	void				*nand;
> +
> +	u32 nand_stat;
> +	wait_queue_head_t nand_wait;
> +};
> +
> +extern struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
> +
> +
> +#endif /* __ASM_FSL_IFC_H */
