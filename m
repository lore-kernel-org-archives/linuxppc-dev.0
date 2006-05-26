Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 096B367A79
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 22:33:27 +1000 (EST)
Date: Fri, 26 May 2006 14:33:21 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] force 64bit mode in system_reset_fwnmi for broken POWER4
	firmware
Message-ID: <20060526123321.GA21866@suse.de>
References: <20060522164111.GA14462@suse.de> <20060523130717.GA22364@suse.de>
	<17526.59069.781220.922878@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17526.59069.781220.922878@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, May 26, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > According to this change for EXCEPTION_PROLOG_COMMON, I get still into
> > decremeter_common, but its not fatal anymore because the cpu is now in
> > 64bit mode and the stack is forced to PACAKSAVE(r13).
> > 
> >         subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack  */ \
> >         beq-    1f;                                                        \
> >         ld      r1,PACAKSAVE(r13);      /* kernel stack to use          */ \
> > -1:     cmpdi   cr1,r1,0;               /* check if r1 is in userspace  */ \
> > +1:                                     \
> > +       cmpdi   cr1,r29,0x42;           \
> 
> Ummm, what's r29 supposed to have in it here?

0x42, from the spinning hello32 app. I filled all regs from r14 to r31
with a fixed value, and used these regs for debugging in the reset
handler.

> > +       bne     cr1,2f;                 \
> > +       li      r29,2f@l;               \
> 
> And why are we setting it?

Just a debug thing to find out how I got into bad_stack. I expected that
system_reset_common calls bad_stack, but it was decrementer_common. No
idea how that happend, MSR_EE is off, the timer interrupt has the lowest
priority, so it should not trigger.


> Does it look like the SRR0 and SRR1 values are correct when we get
> this problem occurring?  Is it just the MSR that is bogus?

The MSR indicates 32bit mode, it is 0x1002 on entry and 0x1032 before
rfdi. I havent dumped the SRR1 content, SRR0 points to the hello32 'b .'
instruction.


It seems the JS20 and POWER4 firmware calls fwnmi on all cpus, while
JS21 (and probably POWER5) does it only on one cpu. The other cpus will
be stopped with an IPI, trap 501.
According to some firmware guys, the OS is supposed to force 64bit mode
on reset.
