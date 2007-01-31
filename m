Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10145DE14C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 18:41:43 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <m1bqkioh6z.fsf@ebiederm.dsl.xmission.com>
	<20070128.155155.51857352.davem@davemloft.net>
	<1170032301.26655.140.camel@localhost.localdomain>
	<20070130.225232.112422538.davem@davemloft.net>
Date: Wed, 31 Jan 2007 00:40:34 -0700
In-Reply-To: <20070130.225232.112422538.davem@davemloft.net> (David Miller's
	message of "Tue, 30 Jan 2007 22:52:32 -0800 (PST)")
Message-ID: <m1fy9rbq4t.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, ebiederm@xmission.com,
	greg@kroah.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller <davem@davemloft.net> writes:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 29 Jan 2007 11:58:21 +1100
>
>> Do you have some pointers to documentation on those sparc64
>> interfaces ?
>
> So I got things working on sparc64 with a one-liner to the current
> upstream vanilla 2.6.20-rc7 :-)  It's not the best, but it works.
>
> You can see it all at:
>
> 	kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git
>
> Basically, I changed arch_teardown_msi_irq() to pass in the
> PCI device pointer, that's it.

Neat. 

I think you could have omitted your one liner if you had done:
struct msi_desc *entry = get_irq_data(irq);
struct pci_dev *dev = entry->dev;

> The rest is sparc64 specific stuff.
>
> One thing that's disappointing is that this "MSI Queue" framework
> sparc64 has really suggests a two-tiered interrupt handling scheme.
> As I previously explained, on sparc64 you assosciated each MSI with a
> queue, and you can attach multiple MSIs to a single queue.

Interesting.

> I've tested tg3 with MSI on my Niagara, it seems to work well.
> Unfortunately I don't have any MSI-X capable devices here, but
> eventually I am sure I will.  I glanced over the MSI-X code and I see
> no reason why it wouldn't work.

Congratulations!

Eric
