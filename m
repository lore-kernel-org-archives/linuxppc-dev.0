Return-Path: <lukas@wunner.de>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPZbP2BlJzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 17:06:41 +1000 (AEST)
Date: Sat, 5 Aug 2017 08:57:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] Split VGA default device handler out of VGA arbiter
Message-ID: <20170805065754.GA8509@wunner.de>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-3-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170804102033.27731-3-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 04, 2017 at 08:20:32PM +1000, Daniel Axtens wrote:
> A system without PCI legacy resources (e.g. ARM64, powerpc) may
> find that no default/boot VGA device has been marked, because the
> VGA arbiter checks for legacy resource decoding before marking a
> card as default.

Would it be feasible to just sprinkle some "if (IS_ENABLED(CONFIG_X86))"
over the portions of vgaarb.c that deal with legacy resources?

I'm missing some context as to the negative consequences you're
experiencing on other arches (the cover letter merely refers to
"quirks in ppc and concerns in arm land" and is missing links to
archived versions of v1 and v2), but clearly legacy resources are
x86-specific so any code dealing with them seems superfluous on
other arches and should be marked as such.

Please cc dri-devel when proposing changes to vgaarb.c (see
MAINTAINERS).

Thanks,

Lukas
