Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id C1A002C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 02:48:46 +1000 (EST)
Date: Wed, 18 Sep 2013 18:50:45 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
References: <20130905185440.GA13175@dhcp-26-207.brq.redhat.com>
 <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130918142231.GA21650@mtj.dyndns.org>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Jan Beulich <JBeulich@suse.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 18, 2013 at 09:22:31AM -0500, Tejun Heo wrote:
> > > We have a small number of MSIs available, limited by hardware &
> > > firmware, if we don't impose a quota then the first device that probes
> > > will get most/all of the MSIs and other devices miss out.
> > 
> > Out of curiosity - how pSeries has had done it without quotas before
> > 448e2ca ("powerpc/pseries: Implement a quota system for MSIs")?
> 
> Hmmm... do we need to treat this any differently?  If the platform
> can't allocate full range of requested MSIs, just failing should be
> enough regardless of why such allocation can't be met, no?

That depends from what "full range of requested MSIs" is. If that is
a maximum number of MSIs the controller advertised, then no. As MSI
design essentially allows devices to operate in lower-than-maximum
modes it is responsibility of a caller to decide how many vectors to
request. So in case of pSeries I think it is completely legitimate to
request lessers to overcome the platform limitation and let all devices
work.

> I really think what we should do is
> 
> * Determine the number of MSIs the controller wants.  Don't worry
>   about quotas or limits or anything.  Just determine the number
>   necessary to enable enhanced interrupt handling.

Actually, I do not see much contradiction with what I proposed. The
key words here "determine the number of MSIs the controller wants".

In general case it is not what pci_msix_table_size() returns (or at
least we should not limit ourselves to it) - there could be non-
standard means to report number of MSIs: hardcoded, version-dependant,
device-specific registers etc.

Next, if we opt to determine the number of MSIs by non-MSI standard
means then there is no reason not to call pci_get_msix_limit() (or
whatever) at this step.

The question how I see it - do we want pci_get_msix_limit() interface
as part of the MSI framework or do we want it pSeries-specific?

> * Try allocating that number of MSIs.  If it fails, then just revert
>   to single interrupt mode.  It's not the end of the world and mostly
>   guaranteed to work.  Let's please not even try to do partial
>   multiple interrupts.  I really don't think it's worth the risk or
>   complexity.

Being Captain Obvious here, but it is up to the device driver to handle
a failure. There could be no such option as single MSI mode after all :)

> Thanks.
> 
> -- 
> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
