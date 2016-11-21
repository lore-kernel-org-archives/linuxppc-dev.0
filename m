Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN2j52KLhzDvWt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 09:05:28 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:05:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access
 timeout
Message-ID: <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matthew,

On Mon, Nov 21, 2016 at 03:09:49PM -0600, Matthew R. Ochs wrote:
> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
> complete. When an access does not complete within this period, a warning
> is logged and an error returned to the caller.
> 
> While this default timeout is valid for most hardware, some devices can
> experience longer access delays under certain circumstances. For example,
> one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
> scenario. These types of devices can benefit from an extended timeout that
> is specific to their hardware constraints.
> 
> To support per-device VPD access timeouts, pci_set_vpd_timeout() is added
> as an exported service. PCI devices will continue to default with the 50ms
> timeout and use a per-device timeout when a driver calls this new service.

Can you include a pointer to something in the spec that's behind the
default 50ms timeout, or did somebody just pull that number out of the
air?

I'm wondering how we know 50ms or 120ms or 250ms or whatever is the
right number.  What bad things would happen if we just increased the
timeout from 50 to 125ms for *all* devices?

I don't really want to end up with a bunch of device-specific quirks
here.  If we have a quirk to work around one defective device, that's
one thing.  If the spec allows a huge variation in VPD access time,
that might be something we want to handle 

Bjorn
