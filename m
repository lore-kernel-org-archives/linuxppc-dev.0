Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09EFB2C007E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 07:32:04 +1000 (EST)
Message-ID: <500F144D.5080508@freescale.com>
Date: Tue, 24 Jul 2012 16:31:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500F1165.9040404@freescale.com>
In-Reply-To: <500F1165.9040404@freescale.com>
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

On 07/24/2012 04:19 PM, Timur Tabi wrote:
> Scott Wood wrote:
>>>> +	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
>> p5040 has PCIe v2.4.
>>
>> Note that there is a version register, so perhaps we should drop the
>> version number from the compatible (and mention the version register in
>> the binding).
>>
>> Might want to double check the other version numbers in this file too.
> 
> It appears that this compatible string is used by U-Boot to find the nodes
> for fixups:

SDK U-Boot, I assume you mean.

> #elif defined(CONFIG_PPC_P5040)
> #define CONFIG_MAX_CPUS			4
> ...
> #define CONFIG_SYS_FSL_PCIE_COMPAT	"fsl,qoriq-pcie-v2.2"
> 
> Which means that I can't just change it from v2.2 to v2.4 without breaking
> U-Boot.  Ugh.

Another reason for dropping the version from this particular compatible.
 Wouldn't stop this breakage, but would make future ones less likely.

And of course why we should carefully verify the information in the
device trees before we go copying and pasting in the first place.

Though, it depends on whether we determine that v2.4 is 100% backwards
compatible with v2.2, in which case we could list both.  It looks like
the v2.3 chips list both, and U-Boot refers to v2.2.  One possible point
of contention on compatibility is the change in where LIODN is specified
(moved from guts to the PCIe registers), especially if we're claiming
backwards comaptibility on the guts side as well.

> How do you know that the P5040 has v2.4?

See PEX_IP_BLK_REV1.

One new thing in v2.4 is the LIODN permission table, rather than one
LIODN for the entire root complex.

-Scott
