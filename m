Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35dV6CRPzF0CG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:19:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Darren Stevens <darren@stevens-zone.net>,
 "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root
 bus
In-Reply-To: <af18fb51-a0bc-68e2-7594-5583e3090f98@xenosoft.de>
References: <20171202230052.34y2ivxgpgr3osct@localhost>
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
 <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
 <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
 <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
 <87fu8odnfk.fsf@concordia.ellerman.id.au>
 <20171206210637.GO23510@bhelgaas-glaptop.roam.corp.google.com>
 <877etxh1lf.fsf@concordia.ellerman.id.au>
 <f5fe03d3-87f8-2a2d-2d83-fbefcd489a77@xenosoft.de>
 <98c7e034-b523-a703-e637-957e2857ab32@xenosoft.de>
 <20171215202509.GZ30595@bhelgaas-glaptop.roam.corp.google.com>
 <6326d79e-405b-2ae8-5295-97bf11219b81@xenosoft.de>
 <af18fb51-a0bc-68e2-7594-5583e3090f98@xenosoft.de>
Date: Fri, 22 Dec 2017 22:19:58 +1100
Message-ID: <87zi6bnh5t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Hi Bjorn,
>
> Sorry I'm bothering you again. Is this small out of tree init routine in=
=20
> the Nemo patch? I haven't get an answer from Darren yet and I didn't=20
> found the small out of tree init routine in the Nemo patch. Please find=20
> attached the Nemo patch. Maybe you can find this small out of tree init=20
> routine.
>
> What do you think of this following code?
>
> if (sb600_bus =3D=3D -1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 busp =3D pci_find_bus(0, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pa_pxp_read_config(busp, PCI_DEVFN(17,0),=20
> PCI_SECONDARY_BUS, 1, &val);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sb600_bus =3D val;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 printk(KERN_CRIT "NEMO SB600 on bus %d.\n",sb600_bus);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

I suspect Darren was referring to all of sb600_set_flag().

What we'd really like is to be able to do something like:

void __init pas_pci_init(void)
{
	...

	if (of_find_compatible_node(NULL, NULL, "nemo-something"))
		pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS).


But I don't know if there's anything in the NEMO device tree that we can
use to uniquely identify those machines? ie. the "nemo-something" string.

Can you attach the output of `lsprop /proc/device-tree` ?

cheers
