Return-Path: <kernel@start.ca>
Received: from mouse.start.ca (mouse.start.ca [64.140.120.56])
 by ozlabs.org (Postfix) with ESMTP id 2DBE42C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 10:18:14 +1100 (EST)
Message-ID: <5257357E.8080506@start.ca>
Date: Thu, 10 Oct 2013 19:17:18 -0400
From: Mark Lord <kernel@start.ca>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
 <5256D5AB.4050105@zytor.com>
 <20131010180704.GA15719@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20131010180704.GA15719@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-s390@vger.kernel.org, Andy King <acking@vmware.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just to help us all understand "the loop" issue..

Here's an example of driver code which uses the existing MSI-X interfaces,
for a device which can work with either 16, 8, 4, 2, or 1 MSI-X interrupt.
This is from a new driver I'm working on right now:


static int xx_alloc_msix_irqs (struct xx_dev *dev, int nvec)
{
        xx_disable_all_irqs(dev);
        do {
                if (nvec < 2)
                        xx_prep_for_1_msix_vector(dev);
                else if (nvec < 4)
                        xx_prep_for_2_msix_vectors(dev);
                else if (nvec < 8)
                        xx_prep_for_4_msix_vectors(dev);
                else if (nvec < 16)
                        xx_prep_for_8_msix_vectors(dev);
                else
                        xx_prep_for_16_msix_vectors(dev);
                nvec = pci_enable_msix(dev->pdev, dev->irqs, dev->num_vectors);
        } while (nvec > 0);

        if (nvec) {
                kerr(dev->name, "pci_enable_msix() failed, err=%d", nvec);
                dev->num_vectors = 0;
                return nvec;
        }
        return 0;       /* success */
}
