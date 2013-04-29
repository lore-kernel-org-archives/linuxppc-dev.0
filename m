Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB9DC2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 19:05:50 +1000 (EST)
Message-ID: <1367226339.7288.17.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix missing doorbell IPIs during nap power saving
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Mon, 29 Apr 2013 19:05:39 +1000
In-Reply-To: <1367223460-4931-1-git-send-email-imunsie@au1.ibm.com>
References: <1367223460-4931-1-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-29 at 18:17 +1000, Ian Munsie wrote:
> This is not an issue with other interrupts that can wake a thread
> (external, decrementer) as they are level sensitive and will continue to
> be asserted by the hardware.

However, it might be worth experimenting setting the corresponding
bits in the PACA as well, as this will diminish the latency of
processing them.

IE. local_irq_enable() will see the bit, generate an interrupt
frame and call the handler which is a faster path than re-enabling
MSR:EE and then taking an external interrupt.

Cheers,
Ben.
