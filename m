Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7180CDDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 20:21:33 +1100 (EST)
Message-ID: <49783993.4090408@denx.de>
Date: Thu, 22 Jan 2009 10:17:07 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: wael showair <showair2003@yahoo.com>
Subject: Re: eth0: Could not attach to PHY
References: <mailman.1613.1232571316.4534.linuxppc-dev@ozlabs.org>
In-Reply-To: <mailman.1613.1232571316.4534.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello wael,

wael showair <showair2003@yahoo.com> wrote:
> i have a board with MPC8555 processor
> uboot version 1.1.6
> linux kernel 2.6.19-rc5
> ltib version: 6.2.2-sv
> gcc 3.4.3
> 
> it boots successfully
> i want to upgrade my linux kernel to 2.6.27
> i upgraded the following:
> ltib version 8.1.2-sv
> gcc 4.1
> linux kernel 2.6.27
> & i kept the uboot with the same version 1.1.6
> 
> the kernel booting stucks as follows:
> 
> *****************************************************************************
> U-Boot 1.1.6 (Feb  8 2007 - 14:00:17)
[...]
> RPC: Registered tcp transport module.
> 24520:10 not found
> eth0: Could not attach to PHY

Here is your problem. For some reason, your network driver
couldnt find the PHY ... Maybe there is something changed
between 2.6.19-rc5 and 2.6.27.

> IP-Config: Failed to open eth0
> IP-Config: Failed to open eth1
> IP-Config: No network devices available.

and so, there is no network device ...

I have no 85xx board, but maybe following commit is something
for you:

gianfar: Convert gianfar to an of_platform_driver
author	Andy Fleming <afleming@freescale.com>
	Tue, 16 Dec 2008 23:29:15 +0000 (15:29 -0800)
committer	David S. Miller <davem@davemloft.net>
	Tue, 16 Dec 2008 23:29:15 +0000 (15:29 -0800)
commit	b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4
tree	f8643c2fd1b137dd6c00bcd385ad36adfca4f540	tree | snapshot
parent	257d938a0c17838c740eb68f0005b041444ac2c2	commit | diff
gianfar: Convert gianfar to an of_platform_driver

Does the same for the accompanying MDIO driver, and then modifies the TBI
configuration method.  The old way used fields in einfo, which no longer
exists.  The new way is to create an MDIO device-tree node for each instance
of gianfar, and create a tbi-handle property to associate ethernet controllers
with the TBI PHYs they are connected to.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

----------------------------------------------------------------------

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
