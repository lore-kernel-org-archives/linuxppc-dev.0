Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F40442C0085
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 07:42:44 +1000 (EST)
Message-ID: <500F16B6.1080605@freescale.com>
Date: Tue, 24 Jul 2012 16:42:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500F1165.9040404@freescale.com>
 <500F144D.5080508@freescale.com> <500F1545.1020705@freescale.com>
In-Reply-To: <500F1545.1020705@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2012 04:36 PM, Timur Tabi wrote:
> Scott Wood wrote:
> 
>>> It appears that this compatible string is used by U-Boot to find the nodes
>>> for fixups:
>>
>> SDK U-Boot, I assume you mean.
> 
> No, upstream as well.  It's pretty much the same code:

I don't see P5040 support in upstream U-Boot yet.

> #ifdef CONFIG_SYS_FSL_PCIE_COMPAT
> #define FSL_PCIE_COMPAT	CONFIG_SYS_FSL_PCIE_COMPAT
> #else
> #define FSL_PCIE_COMPAT	"fsl,mpc8548-pcie"
> #endif
> 
> #define FT_FSL_PCIE1_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 1)
> #define FT_FSL_PCIE2_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 2)
> #define FT_FSL_PCIE3_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 3)
> #define FT_FSL_PCIE4_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 4)
> 
> #define __FT_FSL_PCIE_SETUP(blob, compat, num) \
> 	ft_fsl_pci_setup(blob, compat, CONFIG_SYS_PCIE##num##_ADDR)
> 

Yeah, the code's there, but not the wrong compatible string for P5040.

-Scott
