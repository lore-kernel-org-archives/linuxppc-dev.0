Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 397832C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 18:33:47 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20084-10 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  4 Oct 2013 09:33:42 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Date: Fri, 4 Oct 2013 09:31:49 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
In-Reply-To: <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Alexander Gordeev" <agordeev@redhat.com>,
 "Ben Hutchings" <bhutchings@solarflare.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, iss_storagedev@hp.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-rdma@vger.kernel.org,
 linux-driver@qlogic.com, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > It seems to me that a more useful interface would take a minimum and
> > maximum number of vectors from the driver.  This wouldn't allow the
> > driver to specify that it could only accept, say, any even number =
within
> > a certain range, but you could still leave the current functions
> > available for any driver that needs that.
>=20
> Mmmm.. I am not sure I am getting it. Could you please rephrase?

One possibility is for drivers than can use a lot of interrupts to
request a minimum number initially and then request the additional
ones much later on.
That would make it less likely that none will be available for
devices/drivers that need them but are initialised later.

	David
