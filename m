Return-Path: <bhelgaas@google.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F26EB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 16:37:12 +1100 (EST)
Received: by wiax18 with SMTP id x18so97126wia.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 21:37:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1330395009-29260-9-git-send-email-yinghai@kernel.org>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
 <1330395009-29260-9-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 27 Feb 2012 22:36:48 -0700
Message-ID: <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
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

On Mon, Feb 27, 2012 at 7:09 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =A0arch/powerpc/kernel/pci-common.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index 910b9de..ae5ae5f 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1660,6 +1660,8 @@ void __devinit pcibios_scan_phb(struct pci_controll=
er *hose)
> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
> =A0 =A0 =A0 =A0hose->bus =3D bus;
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last_=
busno);
> +
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1670,8 +1672,11 @@ void __devinit pcibios_scan_phb(struct pci_control=
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

There's a lot of powerpc code that does this:

    bus_range =3D of_get_property(pcictrl, "bus-range", &len);
    hose->first_busno =3D bus_range[0];
    hose->last_busno =3D bus_range[1];

That *looks* like it is discovering the bus number aperture.  Is it?
If it is, why are we using the largest bus number found by
pci_scan_child_bus() rather than "last_busno"?

Bjorn
