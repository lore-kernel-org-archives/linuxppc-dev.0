Return-Path: <knneth@gmail.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19DC71A0862
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 09:42:08 +1100 (AEDT)
Received: by wmww144 with SMTP id w144so42131742wmw.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Dec 2015 14:42:03 -0800 (PST)
MIME-Version: 1.0
Sender: knneth@gmail.com
In-Reply-To: <1449127157-9400-4-git-send-email-igal.liberman@freescale.com>
References: <1449127157-9400-1-git-send-email-igal.liberman@freescale.com>
 <1449127157-9400-4-git-send-email-igal.liberman@freescale.com>
Date: Thu, 3 Dec 2015 23:42:03 +0100
Message-ID: <CA++eYdvVe1qDhpZ8NGVnHeefBnpWMUyn4CFBu8g6TERAr-4B8Q@mail.gmail.com>
Subject: Re: [v9, 3/6] fsl/fman: Add FMan MAC support
From: Kenneth Klette Jonassen <kennetkl@ifi.uio.no>
To: igal.liberman@freescale.com
Cc: netdev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 scottwood@freescale.com, madalin.bucur@freescale.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, ppc@mindchasers.com,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Miller <davem@davemloft.net>,
 Kapil Juneja <Kapil.Juneja@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +/* PHY Control Register */
> +#define PHY_CR_PHY_RESET       0x8000
> +#define PHY_CR_SPEED0          0x2000
> +#define PHY_CR_ANE             0x1000
> +#define PHY_CR_RESET_AN                0x0200
> +#define PHY_CR_FULLDUPLEX      0x0100
> +#define PHY_CR_SPEED1          0x0040

Reuse defines in mii.h? BMCR_SPEED1000, BMCR_*, etc.

> +#define PHY_TBICON_SRESET      0x8000
> +#define PHY_TBICON_CLK_SEL     0x0020

This is similarly named TBICON_CLK_SELECT in freescale/gianfar.h.
Perhaps use the same names, and if possible, use a shared header file?

It would be nice to define all bits of the TBI registers, if only for
completeness. Maybe along with a succinct description, e.g., that
"sreset" means soft reset. (Or just call it TBICON_SOFT_RESET.)

> +/* MII Configuration Control Memory Map Registers */
> +struct dtsec_mii_regs {
> +/* dTSEC Memory Map registers */
> +struct dtsec_regs {
> +static int mii_write_reg(struct fman_mac *dtsec, u8 addr, u8 reg, u16 data)
> +static int mii_read_reg(struct fman_mac *dtsec, u8 addr, u8 reg, u16 *data)

Any chance this patch overlaps significantly with fsl_pq_mdio.c?

http://lxr.free-electrons.com/source/drivers/net/ethernet/freescale/fsl_pq_mdio.c?v=4.3#L44
fsl_pq_mdio_write(),
fsl_pq_mdio_read(),
etc.

> +       if (dtsec->phy_if == PHY_INTERFACE_MODE_SGMII) {
> +               u16 tmp_reg16;
> +
> +               /* Configure the TBI PHY Control Register */
> +               tmp_reg16 = PHY_TBICON_CLK_SEL | PHY_TBICON_SRESET;
> +               mii_write_reg(dtsec, (u8)dtsec_drv_param->tbipa, 17,
> +                             tmp_reg16);
> +
> +               tmp_reg16 = PHY_TBICON_CLK_SEL;
> +               mii_write_reg(dtsec, (u8)dtsec_drv_param->tbipa, 17,
> +                             tmp_reg16);
> +
> +               tmp_reg16 =
> +                   (PHY_CR_PHY_RESET | PHY_CR_ANE | PHY_CR_FULLDUPLEX |
> +                    PHY_CR_SPEED1);
> +               mii_write_reg(dtsec, (u8)dtsec_drv_param->tbipa, 0, tmp_reg16);
> +
> +               if (dtsec->basex_if)
> +                       tmp_reg16 = PHY_TBIANA_1000X;
> +               else
> +                       tmp_reg16 = PHY_TBIANA_SGMII;
> +               mii_write_reg(dtsec, (u8)dtsec_drv_param->tbipa, 4, tmp_reg16);
> +
> +               tmp_reg16 =
> +                   (PHY_CR_ANE | PHY_CR_RESET_AN | PHY_CR_FULLDUPLEX |
> +                    PHY_CR_SPEED1);
> +
> +               mii_write_reg(dtsec, (u8)dtsec_drv_param->tbipa, 0, tmp_reg16);
> +       }

Afaik, programming the TBI belongs in a separate PHY driver. See
drivers/net/phy/phy_device.c.

The same logic applies to gfar_configure_serdes() and uec_configure_serdes().

> +/* Internal PHY Registers - SGMII */
> +#define PHY_SGMII_CR_RESET_AN           0x0200
> +#define PHY_SGMII_CR_AN_ENABLE          0x1000

This namespace duplicates the intention of PHY_CR_*? (Which in turn
duplicated BMCR_*, ..)
