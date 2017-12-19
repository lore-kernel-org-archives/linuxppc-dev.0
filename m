Return-Path: <ruscur@russell.cc>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z15LG75Y0zDsRm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 15:59:49 +1100 (AEDT)
Message-ID: <1513659576.2151.6.camel@russell.cc>
Subject: Re: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
From: Russell Currey <ruscur@russell.cc>
To: Bjorn Helgaas <helgaas@kernel.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, Keith Busch <keith.busch@intel.com>, Gabriele Paoloni
 <gabriele.paoloni@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 19 Dec 2017 15:59:36 +1100
In-Reply-To: <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
 <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
 <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
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

On Mon, 2017-12-18 at 22:50 -0600, Bjorn Helgaas wrote:
> [+cc Keith, Gabriele, Dongdong]
> 
> On Mon, Dec 18, 2017 at 04:38:03PM -0600, Bryant G. Ly wrote:
> > Devices can go offline when EEH is reported. This patch adds
> > a change to the kernel object and lets udev know of error.
> > When device resumes a change is also set reporting device as
> > online. Therefore, EEH events are better propagated to user
> > space for devices in powerpc arch.
> 
> I'm on vacation and can't review this in detail, but I wonder if you
> can compare this with the uevents we emit for DPC, AER, and hotplug
> events (if any).  I hope we don't end up with userspace having to be
> aware of the differences between EEH, DPC, AER, etc.
> 
> From a very quick look, I only see a few uevents even mentioned in
> drivers/pci: KOBJ_ADD in __pci_hp_register() and KOBJ_CHANGE in the
> SR-IOV code.  I'm worried that we're missing some important uevents
> in
> the PCI core.  That's not an argument against what you're doing here;
> it just would be nice to fill in any missing pieces in the core also,
> and hopefully make them consistent with these EEH events.

I don't think this needs to be particularly complex, could we get away
with events for when devices do the following?

- begin recovery
- successfully recover
- fail recovery

It might be worthwhile sorting out some consistent, non-EEH-specific
naming, and then other device error recovery systems can do the same
later.

- Russell

> 
> > Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> > Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
