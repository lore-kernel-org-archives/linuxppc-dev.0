Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4B9CDDEE6
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 07:52:26 +1100 (EST)
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BDC705EB-9078-44FD-800E-D9ADD18B9471@kernel.crashing.org>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
	<1168599942.5011.21.camel@localhost.localdomain>
	<BDC705EB-9078-44FD-800E-D9ADD18B9471@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 13 Jan 2007 07:52:34 +1100
Message-Id: <1168635154.5011.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-12 at 12:39 -0600, Kumar Gala wrote:
> On Jan 12, 2007, at 5:05 AM, Benjamin Herrenschmidt wrote:
> 
> >
> >>> Why do we need a separate ret_from_except_spe_full?
> >>
> >> I'm not sure if the kernel will return from exception in a multi- 
> >> thread
> >> way, but the truth is if restoring EVRs in exsiting  
> >> ret_from_except_full,
> >> some non-SPE exception will try to retore EVR. At that time, the
> >> MSR[SPE] may not be enabled, which will cause error.
> >
> > Hrm... you can restore them before returning from the exception if you
> > are careful about doing that with preempt/irqs off I suppose.
> 
> Which is what I thought having the exception be EXC_XFER_EE and  
> flush_spe_to_thread should get you.
> 
> I dont see any reason to dirty up the 'exception' path for stuff we  
> can do in C code.

Well, doing that means that you will flush the SPE to the thread struct
and disable it, return to userland with SPE disabled, and right away
take a new exception as soon as the next SPE instruction is reached.
Maybe not optimal...

Ben.
