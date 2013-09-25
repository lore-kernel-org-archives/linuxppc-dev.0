Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 86AEA2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 06:56:03 +1000 (EST)
Date: Wed, 25 Sep 2013 22:58:05 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
References: <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130925180220.GB26273@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Jan Beulich <JBeulich@suse.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 25, 2013 at 12:02:20PM -0600, Bjorn Helgaas wrote:
> On Fri, Sep 20, 2013 at 07:27:36AM -0500, Tejun Heo wrote:
> > On Fri, Sep 20, 2013 at 10:24:59AM +0200, Alexander Gordeev wrote:
> > > * Make pci_enable_msix() return 0/-errno
> > 
> > My choice would be this one.
> 
> I agree; it sounds like you've identified several bugs related to the
> current confusing interface, so fixing that seems like the first step.

Yeah, I am trying to. Turns out to be a nice exercise ;)

> I hope we can avoid adding a plethora of interfaces to address unusual
> corner cases.  But if we do the above and it turns out not to be enough,
> we can always extend it later.

Unfortunately, pSeries is a shows-topper here :( It seems we have to
introduce pci_get_msi{,x}_limit() interfaces to honour the quota
thing.  I just hope the hardware set for pSeries is limited and we
won't need to use it for all drivers.

> Bjorn

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
