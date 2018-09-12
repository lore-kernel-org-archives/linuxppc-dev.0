Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429S2m2qY0zF3Bm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 02:31:12 +1000 (AEST)
Message-ID: <867d7f0f47766e42d5fb1a479209fef406cf5fc2.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] sriov enablement on s390
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Date: Wed, 12 Sep 2018 16:40:28 +0200
In-Reply-To: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
 <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
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

On Wed, 2018-09-12 at 08:02 -0500, Bjorn Helgaas wrote:
> [+cc Arnd, powerpc folks]

[+Oliver]

> On Wed, Sep 12, 2018 at 02:34:09PM +0200, Sebastian Ott wrote:
> > Hello Bjorn,
> > 
> > On s390 we currently handle SRIOV within firmware. Which means
> > that the PF is under firmware control and not visible to operating
> > systems. SRIOV enablement happens within firmware and VFs are
> > passed through to logical partitions.
> > 
> > I'm working on a new mode were the PF is under operating system
> > control (including SRIOV enablement). However we still need
> > firmware support to access the VFs. The way this is supposed
> > to work is that when firmware traps the SRIOV enablement it
> > will present machine checks to the logical partition that
> > triggered the SRIOV enablement and provide the VFs via hotplug
> > events.
> > 
> > The problem I'm faced with is that the VF detection code in
> > sriov_enable leads to unusable functions in s390.
> 
> We're moving away from the weak function implementation style.  Can
> you take a look at Arnd's work here, which uses pci_host_bridge
> callbacks instead?
> 
>   https://lkml.kernel.org/r/20180817102645.3839621-1-arnd@arndb.de
> 
> I cc'd some powerpc folks because they also have a fair amount of
> arch-specific SR-IOV code that might one day move in this direction.
> 
> > Sebastian Ott (2):
> >   pci: provide pcibios_sriov_add_vfs
> >   s390/pci: handle function enumeration after sriov enablement
> > 
> >  arch/s390/pci/pci.c | 11 +++++++++++
> >  drivers/pci/iov.c   | 43 +++++++++++++++++++++++++++++++------------
> >  include/linux/pci.h |  2 ++
> >  3 files changed, 44 insertions(+), 12 deletions(-)
> > 
> > -- 
> > 2.13.4
> > 
