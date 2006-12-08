Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17784.59774.968517.908414@cargo.ozlabs.ibm.com>
Date: Fri, 8 Dec 2006 15:26:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Change the program check exception from EXC_XFER_STD
	to EXC_XFER_EE.
In-Reply-To: <4CF47E53-356C-49B7-9F8B-9C61CF8103E5@kernel.crashing.org>
References: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
	<17783.16290.783728.708434@cargo.ozlabs.ibm.com>
	<4CF47E53-356C-49B7-9F8B-9C61CF8103E5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We don't need to rearrange anything, just put the local_irq_enable()  
> call in do_mathemu().  If we are a debugger than REASON_TRAP will  
> have to be set and we dont bother with do_mathemu() than.
> 
> Do you think we should also move the local_irq_enable() that exists  
> in the handler into emulate_instruction().

I'd rather have the local_irq_enable() calls in
program_check_exception() so they're all in one place, preferably with
a comment explaining why they're there.  Having an unpaired
local_irq_enable in do_mathemu() would seem a bit weird to me.

Paul.
