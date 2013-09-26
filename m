Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id CC2ED2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 23:01:38 +1000 (EST)
Date: Thu, 26 Sep 2013 15:03:29 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Mark Lord <kernel@start.ca>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130926130328.GD16774@dhcp-26-207.brq.redhat.com>
References: <20130905185440.GA13175@dhcp-26-207.brq.redhat.com>
 <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <52442975.9000603@start.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52442975.9000603@start.ca>
Cc: linuxppc-dev@lists.ozlabs.org, Joerg Roedel <joro@8bytes.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Jan Beulich <JBeulich@suse.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 08:32:53AM -0400, Mark Lord wrote:
> On 13-09-18 05:48 AM, Alexander Gordeev wrote:
> > The last pattern makes most of sense to me and could be updated with a more
> > clear sequence - a call to (bit modified) pci_msix_table_size() followed
> > by a call to pci_enable_msix(). I think this pattern can effectively
> > supersede the currently recommended "loop" practice.
> 
> The loop is still necessary, because there's a race between those two calls,
> so that pci_enable_msix() can still fail due to lack of MSIX slots.

Moreover, the existing loop pattern is racy and could fail just as easily ;)
But (1) that is something drivers should expect and (2) there is basically
nothing to race against - that is probably the reason it has not been a
problem for pSeries. So I think we should not care about this.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
