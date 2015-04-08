Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E842A1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 18:01:47 +1000 (AEST)
Message-ID: <1428480074.18187.8.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
 in of parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 08 Apr 2015 18:01:14 +1000
In-Reply-To: <CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
 <1428464944.4947.69.camel@kernel.crashing.org>
 <CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 22:39 -0700, Yinghai Lu wrote:
> On Tue, Apr 7, 2015 at 8:49 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2015-04-07 at 17:24 -0700, Yinghai Lu wrote:
> >> For device resource PREF bit setting under bridge 64-bit pref resource,
> >> we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
> >> for 64bit resource during of device resource flags parsing.
> >
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> >
> > These patches (from the above BZ) aren't right for one thing: You
> > shouldn't set the IORESOURCE_PREFETCH in the resource itself. This
> > *will* break stuff.
> >
> > You can put the resource in a prefetchable region indeed, if you
> > are on a PCIe-only path (though we should have some arch flag
> > to check that the host bridge indeed doesn't do any prefetch,
> > on powerpc we are good there).
> 
> The patch is at:
> 
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=1a3ec5e7b00dcd9cac24efe3d65bfccf82597ce5
> 
> and we limit to set pref bit for pcie end devices mmio 64bit resource.

This is still completely wrong. Please revert.

> >
> > But you can't set the "prefetch" bit on the resource because that would
> > be losing the indication that this resource has side effects. This bit
> > is used in some cases to enable store gathering when mmap'ing via sysfs
> > and can be used for similar uses by drivers.
> 
> Any pointer for that?
>
> >
> > It's one thing to say "you can put non-prefetch BARs in prefetch windows
> > on that path", it's another one to completely make the BAR looks like
> > it's prefetchable when it's not.
> 
> Too hard for me to tell the difference.

Fix it. Add a new bit if necessary "CAN_BE_IN_PREFETCH" or whatever but
you just cannot randomly fuck around with the flag like that.

You are basically dropping the information that the BAR has side effects
completely. This is WRONG.

The fact that you can put a non-prefetchable BAR in a prefetchable
window doesn't make the BAR itself prefetchable. Your patch makes it so.

That means that anything that rely on the BAR flag to establish
prefetchable or write-combining mappings will be fucked. Drivers might
test that, arch code will, powerpc sysfs mmap will (see our
implementation of __pci_mmap_set_pgprot), and quite possibly others
architectures or drivers doing the same thing.

This is utterly WRONG.

Use a different flag to indicate the BAR policy or temporarily tweak a
local copy of the resource flag during BAR assignment or whatever you
prefer to fix the original problem but do *not* change the Linux overall
view of that BAR to lie about prefetchability.

Bjorn, please revert this ASAP.

Cheers,
Ben.
