Return-Path: <ebiederm@xmission.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by ozlabs.org (Postfix) with ESMTP id 39733B7CF1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 05:12:05 +1100 (EST)
To: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
	<1268218832.11737.68575.camel@zakaz.uk.xensource.com>
	<m1r5nsjdsh.fsf@fess.ebiederm.org>
	<1268242912.11737.70762.camel@zakaz.uk.xensource.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 Mar 2010 10:11:59 -0800
In-Reply-To: <1268242912.11737.70762.camel@zakaz.uk.xensource.com> (Ian
	Campbell's message of "Wed\, 10 Mar 2010 17\:41\:52 +0000")
Message-ID: <m17hpkgi6o.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Campbell <Ian.Campbell@citrix.com> writes:

> On Wed, 2010-03-10 at 17:18 +0000, Eric W. Biederman wrote:
>> Ian Campbell <Ian.Campbell@citrix.com> writes:
>> 
>> > On Wed, 2010-03-10 at 10:55 +0000, ijc@hellion.org.uk wrote:
>> >> 
>> >> arch_init_chip_data cannot be moved into struct irq_chip at this time
>> >> because irq_desc->chip is not known at the time the irq_desc is
>> >> setup. For now rename arch_init_chip_data to arch_init_irq_desc (for
>> >> PowerPC, the only other user, whose usage better matches the new name)
>> >> and on x86 convert arch_init_chip_data to ioapic_init_chip_data and
>> >> call this whenever the IO APIC code allocates a new IRQ.
>> >
>> > One idea I had to improve this was to add a struct irq_chip * as a
>> > parameter to irq_to_desc_alloc_node. The new parameter potentially could
>> > be NULL for current behaviour. Does that sound like a reasonable
>> > approach?
>> 
>> I don't follow why we have the restriction that irq_to_desc_alloc_node
>> must call arch_init_chip_data.  Assuming that requirement to call arch_init_chip_data
>> is valid, passing something into init_one_irq_desc seems appropriate.
>
> Yes, I suspect that could also be made to work.
>
> The lifecycle of the irq_desc and chip_data isn't really clear to me --
> I guess once allocated an irq_desc never gets freed (at least
> currently)? The associated chip_data can be freed on migrate and
> replaced with a new one, but is not freed otherwise.

Yes.  That actually looks like a bug.

> My concern is that if the caller asks for an IRQ which already exists
> (is that valid?) then you will get that existing irq_desc back,
> including its existing chip_data, which potentially leaks the new one
> which was passed in. Or is it the case that the only way this could
> happen would be for legacy IRQs? In which case perhaps it is simply
> invalid to pass a new chip data in for such an IRQ.

The only irqs that should be allocated/freed are probably the msi
irqs as those are the only ones that dynamically come and go in the
system.

Unfortunately there appears to be a bigger mess here than first appeared.

Eric
