Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1ED3467A95
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 13:32:02 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0501241548380.23263@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0501241548380.23263@blarg.somerset.sps.mot.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 13:31:32 +1100
Message-Id: <1106620292.15850.5.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, waite@skycomputers.com,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: fix powersave with interrupts disabled
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-24 at 15:51 -0600, Kumar Gala wrote:
> It looks like the problem has to do with entering the powersave routine 
> with irqs disabled. Here is a patch that will only enter powersave if irqs 
> are enabled.
> 
> Entering powersave on PPC while irqs are disabled causes a hang. Only 
> enter powersave if irqs are disabled.

I have a different fix which is to re-enable them (basically to move the
local_irq_disable we do in #ifdef CONFIG_SMP above the whole block,
removing the #else case).

I'm waiting for Ingo's ack about what exact race he's trying to fix
though...

Ben.
