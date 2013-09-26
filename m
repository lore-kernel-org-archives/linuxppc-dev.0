Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 4F4792C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 21:36:31 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 25961-09 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 26 Sep 2013 12:36:28 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Date: Thu, 26 Sep 2013 12:34:36 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7360@saturn3.aculab.com>
In-Reply-To: <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
References: <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org> <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com>
 <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Alexander Gordeev" <agordeev@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>,
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

> On Thu, Sep 26, 2013 at 09:58:53AM +0100, David Laight wrote:
> > Would it be possible to do some kind of 2-stage allocation.
> > In the first pass the driver would pass a minimum and desired
> > number of MSI-X interrupts, but not actually be given any.
>=20
> Repeated calls to msi_enable_msi/msix() is what we are trying to =
avoid.

I was thinking that the first call would be done during driver probe
(assuming such a time exists) so that the subsystem could determine
how many interrupts all the drivers would like, so it can then
hand out a smaller number to some of the early drivers in order
to have some left to satisfy the minimum requirement of later
ones.

So all it would do is sum the requirements of all the drivers.

	David
