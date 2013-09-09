Return-Path: <paulus@ozlabs.org>
Date: Mon, 9 Sep 2013 15:29:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 04/12] Validate r1 value before going to host
 kernel in virtual mode.
Message-ID: <20130909052930.GD6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193148.2855.95627.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130826193148.2855.95627.stgit@mars>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 01:01:48AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> We can get machine checks from any context. We need to make sure that
> we handle all of them correctly. Once we decode MCE reason and generate
> MCE event, we continue in host kernel in virtual mode so that we can
> log/display it later. But before going to virtual mode we need to make
> sure that r1 points to host kernel stack. But machine check can occur
> in any context and r1 may not always point to host kernel stack. In cases
> where we can not trust r1 value, we should queue up the MCE event and return
> from interrupt. This patch implements the additional checks that helps to
> decide whether to deleiver machine check event to host kernel right away
> or queue it up and return.

Some comments below...

> +	/*
> +	 * We are now going to host kernel in V mode. We need to make sure
> +	 * that r1 points to host kernel stack.
> +	 *
> +	 * If we are coming from userspace then we can continue in host kernel
> +	 * in V mode.
> +	 * But if we are coming from kernel and r1 does not point to kernel
> +	 * stack then we can not continue, instead we return from here.
> +	 */
> +
> +	ld	r12,_MSR(r1)
> +	andi.	r11,r12,MSR_PR		/* See if coming from user. */
> +	bne	3f			/* continue if we are. */
> +
> +#ifdef CONFIG_KVM_BOOK3S_64_HV
> +	/*
> +	 * We are coming from kernel context. Check if we are coming from
> +	 * guest. if yes, then we can continue. We will fall through
> +	 * do_kvm_200->kvmppc_interrupt which will setup r1 correctly.
> +	 */

It seems fragile to have to check various conditions to know whether
r1 is actually a kernel stack pointer, but I guess it's the best we
can do at present.

> +	lbz	r11,HSTATE_IN_GUEST(r13)
> +	cmpwi	r11,0			/* Check if coming from guest */
> +	bne	3f			/* continue if we are. */
> +
> +	/*
> +	 * So, we did not come from guest. That leaves three possibilities:
> +	 * a. We come from secondary thread which just came out of nap and
> +	 *    about to call kvm_start_guest.
> +	 * b. We come from secondary thread which is about to go to nap
> +	 *    state (see kvm_no_guest()).
> +	 * c. We come from opal context and r1 may be pointing to opal
> +	 *    kernel stack.
> +	 */
> +
> +	lbz	r11,HSTATE_HWTHREAD_STATE(r13)
> +	cmpwi	r11,KVM_HWTHREAD_IN_NAP	/* Was it nap-ing? or about to */
> +	beq	0f		/* Queue up event and return from interrupt */

Two comments here: first, we change the hwthread_state to
KVM_HWTHREAD_IN_KERNEL before loading up r1 -- this is in
system_reset_pSeries in exceptions-64s.S.  So this test isn't really
safe.  It would be possible to add ld r1, PACAR1(r13) before setting
the hwthread_state, and I think that would fix it.

Secondly, if the CPU is napping when the machine check comes along,
it doesn't jump to the machine check vector.  It restarts the CPU at
the system reset vector, with a particular wakeup code in SRR1, which
we currently don't handle.  So you need to add code to do that.

> +	 * So far we checked all possible situations where we can not
> +	 * trust r1. Now we can trust r1.
> +	 *	r1 < 0		r1 points to host kernel stack
> +	 *	r1 > 0		r1 points to opal stack

Are we guaranteed that Sapphire will keep the stack pointer positive
at all times?  (More a question for Ben H than you.)

Paul.
