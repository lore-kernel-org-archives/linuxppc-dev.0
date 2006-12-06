Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0780067CB1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 09:15:45 +1100 (EST)
In-Reply-To: <17783.16290.783728.708434@cargo.ozlabs.ibm.com>
References: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
	<17783.16290.783728.708434@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4CF47E53-356C-49B7-9F8B-9C61CF8103E5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Change the program check exception from EXC_XFER_STD
	to EXC_XFER_EE.
Date: Wed, 6 Dec 2006 16:15:39 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 6, 2006, at 4:09 PM, Paul Mackerras wrote:

> Scott Wood writes:
>
>> Is there any reason why ProgramCheck needs to be EXC_XFER_STD?
>
> Yes.  It used to be EXC_XFER_EE, but I changed it to EXC_XFER_STD
> because I didn't want the possibility of preemption on the way from a
> kernel breakpoint into a kernel debugger (xmon/kgdb/etc.).
>
> I think the solution to your problem is to rearrange
> program_check_exception a little, to make sure we do the
> local_irq_enable before calling do_mathemu (but still after the
> debugger_bpt call).

We don't need to rearrange anything, just put the local_irq_enable()  
call in do_mathemu().  If we are a debugger than REASON_TRAP will  
have to be set and we dont bother with do_mathemu() than.

Do you think we should also move the local_irq_enable() that exists  
in the handler into emulate_instruction().

- k
