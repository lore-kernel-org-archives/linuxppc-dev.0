Return-Path: <bhelgaas@google.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BEAFB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 05:49:32 +1100 (EST)
Received: by wera1 with SMTP id a1so1045016wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 10:49:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329946899.20389.9.camel@pasglop>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
 <1329946899.20389.9.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 10:49:07 -0800
Message-ID: <CAErSpo6=ADAx0LPWQz-YGBm2opoKAMaPGDY6yqvkNY8riF9ZFQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with
 pci_flags
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2012 at 1:41 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>> =A0int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
>> diff --git a/arch/powerpc/platforms/pasemi/pci.c
>> b/arch/powerpc/platforms/pasemi/pci.c
>> index b6a0ec4..b27d886 100644
>> --- a/arch/powerpc/platforms/pasemi/pci.c
>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>> @@ -231,7 +231,7 @@ void __init pas_pci_init(void)
>> =A0 =A0 =A0 =A0 pci_devs_phb_init();
>>
>> =A0 =A0 =A0 =A0 /* Use the common resource allocation mechanism */
>> - =A0 =A0 =A0 pci_probe_only =3D 1;
>> + =A0 =A0 =A0 pci_add_flags(PCI_PROBE_ONLY);
>> =A0}
>
> Olof, do you remember why you used to set that on pasemi ?
>
> I would have expected it to be clear, so the kernel can re-assign things
> if needed. We really only want it set for pseries because of the
> hypervisor being a PITA :-)

Speaking of the hypervisor, powerpc has this of_scan_bus() thing which
seems to discover PCI devices using the OF device tree rather than
using PCI config accesses.  This seems related to the "pci_probe_only"
idea.

I wonder whether it would be possible/feasible/desirable to implement
this by using config space accessors that would internally look at the
OF device tree.  Then we possibly could use the standard PCI scan bus
path.  Maybe the core could detect non-changeable BARs somehow and
mark them, e.g., with IORESOURCE_PCI_FIXED.

Just a pie-in-the sky thought for now; I have no concrete plans to do
anything like this, but it seems like it might allow more unification
if it were possible.

Bjorn
