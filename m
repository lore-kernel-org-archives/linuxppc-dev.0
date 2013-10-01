Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 17:19:55 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20131001071954.GG17966@concordia>
References: <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
 <20130926131147.GA31249@mtj.dyndns.org>
 <20130926143901.GE16774@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130926143901.GE16774@dhcp-26-207.brq.redhat.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jan Beulich <JBeulich@suse.com>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 04:39:02PM +0200, Alexander Gordeev wrote:
> On Thu, Sep 26, 2013 at 09:11:47AM -0400, Tejun Heo wrote:
> > > Because otherwise we will re-introduce a problem described by Michael:
> > > "We have a small number of MSIs available, limited by hardware &
> > > firmware, if we don't impose a quota then the first device that probes
> > > will get most/all of the MSIs and other devices miss out."
> > 
> > Still not following.  Why wouldn't just letting the drivers request
> > the optimal number they want and falling back to single interrupt mode
> > work?  ie. why can't we just have an all or nothing interface?
> 
> I can imagine a scenario where the first device probes in, requests its
> optimal number, acquires that number and exhausts MSIs in pSeries firmware.
> The next few devices possibly end up with single MSI, since no MSIs left
> to satisfy their optimal numbers. If one of those single-MSI'ed devices
> happened to be a high-performance HBA hitting a degraded performance that
> alone would force (IBM) to introduce the quotas.

Yes that's exactly the scenario, and I didn't imagine it, our test
people actually hit it and yelled at me.

I don't remember exactly which adapters it was, I might be able to find
the details if I looked hard, a quick search through my mail archive
didn't find it - it might have come in via irc / bugzilla etc.

cheers
