Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v22hD5tJ9zDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:02:34 +1100 (AEDT)
Subject: Re: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
To: Christoph Hellwig <hch@infradead.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
 <20170113180602.GA30346@infradead.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <587C61B3.3070107@ti.com>
Date: Mon, 16 Jan 2017 11:31:23 +0530
MIME-Version: 1.0
In-Reply-To: <20170113180602.GA30346@infradead.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On Friday 13 January 2017 11:36 PM, Christoph Hellwig wrote:
> Hi Kishon,
> 
> a couple comments on the configfs layout based on my experiments with
> your previous drop to implement a NVMe device using it.

Thanks for trying it out!
> 
> I don't think most of these configfs files should be present here, as
> they are properties of the implemented PCIe devices.  E.g. for my
> NVMe device they will be sort of hardcoded most of the time, as they
> would be for other devices that would always have a fixed vendor/device/
> class ID, cacheline size, etc.

Actually not all devices have hardcoded headers. E.g the platform I'm using
doesn't have hardcoded headers and it can be configured based on the function
the user would like to use. If the devices are hardcoded, then using configfs
can be skipped altogether. In such cases, APIs like pci_epf_create() can
directly be used by the drivers instead of going via configfs.

Thanks
Kishon
