Return-Path: <B35362@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BDA0E100802
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 14:51:31 +1100 (EST)
Message-ID: <4EDEE3AC.7060000@freescale.com>
Date: Wed, 7 Dec 2011 11:55:24 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com>
In-Reply-To: <4EDEAEB9.6020703@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B412=E6=9C=8807=E6=97=A5 08:09, Scott Wood =E5=86=99=
=E9=81=93:
> On 12/03/2011 10:31 PM, shuo.liu@freescale.com wrote:
>> From: Liu Shuo<shuo.liu@freescale.com>
>>
>> Freescale FCM controller has a 2K size limitation of buffer RAM. In or=
der
>> to support the Nand flash chip whose page size is larger than 2K bytes=
,
>> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and sa=
ve
>> them to a large buffer.
>>
>> Signed-off-by: Liu Shuo<shuo.liu@freescale.com>
>> ---
>> v3:
>>      -remove page_size of struct fsl_elbc_mtd.
>>      -do a oob write by NAND_CMD_RNDIN.
>>
>>   drivers/mtd/nand/fsl_elbc_nand.c |  243 ++++++++++++++++++++++++++++=
++++++----
>>   1 files changed, 218 insertions(+), 25 deletions(-)
> What is the plan for bad block marker migration?
This patch has been ported to uboot now, I think we can make a special=20
uboot image for bad
block marker migration when first use the chip.

>> @@ -473,13 +568,72 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mt=
d, unsigned int command,
>>   		 * write so the HW generates the ECC.
>>   		 */
>>   		if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column !=3D 0 ||
>> -		    elbc_fcm_ctrl->index !=3D mtd->writesize + mtd->oobsize)
>> -			out_be32(&lbc->fbcr,
>> -				elbc_fcm_ctrl->index - elbc_fcm_ctrl->column);
>> -		else
>> +		    elbc_fcm_ctrl->index !=3D mtd->writesize + mtd->oobsize) {
>> +			if (elbc_fcm_ctrl->oob&&  mtd->writesize>  2048) {
>> +				out_be32(&lbc->fbcr, 64);
>> +			} else {
>> +				out_be32(&lbc->fbcr, elbc_fcm_ctrl->index
>> +						- elbc_fcm_ctrl->column);
>> +			}
> We need to limit ourselves to the regions that have actually been
> written to in the buffer.  fbcr needs to be set separately for first an=
d
> last subpages, with intermediate subpages having 0, 64, or 2112 as
> appropriate.  Subpages that are entirely before column or entirely afte=
r
> column + index should be skipped.

I have considered this case, but I don't think it is useful.
     1.There isn't a 'length' parameter in driver interface, although we=20
can get it from 'index - column'.
     2.To see nand_do_write_oob() in nand_base.c, it fill '0xff' to=20
entire oob area first and write the user data by nand_fill_oob(), then=20
call ecc.write_oob (default is nand_write_oob_std()). 'column' is=20
mtd->writesize and 'length' of write_buf() is mtd->oobsize. So I don't=20
think we need to deal with it there.

>> +		} else {
>> +			out_be32(&lbc->fir, FIR_OP_WB<<  FIR_OP1_SHIFT);
>> +			for (i =3D 1; i<  n; i++) {
>> +				if (i =3D=3D n - 1) {
>> +					elbc_fcm_ctrl->use_mdr =3D 1;
>> +					out_be32(&lbc->fir,
>> +						(FIR_OP_WB<<  FIR_OP1_SHIFT) |
>> +						(FIR_OP_CM3<<  FIR_OP2_SHIFT) |
>> +						(FIR_OP_CW1<<  FIR_OP3_SHIFT) |
>> +						(FIR_OP_RS<<  FIR_OP4_SHIFT));
> Please explicitly show the (FIR_OP_NOP<<  FIR_OP0_SHIFT) compenent.
>
>> +	} else if (mtd->writesize>=3D 2048&&  mtd->writesize<=3D 16 * 1024) =
{
>> +
>>   		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
> Don't insert a blank line here.
>
Ok.

-LiuShuo
> -Scott
