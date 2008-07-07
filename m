Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53432DE247
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:31:12 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67FV8eY030754
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 11:31:08 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67FV0Wu177098
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:31:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67FUxda021189
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:30:59 -0600
Date: Mon, 7 Jul 2008 11:27:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: prodyut hazarika <prodyuth@gmail.com>
Subject: Re: Support for low power mode for powerpc processors
Message-ID: <20080707112732.3b6c74fb@zod.rchland.ibm.com>
In-Reply-To: <1215128571.7960.10.camel@pasglop>
References: <49c0ff980807031154qa5541c7k7065bdc1054d686a@mail.gmail.com>
	<20080703151646.511ce9b6@zod.rchland.ibm.com>
	<49c0ff980807031252w2c01406dk63bd7d932db37720@mail.gmail.com>
	<1215128571.7960.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 04 Jul 2008 09:42:51 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2008-07-03 at 12:52 -0700, prodyut hazarika wrote:
> > But a lot of SoC like 440GT/EX support two modes of power save -
> > - Cut off power to other cores like PCIExpress/USB/MAC/UART etc
> > - Lower the CPU frequency
> > 
> > Is it possible to scale down CPU freq or cut off power to unused cores
> > while the CPU is idle? The ideal way would be that the SoC registers a
> > set of handlers to the Kernel that can power off/up the SoC components
> > or reduce/restore CPU frequency. Does any such framework exist for
> > PowerPC processors, because most PowerPC based SoC (FreeScale/AMCC
> > etc) support the above two modes of power save.
> 
> Cutting off power to individual cores should be done by the drivers for
> those cores (let's call the devices). For example, the USB driver could
> cut of power when nothing is connected, though I'm not sure if it can do
> that without losing the ability to detect new connections, but then, USB
> has a suspend state that should make it mostly unnecessary. For the
> UART, you may lose the ability to receive.
> 
> At the end of the day, if you don't use at all a core, disable it from
> your firmware and set it as unused in the device-tree.

Right.

To answer the "can the CPU frequency be scaled" question, the answer is
"maybe".  You certainly want to make sure that timebase stays constant
in those transitions, which is easiest to do if timebase is driven by
an external clock and not the CPU clock.

There are also PLB/OPB divisor ratios that have to be taken into
account when changing the CPU frequency.  If the hardware can handle
this for you, then it should work well enough.  I know of at least one
4xx chip that has had CPU frequency scaling working.

If you pursue this at all, you will want to do it as a cpufreq driver.
That will allow you to use the generic cpufreq infrastructure in the
kernel, including the governors.

josh
