Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1E0DDE176
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:39:19 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
	<m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
	<1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
	<m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
	<1170015292.26655.6.camel@localhost.localdomain>
	<m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
	<1170019048.26655.27.camel@localhost.localdomain>
	<m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
	<1170026259.26655.114.camel@localhost.localdomain>
Date: Sun, 28 Jan 2007 16:38:28 -0700
In-Reply-To: <1170026259.26655.114.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 29 Jan 2007 10:17:39 +1100")
Message-ID: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> Because it mixes concerns that do not need to be mixed, and it complicates
>> the code.  The hypervisor has no need to understand how a hardware
>> device is built, and how it's registers operate.  It just needs to
>> know that the given hardware device will generate an msi message on
>> the bus.
>
> I'd be happy for you to go explain your view of what an hypervisor
> should or should not do to IBM HV architects :-) 

Sure think you can setup a meeting, or give me an email introduction to them.

> But in the meantime,
> that's how they have defined it and how it's been implemented and how we
> have to support it. And I have a strong feeling that they won't be the
> only ones to do it that way (I'd like to be proven wrong tho).

No the general linux kernel does not have to support it, and if we don't
I suspect that message would get back fairly clearly to the IBM HV architects.

I haven't been watching closely but I haven heard any rumors on the x86
side that they are looking in that direction.

>> Right, so some way needs to be found to cope with that situation.
>> Likely that involves bypassing all of the code that talks directly to
>> the hardware for MSI.
>
> Which can be done by having the alloc() and free() hooks do all the work
> provide they aren't done per-msi but per-call like in Michael's
> approach. That is, in the MSI-X case, alloc is called once for all of
> the MSI-X requested.
>
> I understand that this conflicts with your idea of requesting new MSI-X
> on the fly but I don't think that trying to add/remove MSI-X that way is
> a sane approach anyway. If you are concerned about HW problems, I think
> by doing so, you'll indeed hit them hard.

That isn't even the reason it is that way.  It is because allocating
4096 irqs in a single vector is a bad idea, and because it requires you
to pass type information of what kind of msi you are dealing with to the
lower levels in an allocation routine that make it bad idea.  Because
if you don't consider the IBM HV it provides not benefit and just puts
unnecessary loops, and type information in architecture code.

Face it.  Trying to make the allocation routine serve for both the
raw and the HV case unmodified is a layering violation.

>> But importantly the hooks are at a whole different layer of the code
>> and most likely at a completely different granularity.  You don't have
>> per bus hypervisor support do you?
>> 
>> So as I see it that is a different layer and should be treated differently.
>
> Well, I think that treating them differently will on the contrary
> complicate the matter :-)

It is tying unrelated concerns together in msi_ops and I am opposed to
that.

> Now, as I said, I agree that Michael's current ops definition might
> benefit from some changes.
>
> I do agree for example that we might want to rework a bit what is done
> in the area of the ->setup_msi_msg. An option is to remove it and
> instead have the backend ->enable() hook be the one figuring out the
> message and calling a low level -raw- helper rather than having a
> generic raw helper hook directly in ->enable and itself then use
> ->setup_msi_msg as a lower level hook to get the message.
>
> Since we need a low level raw helper to writeout the message
> address/data anyway (for use by set_affinity among others), by doing so,
> we avoid duplication.

Exactly.

Eric
