Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18457.1279.401197.763726@cargo.ozlabs.ibm.com>
Date: Thu, 1 May 2008 09:47:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
In-Reply-To: <12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> If we don't handle reschedule or signal will we actually not function  
> properly?  I assume reschedule isn't an issue, but could we lose a  
> signal?

It depends on whether a critical or machine check handler can ever do
anything to generate a signal or a reschedule.  If they can't, then
there is no problem.

If they can, then we have to be very careful.  If a critical or
machine check happens at a point where normal interrupts are disabled
then we have to be extremely careful not to do anything that the code
we've interrupted assumes can't happen - so we'd better not try to
take any spinlocks, for example.  That severely limits what the
handler can do.  It probably shouldn't even call printk, for
instance, or wake any process up, and definitely shouldn't call
schedule (or schedule_preempt) on the way out.

If the critical/mcheck interrupt happens at a point where a normal
interrupt could have happened (including when userspace is running)
then we could treat it pretty much as a normal interrupt, including
handling signals or reschedules on the way out if appropriate.

Paul.
