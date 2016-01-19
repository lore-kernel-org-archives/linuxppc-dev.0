Return-Path: <gpkulkarni@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E44B1A0CDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 23:32:16 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id l65so22942217wmf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 04:32:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160119094150.GA4991@red-moon>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-6-git-send-email-gkulkarni@caviumnetworks.com>
 <569D23AF.9050503@gmail.com>
 <CAFpQJXXESn1EA5kotVOH2oLbRUSpOLf6+MeWG1pY_GhUP+4vVQ@mail.gmail.com>
 <20160119094150.GA4991@red-moon>
Date: Tue, 19 Jan 2016 18:02:13 +0530
Message-ID: <CAFpQJXV_5mryP5ZT5ezE7N9Csj97g7029D_9Fj_fNJ8+5n6O2w@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] PCI: generic: Make pci-host-generic driver numa
 aware
From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: David Daney <ddaney.cavm@gmail.com>, Will Deacon <Will.Deacon@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, rfranz@cavium.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "msalter@redhat.com" <msalter@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Steve Capper <steve.capper@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 tony.luck@intel.com, fenghua.yu@intel.com, james.hogan@imgtec.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, Jon Masters <jonathan@jonmasters.org>,
 Robert Richter <rrichter@cavium.com>,
 Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2016 at 3:11 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Jan 19, 2016 at 11:28:56AM +0530, Ganapatrao Kulkarni wrote:
>> On Mon, Jan 18, 2016 at 11:11 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> > On 01/18/2016 08:36 AM, Ganapatrao Kulkarni wrote:
>> >>
>> >> update numa_node of device associated with pci bus.
>> >> moved down devm_kzalloc to allocate from node memory.
>> >>
>> >> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> >> ---
>> >>   drivers/pci/host/pci-host-generic.c | 9 ++++++---
>> >>   1 file changed, 6 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/drivers/pci/host/pci-host-generic.c
>> >> b/drivers/pci/host/pci-host-generic.c
>> >> index 5434c90..0e1ce06 100644
>> >> --- a/drivers/pci/host/pci-host-generic.c
>> >> +++ b/drivers/pci/host/pci-host-generic.c
>> >> @@ -215,11 +215,9 @@ static int gen_pci_probe(struct platform_device
>> >> *pdev)
>> >>         const struct of_device_id *of_id;
>> >>         struct device *dev = &pdev->dev;
>> >>         struct device_node *np = dev->of_node;
>> >> -       struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> >> +       struct gen_pci *pci;
>> >>         struct pci_bus *bus, *child;
>> >>
>> >> -       if (!pci)
>> >> -               return -ENOMEM;
>> >>
>> >>         type = of_get_property(np, "device_type", NULL);
>> >>         if (!type || strcmp(type, "pci")) {
>> >> @@ -230,6 +228,11 @@ static int gen_pci_probe(struct platform_device
>> >> *pdev)
>> >>         of_pci_check_probe_only();
>> >>
>> >>         of_id = of_match_node(gen_pci_of_match, np);
>> >> +       set_dev_node(dev, of_node_to_nid(np));
>> >
>> >
>> > This shouldn't be done in individual platform_drivers, but instead in the
>> > device probing code.
>> >
>> > There is code that does this in drivers/of/platform.c and
>> > drivers/of/device.c  Is that not being called for the pci-host-gweneric
>> > devices?  If not, we should figure out why, and perhaps attempt to fix it
>> > rather than doing it here.
>> is it more appropriate to call of_platform_device_create ?
>
> That's already done to create the platform device by OF core when
> populating devices from DT, what David suggested is that you should
> add set_dev_node() to core OF code instead of adding it specifically
> to the PCI host generic code.
This patch was worked on 4.2(inherited to 4.4) to have correct
numa_node populated on sysfs.
however, on 4.4, OF  is fixed to set numa_node(fixed by
56f2de81e020c537f7e35550d13840143cb765cd)

This patch (patch #5) is not required and will be dropped.
thanks for your comments.


>
> Lorenzo
thanks
Ganapat
