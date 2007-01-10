Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8B707DDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 04:43:00 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0AHgwOe022960
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 10:42:58 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0AHgvCb005149
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 11:42:58 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
Date: Wed, 10 Jan 2007 10:42:56 -0700
Message-ID: <DDEDA444F5BF0E41AC8649FB40392C2901CD92E0@az33exm23.fsl.freescale.net>
In-Reply-To: <1168431197.22458.336.camel@localhost.localdomain>
From: "Wang Haiying-r54964" <Haiying.Wang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Zang Roy-r61911" <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
>While I agree that we should definitely test for NULL and properly fail
>instead of crashing, there is still the question of why do you fail at
>this point. Do you have PCI devices that don't have=20
>corresponding device
>nodes ? That is not a problem per-se, I'm just wondering if you have a
>device that is supposed to have a node but it's not matching due to a
>problem with the "reg" property...

The reason that it failed at this point is that there is a PCI bridge
connected to the PCI controller of the silicon. We defined this PCI
bridge as a pci node, but all the devices behind the bridge are not
defined as PCI node individually, thus they don't have "reg" property
except the bridge itself. Also, they are not on the same bus as which
the pci bridge is on. Please refer the
arch/powerpc/boot/dts/mpc8641_hpcn.dts or mpc8548cds.dts.

So we should definitely test for NULL here.=20

Haiying
