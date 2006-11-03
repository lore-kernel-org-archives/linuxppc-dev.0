Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7985667C08
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 07:34:35 +1100 (EST)
Subject: Re: [patch 13/16] powerpc: make prom_init.o dependent on PPC_OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20061103094745.GE22478@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125629.335003000@localhost.localdomain>
	<1162506853.10630.55.camel@localhost.localdomain>
	<20061103094745.GE22478@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 07:34:28 +1100
Message-Id: <1162586069.10630.84.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I don't know yet where the exact boarders are in the code between real
> OF and flat device tree. Maybe I can look at it once I have a proper
> device tree for my board.
> Out of curiosity I just disabled CONFIG_PPC_OF. There were two undefined
> references to functions I didn't need at the moment. After commenting
> them out the kernel compiled and booted. It saved me ~10k kernelsize,
> but ok, I thought I would still have flat tree support.

Hrm... it's unclear, I think we changed it a couple of times. In fact,
since the flat DT support is mandatory, I suppose CONFIG_PPC_OF could be
used as "supports booting from a real OF". But in this case, prom_init
is really the only thing that should be covered by it.

Right now, it's used for bits in pci_32.c which should always be enabled
for arch/powerpc so ...

Also, I think we could safely get rid of the pci_OF_bus_map. I don't
think it's ever been used and we have the devspec files now.

Ben.
