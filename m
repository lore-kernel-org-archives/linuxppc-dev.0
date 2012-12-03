Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D59DD2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 07:03:13 +1100 (EST)
Message-ID: <50BD056F.7070701@freescale.com>
Date: Mon, 3 Dec 2012 14:02:55 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
References: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: scottwood@freescale.com, joerg.roedel@amd.com,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Varun Sethi wrote:

> +	out_be32(&pamu_regs->ppbah, ((u64)ppaact_phys) >> 32);
> +	out_be32(&pamu_regs->ppbal, ppaact_phys);
> +	ppaact_phys = ppaact_phys + PAACT_SIZE;
> +	out_be32(&pamu_regs->pplah, ((u64)ppaact_phys) >> 32);
> +	out_be32(&pamu_regs->pplal, ppaact_phys);

Instead of  ((u64)ppaact_phys) >> 32, use upper_32_bits() and lower_32_bits().

> +#define PAACE_NUMBER_ENTRIES    0xFF

This is going to break with large LIODNs.  Instead of hard-coding the size
of the PPAACT, you need to scan the device tree for the largest LIODN, and
make the array dynamically sized.

-- 
Timur Tabi
Linux kernel developer at Freescale
