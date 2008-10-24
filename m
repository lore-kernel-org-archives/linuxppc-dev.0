Return-Path: <sonny@burdell.org>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE06CDDDD8
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 12:07:03 +1100 (EST)
Message-ID: <490248A1.6080004@burdell.org>
Date: Fri, 24 Oct 2008 17:13:53 -0500
From: sonny <sonny@burdell.org>
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC] a little disassembly infrastructure
References: <1224867546.9634.42.camel@localhost.localdomain>
In-Reply-To: <1224867546.9634.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> Hi, I wrote this patch for KVM [1], but now that I look closer it seems
> like there might be some overlapping functionality.
> 
> First there's emulate_instruction(), but since that only handles a few
> instructions it's just an ordered list of if ((instruction & MASK_A) ==
> INST_A) tests, so it doesn't actually parse out opcodes or anything.
> 
> I've also found xmon's ppc-opc.c. That parses the opcode and operands,
> so could use some shared macros. Of course, the actual lookup isn't
> time-sensitive, so that doesn't make sense to share. On the other hand,
> if we do come up with something fast *and* robust for KVM, maybe xmon
> could use that.
> 
> Of course, these macros alone is pretty small, so maybe it's not a big
> deal to make a kvm-specific copy of them, leaving the other uses alone.
> 
> Comments?
> 
> [1] KVM on PowerPC traps when privileged instructions are executed in
> the guest context. We must then (quickly!) disassemble them and emulate
> their behavior. Right now we do this with a giant switch statement or
> two, but are considering more sophisticated techniques in the future.
> 

Yeah, personally I like this change.  I was looking at emulating some 
PPC instructions in a driver and based on inspection I was going to use 
the code you had in for KVM.  Having these macros in a generic header is 
a "Good Thing" IMHO.  I think we should have a generic disassembly 
infrastructure and use that everywhere.
