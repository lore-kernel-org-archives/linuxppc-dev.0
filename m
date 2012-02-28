Return-Path: <bhelgaas@google.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CC5DB6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 10:31:28 +1100 (EST)
Received: by wgbds1 with SMTP id ds1so2448671wgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 15:31:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
 <1330395009-29260-9-git-send-email-yinghai@kernel.org>
 <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 Feb 2012 16:31:04 -0700
Message-ID: <CAErSpo72_JnUkWXrzbNdbX9wiWZtQdX2tuNjEpYrSd+sGzxfzA@mail.gmail.com>
Subject: Re: [PATCH 08/18] PCI, powerpc: Register busn_res for root buses
To: Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 27, 2012 at 10:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote=
:
> On Mon, Feb 27, 2012 at 7:09 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>> =A0arch/powerpc/kernel/pci-common.c | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-=
common.c
>> index 910b9de..ae5ae5f 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1660,6 +1660,8 @@ void __devinit pcibios_scan_phb(struct pci_control=
ler *hose)
>> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
>> =A0 =A0 =A0 =A0hose->bus =3D bus;
>>
>> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last=
_busno);
>> +
>> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
>> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
>> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
>> @@ -1670,8 +1672,11 @@ void __devinit pcibios_scan_phb(struct pci_contro=
ller *hose)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL)
>> + =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, 255);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =3D=
 pci_scan_child_bus(bus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, bus->subo=
rdinate);
>> + =A0 =A0 =A0 }
>
> There's a lot of powerpc code that does this:
>
> =A0 =A0bus_range =3D of_get_property(pcictrl, "bus-range", &len);
> =A0 =A0hose->first_busno =3D bus_range[0];
> =A0 =A0hose->last_busno =3D bus_range[1];
>
> That *looks* like it is discovering the bus number aperture. =A0Is it?
> If it is, why are we using the largest bus number found by
> pci_scan_child_bus() rather than "last_busno"?

Sorry, I missed the earlier hunk of the patch where you *do* use last_busno=
:

>> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last=
_busno);

I still think this part is wrong:

+       if (mode =3D=3D PCI_PROBE_NORMAL) {
+               pci_bus_update_busn_res_end(bus, 255);
               hose->last_busno =3D bus->subordinate =3D pci_scan_child_bus=
(bus);
+               pci_bus_update_busn_res_end(bus, bus->subordinate);

I think there are two problems:

1) We can enumerate devices under the wrong PHB.  Assume this:

PCI host bridge A to [bus 00]
pci 0000:00:01.0: PCI bridge
PCI host bridge B to [bus 01]
pci 0000:01:01.0: PCI endpoint

The P2P bridge at 00:01.0 has no devices below it, but of course we
can't tell that until we look behind it.  To do that, we'll have to
assign a bus number, and since we forced the bus number aperture to
[bus 00-ff] instead of the correct [bus 00], we'll probably allocate
bus number 01 as the secondary bus.  Then we'll generate a config
cycle for 01:01.0, which discovers a device.  But we can't tell that
the cycle was actually claimed by host bridge B, not A.  So now we
wrongly think that 01:01.0 is under A, so we can't handle its
resources correctly.

I think we should have failed when allocating a secondary bus number
for 00:01.0 and just skipped looking behind it.

2) We preclude hot-add in some cases.  For example, if we scan this topolog=
y:

PCI host bridge C to [bus 00-7f]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:01:01.0: PCI endpoint

we set the root bus's subordinate bus number to 01 (the highest bus
number we discovered), so we now think host bridge C leads only to
[bus 00-01].  Now let's remove 01:01.0 and plug in a card with a
bridge on it, e.g.,

pci 0000:01:01.0: PCI bridge to ...
pci 0000:xx:01.0: PCI endpoint

We can't allocate a bus number for 01:01.0's secondary bus because we
think we're out of space.  But we're really not; the true bus number
aperture for C is [bus 00-7f], not [bus 00-01].

We may need mechanism to say "don't trust this info from the
firmware," but we should be able to figure out a way that doesn't
penalize platforms that do everything correctly.  The current patch
breaks these scenarios even when the platform firmware is 100%
correct.

Bjorn
