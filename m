Return-Path: <B35362@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5B8B41007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 23:10:53 +1100 (EST)
Message-ID: <4ECCE393.2030600@freescale.com>
Date: Wed, 23 Nov 2011 20:14:11 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
 <1321349355-1639-2-git-send-email-b35362@freescale.com>
 <1321349355-1639-3-git-send-email-b35362@freescale.com>
 <4ECC368C.3010801@freescale.com>
In-Reply-To: <4ECC368C.3010801@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Liu Shuo <Shuo.Liu@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B411=E6=9C=8823=E6=97=A5 07:55, Scott Wood =E5=86=99=
=E9=81=93:
> On 11/15/2011 03:29 AM, b35362@freescale.com wrote:
>> From: Liu Shuo<b35362@freescale.com>
>>
>> Freescale FCM controller has a 2K size limitation of buffer RAM. In or=
der
>> to support the Nand flash chip whose page size is larger than 2K bytes=
,
>> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and sa=
ve
>> them to a large buffer.
>>
>> Signed-off-by: Liu Shuo<Shuo.Liu@freescale.com>
>> Signed-off-by: Shengzhou Liu<Shengzhou.Liu@freescale.com>
>> Signed-off-by: Li Yang<leoli@freescale.com>
>> ---
>>   drivers/mtd/nand/fsl_elbc_nand.c |  216 ++++++++++++++++++++++++++++=
+++++++---
>>   1 files changed, 199 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_e=
lbc_nand.c
>> index c2c231b..415f87e 100644
>> --- a/drivers/mtd/nand/fsl_elbc_nand.c
>> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
>> @@ -55,7 +55,9 @@ struct fsl_elbc_mtd {
>>   	struct device *dev;
>>   	int bank;               /* Chip select bank number           */
>>   	u8 __iomem *vbase;      /* Chip select base virtual address  */
>> -	int page_size;          /* NAND page size (0=3D512, 1=3D2048)    */
>> +	int page_size;          /* NAND page size (0=3D512, 1=3D2048, 2=3D40=
96...),
>> +				 * the mutiple of 2048.
>> +				 */
> That "..." isn't very descriptive.  What happens with 8192-byte pages?
> Is it 3 or 4?
>
> Please just get rid of this and use mtd->writesize.
>
>> +		for (i =3D 1; i<  priv->page_size; i++) {
>> +			/*
>> +			 * Maybe there are some reasons of FCM hardware timming,
>> +			 * we must insert a FIR_OP_NOP(0x00) before FIR_OP_RB.
>> +			 */
> s/timming/timing/
>
>>   	/* PAGEPROG reuses all of the setup from SEQIN and adds the length =
*/
>>   	case NAND_CMD_PAGEPROG: {
>> +		int len;
>>   		dev_vdbg(priv->dev,
>>   			 "fsl_elbc_cmdfunc: NAND_CMD_PAGEPROG "
>>   			 "writing %d bytes.\n", elbc_fcm_ctrl->index);
>> -
>>   		/* if the write did not start at 0 or is not a full page
>>   		 * then set the exact length, otherwise use a full page
>>   		 * write so the HW generates the ECC.
>>   		 */
>> -		if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column !=3D 0 ||
>> +		if (elbc_fcm_ctrl->column>=3D mtd->writesize) {
>> +			/* write oob */
>> +			if (priv->page_size>  1) {
>> +				/* when pagesize of chip is greater than 2048,
>> +				 * we have to write full page to write spare
>> +				 * region, so we fill '0xff' to main region
>> +				 * and some bytes of spare region which we
>> +				 * don't want to rewrite.
>> +				 * (write '1' won't change the original value)
>> +				 */
>> +				memset(elbc_fcm_ctrl->buffer, 0xff,
>> +						elbc_fcm_ctrl->column);
> I don't like relying on this -- can we use RNDIN instead to do a
> discontiguous write?
>
I have no better way to implement it now.
Some chips have 'NOP' limitation, so I don't use the FIR_OP_UA to do a=20
oob write.
>> +				len =3D 2112;
> len =3D min(elbc_fcm_ctrl->index, 2112);
when do a oob write (writesize > 2048), elbc_fcm_ctrl->index is greater=20
writesize
(is 4096 at least).
>> +			} else
>> +				len =3D mtd->writesize + mtd->oobsize -
>> +					elbc_fcm_ctrl->column;
>> +			out_be32(&lbc->fbcr, len);
> len =3D elbc_fcm_ctrl->index - elbc_fcm_ctrl->column;
>
> Use braces on both sides of the if/else if it's needed on one side.
>> +		} else if (elbc_fcm_ctrl->column !=3D 0 ||
>>   		    elbc_fcm_ctrl->index !=3D mtd->writesize + mtd->oobsize)
>>   			out_be32(&lbc->fbcr, elbc_fcm_ctrl->index);
> This should have set fbcr to index - column as well (after adjusting --
> though really it's not a supported use case.  We should only be seeing
> column !=3D 0 for oob.
>
I have make a independent to fix this issue.
(In fact,documentation says FCM will stop automatically after
reading the last byte of spare region)
>> @@ -625,10 +776,16 @@ static int fsl_elbc_verify_buf(struct mtd_info *=
mtd, const u_char *buf, int len)
>>   		return -EINVAL;
>>   	}
>>
>> -	for (i =3D 0; i<  len; i++)
>> -		if (in_8(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index + i])
>> -				!=3D buf[i])
>> -			break;
>> +	if (mtd->writesize>  2048)
>> +		for (i =3D 0; i<  len; i++)
>> +			if (elbc_fcm_ctrl->buffer[elbc_fcm_ctrl->index + i]
>> +					!=3D buf[i])
>> +				break;
>> +	else
>> +		for (i =3D 0; i<  len; i++)
>> +			if (in_8(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index + i])
>> +					!=3D buf[i])
>> +				break;
> Please use braces around multiline if/for bodies, even if they're
> technically a single statement -- especially when you've got a dangling
> else.
>
>>   	elbc_fcm_ctrl->index +=3D len;
>>   	return i =3D=3D len&&  elbc_fcm_ctrl->status =3D=3D LTESR_CC ? 0 : =
-EIO;
>> @@ -657,6 +814,7 @@ static int fsl_elbc_chip_init_tail(struct mtd_info=
 *mtd)
>>   	struct fsl_elbc_mtd *priv =3D chip->priv;
>>   	struct fsl_lbc_ctrl *ctrl =3D priv->ctrl;
>>   	struct fsl_lbc_regs __iomem *lbc =3D ctrl->regs;
>> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl =3D ctrl->nand;
>>   	unsigned int al;
>>
>>   	/* calculate FMR Address Length field */
>> @@ -707,12 +865,17 @@ static int fsl_elbc_chip_init_tail(struct mtd_in=
fo *mtd)
>>   	dev_dbg(priv->dev, "fsl_elbc_init: mtd->oobsize =3D %d\n",
>>   		mtd->oobsize);
>>
>> +	kfree(elbc_fcm_ctrl->buffer);
>> +	elbc_fcm_ctrl->buffer =3D NULL;
>> +
>>   	/* adjust Option Register and ECC to match Flash page size */
>>   	if (mtd->writesize =3D=3D 512) {
>>   		priv->page_size =3D 0;
>>   		clrbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
>> -	} else if (mtd->writesize =3D=3D 2048) {
>> -		priv->page_size =3D 1;
>> +	} else if (mtd->writesize>=3D 2048) {
>> +		/* page_size =3D writesize / 2048 */
>> +		priv->page_size =3D mtd->writesize>>  11;
> Why not just write priv->page_size =3D mtd->writesize / 2048 in the cod=
e
> rather than the comment (it compiles to the same code)?  Other than
> because you were requested to remove priv->page_size, that is. :-)
>
>>   		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
>>   		/* adjust ecc setup if needed */
>>   		if ((in_be32(&lbc->bank[priv->bank].br)&  BR_DECC) =3D=3D
>> @@ -723,6 +886,14 @@ static int fsl_elbc_chip_init_tail(struct mtd_inf=
o *mtd)
>>   					&fsl_elbc_oob_lp_eccm0;
>>   			chip->badblock_pattern =3D&largepage_memorybased;
>>   		}
>> +
>> +		/* re-malloc if pagesize>  2048*/
>> +		if (mtd->writesize>  2048) {
>> +			elbc_fcm_ctrl->buffer =3D kmalloc(mtd->writesize +
>> +						    mtd->oobsize, GFP_KERNEL);
>> +			if (!elbc_fcm_ctrl->buffer)
>> +				return -ENOMEM;
>> +		}
>>   	} else {
>>   		dev_err(priv->dev,
>>   			"fsl_elbc_init: page size %d is not supported\n",
> buffer is a controller-wide resource, but you're setting it based on th=
e
> most-recently-probed NAND chip.  It should be large enough to
> accommodate the largest page size in use on any connected chip.  Even i=
f
> all chips in the system have the same page size, you're introducing a
> race if a previously-probed chip is already in use (the controller lock
> is not held here).
>
> Just allocate a buffer large enough for a 16K page size in the main ini=
t
> function, and print an error in the tail if you encounter a larger page
> size.
>
>> @@ -886,6 +1057,17 @@ static int __devinit fsl_elbc_nand_probe(struct =
platform_device *pdev)
>>   			goto err;
>>   		}
>>   		elbc_fcm_ctrl->counter++;
>> +		/*
>> +		 * Freescale FCM controller has a 2K size limitation of buffer
>> +		 * RAM, so elbc_fcm_ctrl->buffer have to be used if writesize
>> +		 * of chip is greater than 2048.
>> +		 * We malloc a large enough buffer at this point, because we
>> +		 * don't know writesize before calling nand_scan(). We will
>> +		 * re-malloc later if needed.
>> +		 */
>> +		elbc_fcm_ctrl->buffer =3D kmalloc(4096 * 6, GFP_KERNEL);
>> +		if (!elbc_fcm_ctrl->buffer)
>> +			return -ENOMEM;
> Clean up properly if you fail to allocate the buffer.  This includes
> freeing elbc_fcm_ctrl, setting fsl_lbc_ctrl_dev->nand to NULL, and
> releasing fsl_elbc_nand_mutex.
> -Scott
- LiuShuo
