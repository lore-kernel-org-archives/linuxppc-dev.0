Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429MPY6MMjzF2QM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 23:02:09 +1000 (AEST)
Date: Wed, 12 Sep 2018 08:02:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] sriov enablement on s390
Message-ID: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180912123411.23229-1-sebott@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Arnd, powerpc folks]

On Wed, Sep 12, 2018 at 02:34:09PM +0200, Sebastian Ott wrote:
> Hello Bjorn,
> 
> On s390 we currently handle SRIOV within firmware. Which means
> that the PF is under firmware control and not visible to operating
> systems. SRIOV enablement happens within firmware and VFs are
> passed through to logical partitions.
> 
> I'm working on a new mode were the PF is under operating system
> control (including SRIOV enablement). However we still need
> firmware support to access the VFs. The way this is supposed
> to work is that when firmware traps the SRIOV enablement it
> will present machine checks to the logical partition that
> triggered the SRIOV enablement and provide the VFs via hotplug
> events.
> 
> The problem I'm faced with is that the VF detection code in
> sriov_enable leads to unusable functions in s390.

We're moving away from the weak function implementation style.  Can
you take a look at Arnd's work here, which uses pci_host_bridge
callbacks instead?

  https://lkml.kernel.org/r/20180817102645.3839621-1-arnd@arndb.de

I cc'd some powerpc folks because they also have a fair amount of
arch-specific SR-IOV code that might one day move in this direction.

> Sebastian Ott (2):
>   pci: provide pcibios_sriov_add_vfs
>   s390/pci: handle function enumeration after sriov enablement
> 
>  arch/s390/pci/pci.c | 11 +++++++++++
>  drivers/pci/iov.c   | 43 +++++++++++++++++++++++++++++++------------
>  include/linux/pci.h |  2 ++
>  3 files changed, 44 insertions(+), 12 deletions(-)
> 
> -- 
> 2.13.4
> 
