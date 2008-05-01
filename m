Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE705DE05C
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 05:02:27 +1000 (EST)
Message-ID: <481A13DF.3000405@freescale.com>
Date: Thu, 01 May 2008 14:02:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<18457.32297.485053.356477@cargo.ozlabs.ibm.com>
	<2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
	<20080501161451.GH17142@ld0162-tx32.am.freescale.net>
	<78125A27-D99A-447D-9C65-4705DD153567@kernel.crashing.org>
	<20080501164228.GA17992@ld0162-tx32.am.freescale.net>
	<17325743-606C-4B3D-88C0-2D0B7902B4E1@kernel.crashing.org>
In-Reply-To: <17325743-606C-4B3D-88C0-2D0B7902B4E1@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> copying the flags isn't the issue.  Its acting on the flags thats the 
> problem.  I'm not 100% sure the C code that might clear the flags is 
> consistent on how it access them.  

Actually *delivering* the signal should never be done except when 
returning to user.  That's different from sending the signal, though.

BTW, it doesn't seem all that unreasonable for a kernel 
profiling/tracing exception to signal a process that, for example, an 
event buffer is over a certain threshold.

 > So if one bit of code clears
 > task_struct->stack->thread_info->flags and other clears
 > thread_info(STACK)->flags we get into an issue on how to merge after
 > that.

It appears that TIF_SIGPENDING is always accessed through the task 
struct, though not so for TIF_NEED_RESCHED.

-Scott
