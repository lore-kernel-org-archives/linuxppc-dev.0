Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x22c.google.com (mail-qa0-x22c.google.com
 [IPv6:2607:f8b0:400d:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C98532C0127
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 02:43:30 +1100 (EST)
Received: by mail-qa0-f44.google.com with SMTP id cm18so1079898qab.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 08:43:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 9 Oct 2013 11:43:23 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131009154323.GB22495@htj.dyndns.org>
References: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
 <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>
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

On Wed, Oct 09, 2013 at 02:57:16PM +0200, Alexander Gordeev wrote:
> On Mon, Oct 07, 2013 at 02:01:11PM -0400, Tejun Heo wrote:
> > Hmmm... yean, the race condition could be an issue as multiple msi
> > allocation might fail even if the driver can and explicitly handle
> > multiple allocation if the quota gets reduced inbetween.
> 
> BTW, should we care about the quota getting increased inbetween?
> That would entail.. kind of pci_get_msi_limit() :), but IMHO it is
> not worth it.

I think we shouldn't.  If the resource was low during a point in time
during allocation, it's fine to base the result on that - the resource
was actually low and which answer we return is just a question of
timing and both are correct.  The only reason the existing race
condition is problematic is because it may fail even if the resource
never falls below the failure point.

Thanks.

-- 
tejun
