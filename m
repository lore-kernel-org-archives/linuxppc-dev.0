Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EFEADE147
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 04:57:17 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
	<20070126171928.GA22275@colo.lackof.org>
Date: Fri, 26 Jan 2007 10:56:35 -0700
In-Reply-To: <20070126171928.GA22275@colo.lackof.org> (Grant Grundler's
	message of "Fri, 26 Jan 2007 10:19:28 -0700")
Message-ID: <m1ejphvfho.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S.Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Grundler <grundler@parisc-linux.org> writes:

> On Fri, Jan 26, 2007 at 09:32:33AM -0700, Eric W. Biederman wrote:
>> > Well of course it's connected to real hardware.  The virq
>> > numbers are a flat space; hwirqs are not (those are relative
>> > to one certain interrupt controller) so virqs are easier
>> > in use.
>> 
>> ....However they are the linux abstraction of the hardware and
>> as such a useful mapping to the hardware is not required.
>
> What?!!! The whole point of the abstraction ("flat space") is
> to be able to do reverse lookups for additional information.

Yes.  But that doesn't mean the number has any useful meaning
in and of itself.  Just that you can index into a table and
get that meaning.  (i.e. If you are a human being or anything
outside of the kernel you may not be able to do a reverse lookup
because you don't have the table.)

>> ia64 is the strong culprit
>> in this regard, and simply picks the next free number it can use
>> when a device asks for an irq.
>
> I think this is the only viable aproach to support MSI migration.
> Basing the "virq" value on bits in the addr/data pair can't migrate.

Thus my initial surprise at people not liking create_irq().

If the irq controller the msi arrives at can redirect the irq the
bits in the msi message could have some connection to the irq number.
Likewise if some of those bits have nothing to do with migration.

For irqs going across traces on a motherboard and into interrupt pins
you can embed a lot of that knowledge into the irq number.  For MSI
with arbitrary programmable connections the numbers have less meaning
and less need of meaning in that sense.

> ...
>> The minimum silicon version of the destination of an MSI really only
>> needs the ability to record that it happened.
>
> "it" == record the data value sent to a specific address.

The data value the address something.  You don't have to reply msi's
are edge triggered and non-acknowledged so you just need to record
enough for the software to figure it out.

> If the IRQ handler lookup is done in HW it can save us a substantial number
> of CPU cycles before we invoke the corresponding handler.

Maybe.  I would love to see a useful implementation of that.

>> A prioiri setup of the
>> controller (in hardware) for each individual MSI source interrupt
>> seems to imply extra hardware logic, and limit the total number of
>> MSI's the system can handle for no apparent reason.  For that
>> reason I expect more systems to do things closer to how x86 does it.
>> If for no other reason than because it is less logic to validate.
>
> It doesn't matter how many systems "do things closer to how x86"
> works since 95% (or more) of the systems running linux are x86.
> Linux MSI support must work on x86.
>
> Helping Michael make it work would be a constructive way forward.
> I think Michael has the abstraction correct so it's NOT x86 centric
> but still works optimally on x86.

NO NO NO NO Michaels abstraction does not work on x86.
Which is a big part of the my problem.
Michaels abstraction does not allow me to migrate irqs on x86.

setup_msi_msg only gets called when you enable the msi.  Nothing
gets called when irqbalaced changes the cpu mask, and there is no
support that would allow that with Michael's msi ops.

I can't use Michaels msi_ops as they stand.

They also have the problem of trying to exist at two different levels
of the interrupt hierarchy setup hierarchy simultaneously which is
another part of the problem.

Micaheal's code is simple beautiful and doesn't work on x86, because
he has not implemented what needs to be there.

That is why I have asked for an evolutionary approach and not this
stupid drop and replace attempt.

Sorry for the rant I'm just a little annoyed that you hadn't hurd that
what Micahel is doing does not work on x86.

>> On x86 the only hardware we have to deal with is the 8 bit number
>> delivered to the cpu at interrupt time and the MSI registers.
>
> 8 bit number? That's the Intel Interrupt architecture definition.
> The PCI spec defines 16-bit messages for MSI. The chipsets
> can implement any number of bits they want up to that limits.

I said on x86.  The cpu receives a 8 bit number.

>> All of
>> the rest of the x86 logic needed to translate MSI interrupts to
>> processor bus messages and the like has no registers we can set
>
> Are the EID and ID fields defined in Intel adrresses not programmable?
> Those are part of the MSI address.

All msi address on x86 by definition are of the form 0xffe????? if I
have remembered the address correctly.  ia64 doesn't have that rule.

>> and
>> always behaves exactly the same way so is for all intents and purposes
>> transparent.  The PCI-HT bridge logic for MSI is the most visible our
>> logic for MSI ever becomes.  As for the destination window it is an
>> architecturally defined target with fixed meanings for all of the bits
>> on every system.  So by transparent I mean that we don't have to
>> perform any per irq setup in the hardware except the pci card to make
>> MSI's work.
>
> I had the impression "we" was the OS and the setup was being done by BIOS.
> IIRC, main reason for doing setup in BIOS was to enable existing OS versions
> to run new HW without any changes. Paying customers like that sort of thing.

There is an architectural definition of how irq work on x86.  The BIOS
sets up the hardware to match that definition if there are any registers
to setup.  Things like the PCI-HT bridge registers.  There are no
registers that need to be setup on a per msi basis.

Eric
