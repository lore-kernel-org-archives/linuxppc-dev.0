Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DCCD2C0083
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 07:36:15 +1000 (EST)
Message-ID: <500F1545.1020705@freescale.com>
Date: Tue, 24 Jul 2012 16:36:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500F1165.9040404@freescale.com>
 <500F144D.5080508@freescale.com>
In-Reply-To: <500F144D.5080508@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

>> It appears that this compatible string is used by U-Boot to find the nodes
>> for fixups:
> 
> SDK U-Boot, I assume you mean.

No, upstream as well.  It's pretty much the same code:

#ifdef CONFIG_SYS_FSL_PCIE_COMPAT
#define FSL_PCIE_COMPAT	CONFIG_SYS_FSL_PCIE_COMPAT
#else
#define FSL_PCIE_COMPAT	"fsl,mpc8548-pcie"
#endif

#define FT_FSL_PCIE1_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 1)
#define FT_FSL_PCIE2_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 2)
#define FT_FSL_PCIE3_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 3)
#define FT_FSL_PCIE4_SETUP __FT_FSL_PCIE_SETUP(blob, FSL_PCIE_COMPAT, 4)

#define __FT_FSL_PCIE_SETUP(blob, compat, num) \
	ft_fsl_pci_setup(blob, compat, CONFIG_SYS_PCIE##num##_ADDR)

-- 
Timur Tabi
Linux kernel developer at Freescale
