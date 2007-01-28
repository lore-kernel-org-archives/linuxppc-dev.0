Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55752DE0B4
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 19:37:30 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<1169876504.2294.23.camel@concordia.ozlabs.ibm.com>
	<m1k5z7smkj.fsf@ebiederm.dsl.xmission.com>
	<1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
Date: Sun, 28 Jan 2007 01:36:52 -0700
In-Reply-To: <1169971963.19887.15.camel@concordia.ozlabs.ibm.com> (Michael
	Ellerman's message of "Sun, 28 Jan 2007 19:12:43 +1100")
Message-ID: <m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
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

> We should probably just stop talking until I've got that series worked
> out and posted, and then you can tell me what you think of it :)

Sounds like a plan.  A series that kills the worst of the current code
as far as multiple architecture stuff, which should make your series
prettier.  I just finished testing and I'm heading for bed now.

When I'm alert enough to rebase my changes onto Greg's tree 
instead of linus-current.  I'll submit it.

I don't think there are going to be any conflicts with your first
4 patches that Greg sucked up but I figure it is best to check.

Anyway for architecture hooks I have it down to just:
/*
 * The arch hook for setup up msi irqs
 */
int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
void arch_teardown_msi_irq(unsigned int irq);

Which should be good enough to handle everything but RTAS.

Eric
