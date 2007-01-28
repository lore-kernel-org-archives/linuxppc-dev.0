Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41C6BDDFA9
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 07:54:05 +1100 (EST)
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
Date: Sun, 28 Jan 2007 13:53:14 -0700
In-Reply-To: <1170015292.26655.6.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 29 Jan 2007 07:14:52 +1100")
Message-ID: <m1fy9uq3et.fsf@ebiederm.dsl.xmission.com>
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

>> Anyway for architecture hooks I have it down to just:
>> /*
>>  * The arch hook for setup up msi irqs
>>  */
>> int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
>> void arch_teardown_msi_irq(unsigned int irq);
>
> Which we would have to turn into "ops" hooks right away on powerpc
> anyway because we can have multiple implementations in a given kernel
> image depending on a mix of platform and which bus the devie is on.

Yes of some form.  Although only needing 2 ops instead of 6 is still
simpler.  Until we can agree on a point where the ops lookup is
generic I don't see the point in placing it in generic code.

In addition I am extremely uncomfortable with making the interface to
the architecture any wider than we need it to be, as refactoring code
across multiple architectures is hard as usually the developer does
not have the hardware to touch all of the code that is touched.

>> Which should be good enough to handle everything but RTAS.
>
> You keep ignoring the problem then... we -HAVE- to handle the RTAS case.
> In addition, it's not unlikely that other virtualized environment will
> provide a similar very high level APIs to MSIs.

No I'm postponing the problem in good unix fashion and delivering the
90% solution now.  Beyond that I'm taking the problem in small
comprehensible steps.  I'm not saying we have to stop there but
we need to pass through this point.

The argument that we need to support what the RTAS is doing to support
other hypervisors seems to be a fallacy.  What the RTAS is doing is
not sane from a hardware standpoint, so I do not expect it from other
virtualized/hypervisor style environments. 

If the hardware provides capabilities to isolate the MSI messages
properly it does not need to prevent us from touching the msi setup
registers.  If the hardware does not isolate the MSI messages properly
there is another problem.  Especially in the context of MSI-X where
the registers can be in the middle of any mmio bar I do not see a sane
way of keeping us from touching the hardware directly in the first
place.

However it is quite likely that supporting the RTAS is not going to 
require much code to support.  So I don't see an argument against not
supporting the RTAS.


There is the additional problem in all of this that our interface for
MSI-X to the drivers is quite likely the wrong interface.  I believe
we will want to incrementally allocate more irqs at run time as there
are work queues or the like which can be attached to them.  We can get
there with the current vector allocator by freeing and reallocating
all of the msi-x irqs when the driver wants more so the current
interface will suffice but it is far from optimal.

Also I'm not at all comfortable with the 32k msix_entry array
allocation we will need for a MSI-X device that pushes the limits,
of the number of irqs it can allocate, especially as this goes
up to 64k when we start using the proper types to hold the linux
irq number.

Small simple obviously correct steps.

Eric
