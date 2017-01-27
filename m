Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8kRf2w85zDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 14:14:54 +1100 (AEDT)
Date: Fri, 27 Jan 2017 14:14:49 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, gleb@kernel.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 pbonzini@redhat.com, mpe@ellerman.id.au, bsingharora@gmail.com,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH v5 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
Message-ID: <20170127031449.kecknhpwjzmnpvbo@oak.ozlabs.ibm.com>
References: <148430634902.22799.7589829837646104546.stgit@aravinda>
 <148430650591.22799.7426036865298338317.stgit@aravinda>
 <20170116043527.GA4577@fergus.ozlabs.ibm.com>
 <fc415f1b-fdb0-a763-0eba-5fb10176844f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fc415f1b-fdb0-a763-0eba-5fb10176844f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 18, 2017 at 11:19:26AM +0530, Mahesh Jagannath Salgaonkar wrote:
> On 01/16/2017 10:05 AM, Paul Mackerras wrote:
> > On Fri, Jan 13, 2017 at 04:51:45PM +0530, Aravinda Prasad wrote:

[snip]

> >>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> >> +		/* Exit to guest with KVM_EXIT_NMI as exit reason */
> >> +		run->exit_reason = KVM_EXIT_NMI;
> >> +		r = RESUME_HOST;
> >>  		/*
> >> -		 * Deliver a machine check interrupt to the guest.
> >> -		 * We have to do this, even if the host has handled the
> >> -		 * machine check, because machine checks use SRR0/1 and
> >> -		 * the interrupt might have trashed guest state in them.
> >> +		 * Invoke host-kernel handler to perform any host-side
> >> +		 * handling before exiting the guest.
> >>  		 */
> >> -		kvmppc_book3s_queue_irqprio(vcpu,
> >> -					    BOOK3S_INTERRUPT_MACHINE_CHECK);
> >> -		r = RESUME_GUEST;
> >> +		kvmppc_machine_check_hook();
> > 
> > Note that this won't necessarily be called on the same CPU that
> > received the machine check.  This will be called on thread 0 of the
> > core (or subcore), whereas the machine check could have occurred on
> > some other thread.  Are you sure that the machine check handling code
> > will be OK with that?
> 
> That will have only one problem. get_mce_event() from
> opal_machine_check() may not be able to pull mce event for error on
> non-zero thread. We should hook the mce event into vcpu structure during
> kvmppc_realmode_machine_check() and then pass it to
> ppc_md.machine_check_exception() as an additional argument.

To move things along...

Mahesh, how would we get hold of the mce event from real-mode assembly
code?  What function would we need to call to get the event?  Could
you write some code (or at least some pseudo-code) to illustrate how
it would be done?

Thanks,
Paul.
