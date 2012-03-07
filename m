Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A3C6B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 21:45:04 +1100 (EST)
Subject: Re: [PATCH 2/9] powerpc/mpc85xxcds: Fix PCI I/O space resource of PCI
 bridge
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7AA2FF042C086D469F577FA6723434DA015EEA@039-SN1MPN1-002.039d.mgd.msft.net>
Date: Wed, 7 Mar 2012 04:45:03 -0600
Message-Id: <327EA0C3-3ED8-4945-8007-9F47332FBCC2@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <7FB9C27D-621B-4DF0-BFE0-CBF2D49B52D6@kernel.crashing.org>
 <7AA2FF042C086D469F577FA6723434DA015EEA@039-SN1MPN1-002.039d.mgd.msft.net>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 7, 2012, at 3:31 AM, Zhao Chenhui-B35336 wrote:

>>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>> index 40f03da..c009c5b 100644
>>> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
>>> @@ -3,7 +3,7 @@
>>> *
>>> * Maintained by Kumar Gala (see MAINTAINERS for contact information)
>>> *
>>> - * Copyright 2005 Freescale Semiconductor Inc.
>>> + * Copyright 2005, 2011-2012 Freescale Semiconductor Inc.
>>> *
>>> * This program is free software; you can redistribute  it and/or =
modify it
>>> * under  the terms of  the GNU General  Public License as published =
by the
>>> @@ -158,6 +158,31 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, =
skip_fake_bridge);
>>> DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
>>> DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
>>>=20
>>> +/*
>>> + * Fix Tsi310 PCI-X bridge resource.
>>> + * Force the bridge to open a window from 0x0000-0x1fff in PCI I/O =
space.
>>> + * This allows legacy I/O(i8259, etc) on the VIA southbridge to be =
accessed.
>>> + */
>>=20
>> This comment and the code don't make sense.  Why is the bridge =
described as Tsi310 in comments but the
>> vendor ID is IBM ?
>=20
> This chip is from IBM originally, and bought by IDT.
> The vendor ID is IBM, but the part number is Tsi310(IDT).
>=20

Ok, we should probably call it PCI_DEVICE_ID_..._TSI310

- k
