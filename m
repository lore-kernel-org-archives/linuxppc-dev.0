Return-Path: <sebott@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429yvL6zw1zF3SF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:41:34 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8DCd5aq141638
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 08:41:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mfneppxed-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 08:41:31 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.ibm.com>;
 Thu, 13 Sep 2018 13:41:29 +0100
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH 0/2] sriov enablement on s390
Date: Thu, 13 Sep 2018 14:41:22 +0200
In-Reply-To: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180913124124.14632-1-sebott@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Sep 2018, Bjorn Helgaas wrote:
> [+cc Arnd, powerpc folks]
> 
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

Rebased to Arnd's pci-probe-rework branch.

Sebastian Ott (2):
  pci: provide add_vfs/del_vfs callbacks
  s390/pci: handle function enumeration after sriov enablement

 arch/s390/pci/pci.c | 11 +++++++++++
 drivers/pci/iov.c   | 51 +++++++++++++++++++++++++++++++++++++++------------
 include/linux/pci.h |  2 ++
 3 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.13.4
