Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0613667A45
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 09:00:38 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add 85xx CDS to arch/powerpc
Date: Mon, 3 Apr 2006 01:00:26 +0200
References: <Pine.LNX.4.61.0604021737010.9886@ld0175-tx32.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0604021737010.9886@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Message-Id: <200604030100.27013.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 April 2006 00:42, Andy Fleming wrote:
> +void __init mpc85xx_cds_pic_init(void)
> +{
> +	struct mpic *mpic1;
> +	phys_addr_t OpenPIC_PAddr;
> +
> +	/* Determine the Physical Address of the OpenPIC regs */
> +	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
> +
> +	mpic1 = mpic_alloc(OpenPIC_PAddr,
> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
> +			mpc85xx_cds_openpic_initsenses,
> +			sizeof(mpc85xx_cds_openpic_initsenses), " OpenPIC  ");
> +	BUG_ON(mpic1 == NULL);
> +	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
> +	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
> +	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10300);
> +	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10380);
> +	mpic_assign_isu(mpic1, 4, OpenPIC_PAddr + 0x10400);
> +	mpic_assign_isu(mpic1, 5, OpenPIC_PAddr + 0x10480);
> +	mpic_assign_isu(mpic1, 6, OpenPIC_PAddr + 0x10500);
> +	mpic_assign_isu(mpic1, 7, OpenPIC_PAddr + 0x10580);
> +
> +	/* dummy mappings to get to 48 */
> +	mpic_assign_isu(mpic1, 8, OpenPIC_PAddr + 0x10600);
> +	mpic_assign_isu(mpic1, 9, OpenPIC_PAddr + 0x10680);
> +	mpic_assign_isu(mpic1, 10, OpenPIC_PAddr + 0x10700);
> +	mpic_assign_isu(mpic1, 11, OpenPIC_PAddr + 0x10780);
> +
> +	/* External ints */
> +	mpic_assign_isu(mpic1, 12, OpenPIC_PAddr + 0x10000);
> +	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
> +	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);

Shouldn't all this come from the device tree?

> +/* CADMUS info */
> +#define CADMUS_BASE (0xf8004000)
> +#define CADMUS_SIZE (256)
> +#define CM_VER	(0)
> +#define CM_CSR	(1)
> +#define CM_RST	(2)
> +
> +/* CDS NVRAM/RTC */
> +#define CDS_RTC_ADDR	(0xf8000000)
> +#define CDS_RTC_SIZE	(8 * 1024)
> +
> +/* PCI interrupt controller */
> +#define PIRQ0A			MPC85xx_IRQ_EXT0
> +#define PIRQ0B			MPC85xx_IRQ_EXT1
> +#define PIRQ0C			MPC85xx_IRQ_EXT2
> +#define PIRQ0D			MPC85xx_IRQ_EXT3
> +#define PIRQ1A			MPC85xx_IRQ_EXT11

And these as well, more importantly?

	Arnd <><
