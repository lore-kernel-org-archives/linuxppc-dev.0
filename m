Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0CD87B7047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 02:31:49 +1100 (EST)
Received: by wgbdt12 with SMTP id dt12so8408419wgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 07:31:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1324385081-30824-1-git-send-email-vhtnguyen@apm.com>
References: <1324385081-30824-1-git-send-email-vhtnguyen@apm.com>
Date: Tue, 20 Dec 2011 10:31:44 -0500
Message-ID: <CA+5PVA41Haf-_H3UoR1O3VFbC3XtgScyo5hekNjt0VWxunL-fg@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc/44x: Add support PCI-E for APM821xx SoC and
 Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ayman El-Khashab <ayman@elkhashab.com>,
 Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Rob Herring <rob.herring@calxeda.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2011 at 7:44 AM, Vinh Nguyen Huu Tuong
<vhtnguyen@apm.com> wrote:
> This patch extends PCI-E driver to support PCI-E for APM821xx SoC on Blue=
stone board.
>
> Signed-off-by: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>

> +static int apm821xx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 u32 utlset1;
> + =A0 =A0 =A0 u32 timeout;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Do a software reset on PCIe ports.
> + =A0 =A0 =A0 =A0* This code is to fix the issue that pci drivers doesn't=
 re-assign
> + =A0 =A0 =A0 =A0* bus number for PCIE devices after Uboot
> + =A0 =A0 =A0 =A0* scanned and configured all the buses (eg. PCIE NIC Int=
elPro/1000
> + =A0 =A0 =A0 =A0* PT quad port, SAS LSI 1064E)
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST + (port->index * 0x55=
), 0x0);
> + =A0 =A0 =A0 mdelay(10);
> +
> + =A0 =A0 =A0 if (port->endpoint)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D PTYPE_LEGACY_ENDPOINT << 20;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D PTYPE_ROOT_PORT << 20;
> +
> + =A0 =A0 =A0 if (port->index =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D LNKW_X1 << 12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 utlset1 =3D 0x00000000;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D LNKW_X4 << 12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 utlset1 =3D 0x20101101;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_DLPSET, val);
> + =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET1, utlset1);
> + =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_UTLSET2, 0x01010000);
> +
> + =A0 =A0 =A0 switch (port->index) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR0_460EX_L0CDRCTL, 0x00003=
230);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR0_460EX_L0DRV, 0x00000130=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR0_460EX_L0CLK, 0x00000006=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST, 0x10=
000000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(50);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST, 0x30=
000000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L0CDRCTL, 0x00003=
230);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L1CDRCTL, 0x00003=
230);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L2CDRCTL, 0x00003=
230);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L3CDRCTL, 0x00003=
230);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L0DRV, 0x00000130=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L1DRV, 0x00000130=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L2DRV, 0x00000130=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L3DRV, 0x00000130=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L0CLK, 0x00000006=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L1CLK, 0x00000006=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L2CLK, 0x00000006=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_L3CLK, 0x00000006=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, PESDR1_460EX_PHY_CTL_RST, 0x10=
000000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }

Do we need a default case here to catch oddness and exit the function?

> +
> + =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET=
) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (PESDRx_RCSSET_RSTGU | PESDRx_RCSSET_RSTPYN=
));
> +
> + =A0 =A0 =A0 /* Poll for PHY reset */
> + =A0 =A0 =A0 timeout =3D 0;
> + =A0 =A0 =A0 while ((!(mfdcri(SDR0, PESDR0_460EX_RSTSTA +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (port->index * 0x55)) & 0x1=
)) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(timeout < PCIE_PHY_RESET_TIMEOUT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (timeout < PCIE_PHY_RESET_TIMEOUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mfdcri(SDR0, port->sdr_bas=
e + PESDRn_RCSSET) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(PESDRx_RCSSET_RSTGU | PES=
DRx_RCSSET_RSTDL)) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PESDRx_RCSSET_RSTPYN);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->has_ibpre =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "PCIE: Can't reset PHY\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }

If we can't reset the PHY, does this whole function essentially fail?
Do the devices not get renumbered, etc?  If so, you probably want to
make that KERN_ERR.

> @@ -1751,9 +1856,9 @@ static void __init ppc4xx_configure_pciex_PIMs(stru=
ct ppc4xx_pciex_port *port,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * if it works
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM0LAL, 0x00000000=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM0LAH, 0x00000000)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM0LAH, 0x00000008)=
; /* Moving on HB */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM1LAL, 0x00000000=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM1LAH, 0x00000000)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM1LAH, 0x0000000c)=
; /* Moving on HB */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM01SAH, 0xffff000=
0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM01SAL, 0x0000000=
0);

Why are these values changed, and are those changes only needed on APM821xx=
?

> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/sysdev/ppc4x=
x_pci.h
> index 32ce763..faf3017 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.h
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.h
> @@ -441,6 +441,7 @@
> =A0/*
> =A0* Config space register offsets
> =A0*/
> +#define PECFG_ECDEVCTL =A0 =A0 =A0 =A0 0x060
> =A0#define PECFG_ECRTCTL =A0 =A0 =A0 =A0 =A00x074
>
> =A0#define PECFG_BAR0LMPA =A0 =A0 =A0 =A0 0x210
> @@ -448,6 +449,7 @@
> =A0#define PECFG_BAR1MPA =A0 =A0 =A0 =A0 =A00x218
> =A0#define PECFG_BAR2LMPA =A0 =A0 =A0 =A0 0x220
> =A0#define PECFG_BAR2HMPA =A0 =A0 =A0 =A0 0x224
> +#define PECFG_ECDEVCAPPA =A0 =A0 =A0 0x25c
>
> =A0#define PECFG_PIMEN =A0 =A0 =A0 =A0 =A0 =A00x33c
> =A0#define PECFG_PIM0LAL =A0 =A0 =A0 =A0 =A00x340
> @@ -494,5 +496,7 @@ enum
> =A0 =A0 =A0 =A0LNKW_X8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x8
> =A0};
>
> +/* Timout for reset phy */
> +#define PCIE_PHY_RESET_TIMEOUT 10

Is this value applicable to all the 44x devices with PCI-e?

josh
