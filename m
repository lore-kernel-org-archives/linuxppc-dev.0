Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 5F7EDDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 05:34:02 +1100 (EST)
Received: by qyk14 with SMTP id 14so1132387qyk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 10:34:01 -0800 (PST)
Message-ID: <c384c5ea0811261026y73679a16tfa29a33f3e780954@mail.gmail.com>
Date: Wed, 26 Nov 2008 19:26:47 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: AMCC PPC460EX Canyonlands does not see PCIe end point with only
	non-prefetchable memory (both 2.6.27.7 and -next)
In-Reply-To: <c384c5ea0811260725x3476fa43o9950123948e99acb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0811260632n24e8b536v9a4a16833644976c@mail.gmail.com>
	<c384c5ea0811260725x3476fa43o9950123948e99acb@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2008 at 4:25 PM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
> The non-detected end point boot:
>
> pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
> PCI: Scanning bus 0001:81
> PCI: Fixups for bus 0001:81
>
Further debugging.

drivers/pci/probe.c:
static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
{
...
	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
		return NULL;
...
	/* some broken boards return 0 or ~0 if a slot is empty: */
	if (l == 0xffffffff || l == 0x00000000 ||
	    l == 0x0000ffff || l == 0xffff0000) {
  	printk(KERN_WARNING "--- slot empty?! l == 0x%lx\n", (u32)l);
		return NULL;
	}

It ends up here with l == 0xffffffff.

Note that u-boot finds the end point vendor ID, and Linux on x86 and
Linux on  mpc8316e powerpc also.

Regards,
-- 
Leon
