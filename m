Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:16:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE0E206E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0E206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cXYx10wrzDqSW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 01:16:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.198;
 helo=relay6-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cW3M3s9yzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 00:08:30 +1000 (AEST)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 788AFC0007;
 Wed,  3 Jun 2020 14:08:25 +0000 (UTC)
Date: Wed, 3 Jun 2020 16:08:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 08/10] mtd: rawnand: fsl_upm: Implement exec_op()
Message-ID: <20200603160824.3adae7b8@xps13>
In-Reply-To: <20200603134922.1352340-9-boris.brezillon@collabora.com>
References: <20200603134922.1352340-1-boris.brezillon@collabora.com>
 <20200603134922.1352340-9-boris.brezillon@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 Anton Vorontsov <anton@enomsg.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Boris Brezillon <boris.brezillon@collabora.com> wrote on Wed,  3 Jun
2020 15:49:20 +0200:

> Implement exec_op() so we can get rid of the legacy interface
> implementation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/mtd/nand/raw/fsl_upm.c | 86 ++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
> index 9a63e36825d8..03ca20930274 100644
> --- a/drivers/mtd/nand/raw/fsl_upm.c
> +++ b/drivers/mtd/nand/raw/fsl_upm.c
> @@ -194,6 +194,91 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
>  	return ret;
>  }
>  
> +static int func_exec_instr(struct nand_chip *chip,
> +			   const struct nand_op_instr *instr)
> +{
> +	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
> +	u32 mar, reg_offs = fun->mchip_offsets[fun->mchip_number];
> +	unsigned int i;
> +	const u8 *out;
> +	u8 *in;
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		fsl_upm_start_pattern(&fun->upm, fun->upm_cmd_offset);
> +		mar = (instr->ctx.cmd.opcode << (32 - fun->upm.width)) |
> +		      reg_offs;
> +		fsl_upm_run_pattern(&fun->upm, fun->io_base + reg_offs, mar);
> +		fsl_upm_end_pattern(&fun->upm);
> +		return 0;
> +
> +	case NAND_OP_ADDR_INSTR:
> +		fsl_upm_start_pattern(&fun->upm, fun->upm_addr_offset);
> +		for (i = 0; i < instr->ctx.addr.naddrs; i++) {
> +			mar = (instr->ctx.addr.addrs[i] << (32 - fun->upm.width)) |
> +			      reg_offs;
> +			fsl_upm_run_pattern(&fun->upm, fun->io_base + reg_offs, mar);
> +		}
> +		fsl_upm_end_pattern(&fun->upm);
> +		return 0;
> +
> +	case NAND_OP_DATA_IN_INSTR:
> +		in = instr->ctx.data.buf.in;
> +		for (i = 0; i < instr->ctx.data.len; i++)
> +			in[i] = in_8(fun->io_base + reg_offs);
> +		return 0;
> +
> +	case NAND_OP_DATA_OUT_INSTR:
> +		out = instr->ctx.data.buf.out;
> +		for (i = 0; i < instr->ctx.data.len; i++)
> +			out_8(fun->io_base + reg_offs, out[i]);
> +		return 0;
> +
> +	case NAND_OP_WAITRDY_INSTR:
> +		if (!fun->rnb_gpio[fun->mchip_number])
> +			return nand_soft_waitrdy(chip, instr->ctx.waitrdy.timeout_ms);
> +
> +		return nand_gpio_waitrdy(chip, fun->rnb_gpio[fun->mchip_number],
> +					 instr->ctx.waitrdy.timeout_ms);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fun_exec_op(struct nand_chip *chip, const struct nand_operation *op,
> +		       bool check_only)
> +{
> +	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
> +	unsigned int i;
> +	int ret;
> +
> +	if (op->cs > NAND_MAX_CHIPS)
> +		return -EINVAL;
> +
> +	if (check_only)
> +		return 0;
> +
> +	fun->mchip_number = op->cs;
> +
> +	for (i = 0; i < op->ninstrs; i++) {
> +		ret = func_exec_instr(chip, &op->instrs[i]);
> +		if (ret)
> +			return ret;
> +
> +		if (op->instrs[i].delay_ns)
> +			ndelay(op->instrs[i].delay_ns);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops fun_ops = {
> +	.exec_op = fun_exec_op,
> +};
> +
>  static int fun_probe(struct platform_device *ofdev)
>  {
>  	struct fsl_upm_nand *fun;
> @@ -271,6 +356,7 @@ static int fun_probe(struct platform_device *ofdev)
>  				  FSL_UPM_WAIT_WRITE_BYTE;
>  
>  	nand_controller_init(&fun->base);
> +	fun->base.ops = &fun_ops;
>  	fun->dev = &ofdev->dev;
>  	fun->last_ctrl = NAND_CLE;
>  


Looks fine!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

