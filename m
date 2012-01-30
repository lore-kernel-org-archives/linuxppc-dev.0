Return-Path: <bhelgaas@google.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6FD31007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 02:44:28 +1100 (EST)
Received: by wibhj6 with SMTP id hj6so3614610wib.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2012 07:44:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1327718971-9598-7-git-send-email-yinghai@kernel.org>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
 <1327718971-9598-7-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Jan 2012 07:44:04 -0800
Message-ID: <CAErSpo44qjFk5SQ+VWD=Y+Fg_xyykmh-ZOdFsfN-nELE29YP-A@mail.gmail.com>
Subject: Re: [PATCH 06/13] PCI, powerpc: Register busn_res for root buses
To: Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Paul Mackerras <paulus@samba.org>,
 linux-pci@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
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
> index cce98d7..501f29b 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1732,6 +1732,8 @@ void __devinit pcibios_scan_phb(struct pci_controll=
er *hose)
> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
> =A0 =A0 =A0 =A0hose->bus =3D bus;
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last_=
busno);

The pci_create_root_bus() call is a few lines above this.  So this is
a case of "create the root bus" followed by "fix something that's
wrong with the bus we just created."  I'm trying to get rid of that
pattern because it's just an opportunity for bugs.  I'd rather create
the root bus with all the information it needs up front.

And pci_bus_insert_busn_res() is not really architecture-specific, so
I'd like this better if that call were done in the PCI core somewhere.

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
> =A0 =A0 =A0 =A0/* Platform gets a chance to do some global fixups before
> =A0 =A0 =A0 =A0 * we proceed to resource allocation
> --
> 1.7.7
>
