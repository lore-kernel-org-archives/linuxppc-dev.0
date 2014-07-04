Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 9D48B1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 19:13:06 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 28971-08 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  4 Jul 2014 10:13:02 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexander Gordeev' <agordeev@redhat.com>
Subject: RE: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Fri, 4 Jul 2014 09:11:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1726C717@AcuExch.aculab.com>
References: <cover.1402405331.git.agordeev@redhat.com>
 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com>
 <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
 <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 'Bjorn Helgaas' <bhelgaas@google.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexander Gordeev
...
> > Even if you do that, you ought to write valid interrupt information
> > into the 4th slot (maybe replicating one of the earlier interrupts).
> > Then, if the device does raise the 'unexpected' interrupt you don't
> > get a write to a random kernel location.
>=20
> I might be missing something, but we are talking of MSI address space
> here, aren't we? I am not getting how we could end up with a 'write'
> to a random kernel location when a unclaimed MSI vector sent. We could
> only expect a spurious interrupt at worst, which is handled and reported.
>=20
> Anyway, as I described in my reply to Bjorn, this is not a concern IMO.

I'm thinking of the following - which might be MSI-X ?
1) Hardware requests some interrupts and tells the host the BAR (and offset=
)
   where the 'vectors' should be written.
2) To raise an interrupt the hardware uses the 'vector' as the address
   of a normal PCIe write cycle.

So if the hardware requests 4 interrupts, but the driver (believing it
will only use 3) only write 3 vectors, and then the hardware uses the
4th vector it can write to a random location.

Debugging that would be hard!

	David
