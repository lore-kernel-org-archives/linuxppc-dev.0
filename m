Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B535DDF16
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 17:17:14 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
Date: Sat, 27 Jan 2007 23:16:28 -0700
In-Reply-To: <1169876504.2294.23.camel@concordia.ozlabs.ibm.com> (Michael
	Ellerman's message of "Sat, 27 Jan 2007 16:41:44 +1100")
Message-ID: <m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
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

Michael Ellerman <michael@ellerman.id.au> writes:

> I guess I wasn't clear enough in my original post, but I fully expect
> that I'll need to tweak parts of the core to make Intel fit. That's
> still a work in progress.

Ok.  To be very clear.

Any plan that does not involve using drivers/pci/msi.c for the
raw hardware operations is flawed.  Yes that code is a mess
but it works today, and appears to capture all of the requirements.
Where there are issues that code should be fixed not ignored.

The architecture specific bits of the current msi code roughly
correspond to your alloc and free routines.  All that is
needed going from generic code to architecture specific code
is the ability to allocate and free an msi irq.  You have
a lot more operations than that and it is overkill.

As a practical measure you current operations are such a bad fit
for the architectures a port would be very difficult.  Basically
setup_msi_message is simply a bad idea.  You need to use a
write_msi_message call from the architecture to the generic code
instead.

I have some patches cooking to cleanup msi.c so it can be used
as is.  I'm pretty much their but it looks like I need to slay
msi_lock to make things sane.

Eric
