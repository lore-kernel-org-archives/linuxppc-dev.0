Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 233292C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 08:50:00 +1000 (EST)
Received: by mail-ob0-f169.google.com with SMTP id up14so3460439obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jul 2013 15:49:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1373063807.4446.10.camel@pasglop>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
 <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
 <1373063807.4446.10.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Jul 2013 16:49:37 -0600
Message-ID: <CAErSpo52hic4nb-RtTT+e1nhXFeuWUJWajEzMy3j6wzWHVaG4A@mail.gmail.com>
Subject: Re: [PATCH 1/8] PCI: Add pcibios_stop_dev()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 5, 2013 at 4:36 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-07-05 at 12:49 -0600, Bjorn Helgaas wrote:
>> We already have pcibios_release_device() (just merged for v3.11).
>> Would that work for you?  I haven't seen your whole series, so I can't
>> tell whether you need something different.
>
> Maybe... Gavin's original hook applies when the device is removed
> from the tree, your new hook when the refcount expires and the
> structure is about to be freed...

Yep, pcibios_release_device() is definitely at a different point.  I
just want to avoid exposing too many points in the device lifetime to
the arch, because it makes it so much harder to refactor things.

> I *suspect* that's fine but I'll need to have a closer look (or wait
> for Gavin to be back from vacation :-)
>
> BTW. One thing we do in EEH is that if we get an error and the driver
> for the device doesn't implement recovery, we simulate a hotplug.
>
> IE. We unplug the device (currently removing it), reset it (or the
> bus it's on, whatever applies, which lifts the fence established by
> the EEH hardware), and re-plug it.
>
> The current method really removes the device from the PCI subsystem,
> and "plugs" it back. IE. We rescan the slot, and might even end up
> re-assigning resources, which I'm not too fan about. It's also unclear
> what quirks gets called in that re-plug case, etc...
>
> I'm wondering whether it might be better to keep the pci_dev around,
> just mark it blocked for user access, unbind the driver, reset, restore
> the BARs to their original values, unblock and re-bind.

Personally, I like the full hotplug approach, even though it will
probably reassign resources, because it uses the standard paths that
should be better-tested, and it's clear what should happen.
Reassigning resources should be OK because we already have to do that
for the non-error handling hot-add case.

I know we have paths where we save config space, do a reset, and
restore config space.  I don't like those because some quirks aren't
applied and I don't believe restoring config space is sufficient to
make the device safe to use.  There could be internal state that we
aren't restoring.  It's also possible that a firmware update means the
device is different than it was before the reset, e.g., BARs could be
different types or sizes.

Bjorn
