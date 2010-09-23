Return-Path: <david.hagood@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id BBD39B70E0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 21:11:13 +1000 (EST)
Received: by iwn37 with SMTP id 37so1646229iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 04:11:12 -0700 (PDT)
Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
From: David Hagood <david.hagood@gmail.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>, linuxppc-dev@ozlabs.org
In-Reply-To: <52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Sep 2010 06:11:08 -0500
Message-ID: <1285240268.2454.8.camel@chumley>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-23 at 05:21 +0200, Chen, Tiejun wrote:
> > I can get the device to show up on the host's PCI bus, I can 
> 
> This only ensure you can access the PCIe configure space.
Not quite: I can also read the BARs that I program, and the memory
behind them on the PPC.
> 
> > program the inbound ATMUs such that the BARS are updated when 
> > the host (re-)scans them, but I cannot for the life of me get
> 
> What value are configured to IntBound REGs?
I can program them at run time via sysfs on the PPC's side, so there is
no single set of values. However, I am pointing them at the PPC's RAM
space, and as I stated above, I can read the PPC's RAM from the host
side via the BARs.

> How do you configure OWS of PEXOWAR?
> 
> I means you still access that if OWS is match the whole target memory
> size even when '0' is as the internal platform address.
As I understand it, not if the OWS is not correctly mapped on the PPC
side - the PEX outbound ATMU's OWBAR must be mapped to a region of the
PPCs address space that is also mapped to PEX in the LAW. The LAW does
NOT indicate that PPC address 0 is mapped to the PEX.

> 
> Out_be32 should be fine for atmu REGs. And also you can refe to the
> function, setup_pci_atmu & setup_one_atmu, on the file,
> arch/powerpc/sysdev/fsl_pci.c, to know how to access atmu REGs. Often
> you should disable them, configure then enable/invoke atmu antry as
> normal configuring sequent.
I have tried disabling the outbound ATMU when I program it, with no
change.
I have looked at the functions you mention, and that is a part of my
confusion, as they aren't doing anything different than I am.
> 
> Additionally I'm a bit afraid your initial phase :) As you know PCIe
> would be used as RC mode on Freescale PowerPC kernel. So I don't know if
> you also drop this path on your kernel to conflict each other :) 
I have tried doing this under a kernel built without PCI support with no
change.
