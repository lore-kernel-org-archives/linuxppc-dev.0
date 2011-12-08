Return-Path: <B35362@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E2A691007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 21:41:07 +1100 (EST)
Message-ID: <4EE09526.5040705@freescale.com>
Date: Thu, 8 Dec 2011 18:44:54 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <4EDEE3AC.7060000@freescale.com>
 <4EDFBA6D.9080500@freescale.com>
In-Reply-To: <4EDFBA6D.9080500@freescale.com>
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

=E4=BA=8E 2011=E5=B9=B412=E6=9C=8808=E6=97=A5 03:11, Scott Wood =E5=86=99=
=E9=81=93:
> On 12/06/2011 09:55 PM, LiuShuo wrote:
>> =E4=BA=8E 2011=E5=B9=B412=E6=9C=8807=E6=97=A5 08:09, Scott Wood =E5=86=
=99=E9=81=93:
>>> On 12/03/2011 10:31 PM, shuo.liu@freescale.com wrote:
>>>> From: Liu Shuo<shuo.liu@freescale.com>
>>>>
>>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In
>>>> order
>>>> to support the Nand flash chip whose page size is larger than 2K byt=
es,
>>>> we read/write 2k data repeatedly by issuing FIR_OP_RB/FIR_OP_WB and =
save
>>>> them to a large buffer.
>>>>
>>>> Signed-off-by: Liu Shuo<shuo.liu@freescale.com>
>>>> ---
>>>> v3:
>>>>       -remove page_size of struct fsl_elbc_mtd.
>>>>       -do a oob write by NAND_CMD_RNDIN.
>>>>
>>>>    drivers/mtd/nand/fsl_elbc_nand.c |  243
>>>> ++++++++++++++++++++++++++++++++++----
>>>>    1 files changed, 218 insertions(+), 25 deletions(-)
>>> What is the plan for bad block marker migration?
>> This patch has been ported to uboot now, I think we can make a special
>> uboot image for bad
>> block marker migration when first use the chip.
> It should not be a special image, and there should be some way to mark
> that the migration has happened.  Even if we do the migration in U-Boot=
,
> Linux could check for the marker and if absent, disallow access and tel=
l
> the user to run the migration tool.
>
>>>> @@ -473,13 +568,72 @@ static void fsl_elbc_cmdfunc(struct mtd_info
>>>> *mtd, unsigned int command,
>>>>             * write so the HW generates the ECC.
>>>>             */
>>>>            if (elbc_fcm_ctrl->oob || elbc_fcm_ctrl->column !=3D 0 ||
>>>> -            elbc_fcm_ctrl->index !=3D mtd->writesize + mtd->oobsize=
)
>>>> -            out_be32(&lbc->fbcr,
>>>> -                elbc_fcm_ctrl->index - elbc_fcm_ctrl->column);
>>>> -        else
>>>> +            elbc_fcm_ctrl->index !=3D mtd->writesize + mtd->oobsize=
) {
>>>> +            if (elbc_fcm_ctrl->oob&&   mtd->writesize>   2048) {
>>>> +                out_be32(&lbc->fbcr, 64);
>>>> +            } else {
>>>> +                out_be32(&lbc->fbcr, elbc_fcm_ctrl->index
>>>> +                        - elbc_fcm_ctrl->column);
>>>> +            }
>>> We need to limit ourselves to the regions that have actually been
>>> written to in the buffer.  fbcr needs to be set separately for first =
and
>>> last subpages, with intermediate subpages having 0, 64, or 2112 as
>>> appropriate.  Subpages that are entirely before column or entirely af=
ter
>>> column + index should be skipped.
>> I have considered this case, but I don't think it is useful.
>>      1.There isn't a 'length' parameter in driver interface, although =
we
>> can get it from 'index - column'.
> Right.  column is start, and index is end + 1.  We have the bounds of
> what has been written.
>
>>      2.To see nand_do_write_oob() in nand_base.c, it fill '0xff' to
>> entire oob area first and write the user data by nand_fill_oob(), then
>> call ecc.write_oob (default is nand_write_oob_std()).
> Do we really want to assume that that's what it will always do?
>
> And if we do want to make such assumptions, we could rip out all usage
> of index/column here, and just handle "oob" and "full page" cases.
The function nand_do_write_ops() in nandbase.c is a Nand internal interfa=
ce.
It always is called when application write to nand flash. (e.g. dd)
In this function, partial page write is dealt with by filling '0xff' to=20
buffer before data copy.
(nand_do_write_oob() is similar)
So I don't think we need to do it in our controller driver again, it=20
should be a job of upper layer.


I found that 'column' for NAND_CMD_SEQIN is always 0 or writesize except=20
for oob write with
  NAND_ECC_HW_SYNDROME, but it's not useful case for our controller.

-LiuShuo
> -Scott
