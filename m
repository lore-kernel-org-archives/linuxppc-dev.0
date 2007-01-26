Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A9EEDE087
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:03:00 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
Date: Fri, 26 Jan 2007 00:02:15 -0700
In-Reply-To: <20070126064352.GA328@colo.lackof.org> (Grant Grundler's message
	of "Thu, 25 Jan 2007 23:43:52 -0700")
Message-ID: <m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Grundler <grundler@parisc-linux.org> writes:

> On Thu, Jan 25, 2007 at 07:34:16PM +1100, Michael Ellerman wrote:
>> MPIC MSI backend. Based on code from Segher, heavily hacked by me.
>> Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.
> ...
>> +		/* FIXME should we save the existing type */
>> +		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
>
> What exactly does the "virq" represent here?
> I'd like to understand if the FIXME comment could be dropped (or not).
>
> I don't get the impression it's related to a PCI IRQ line.
> Maybe irq_create_mapping() has comments that describe hwirq and virq?
> If not, it would be useful if those terms were described.


I don't have a clue why it is called virq.  But looking at the
usage it must be a linux irq number as shown in /proc/interrupts and
as such there need be no connection with hardware.

I believe the ppc model is to allocate an interrupt source on their
existing interrupt controller and use that instead of the normal x86
case of having the MSI interrupt go transparently to the cpu.

Both set_irq_type, and entries.vector take a linux irq number.
Darn we should change that field name, it is misleading.

Eric
