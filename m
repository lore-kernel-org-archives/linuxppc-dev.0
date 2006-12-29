Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7B5B5DDEC2
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 10:04:38 +1100 (EST)
Message-ID: <45959EFC.4040404@freescale.com>
Date: Fri, 29 Dec 2006 17:04:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mpc83xx_restart() buggy
References: <006401c72a19$7680a5c0$1e67a8c0@Jocke>
	<48D9A818-DDBF-4DF1-9F79-AE93EC476511@kernel.crashing.org>
In-Reply-To: <48D9A818-DDBF-4DF1-9F79-AE93EC476511@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>,
	'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Dec 27, 2006, at 6:45 PM, Tjernlund wrote:
>>mpc83xx_restart() uses ioremap(), which doesn't like
>>beeing called while in IRQ context.
>>
>>Calling mpc83xx_restart() in IRQ context yields OOPS
>>which calls mpc83xx_restart() again and the loop never
>>termintes.
> 
> This is interesting, I know I've seen restart work properly w/o an  
> oops.  How are you causing the restart?

sysrq-b triggers it, as probably does crashing from an interrupt handler 
with panic_timeout nonzero.  You'll need CONFIG_DEBUG_SPINLOCK_SLEEP 
turned on, of course.

-Scott
