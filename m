Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DDDECB6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 14:26:26 +1000 (EST)
Message-ID: <1336019173.2653.12.camel@pasglop>
Subject: Re: [PATCH] powerpc: use local var instead of
 local_paca->irq_happened directly in __check_irq_replay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Sheng-Hui <shhuiw@gmail.com>
Date: Thu, 03 May 2012 14:26:13 +1000
In-Reply-To: <4FA1EE2C.6050201@gmail.com>
References: <4FA1E527.1090807@gmail.com> <1336011306.2653.3.camel@pasglop>
 <4FA1EE2C.6050201@gmail.com>
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

On Thu, 2012-05-03 at 10:32 +0800, Wang Sheng-Hui wrote:
> > It should not as __check_irq_replay() should always be called
> > with interrupts hard disabled... Do you see any code path
> > where that is not the case ?
> 
> Since __check_irq_replay() should always be called with interrupts
> hard disabled, I think it's harmless to use local var here.

No, that would be papering over the real problem. All oprofile does is
trigger perfmon interrupts (which act as some kind of NMI when
soft-disabled but should be masked by MSR:EE when hard disabled).

So there's a deeper issue here that we need to understand before we can
propose a fix. IE. It should not have happened.

Cheers,
Ben.
