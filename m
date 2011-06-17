Return-Path: <bryanhundven@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8259B6FD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 03:58:56 +1000 (EST)
Received: by pzk26 with SMTP id 26so2168180pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 10:58:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Fri, 17 Jun 2011 10:58:53 -0700
Message-ID: <BANLkTikoRk9OUrQGOFJZjMWOLLT5GXAEDQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: fix NAND_CMD_READID read bytes number
From: Bryan Hundven <bryanhundven@gmail.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 12, 2011 at 7:23 PM, Shaohui Xie <Shaohui.Xie@freescale.com> wr=
ote:
> when nand_get_flash_type() is called, it will read 8 bytes of ID instead =
of 5,
> but the driver only read 5 bytes, so kernel will dump error messages like=
:
>
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> =C2=A0drivers/mtd/nand/fsl_elbc_nand.c | =C2=A0 =C2=A06 +++---
> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc=
_nand.c
> index 0bb254c..33d8aad 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -339,9 +339,9 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, un=
signed int command,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(FIR_OP_UA =C2=A0<< FIR=
_OP1_SHIFT) |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(FIR_OP_RBW << FIR_OP2_=
SHIFT));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out_be32(&lbc->fcr=
, NAND_CMD_READID << FCR_CMD0_SHIFT);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 5 bytes for manuf, =
device and exts */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&lbc->fbcr, 5=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elbc_fcm_ctrl->read_by=
tes =3D 5;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* nand_get_flash_type=
() reads 8 bytes of entire ID string */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&lbc->fbcr, 8=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elbc_fcm_ctrl->read_by=
tes =3D 8;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elbc_fcm_ctrl->use=
_mdr =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elbc_fcm_ctrl->mdr=
 =3D 0;
>
> --
> 1.6.4
>
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>

Shaohui,

I have tested this on p1011rdb, p1020rdb, and p2020rdb on 2.6.35.13
and 2.6.39.1.
Thank you for fixing this :-)

-Bryan
