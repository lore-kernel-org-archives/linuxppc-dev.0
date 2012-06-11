Return-Path: <bhelgaas@google.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2566B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 08:51:29 +1000 (EST)
Received: by lagw12 with SMTP id w12so2849992lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 15:51:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1338960416.7150.160.camel@pasglop>
References: <4FBC4C86.9050206@jp.fujitsu.com>
 <1338960416.7150.160.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 11 Jun 2012 16:51:04 -0600
Message-ID: <CAErSpo79RDid=4m+Q8FZxnhThQ9BAJo4HhtZ8ZQ5rGc1nmvH-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add pcibios_device_change_notifier
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, jbarnes@virtuousgeek.org,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 5, 2012 at 11:26 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-05-23 at 11:33 +0900, Hiroo Matsumoto wrote:
>> This patchset is for PCI hotplug.
>>
>>
>> pcibios_setup_bus_devices which sets DMA and IRQs of PCI device is calle=
d
>> only when boot. DMA setting in probe for PCI driver, like dma_set_mask,
>> does not work on powerpc platform. So it is need to set DMA and IRQs of
>> PCI device when hotplug.
>>
>> 1. Moving pcibios_setup_bus_devices code to pcibios_device_change_notifi=
er
>> =A0 =A0which is registered to bus notifier in pcibios_init.
>> 2. Removing caller and callee of pcibios_setup_bus_devices bus notifier
>> =A0 =A0works instead of pcibios_setup_bus_devices.
>> 3. Using this bus notifier for microblaze because microblaze/PCI is simi=
ler
>> =A0 =A0with powerpc/PCI.
>
> This makes me a bit nervous (that doesn't mean it's not right, but
> we need some careful auditing & testing here, which I won't be
> able to do until I'm back from leave). Mostly due to the change in when
> we do the work.
>
> pcibios_fixup_bus() used to be called early on in the initial scan pass.
>
> Your code causes the code to be called -much- later when registering the
> device with the device model. Are we 100% certain nothing will happen in
> between that might rely on the stuff being setup already ? It might well
> be ok, but I want us to triple check that.

Here's my theory on this: we're setting up DMA and IRQ stuff.  DMA and
IRQ usage is device-specific, so the core can't do anything with them.
 Only drivers know how to use them.  Drivers can't find the device
until it's registered with the device model.  So it seems like it
should be safe to move it later.  Subject to thinkos and testing in
the real world, of course :)

> Now, if we are ok to do the setup that late (basically right before the
> driver probe() routine gets called), would it make sense to simplify
> things even further ... and do it from pcibios_enable_device() ? Thus
> avoiding the notifier business completely or is that pushing it too
> far ?

Kenji-san actually suggested using pcibios_enable_device() early on,
and I'm the one who suggested the notifiers instead.  I think I
suggested that because I was copying the amd_iommu_init_notifier()
style.

But I now think that might have been a mistake.  Notifiers are
definitely more complicated, and a pcibios_*() hook seems
straightforward.  It could be in pcibios_enable_device(), though we
only need it to be called once, and the enable_device() path may be
called many times, e.g., every time a driver claims it.  My new vote
is a pcibios_device_add(), with an empty weak definition in
drivers/pci, and a non-empty definition for microblaze and powerpc.

> Also you seem to add:
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup OF node pointer in the device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dev.of_node =3D pci_device_to_OF_node(=
dev);
>
> This shouldn't be needed anymore, the device node should be setup by the
> core nowadays. Is this just a remnant of you rebasing an old patch or do
> you have a good reason to add this statement ?

It sounds like you want to remove this line in any case, so I'll wait
for updated patches.

Bjorn
