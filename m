Return-Path: <dadair@ariodata.com>
Received: from orion.ariodata.com (adsl-64-170-199-186.dsl.snfc21.pacbell.net
	[64.170.199.186]) by ozlabs.org (Postfix) with ESMTP id 8EA212BF0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 15:59:44 +1100 (EST)
From: "David Adair" <dadair@ariodata.com>
To: "'Praveen Mehrotra'" <praveen.mehrotra@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Wed, 3 Nov 2004 20:48:00 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <a2ea557e041103180817107b9e@mail.gmail.com>
Message-ID: <ORIONuNjVuMhvqgStMV000000ab@orion.ariodata.com>
Cc: 
Subject: RE: Critical Interrupt on 405EP
Reply-To: dadair@ariodata.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


You might want to check out the old e-mails about CI on the 440.

I use 2.4.19 + some cruft on a 440GP.  In this case
SPRN_SPRG0 and SPRN_SPRG1 are used by both critical and non-critical
interrupts making it just a matter of time before the CI stomps
on a normal interrupt.  You can look at the "PROLOG" stuff in
the appropriate head_xxx.S file to see if you have the same issue.


Have not actually run it, but looking at the code 2.6 is much
closer although. I don't yet understand why crit_transfer_to_handler,
ret_from_crit_exc were not used here though:

#define CRITICAL_EXCEPTION(n, label, hdlr)			\
	START_EXCEPTION(label);					\
	CRITICAL_EXCEPTION_PROLOG;				\
	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),
\
			  NOCOPY, transfer_to_handler_full, \
			  ret_from_except_full)

David



> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org [mailto:linuxppc-embedded-
> bounces@ozlabs.org] On Behalf Of Praveen Mehrotra
> Sent: Wednesday, November 03, 2004 6:09 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Critical Interrupt on 405EP
> 
> Hello,
> 
> I'm running 2.4.20 kernel on a 405EP board and am interested in using
> critical interrupt for one of the devices. I've almost got it working,
> except that after several minutes (ranging from 10-30) of operation
> kernel crash occurs.
> 
> Has anyone got the critical interrupt on 405EP working for 2.4.x
> kernels ? I can post details specific to changes I made if someone has
> experience regarding this.
> 
> Thanks,
> Praveen
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
