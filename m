Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D31214007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 10:47:43 +1000 (EST)
Message-ID: <1397004452.32034.330.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 3/3] powerpc/mpc85xx: add support for Keymile's
 kmcoge4 board
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Tue, 8 Apr 2014 19:47:32 -0500
In-Reply-To: <1395754915-14534-4-git-send-email-valentin.longchamp@keymile.com>
References: <1395754915-14534-1-git-send-email-valentin.longchamp@keymile.com>
 <1395754915-14534-4-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-25 at 14:41 +0100, Valentin Longchamp wrote:
> +	lbc: localbus@ffe124000 {
> +		reg = <0xf 0xfe124000 0 0x1000>;
> +		ranges = <0 0 0xf 0xffa00000 0x00040000		/* LB 0 */
> +			  1 0 0xf 0xfb000000 0x00010000		/* LB 1 */
> +			  2 0 0xf 0xd0000000 0x10000000		/* LB 2 */
> +			  3 0 0xf 0xe0000000 0x10000000>;	/* LB 3 */
> +
> +		nand@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,elbc-fcm-nand";
> +			reg = <0 0 0x40000>;
> +
> +			partition@0 {
> +				label = "ubi0";
> +				reg = <0x0 0x10000000>;
> +			};

Putting partition info in the dts file is a bad habit and (as I've told
others) I don't think we should continue doing so in new dts files.

In this case it looks like you're just making the entire chip into one
partition, so I'm not sure what the point is of partitioning at all.

-Scott
