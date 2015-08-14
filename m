Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 021701A0259
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 02:51:11 +1000 (AEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 2/4] PCI: pci-host-generic: Fix lookup of linux,
 pci-probe-only property
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20150814164324.GC22809@arm.com>
Date: Fri, 14 Aug 2015 09:50:54 -0700
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <Marc.Zyngier@arm.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-Id: <EA13B7D9-D612-4957-AF64-6B0BA0DFE06F@suse.de>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-3-git-send-email-marc.zyngier@arm.com>
 <20150814164051.GF26431@google.com> <20150814164324.GC22809@arm.com>
To: Will Deacon <will.deacon@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 14.08.2015, at 09:43, Will Deacon <will.deacon@arm.com> wrote:
>=20
> On Fri, Aug 14, 2015 at 05:40:51PM +0100, Bjorn Helgaas wrote:
>> On Fri, Aug 14, 2015 at 05:19:17PM +0100, Marc Zyngier wrote:
>>> When pci-host-generic looks for the probe-only property, it seems
>>> to trust the DT to be correctly written, and assumes that there
>>> is a parameter to the property.
>>>=20
>>> Unfortunately, this is not always the case, and some firmware expose
>>> this property naked. The driver ends up making a decision based on
>>> whatever the property pointer points to, which is likely to be junk.
>>>=20
>>> Switch to the common of_pci.c implementation that doesn't suffer
>>> from this problem.
>>>=20
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>> drivers/pci/host/pci-host-generic.c | 9 +--------
>>> 1 file changed, 1 insertion(+), 8 deletions(-)
>>>=20
>>> diff --git a/drivers/pci/host/pci-host-generic.c =
b/drivers/pci/host/pci-host-generic.c
>>> index 265dd25..545ff4e 100644
>>> --- a/drivers/pci/host/pci-host-generic.c
>>> +++ b/drivers/pci/host/pci-host-generic.c
>>> @@ -210,7 +210,6 @@ static int gen_pci_probe(struct platform_device =
*pdev)
>>> 	int err;
>>> 	const char *type;
>>> 	const struct of_device_id *of_id;
>>> -	const int *prop;
>>> 	struct device *dev =3D &pdev->dev;
>>> 	struct device_node *np =3D dev->of_node;
>>> 	struct gen_pci *pci =3D devm_kzalloc(dev, sizeof(*pci), =
GFP_KERNEL);
>>> @@ -225,13 +224,7 @@ static int gen_pci_probe(struct platform_device =
*pdev)
>>> 		return -EINVAL;
>>> 	}
>>>=20
>>> -	prop =3D of_get_property(of_chosen, "linux,pci-probe-only", =
NULL);
>>> -	if (prop) {
>>> -		if (*prop)
>>> -			pci_add_flags(PCI_PROBE_ONLY);
>>> -		else
>>> -			pci_clear_flags(PCI_PROBE_ONLY);
>>> -	}
>>> +	of_pci_check_probe_only(of_chosen);
>>=20
>> Do we need support for pci-probe-only in pci-host-generic at all?
>> You're removing the use in amd-overdrive.dts, and there are no other
>> DTs in the kernel tree that mention it.
>>=20
>> If we can live without it, that would be nice.  It seems like a relic =
from
>> days when we couldn't reliably assign resources.  (I'm not saying we =
can do
>> that reliably even today, but I'd rather make it reliable than turn =
it
>> off.)
>=20
> Kvmtool certainly uses it (and generates its own DT, hence why you =
don't
> see it in mainline). Not sure about qemu, though.

QEMU definitely doesn't do proble-only. Is this driver used on real PPC =
machines too? In that case you also won't see the dt, because it comes =
with the hardware ;).


Alex
