Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 44A7ADDE48
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 10:11:01 +1000 (EST)
Date: Mon, 15 Oct 2007 19:17:01 -0500
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] pasemi: process i2c device tree entries at boot
Message-ID: <20071016001701.GA25444@lixom.net>
References: <20071015015232.GA4641@lixom.net>
	<20071015224932.GA23875@lixom.net> <4713EFBB.3070203@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4713EFBB.3070203@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 05:54:51PM -0500, Scott Wood wrote:
> Olof Johansson wrote:
>> Setup i2c_board_info based on device tree contents. This has to be
>> a device_initcall since we need PCI to be probed by the time we
>> run it, but before the actual driver is initialized.
>
> Can we factor at least some of this stuff out into common code?

I didn't really feel strong motivations to do so, given that the amount
of shared code is quite small, and the official bindings are not yet
determined.

Chances are whenever the bindings are done they might be incompatible
with what we already have in our firmware, so the code would need to be
separated out again.

> We certainly shouldn't need more than one translation table, and this loop:
>
>> +static int __init pasemi_register_i2c_devices(void)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct device_node *adap_node;
>> +	struct device_node *node;
>> +
>> +	pdev = NULL;
>> +	while ((pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa003, pdev))) {
>> +		adap_node = pci_device_to_OF_node(pdev);
>
> Should be in the pasemi code, and pass a bus number and device node to 
> generic code that does this:

Yeah, it'd be the natural way of doing it, if it was needed.


-Olof
