Return-Path: <bhelgaas@google.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F0D6B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 07:51:54 +1100 (EST)
Received: by wibhj6 with SMTP id hj6so1131250wib.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 12:51:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120223122536.6a2a7a6b@jbarnes-desktop>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org>
 <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
 <1328738567.2903.45.camel@pasglop>
 <CAErSpo7ekGn-+Mnyz7KL=fVFH3Ed19AeE3MKkZWJ4bd0Jo7kCw@mail.gmail.com>
 <1328823358.2903.77.camel@pasglop> <20120223122536.6a2a7a6b@jbarnes-desktop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 12:51:30 -0800
Message-ID: <CAErSpo7_WGjitDZz4XH+77f65Uz1ynd5_USN+D17D09Eux1iQQ@mail.gmail.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2012 at 12:25 PM, Jesse Barnes <jbarnes@virtuousgeek.org> w=
rote:
> On Fri, 10 Feb 2012 08:35:58 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Thu, 2012-02-09 at 11:24 -0800, Bjorn Helgaas wrote:
>> > My point is that the interface between the arch and the PCI core
>> > should be simply the arch telling the core "this is the range of bus
>> > numbers you can use." =A0If the firmware doesn't give you the HW limit=
s,
>> > that's the arch's problem. =A0If you want to assume 0..255 are
>> > available, again, that's the arch's decision.
>> >
>> > But the answer to the question "what bus numbers are available to me"
>> > depends only on the host bridge HW configuration. =A0It does not depen=
d
>> > on what pci_scan_child_bus() found. =A0Therefore, I think we can come =
up
>> > with a design where pci_bus_update_busn_res_end() is unnecessary.
>>
>> In an ideal world yes. In a world where there are reverse engineered
>> platforms on which we aren't 100% sure how thing actually work under the
>> hood and have the code just adapt on "what's there" (and try to fix it
>> up -sometimes-), thinks can get a bit murky :-)
>>
>> But yes, I see your point. As for what is the "correct" setting that
>> needs to be done so that the patch doesn't end up a regression for us,
>> I'll have to dig into some ancient HW to dbl check a few things. I hope
>> 0...255 will just work but I can't guarantee it.
>>
>> What I'll probably do is constraint the core to the values in
>> hose->min/max, and update selected platforms to put 0..255 in there when
>> I know for sure they can cope.
>
> But I think the point is, can't we intiialize the busn resource after
> the first & last bus numbers have been determined? =A0E.g. rather than
> Yinghai's current:
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last_=
busno);
> +
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_control=
ler *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL)
> + =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =3D =
pci_scan_child_bus(bus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, bus->subor=
dinate);
> + =A0 =A0 =A0 }
>
> we'd have something more like:
>
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_control=
ler *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (mode =3D=3D PCI_PROBE_NORMAL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =3D =
pci_scan_child_bus(bus);
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last_=
busno);
>
> since we should have the final bus range by then? =A0Setting the end to
> 255 and then changing it again doesn't make sense; and definitely makes
> the code hard to follow.

I have two issues here:

1) hose->last_busno is currently the highest bus number found by
pci_scan_child_bus().  If I understand correctly,
pci_bus_insert_busn_res() is supposed to update the core's idea of the
host bridge's bus number aperture.  (Actually, I guess it just updates
the *end* of the aperture, since we supply the start directly to
pci_scan_root_bus()).  The aperture and the highest bus number we
found are not related, except that we should have:

    hose->first_busno <=3D bus->subordinate <=3D hose->last_busno

If we set the aperture to [first_busno - last_busno], we artificially
prevent some hotplug.

2) We already have a way to add resources to a root bus: the
pci_add_resource() used to add I/O port and MMIO apertures.  I think
it'd be a lot simpler to just use that same interface for the bus
number aperture, e.g.,

    pci_add_resource(&resources, hose->io_space);
    pci_add_resource(&resources, hose->mem_space);
    pci_add_resource(&resources, hose->busnr_space);
    bus =3D pci_scan_root_bus(dev, next_busno, pci_ops, sysdata, &resources=
);

This is actually a bit redundant, since "next_busno" should be the
same as hose->busnr_space->start.  So if we adopted this approach, we
might want to eventually drop the "next_busno" argument.

 Bjorn
