Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5A82688CB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2005 13:06:06 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tjernlund <tjernlund@tjernlund.se>
In-Reply-To: <000e01c5fc4c$25b17cb0$020120ac@Jocke>
References: <000e01c5fc4c$25b17cb0$020120ac@Jocke>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 13:05:00 +1100
Message-Id: <1134093900.11760.66.camel@gaston>
Mime-Version: 1.0
Cc: Linuxppc-Dev <linuxppc-dev@ozlabs.org>, 'Linh Dang' <linhd@nortel.com>,
	uclibc@uclibc.org
Subject: Re: Linux process ABI broken in 2.6?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-12-09 at 00:07 +0100, Tjernlund wrote:
> Seems like ppc32 kernel pass the application entry point address
> in r7 and MSR in r8 when starting the application. The source might be
> ret_from_syscall, in entry.S: 
> 	...
> 	lwz	r7,_NIP(r1)
>  	lwz	r8,_MSR(r1)
>  	FIX_SRR1(r8, r0)
>  	lwz	r2,GPR2(r1)
> 	lwz	r1,GPR1(r1)
> 	mtspr	SPRN_SRR0,r7
> 	mtspr	SPRN_SRR1,r8
> 	SYNC
> 	RFI
> I am not convinced this is the source, but a non zero r7
> breaks static apps in uClibc.
> 
> Is this on purpose and why?
> 
> Secion 8.4.1 in
> http://refspecs.freestandards.org/LSB_3.1.0/LSB-Core-PPC32/LSB-Core-PPC32.html#PROCESSINITIALIZATION
> 
> says:
> "Contrary to what is stated in the Registers part of chapter 3 of the System V Application Binary Interface PowerPC Processor
> Supplement there are no values set in registers r3, r4, r5, r6 and r7. Instead the values specified to appear in all of those
> registers except r7 are placed on the stack. The value to be placed into register r7, the termination function pointer is not passed
> to the process."
> 
> How do one not pass a termination function in r7 other than setting
> r7 to zero?

Just ignore those registers on entry. The semantics of a syscall are to
clobber all volatile registers and there is no point doing anything
else.

Ben.
