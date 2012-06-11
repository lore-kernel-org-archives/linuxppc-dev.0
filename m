Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97F87B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 09:24:55 +1000 (EST)
Message-ID: <1339457081.9220.35.camel@pasglop>
Subject: Re: [PATCH v2 0/2] Add pcibios_device_change_notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 12 Jun 2012 09:24:41 +1000
In-Reply-To: <CAErSpo79RDid=4m+Q8FZxnhThQ9BAJo4HhtZ8ZQ5rGc1nmvH-w@mail.gmail.com>
References: <4FBC4C86.9050206@jp.fujitsu.com>
 <1338960416.7150.160.camel@pasglop>
 <CAErSpo79RDid=4m+Q8FZxnhThQ9BAJo4HhtZ8ZQ5rGc1nmvH-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Mon, 2012-06-11 at 16:51 -0600, Bjorn Helgaas wrote:

> > This makes me a bit nervous (that doesn't mean it's not right, but
> > we need some careful auditing & testing here, which I won't be
> > able to do until I'm back from leave). Mostly due to the change in when
> > we do the work.
> >
> > pcibios_fixup_bus() used to be called early on in the initial scan pass.
> >
> > Your code causes the code to be called -much- later when registering the
> > device with the device model. Are we 100% certain nothing will happen in
> > between that might rely on the stuff being setup already ? It might well
> > be ok, but I want us to triple check that.
> 
> Here's my theory on this: we're setting up DMA and IRQ stuff.  DMA and
> IRQ usage is device-specific, so the core can't do anything with them.
>  Only drivers know how to use them.  Drivers can't find the device
> until it's registered with the device model.  So it seems like it
> should be safe to move it later.  Subject to thinkos and testing in
> the real world, of course :)

I am aware of that and that's why I say "might well be ok" :-) But this
is old code and you know what can happen in there ... might be a quirk
here or a piece of platform code there trying to fixup the IRQ for
example ... before we set it up. That sort of thing.

I should be allright, but I want to test, which I won't be able to do
properly before I'm back at work next week.

> > Now, if we are ok to do the setup that late (basically right before the
> > driver probe() routine gets called), would it make sense to simplify
> > things even further ... and do it from pcibios_enable_device() ? Thus
> > avoiding the notifier business completely or is that pushing it too
> > far ?
> 
> Kenji-san actually suggested using pcibios_enable_device() early on,
> and I'm the one who suggested the notifiers instead.  I think I
> suggested that because I was copying the amd_iommu_init_notifier()
> style.
> 
> But I now think that might have been a mistake.  Notifiers are
> definitely more complicated, and a pcibios_*() hook seems
> straightforward.  It could be in pcibios_enable_device(), though we
> only need it to be called once, and the enable_device() path may be
> called many times, e.g., every time a driver claims it.  My new vote
> is a pcibios_device_add(), with an empty weak definition in
> drivers/pci, and a non-empty definition for microblaze and powerpc.

Would it be called before or after the notifiers ? I wonder... if others
already use the notifiers maybe we should stick to it. I only suggested
pcibios_enable_device() because it's already there.

> > Also you seem to add:
> >
> > +               /* Setup OF node pointer in the device */
> > +               dev->dev.of_node = pci_device_to_OF_node(dev);
> >
> > This shouldn't be needed anymore, the device node should be setup by the
> > core nowadays. Is this just a remnant of you rebasing an old patch or do
> > you have a good reason to add this statement ?
> 
> It sounds like you want to remove this line in any case, so I'll wait
> for updated patches.

Cheers,
Ben.
