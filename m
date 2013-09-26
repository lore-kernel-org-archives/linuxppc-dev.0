Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id A8DF52C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 19:20:52 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 17330-10 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 26 Sep 2013 10:20:48 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Date: Thu, 26 Sep 2013 09:58:53 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com>
In-Reply-To: <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
References: <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org> <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Alexander Gordeev" <agordeev@redhat.com>,
	"Tejun Heo" <tj@kernel.org>
Cc: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() =
interface
>=20
> On Wed, Sep 25, 2013 at 05:00:16PM -0400, Tejun Heo wrote:
> > Hello,
> >
> > On Wed, Sep 25, 2013 at 10:58:05PM +0200, Alexander Gordeev wrote:
> > > Unfortunately, pSeries is a shows-topper here :( It seems we have =
to
> > > introduce pci_get_msi{,x}_limit() interfaces to honour the quota
> > > thing.  I just hope the hardware set for pSeries is limited and we
> > > won't need to use it for all drivers.
> >
> > Can you please go into a bit of detail on that?  Why does it matter?
>=20
> Because otherwise we will re-introduce a problem described by Michael:
> "We have a small number of MSIs available, limited by hardware &
> firmware, if we don't impose a quota then the first device that probes
> will get most/all of the MSIs and other devices miss out."

Would it be possible to do some kind of 2-stage allocation.
In the first pass the driver would pass a minimum and desired
number of MSI-X interrupts, but not actually be given any.
Interrupts could then be allocated after it is known how many
are required and how many are available.

	David
