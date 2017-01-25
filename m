Return-Path: <kishon@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7Ypn5kfVzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 16:42:25 +1100 (AEDT)
Subject: Re: [PATCH 31/37] misc: Add host side pci driver for pci test
 function device
To: Christoph Hellwig <hch@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-32-git-send-email-kishon@ti.com>
 <20170124160224.GA23528@infradead.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58883A65.8020306@ti.com>
Date: Wed, 25 Jan 2017 11:10:53 +0530
MIME-Version: 1.0
In-Reply-To: <20170124160224.GA23528@infradead.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tuesday 24 January 2017 09:32 PM, Christoph Hellwig wrote:
> On Thu, Jan 12, 2017 at 03:56:20PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCI endpoint test driver that can verify base address
>> register, legacy interrupt/MSI interrupt and read/write/copy
>> buffers between host and device. The corresponding pci-epf-test
>> function driver should be used on the EP side.
> 
> Just curious:  what would you think of a text based (e.g. debugfs)
> interface to avoid the need for a userspace tool here?

I felt having a userspace tool gives the flexibility to add more tests
(iterations, sizes etc..) while the driver can just focus on performing simple
tests. Say we'd like to perform infinite read/write tests, it's better if the
userspace tool invokes read/write tests repeatedly instead of that being
implemented in the driver.
> 
>> +static const struct pci_device_id pci_endpoint_test_tbl[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
> Also this looks really odd, and dangerous.  Probing for any
> TI device will bind to all kinds of legit devices.  It would
> be good if you could squeeze out a single id for this device

There is actually an id for the device, but I think we'll need an id for every
function right?

Having said that the id for the device is better than PCI_ANY_ID. Will fix it
in my next revision.

Thanks
Kishon
