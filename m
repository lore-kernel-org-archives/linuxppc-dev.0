Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 62CE3DDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:24:12 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0B5O6aZ018796
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 22:24:06 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0B5O4pg004954
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:24:05 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168431197.22458.336.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
	<1168419440.1704.16.camel@localhost.localdomain>
	<1168431197.22458.336.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168493104.6411.10.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jan 2007 13:25:04 +0800
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

On Wed, 2007-01-10 at 20:13, Benjamin Herrenschmidt wrote:

> While I agree that we should definitely test for NULL and properly
> fail
> instead of crashing, there is still the question of why do you fail at
> this point. Do you have PCI devices that don't have corresponding
> device
> nodes ? 
Flat device tree does not allocate node for each PCI device on a bus.
> That is not a problem per-se, I'm just wondering if you have a
> device that is supposed to have a node but it's not matching due to a
> problem with the "reg" property...
The problem was induced by PCI bridge just as Haiying explained. Until
now, we do not describe PCI bridge in device tree. Only PCI host has the
"reg" property. We can not identify the PCI device on bus 0 or bus 1 by
node in device tree. The difference between device tree and OF might
introduce potential bugs for PCI bus. We should consider the difference.
> 
> In any case, a patch is definitely needed to properly check for NULL
> and
> should get into 2.6.20, so if you want to do it, it will be much
> welcome !
I will provide it later.
Roy
