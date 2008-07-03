Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFC24DDEF2
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 09:44:23 +1000 (EST)
Subject: Re: Support for low power mode for powerpc processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prodyut hazarika <prodyuth@gmail.com>
In-Reply-To: <49c0ff980807031252w2c01406dk63bd7d932db37720@mail.gmail.com>
References: <49c0ff980807031154qa5541c7k7065bdc1054d686a@mail.gmail.com>
	<20080703151646.511ce9b6@zod.rchland.ibm.com>
	<49c0ff980807031252w2c01406dk63bd7d932db37720@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Jul 2008 09:42:51 +1000
Message-Id: <1215128571.7960.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-03 at 12:52 -0700, prodyut hazarika wrote:
> But a lot of SoC like 440GT/EX support two modes of power save -
> - Cut off power to other cores like PCIExpress/USB/MAC/UART etc
> - Lower the CPU frequency
> 
> Is it possible to scale down CPU freq or cut off power to unused cores
> while the CPU is idle? The ideal way would be that the SoC registers a
> set of handlers to the Kernel that can power off/up the SoC components
> or reduce/restore CPU frequency. Does any such framework exist for
> PowerPC processors, because most PowerPC based SoC (FreeScale/AMCC
> etc) support the above two modes of power save.

Cutting off power to individual cores should be done by the drivers for
those cores (let's call the devices). For example, the USB driver could
cut of power when nothing is connected, though I'm not sure if it can do
that without losing the ability to detect new connections, but then, USB
has a suspend state that should make it mostly unnecessary. For the
UART, you may lose the ability to receive.

At the end of the day, if you don't use at all a core, disable it from
your firmware and set it as unused in the device-tree.

Ben.
