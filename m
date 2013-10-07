Return-Path: <htejun@gmail.com>
Received: from mail-qe0-x22a.google.com (mail-qe0-x22a.google.com
 [IPv6:2607:f8b0:400d:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C370B2C010C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 05:01:18 +1100 (EST)
Received: by mail-qe0-f42.google.com with SMTP id gc15so760814qeb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Oct 2013 11:01:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 7 Oct 2013 14:01:11 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131007180111.GC2481@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, linux390@de.ibm.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Ben Hutchings <bhutchings@solarflare.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey, guys.

On Sun, Oct 06, 2013 at 09:10:30AM +0200, Alexander Gordeev wrote:
> On Sun, Oct 06, 2013 at 05:19:46PM +1100, Benjamin Herrenschmidt wrote:
> > On Sun, 2013-10-06 at 08:02 +0200, Alexander Gordeev wrote:
> > > In fact, in the current design to address the quota race decently the
> > > drivers would have to protect the *loop* to prevent the quota change
> > > between a pci_enable_msix() returned a positive number and the the next
> > > call to pci_enable_msix() with that number. Is it doable?
> > 
> > I am not advocating for the current design, simply saying that your
> > proposal doesn't address this issue while Ben's does.

Hmmm... yean, the race condition could be an issue as multiple msi
allocation might fail even if the driver can and explicitly handle
multiple allocation if the quota gets reduced inbetween.

> There is one major flaw in min-max approach - the generic MSI layer
> will have to take decisions on exact number of MSIs to request, not
> device drivers.

The min-max approach would actually be pretty nice for the users which
actually care about this.

> This will never work for all devices, because there might be specific
> requirements which are not covered by the min-max. That is what Ben
> described "...say, any even number within a certain range". Ben suggests
> to leave the existing loop scheme to cover such devices, which I think is
> not right.

if it could work.

> What about introducing pci_lock_msi() and pci_unlock_msi() and let device
> drivers care about their ranges and specifics in race-safe manner?
> I do not call to introduce it right now (since it appears pSeries has not
> been hitting the race for years) just as a possible alternative to Ben's
> proposal.

I don't think the same race condition would happen with the loop.  The
problem case is where multiple msi(x) allocation fails completely
because the global limit went down before inquiry and allocation.  In
the loop based interface, it'd retry with the lower number.

As long as the number of drivers which need this sort of adaptive
allocation isn't too high and the common cases can be made simple, I
don't think the "complex" part of interface is all that important.
Maybe we can have reserve / cancel type interface or just keep the
loop with more explicit function names (ie. try_enable or something
like that).

Thanks.

-- 
tejun
