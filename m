Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F666DE058
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:25:32 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc: don't pass unused regs around in head_.*.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <1223820494-7822-2-git-send-email-sebastian@breakpoint.cc>
References: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
	<1223820494-7822-2-git-send-email-sebastian@breakpoint.cc>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:25:12 +1100
Message-Id: <1223940312.8157.281.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-10-12 at 16:08 +0200, Sebastian Andrzej Siewior wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This looks like a relict from arch/ppc. machine_init() is accepting
> only two parameters (dtb, phys) and is using only the first one.

This isn't 100% correct actually...

First, the base head_32.S (could be called head_6xx.S I suppose)
supports a few more calling conventions such as the real OF one, with
added support for initrd and cmdline in registers , and the BootX one.

Then, calling convention for the other cases is slightly better defined
than just having r3 contain a device-tree pointer. The physical address
is an important part of it, the fact that r5 is NULL to differenciate
from an OF entry too, and we're moving toward the full ePAPR definition.

Cheers,
Ben.
