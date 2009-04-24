Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 417D2DDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 03:35:16 +1000 (EST)
Message-ID: <49F1F841.8080507@freescale.com>
Date: Fri, 24 Apr 2009 12:34:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: help with inline assembly code?
References: <49F1F56C.8000708@nortel.com>
In-Reply-To: <49F1F56C.8000708@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen wrote:
> I've got a function that is used to overwrite opcodes in order to create 
> self-modifying code.  It worked just fine with previous compilers, but 
> with gcc 4.3 it seems like it sometimes (but not always) causes problems 
> when inlined.  If I force it to never be inlined, it works fine.
> 
> First, here's the code:
> 
> void alter_opcode(unsigned long *addr, unsigned long opcode)
> {
>     asm volatile(
>                 "stw    %1,0(%0)    \n\t"
>                 "dcbf   0,%0        \n\t"
>                 "sync            \n\t"
>                 "icbi   0,%0,        \n\t"
>                 "isync            \n\t"
>                     :: "r" (addr), "r" (opcode): "memory");
> }
> 
> The symptom of the problem is a segfault on the "stw" instruction.  I've 
> verified that the address it's trying to write to is the expected 
> address, 

Verified by looking at the address in "addr", or by looking at the 
reported faulting address?

> and that the opcode being written is the expected opcode.
> 
> I assume I've mixed up the registers or constraints or 
> something...anyone want to take a crack at it?

Is the compiler assigning r0 to addr?  That will be treated as a literal 
zero instead.  Try changing "r" (addr) to "b" (addr), or use stwx.

-Scott
