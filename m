Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB671DE0B6
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 06:04:33 +1000 (EST)
Message-ID: <486BDF26.2030006@freescale.com>
Date: Wed, 02 Jul 2008 15:03:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Kernel marking NAND blocks bad
References: <972393.72007.qm@web83508.mail.sp1.yahoo.com>
In-Reply-To: <972393.72007.qm@web83508.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> /* Large Page FLASH with FMR[ECCM] = 0 */
> static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
> 	.eccbytes = 12,
> 	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
> -	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
> +	.oobfree = { {2, 4}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
> 	.oobavail = 48,
> };
> 
> /* Large Page FLASH with FMR[ECCM] = 1 */
> static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
> 	.eccbytes = 12,
> 	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
> -	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
> +	.oobfree = { {2, 6}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
> 	.oobavail = 48,
> };

Anton's recent patchset (posted to the MTD list) should fix this.

-scott
