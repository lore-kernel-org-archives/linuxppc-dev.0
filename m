Return-Path: <david.hagood@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 29411B7116
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 00:20:56 +1000 (EST)
Received: by iwn4 with SMTP id 4so1168164iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 07:20:52 -0700 (PDT)
Message-ID: <e7c7327df154359eb271364b5b579a52.squirrel@localhost>
In-Reply-To: <1285672565.6920.3.camel@parana.digitel.com.br>
References: <1285672565.6920.3.camel@parana.digitel.com.br>
Date: Tue, 28 Sep 2010 09:20:24 -0500
Subject: Re: Doubt about Linux PCIe infraestructure
From: david.hagood@gmail.com
To: "Carlos Roberto Moratelli" <carlos.moratelli@digitel.com.br>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi,
>
> I have a simple doubt about linux PCI/PCIe infraestructure.
>
> When I register a PCI driver using pci_register_driver() will the
> probe function be automatically called or will it just be called if PCI
> infraestructure match a Vendor and Device id on bus?
When you register your driver, you supply a list of VID/DID pairs for
which your driver is applicable, and if those devices are on the bus, your
probe will be called.

>
> I am loading a PCI driver that register itself using
> pci_register_driver() but the probe function isn't called.
>
If you didn't indicate your driver was for the VID/DID of the device, your
probe won't be called - why should it? As far as you told the kernel,
there's no hardware pertaining to your driver.

The old days of "every driver probes every device" are gone.

Here's an example code fragment:

/* define the list of devices we support */
static struct pci_device_id ppc_ep_device_ids[] =
{
      {PCI_DEVICE(PCI_VENDOR_ID_FREESCALE,PCI_DEVICE_ID_MPC8641D)},
      {0} /* end of list indicator */
};
MODULE_DEVICE_TABLE(pci, ppc_ep_device_ids); /* tell udev to load our
module for these devices */

pci_register_driver(&ppc_ep_device_driver); /* tell the kernel we handle
these devices */
