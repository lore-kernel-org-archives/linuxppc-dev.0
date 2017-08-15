Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWhGs6mXtzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 15:43:33 +1000 (AEST)
Message-ID: <1502775751.4493.47.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robin Murphy <robin.murphy@arm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger
 <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Alex
 Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira
 <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>, Paul Mackerras
 <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Aug 2017 15:42:31 +1000
In-Reply-To: <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
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

On Mon, 2017-08-14 at 14:12 +0100, Robin Murphy wrote:
> On the other hand, if the check is not so much to mitigate malicious
> guests attacking the system as to prevent dumb guests breaking
> themselves (e.g. if some or all of the MSI-X capability is actually
> emulated), then allowing things to sometimes go wrong on the grounds of
> an irrelevant hardware feature doesn't seem correct :/

There is 0 value in trying to prevent the guest kernel from shooting
itself in the foot. There are so many other ways it can do it that I
fail the point of even attempting it here.

In addition, this actually harms performance on some devices. There
are cases where the MSI-X table shares a page with other registrers
that are used during normal device operation. This is especially
problematic on architectures such as powerpc that use 64K pages.

Those devices thus suffer a massive performance loss, for the sake of
something that never happens in practice (especially on pseries where
the MSI configuration is done by paravirt calls, thus by qemu itself).

Cheers,
Ben.
