Return-Path: <bhelgaas@google.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com
 [IPv6:2a00:1450:400c:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D9E31A1D6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 06:26:44 +1000 (AEST)
Received: by wicja10 with SMTP id ja10so28403852wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 13:26:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150814164324.GC22809@arm.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-3-git-send-email-marc.zyngier@arm.com>
 <20150814164051.GF26431@google.com>
 <20150814164324.GC22809@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Aug 2015 15:26:21 -0500
Message-ID: <CAErSpo5abs2Qj25Bs+JVg87ve346f_RVz7jhNwqdv856+WvXQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI: pci-host-generic: Fix lookup of
 linux,pci-probe-only property
To: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2015 at 11:43 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Aug 14, 2015 at 05:40:51PM +0100, Bjorn Helgaas wrote:
>> On Fri, Aug 14, 2015 at 05:19:17PM +0100, Marc Zyngier wrote:
>> > When pci-host-generic looks for the probe-only property, it seems
>> > to trust the DT to be correctly written, and assumes that there
>> > is a parameter to the property.
>> >
>> > Unfortunately, this is not always the case, and some firmware expose
>> > this property naked. The driver ends up making a decision based on
>> > whatever the property pointer points to, which is likely to be junk.
>> >
>> > Switch to the common of_pci.c implementation that doesn't suffer
>> > from this problem.
>> >
>> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> > ---
>> >  drivers/pci/host/pci-host-generic.c | 9 +--------
>> >  1 file changed, 1 insertion(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
>> > index 265dd25..545ff4e 100644
>> > --- a/drivers/pci/host/pci-host-generic.c
>> > +++ b/drivers/pci/host/pci-host-generic.c
>> > @@ -210,7 +210,6 @@ static int gen_pci_probe(struct platform_device *pdev)
>> >     int err;
>> >     const char *type;
>> >     const struct of_device_id *of_id;
>> > -   const int *prop;
>> >     struct device *dev = &pdev->dev;
>> >     struct device_node *np = dev->of_node;
>> >     struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> > @@ -225,13 +224,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>> >             return -EINVAL;
>> >     }
>> >
>> > -   prop = of_get_property(of_chosen, "linux,pci-probe-only", NULL);
>> > -   if (prop) {
>> > -           if (*prop)
>> > -                   pci_add_flags(PCI_PROBE_ONLY);
>> > -           else
>> > -                   pci_clear_flags(PCI_PROBE_ONLY);
>> > -   }
>> > +   of_pci_check_probe_only(of_chosen);
>>
>> Do we need support for pci-probe-only in pci-host-generic at all?
>> You're removing the use in amd-overdrive.dts, and there are no other
>> DTs in the kernel tree that mention it.
>>
>> If we can live without it, that would be nice.  It seems like a relic from
>> days when we couldn't reliably assign resources.  (I'm not saying we can do
>> that reliably even today, but I'd rather make it reliable than turn it
>> off.)
>
> Kvmtool certainly uses it (and generates its own DT, hence why you don't
> see it in mainline). Not sure about qemu, though.

Do you know why kvmtool wants probe-only?  Would something break if we
didn't support probe-only?  I guess we'd be looking for a case where
Linux assigns resources and that assignment doesn't work with kvmtool?

"pci-probe-only" doesn't appear in qemu
(git://git.qemu-project.org/qemu.git).  (I guess Alexander confirmed
that later.)

Alexander wrote:
> QEMU definitely doesn't do proble-only.
> Is this driver used on real PPC machines too?

I think you're asking about pci-host-generic.c, and the answer is
"no," because pci-host-generic.c currently depends on CONFIG_ARM.

Bjorn
