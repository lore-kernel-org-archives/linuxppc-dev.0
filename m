Return-Path: <michael@ellerman.id.au>
Date: Wed, 2 Oct 2013 12:43:24 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20131002024324.GC22748@concordia>
References: <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20131001075133.GJ17966@concordia>
 <20131001103526.GA5053@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131001103526.GA5053@dhcp-26-207.brq.redhat.com>
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

On Tue, Oct 01, 2013 at 12:35:27PM +0200, Alexander Gordeev wrote:
> On Tue, Oct 01, 2013 at 05:51:33PM +1000, Michael Ellerman wrote:
> > The disadvantage is that any restriction imposed on us above the quota
> > can only be reported as an error from pci_enable_msix().
> > 
> > The quota code, called from pci_get_msix_limit(), can only do so much to
> > interogate firmware about the limitations. The ultimate way to check if
> > firmware will give us enough MSIs is to try and allocate them. But we
> > can't do that from pci_get_msix_limit() because the driver is not asking
> > us to enable MSIs, just query them.
> 
> If things are this way then pci_enable_msix() already exposed to this
> problem internally on pSeries.
> 
> I see that even successful quota checks in rtas_msi_check_device() and
> rtas_setup_msi_irqs() do not guarantee (as you say) that firmware will
> give enough MSIs. Hence, pci_enable_msix() might fail even though the
> its quota checks succeeded.

Yes, but it can report that failure to the caller, which can then retry.

> Therefore, nothing will really change if we make pci_get_msix_limit() check
> quota and hope the follow-up call to pci_enable_msix() succeeded.

No that's not equivalent. Under your scheme if pci_enable_msix() fails
then the caller just bails, it will never try again with a lower number.

> (Of course, we could allocate-deallocate MSIs at check time, but I think it
> is an overkill).

It's not only overkill, it's messing with the device behind the drivers
back, which is definitely a no-no in my opinion.
 
> > You'll also need to add another arch hook, for the quota check, and
> > we'll have to add it to our per-platform indirection as well.
> 
> Already, in a branch, hidden from Bjorn & Tejun eyes ;)
> 
> > All a lot of bother for no real gain IMHO.
> 
> Well, I do not have a strong opinion here. I leave it to the ones who have :)
> But few drivers have became clearer as result of this change (and messy ones
> are still messy).

Amen.

cheers
