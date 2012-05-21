Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 03035B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 16:31:58 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Anthony Foiani <tkil@scrye.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
Date: Mon, 21 May 2012 06:31:48 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ghave7n25.fsf@dworkin.scrye.com>
In-Reply-To: <ghave7n25.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>, Jeff Garzik <jeff@garzik.org>,
 ashish kalra <ashish.kalra@freescale.com>, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Anthony Foiani [mailto:tkil@scrye.com]
> Sent: Friday, May 18, 2012 1:08 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: ashish kalra; Li Yang-R58472; Jeff Garzik; Robert P.J.Day; Adrian
> Bunk
> Subject: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
>=20
>=20
> Greetings.
>=20
> I was occasionally running into problems at boot time on an MPC8315-based
> board (derived from the MPC831xRDB, apparently), using SATA to talk to an
> SSD.  My vendor suggested that I enable CONFIG_MPC8315_DS.
>=20
> That symbol is only found once in the entire kernel codebase:
>=20
>   $ git checkout v3.4-rc7
>   HEAD is now at 36be505... Linux 3.4-rc7
>=20
>   $ git grep -nH CONFIG_MPC8315_DS
>   drivers/ata/sata_fsl.c:729:#ifdef CONFIG_MPC8315_DS
>=20
> There is no kconfig support for it at all.
>=20
> It was added in 2007; further, this is the only commit in the entire git
> history that contains this string:
>=20
>    commit e7eac96e8f0e57a6e9f94943557bc2b23be31471
>    Author: ashish kalra <ashish.kalra@freescale.com>
>    Date:   Wed Oct 31 19:28:02 2007 +0800
>=20
>        ata/sata_fsl: Move MPC8315DS link speed limit workaround to
> specific ifdef
>=20
>        Signed-off-by: ashish kalra <ashish.kalra@freescale.com>
>        Signed-off-by: Li Yang <leoli@freescale.com>
>        Signed-off-by: Jeff Garzik <jeff@garzik.org>
>=20
>    diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>    index 5892472..e076e1f 100644
>    --- a/drivers/ata/sata_fsl.c
>    +++ b/drivers/ata/sata_fsl.c
>    @@ -652,6 +652,7 @@ static int sata_fsl_port_start(struct ata_port *ap=
)
>            VPRINTK("HControl =3D 0x%x\n", ioread32(hcr_base + HCONTROL));
>            VPRINTK("CHBA  =3D 0x%x\n", ioread32(hcr_base + CHBA));
>=20
>    +#ifdef CONFIG_MPC8315_DS
>            /*
>             * Workaround for 8315DS board 3gbps link-up issue,
>             * currently limit SATA port to GEN1 speed
>    @@ -664,6 +665,7 @@ static int sata_fsl_port_start(struct ata_port *ap=
)
>            sata_fsl_scr_read(ap, SCR_CONTROL, &temp);
>            dev_printk(KERN_WARNING, dev, "scr_control, speed limited
> to %x\n",
>                            temp);
>    +#endif
>=20
>            return 0;
>     }
>=20
> This otherwise-unsupported variable was noted by Robert Day in 2008;
> Adrian Bunk suggested a patch, but the Freescale folks said that it was
> for a not-yet-mainlined board, so the patch was dropped:
>=20
>    http://marc.info/?l=3Dlinux-ide&m=3D121783965216004&w=3D2
>=20
> As Robert notied again in 2010, it still wasn't mainlined:
>=20
>    http://marc.info/?l=3Dlinux-ide&m=3D121783965216004&w=3D2
>=20
> And, obviously, it still isn't today.
>=20
> Can the Freescale people tell us exactly what we should be testing to
> determine when to enforce this restriction?  A config variable that
> points to a non-existent board doesn't seem much help.

Thanks for bringing it up again.  Looks like we do have a problem here.

Btw, did it help with your problem by enabling it?

Leo
