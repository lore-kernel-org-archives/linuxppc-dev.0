Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb61B3JJpzDqhM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 05:13:34 +1000 (AEST)
Message-ID: <1503256100.12059.13.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Axtens <dja@axtens.net>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, gabriele.paoloni@huawei.com,
 airlied@linux.ie, will.deacon@arm.com, dri-devel@lists.freedesktop.org,
 z.liuxinliang@hisilicon.com, bhelgaas@google.com,
 alex.williamson@redhat.com, lukas@wunner.de, catalin.marinas@arm.com,
 zourongrong@gmail.com, daniel.vetter@intel.com
Date: Sun, 20 Aug 2017 12:08:20 -0700
In-Reply-To: <20170819154753.GQ28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
 <20170819154753.GQ28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-08-19 at 10:47 -0500, Bjorn Helgaas wrote:
> So if ARM64 doesn't have these PCI legacy resources, does that mean an
> ARM64 host bridge cannot generate these legacy addresses on PCI?  That
> is, there's no host bridge window that maps to those PCI addresses?
> That seems like a curious restriction on host bridges, but I guess it
> would be possible.

It's rather common. For example on POWER8:

 - There is no IO space at all

 - We configure the 32-bit MMIO window to be around 3..4G (to avoid
overlapping with DMA space below it).

So we effectively have no path to the legacy areas, and that hasn't
been a problem so far.

Cheers,
Ben.
 
