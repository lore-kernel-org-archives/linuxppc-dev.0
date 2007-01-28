Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C972DE4A6
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 09:37:01 +1100 (EST)
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
Date: Sun, 28 Jan 2007 15:36:20 -0700
In-Reply-To: <1170019048.26655.27.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 29 Jan 2007 08:17:28 +1100")
Message-ID: <m1lkjmok2j.fsf@ebiederm.dsl.xmission.com>
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

>> Yes of some form.  Although only needing 2 ops instead of 6 is still
>> simpler.  Until we can agree on a point where the ops lookup is
>> generic I don't see the point in placing it in generic code.
>
> At least 4 actually, since we would need suspend/resume as well.

That one I don't quite understand yet.  But the current code is
quite happy to support suspend/resume generically.  It will be
interesting to see what part of that support does not work on ppc.

Especially as the current interface allows you to reprogram the
msi_message at any time.
  
>> In addition I am extremely uncomfortable with making the interface to
>> the architecture any wider than we need it to be, as refactoring code
>> across multiple architectures is hard as usually the developer does
>> not have the hardware to touch all of the code that is touched.
>
> The interface to the arch in our model is the function to get ops :-)
> Most "normal" backends would just "plug" those ops with the provided
> raw_ functions.
>
>> The argument that we need to support what the RTAS is doing to support
>> other hypervisors seems to be a fallacy.  What the RTAS is doing is
>> not sane from a hardware standpoint, so I do not expect it from other
>> virtualized/hypervisor style environments. 
>>
>> If the hardware provides capabilities to isolate the MSI messages
>> properly it does not need to prevent us from touching the msi setup
>> registers. 
>
> It does isolate and it doesn't -prevent- config space access. However,
> in order to enable MSIs, we have to configure the device -and- the IRQ
> controller on the bus on which the device sits on, that is, to obtain
> vectors from the HV, configure the controller to receive MSIs from that
> device and route them to us, etc...., and the only API the HV provides
> for doing so is that RTAS function that configures both in one call.
>
> I don't see what's fundamentally wrong with that approach.

Because it mixes concerns that do not need to be mixed, and it complicates
the code.  The hypervisor has no need to understand how a hardware
device is built, and how it's registers operate.  It just needs to
know that the given hardware device will generate an msi message on
the bus.

The practical difference is if someone comes out with MSI-Y or they
have a card that doesn't quite implement the MSI registers correctly
that hypervisor interface falls down, whereas my current architecture
hooks do not.

Plus it is more code in the hypervisor if it has to has to distinguish
between MSI and MSI-X.

>>  If the hardware does not isolate the MSI messages properly
>> there is another problem.  Especially in the context of MSI-X where
>> the registers can be in the middle of any mmio bar I do not see a sane
>> way of keeping us from touching the hardware directly in the first
>> place.
>
> They are not blocked as I said above, at least not for most devices,
> (though the controller/receiver side is). However, we don't have an API
> to get the address/value to write into the device, nor to
> configure/enable MSIs in the PIC. The only API we have is basically
> called "change-msi" which can be use to enable MSI, MSI-X or disable
> them (though we can provide how many we want to enable out of what is
> requested by the device... we can't enable sparse MSI-X though, we can
> only enable the N first ones).

Right, so some way needs to be found to cope with that situation.
Likely that involves bypassing all of the code that talks directly to
the hardware for MSI.

>> However it is quite likely that supporting the RTAS is not going to 
>> require much code to support.  So I don't see an argument against not
>> supporting the RTAS.
>
> It would imply 2 or 3 more hooks at the toplevel... so we are going from
> your 2 initial hooks to 4 (bcs we need to hook suspend/resume), now to 6
> or 7.... 

But importantly the hooks are at a whole different layer of the code
and most likely at a completely different granularity.  You don't have
per bus hypervisor support do you?

So as I see it that is a different layer and should be treated differently.

>> There is the additional problem in all of this that our interface for
>> MSI-X to the drivers is quite likely the wrong interface.  I believe
>> we will want to incrementally allocate more irqs at run time as there
>> are work queues or the like which can be attached to them.  We can get
>> there with the current vector allocator by freeing and reallocating
>> all of the msi-x irqs when the driver wants more so the current
>> interface will suffice but it is far from optimal.
>
> Our hypervisor will not unfortunately let us do that. We can only use
> RTAS "change-msi" to allocate more/less MSIs and that is disruptive of
> the device function (we might lose pending interrupts when doing so, in
> fact, in the initial HV interface definition, we could only do that with
> the device actually disabled in the command register !).
>
> In general, I'd rather have the device pre-allocate the MSI-X it needs,
> though it can later on decide to use more or less.

That might be the right solution.  I don't know.  But that is one
among several that your HV interface is wrong and probably should be
fixed at the HV.  I definitely have no intentions of encouraging
another HV to emulate the brittleness of your solution.

Nor do I want to ask device drivers to preallocate 4096 interrupts
just in case they need them.  Even if batch allocation makes sense
always asking for the maximum possible that you might use is overkill.

Eric
