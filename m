Return-Path: <htejun@gmail.com>
Received: from mail-qe0-x22d.google.com (mail-qe0-x22d.google.com
 [IPv6:2607:f8b0:400d:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6F652C010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 02:41:26 +1100 (EST)
Received: by mail-qe0-f45.google.com with SMTP id 8so739856qea.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 08:41:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 9 Oct 2013 11:41:17 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131009154117.GA22495@htj.dyndns.org>
References: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
 <20131008122215.GA14389@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131008122215.GA14389@dhcp-26-207.brq.redhat.com>
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

Hello,

On Tue, Oct 08, 2013 at 02:22:16PM +0200, Alexander Gordeev wrote:
> If we talk about pSeries quota, then the current pSeries pci_enable_msix()
> implementation is racy internally and could fail if the quota went down
> *while* pci_enable_msix() is executing. In this case the loop will have to
> exit rather than retry with a lower number (what number?).

Ah, okay, so that one is already broken.

> In this regard the new scheme does not bring anything new and relies on
> the fact this race does not hit and therefore does not worry.
> 
> If we talk about quota as it has to be, then yes - the loop scheme seems
> more preferable.
> 
> Overall, looks like we just need to fix the pSeries implementation,
> if the guys want it, he-he :)

If we can't figure out a better interface for the retry case, I think
what can really help is having a simple interface for the simpler
cases.

> > The problem case is where multiple msi(x) allocation fails completely
> > because the global limit went down before inquiry and allocation.  In
> > the loop based interface, it'd retry with the lower number.
> 
> I am probably missing something here. If the global limit went down before
> inquiry then the inquiry will get what is available and try to allocate with
> than number.

Oh, I should have written between inquiry and allocation.  Sorry.

Thanks.

-- 
tejun
