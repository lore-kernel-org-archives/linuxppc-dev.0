Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E35362C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Oct 2013 17:21:32 +1100 (EST)
Message-ID: <1381040386.645.143.camel@pasglop>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Gordeev <agordeev@redhat.com>
Date: Sun, 06 Oct 2013 17:19:46 +1100
In-Reply-To: <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
 Ben Hutchings <bhutchings@solarflare.com>, Ingo Molnar <mingo@redhat.com>,
 iss_storagedev@hp.com, linux-driver@qlogic.com,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Tejun Heo <tj@kernel.org>, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-10-06 at 08:02 +0200, Alexander Gordeev wrote:
> On Sun, Oct 06, 2013 at 08:46:26AM +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2013-10-05 at 16:20 +0200, Alexander Gordeev wrote:
> > > So my point is - drivers should first obtain a number of MSIs they *can*
> > > get, then *derive* a number of MSIs the device is fine with and only then
> > > request that number. Not terribly different from memory or any other type
> > > of resource allocation ;)
> > 
> > What if the limit is for a group of devices ? Your interface is racy in
> > that case, another driver could have eaten into the limit in between the
> > calls.
> 
> Well, the another driver has had a better karma ;) But seriously, the
> current scheme with a loop is not race-safe wrt to any other type of
> resource which might exhaust. What makes the quota so special so we
> should care about it and should not care i.e. about lack of msi_desc's?

I'm not saying the current scheme is better but I prefer the option of
passing a min,max to the request function.

> Yeah, I know the quota might hit more likely. But why it is not addressed
> right now then? Not a single function in chains...
>   rtas_msi_check_device() -> msi_quota_for_device() -> traverse_pci_devices()
>   rtas_setup_msi_irqs() -> msi_quota_for_device() -> traverse_pci_devices()
> ...is race-safe. So if it has not been bothering anyone until now then 
> no reason to start worrying now :)
>
> In fact, in the current design to address the quota race decently the
> drivers would have to protect the *loop* to prevent the quota change
> between a pci_enable_msix() returned a positive number and the the next
> call to pci_enable_msix() with that number. Is it doable?

I am not advocating for the current design, simply saying that your
proposal doesn't address this issue while Ben's does.

Cheers,
Ben.

> > Ben.
> > 
> > 
> 
