Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17854.32201.131104.928581@cargo.ozlabs.ibm.com>
Date: Tue, 30 Jan 2007 10:05:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Benjamin
	Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/6] MSI portability cleanups
In-Reply-To: <1170102158.26655.273.camel@localhost.localdomain>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
	<m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
	<1170102158.26655.273.camel@localhost.localdomain>
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	David Miller <davem@davemloft.net>, greg@kroah.com,
	linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> > I'd hate to hit a different Hypervisor that did something close but
> > not quite the same and have the code fail then.  So definitely
> > avoiding touching pci config space at all in the calls seems to make a
> > lot of sense.  This includes avoiding pci_find_capability right?
> 
> Quite possibly yes. I'm pretty sure it will work on IBM HV but we aren't
> really supposed to use it...

Actually, I don't know of any reason why we can't use
pci_find_capability.  We are supposed to avoid trying to touch config
space of devices (in fact, functions) that aren't assigned to our
partition, but we're not talking about that here.

I just got an answer from the hypervisor architects.  It turns out
that the hardware _does_ prevent the device from sending MSI messages
to another partition.  The OS _can_ write whatever it likes to the MSI
address and data registers.  It can potentially lose interrupts (or, I
expect, get the device isolated by EEH) but it can't disrupt another
partition.

I think the reason why the hypervisor call writes the values straight
into the MSI/MSI-X registers in the device is (a) that's convenient
for AIX, since it saves it from immediately having to do more calls
into the hypervisor to write those values to the device, and (b) there
are some ABI complications in returning a lot of values, so the device
registers provide a convenient place to return those values.

So it would be possible, although gross, to do the hypervisor call,
read the values from config space and return them to the generic code,
then let the generic code write them to config space for us. :P

The remaining point of difference then seems to be that for MSI-X, we
really want to know up-front how many interrupts the device driver is
asking for, rather than having a series of alloc requests dribble in
one at a time.

Regards,
Paul.
