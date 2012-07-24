Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B64B2C0078
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 07:19:42 +1000 (EST)
Message-ID: <500F1165.9040404@freescale.com>
Date: Tue, 24 Jul 2012 16:19:33 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com>
In-Reply-To: <500EE1BB.6060104@freescale.com>
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
>> > +	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
> p5040 has PCIe v2.4.
> 
> Note that there is a version register, so perhaps we should drop the
> version number from the compatible (and mention the version register in
> the binding).
> 
> Might want to double check the other version numbers in this file too.

It appears that this compatible string is used by U-Boot to find the nodes
for fixups:

#elif defined(CONFIG_PPC_P5040)
#define CONFIG_MAX_CPUS			4
...
#define CONFIG_SYS_FSL_PCIE_COMPAT	"fsl,qoriq-pcie-v2.2"

Which means that I can't just change it from v2.2 to v2.4 without breaking
U-Boot.  Ugh.

How do you know that the P5040 has v2.4?

-- 
Timur Tabi
Linux kernel developer at Freescale
