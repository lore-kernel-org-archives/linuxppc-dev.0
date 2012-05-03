Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DDD8B6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 18:09:35 +1000 (EST)
Message-ID: <1336032561.18712.1.camel@pasglop>
Subject: Re: [PATCH] powerpc: use local var instead of
 local_paca->irq_happened directly in __check_irq_replay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Sheng-Hui <shhuiw@gmail.com>
Date: Thu, 03 May 2012 18:09:21 +1000
In-Reply-To: <4FA22CC5.3010107@gmail.com>
References: <4FA1E527.1090807@gmail.com> <1336011306.2653.3.camel@pasglop>
 <1336018961.2653.11.camel@pasglop> <4FA226A8.1080903@gmail.com>
 <4FA22CC5.3010107@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-03 at 14:59 +0800, Wang Sheng-Hui wrote:
> On 2012年05月03日 14:33, Wang Sheng-Hui wrote:
> > if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
> >> 		__hard_irq_disable();
> 
> I have commented out the 2 lines.

No, Only comment the test, you must absolutely leave the
__hard_irq_disable() call ! That's the whole point of the test, make
sure we unconditionally disable to see if that fixes the problem, in
which case that will tell us that we somewhere accidentally leave
irq_happened set to 0x01 while irqs are hard enabled.

Cheers,
Ben.
