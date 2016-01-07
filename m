Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0116.outbound.protection.outlook.com [157.56.111.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4172A1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 06:47:48 +1100 (AEDT)
Message-ID: <1452196053.19133.23.camel@freescale.com>
Subject: Re: [PATCH] mtd: nand: add FSL_SOC dependency to drivers using FSL_LBC
From: Scott Wood <scottwood@freescale.com>
To: Brian Norris <computersforpeace@gmail.com>, <linux-mtd@lists.infradead.org>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 7 Jan 2016 13:47:33 -0600
In-Reply-To: <1452194501-115280-1-git-send-email-computersforpeace@gmail.com>
References: <1452194501-115280-1-git-send-email-computersforpeace@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-07 at 11:21 -0800, Brian Norris wrote:
> I've managed to construct .config files (for ppc64) that come across
> this Kconfig warning:
> 
>   warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM) selects
> FSL_LBC which has unmet direct dependencies (FSL_SOC)
> 
> Let's add the FSL_SOC dependency to the NAND drivers. AFAICT, they are
> only supported on PPC32 FSL SoCs anyway.

There are other problems, if you can enable an 83xx board on ppc64.  PPC_83xx
does select FSL_SOC so I don't know why it's unmet.

FWIW, I think we should instead drop the FSL_SOC dependency from FSL_LBC.  It
doesn't use anything that I can see from fsl_soc.c.  It's been commonly abused
as a means for hiding the option on builds for other platforms, but that has
to stop anyway now that many of these devices are also on ARM-based chips. 
 eLBC isn't, since it was obsoleted by IFC, but it shouldn't be unnecessarily
different from IFC.  IFC currently depends on FSL_SOC but that needs to go
away.

-Scott
