Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9CA8B2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 02:26:40 +1100 (EST)
Message-ID: <1364397928.11644.41.camel@pasglop>
Subject: Re: [PATCHv2 1/3] pci: added pcie_get_speed_cap_mask function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Mar 2013 16:25:28 +0100
In-Reply-To: <CAErSpo4rc=8mYgwuTO6693QCQJ9nsPsxmh7YAwxMygiVrPQR0A@mail.gmail.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1363757079-23550-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <CAErSpo4rc=8mYgwuTO6693QCQJ9nsPsxmh7YAwxMygiVrPQR0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 DRI mailing list <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-03-26 at 12:39 -0600, Bjorn Helgaas wrote:
> But we also know pdev is a PCIe device, and I think a PCIe device on a
> root bus must be a "Root Complex Integrated Endpoint" (PCIe spec sec
> 1.3.2.3).  Such a device does not have a link at all, so there's no
> point in fiddling with its link speed.

This is where our IBM hypervisor makes things murky. It doesn't expose
the PCIe parents (basically somewhat makes PCIe look like PCI except we
still have the PCIe caps on the child devices, just no access to the
parent device).

It's garbage but can't be fixed (would break AIX :-)

However we might be able to populate the bus->max_bus_speed from some
architecture specific quirk and have radeon use that.

Cheers,
Ben.
