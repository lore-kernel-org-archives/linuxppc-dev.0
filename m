Return-Path: <tjernlund@tjernlund.se>
Received: from csmtp.b-one.net (csmtp.b-one.net [195.47.247.21])
	by ozlabs.org (Postfix) with ESMTP id DC0496887E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2005 10:38:10 +1100 (EST)
From: "Tjernlund" <tjernlund@tjernlund.se>
To: "Linuxppc-Dev" <linuxppc-dev@ozlabs.org>
Date: Fri, 9 Dec 2005 00:07:22 +0100
Message-ID: <000e01c5fc4c$25b17cb0$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: uclibc@uclibc.org, 'Linh Dang' <linhd@nortel.com>
Subject: Linux process ABI broken in 2.6?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Seems like ppc32 kernel pass the application entry point address
in r7 and MSR in r8 when starting the application. The source might be
ret_from_syscall, in entry.S: 
	...
	lwz	r7,_NIP(r1)
 	lwz	r8,_MSR(r1)
 	FIX_SRR1(r8, r0)
 	lwz	r2,GPR2(r1)
	lwz	r1,GPR1(r1)
	mtspr	SPRN_SRR0,r7
	mtspr	SPRN_SRR1,r8
	SYNC
	RFI
I am not convinced this is the source, but a non zero r7
breaks static apps in uClibc.

Is this on purpose and why?

Secion 8.4.1 in
http://refspecs.freestandards.org/LSB_3.1.0/LSB-Core-PPC32/LSB-Core-PPC32.html#PROCESSINITIALIZATION

says:
"Contrary to what is stated in the Registers part of chapter 3 of the System V Application Binary Interface PowerPC Processor
Supplement there are no values set in registers r3, r4, r5, r6 and r7. Instead the values specified to appear in all of those
registers except r7 are placed on the stack. The value to be placed into register r7, the termination function pointer is not passed
to the process."

How do one not pass a termination function in r7 other than setting
r7 to zero?

 Jocke
