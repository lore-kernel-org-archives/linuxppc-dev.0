Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6E97F1007D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 15:36:25 +1100 (EST)
Message-ID: <4F03D717.6030108@freescale.com>
Date: Wed, 4 Jan 2012 10:05:35 +0530
From: Prabhakar <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] mtd/nand:Fix wrong address read in is_blank()
References: <1325134779-3571-1-git-send-email-prabhakar@freescale.com>
 <1325134779-3571-2-git-send-email-prabhakar@freescale.com>
 <4F0363E2.6040702@freescale.com>
In-Reply-To: <4F0363E2.6040702@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 04 January 2012 01:54 AM, Scott Wood wrote:
> On 12/28/2011 10:59 PM, Prabhakar Kushwaha wrote:
>> IFC NAND Machine calculates ECC on 512byte sector. Same is taken care in
>> fsl_ifc_run_command() while ECC status verification. Here buffer number is
>> calculated assuming 512byte sector and same is passed to is_blank.
>> However in is_blank() buffer address is calculated using mdt->writesize which is
>> wrong. It should be calculated on basis of ecc sector size.
>>
>> Also, in fsl_ifc_run_command() bufferpage is calculated on the basis of ecc sector
>> size instead of hard coded value.
>>
>> Signed-off-by: Poonam Aggrwal<poonam.aggrwal@freescale.com>
>> Signed-off-by: Prabhakar Kushwaha<prabhakar@freescale.com>
>> ---
>>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)
>>
>>   Tested on P1010RDB
>>
>>   drivers/mtd/nand/fsl_ifc_nand.c |    6 ++++--
>>   1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
>> index 8475b88..2df7206 100644
>> --- a/drivers/mtd/nand/fsl_ifc_nand.c
>> +++ b/drivers/mtd/nand/fsl_ifc_nand.c
>> @@ -191,7 +191,9 @@ static int is_blank(struct mtd_info *mtd, unsigned int bufnum)
>>   {
>>   	struct nand_chip *chip = mtd->priv;
>>   	struct fsl_ifc_mtd *priv = chip->priv;
>> -	u8 __iomem *addr = priv->vbase + bufnum * (mtd->writesize * 2);
>> +	int bufperpage = mtd->writesize / chip->ecc.size;
>> +	u8 __iomem *addr = priv->vbase + bufnum / bufperpage
>> +					* (mtd->writesize * 2);
>>   	u32 __iomem *mainarea = (u32 *)addr;
>>   	u8 __iomem *oob = addr + mtd->writesize;
>>   	int i;
> This function should only be checking one ECC block, not the entire
> page.  The caller is responsible for passing in the appropriate buffer
> numbers.
>
> I think what the current code needs is for (mtd->writesize * 2) to be
> replaced with chip->ecc.size, and for the calling code to multiply the
> starting bufnum by two.

     Got your point :). I will take care in next patch version.


>> @@ -273,7 +275,7 @@ static void fsl_ifc_run_command(struct mtd_info *mtd)
>>   		dev_err(priv->dev, "NAND Flash Write Protect Error\n");
>>
>>   	if (nctrl->eccread) {
>> -		int bufperpage = mtd->writesize / 512;
>> +		int bufperpage = mtd->writesize / chip->ecc.size;
>>   		int bufnum = (nctrl->page&  priv->bufnum_mask) * bufperpage;
>>   		int bufnum_end = bufnum + bufperpage - 1;
>>
> Currently this driver always sets chip->ecc.size to 512.  If we want to
> support other ECC block sizes that future versions of IFC may have, can
> we calculate bufperpage during chip init (similar to bufnum_mask) to
> avoid the runtime division?  It's probably not huge overhead compared to
> everything else we do per NAND page transfer, but still...
>

   Yes. I agree.
    We are working on this in order to support new controller version.

--Prabhakar
