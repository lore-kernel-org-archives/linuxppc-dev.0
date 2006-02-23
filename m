Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57A9C679F5
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2006 15:22:15 +1100 (EST)
In-Reply-To: <200602222129.31700.mbuesch@freenet.de>
References: <200602222129.31700.mbuesch@freenet.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A04DCF5-C5CF-46E2-A133-A7743BD83B17@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC: Sleeping function called from invalid context at
	emulate_instruction()
Date: Wed, 22 Feb 2006 22:22:17 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Michael Buesch <mbuesch@freenet.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 22, 2006, at 2:29 PM, Michael Buesch wrote:

> Hi,
>
> On a powerPC 32bit, I got the following debugging assertion failure:
>
> [  733.209827] Debug: sleeping function called from invalid context  
> at arch/powerpc/kernel/traps.c:697
> [  733.210682] in_atomic():0, irqs_disabled():1
> [  733.211347] Call Trace:
> [  733.211969] [D6023EB0] [C0007F84] show_stack+0x58/0x174  
> (unreliable)
> [  733.212765] [D6023EE0] [C0022C34] __might_sleep+0xbc/0xd0
> [  733.213523] [D6023EF0] [C000D158] program_check_exception 
> +0x1d8/0x4fc
> [  733.214309] [D6023F40] [C000E744] ret_from_except_full+0x0/0x4c
> [  733.215076] --- Exception: 700 at 0x102a7100
> [  733.215785]     LR = 0xdb9ef04
>
> It is caused by the line
> if (get_user(instword, (u32 __user *)(regs->nip)))
> in arch/powerpc/kernel/traps.c:emulate_instruction()
>
> I am not sure, if this is an indication for a bug, or just false  
> alarm.
> In case of false alarm, the debugging message should be made quiet
> somehow, though.

Paul,

Last time this was brought up we left it wondering why you had made  
program_check_exception() run with interrupts disabled.  Any further  
ideas on that one?

- kumar
