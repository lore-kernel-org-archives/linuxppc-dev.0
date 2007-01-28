Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 485A7DE137
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 08:17:50 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
	<m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
	<1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
	<m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
	<1170015292.26655.6.camel@localhost.localdomain>
	<m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 08:17:28 +1100
Message-Id: <1170019048.26655.27.camel@localhost.localdomain>
Mime-Version: 1.0
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


> Yes of some form.  Although only needing 2 ops instead of 6 is still
> simpler.  Until we can agree on a point where the ops lookup is
> generic I don't see the point in placing it in generic code.

At least 4 actually, since we would need suspend/resume as well.
 
> In addition I am extremely uncomfortable with making the interface to
> the architecture any wider than we need it to be, as refactoring code
> across multiple architectures is hard as usually the developer does
> not have the hardware to touch all of the code that is touched.

The interface to the arch in our model is the function to get ops :-)
Most "normal" backends would just "plug" those ops with the provided
raw_ functions.

> The argument that we need to support what the RTAS is doing to support
> other hypervisors seems to be a fallacy.  What the RTAS is doing is
> not sane from a hardware standpoint, so I do not expect it from other
> virtualized/hypervisor style environments. 
>
> If the hardware provides capabilities to isolate the MSI messages
> properly it does not need to prevent us from touching the msi setup
> registers. 

It does isolate and it doesn't -prevent- config space access. However,
in order to enable MSIs, we have to configure the device -and- the IRQ
controller on the bus on which the device sits on, that is, to obtain
vectors from the HV, configure the controller to receive MSIs from that
device and route them to us, etc...., and the only API the HV provides
for doing so is that RTAS function that configures both in one call.

I don't see what's fundamentally wrong with that approach.

>  If the hardware does not isolate the MSI messages properly
> there is another problem.  Especially in the context of MSI-X where
> the registers can be in the middle of any mmio bar I do not see a sane
> way of keeping us from touching the hardware directly in the first
> place.

They are not blocked as I said above, at least not for most devices,
(though the controller/receiver side is). However, we don't have an API
to get the address/value to write into the device, nor to
configure/enable MSIs in the PIC. The only API we have is basically
called "change-msi" which can be use to enable MSI, MSI-X or disable
them (though we can provide how many we want to enable out of what is
requested by the device... we can't enable sparse MSI-X though, we can
only enable the N first ones).

> However it is quite likely that supporting the RTAS is not going to 
> require much code to support.  So I don't see an argument against not
> supporting the RTAS.

It would imply 2 or 3 more hooks at the toplevel... so we are going from
your 2 initial hooks to 4 (bcs we need to hook suspend/resume), now to 6
or 7.... 

> There is the additional problem in all of this that our interface for
> MSI-X to the drivers is quite likely the wrong interface.  I believe
> we will want to incrementally allocate more irqs at run time as there
> are work queues or the like which can be attached to them.  We can get
> there with the current vector allocator by freeing and reallocating
> all of the msi-x irqs when the driver wants more so the current
> interface will suffice but it is far from optimal.

Our hypervisor will not unfortunately let us do that. We can only use
RTAS "change-msi" to allocate more/less MSIs and that is disruptive of
the device function (we might lose pending interrupts when doing so, in
fact, in the initial HV interface definition, we could only do that with
the device actually disabled in the command register !).

In general, I'd rather have the device pre-allocate the MSI-X it needs,
though it can later on decide to use more or less.

Ben.
