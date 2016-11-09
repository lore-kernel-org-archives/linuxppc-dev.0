Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tDbH81sk6zDvhn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 06:05:40 +1100 (AEDT)
Date: Wed, 9 Nov 2016 19:04:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, frowand.list@gmail.com,
 robh+dt@kernel.org, marc.zyngier@arm.com
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process
 failure
Message-ID: <20161109190457.GC837@leverpostej>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2016 at 12:05:08PM -0200, Guilherme G. Piccoli wrote:
> On PowerPC machines some PCI slots might not have Level-triggered
> interrupts capability (also know as Level Signaled Interrupts - LSI),
> leading of_irq_parse_pci() to complain by presenting error messages
> on the kernel log - in this case, the properties "interrupt-map" and
> "interrupt-map-mask" are not present on the device's node on device
> tree.

If we don't have an interrupt-map on a PCI controller, why don't we
instead log a message regarding that being missing, and give up early?

That sounds like a more generically useful error message; it's also
possible that a DT author simply forgot to add the map, and the platform
has suitable interrupts wired up.

> This patch introduces a different message for this specific case,
> and it also reduces the level of the message from error to warning.
> Before this patch, when an adapter was plugged in a slot without Level
> interrupts capabilities, we saw generic error messages like this:
> 
>     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-22
> 
> Now, with this applied, we see the following specific message:
> 
>     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot of this
>     device has no Level-triggered Interrupts capability.

Following my above example, this has gone from opaque to potentially
misleading.

Thanks,
Mark.
