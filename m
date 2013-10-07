Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEDEF2C020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 07:12:56 +1100 (EST)
Message-ID: <1381176656.645.171.camel@pasglop>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
Date: Tue, 08 Oct 2013 07:10:56 +1100
In-Reply-To: <20131007180111.GC2481@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, iss_storagedev@hp.com,
 linux-driver@qlogic.com, linux390@de.ibm.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, Ingo Molnar <mingo@redhat.com>,
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

On Mon, 2013-10-07 at 14:01 -0400, Tejun Heo wrote:
> I don't think the same race condition would happen with the loop.  The
> problem case is where multiple msi(x) allocation fails completely
> because the global limit went down before inquiry and allocation.  In
> the loop based interface, it'd retry with the lower number.
> 
> As long as the number of drivers which need this sort of adaptive
> allocation isn't too high and the common cases can be made simple, I
> don't think the "complex" part of interface is all that important.
> Maybe we can have reserve / cancel type interface or just keep the
> loop with more explicit function names (ie. try_enable or something
> like that).

I'm thinking a better API overall might just have been to request
individual MSI-X one by one :-)

We want to be able to request an MSI-X at runtime anyway ... if I want
to dynamically add a queue to my network interface, I want it to be able
to pop a new arbitrary MSI-X.

And we don't want to lock drivers into contiguous MSI-X sets either.

And for the cleanup ... well that's what the "pcim" functions are for,
we can just make MSI-X variants.

Ben.
