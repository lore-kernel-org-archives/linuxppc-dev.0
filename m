Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0057ADE054
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:42:35 +1100 (EST)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20070126064352.GA328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 07:41:56 +1100
Message-Id: <1169844117.24996.118.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org,
	"Eric W.Biederman" <ebiederm@xmission.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>,
	Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-25 at 23:43 -0700, Grant Grundler wrote:
> On Thu, Jan 25, 2007 at 07:34:16PM +1100, Michael Ellerman wrote:
> > MPIC MSI backend. Based on code from Segher, heavily hacked by me.
> > Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.
> ...
> > +		/* FIXME should we save the existing type */
> > +		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
> 
> What exactly does the "virq" represent here?
> I'd like to understand if the FIXME comment could be dropped (or not).
> 
> I don't get the impression it's related to a PCI IRQ line.
> Maybe irq_create_mapping() has comments that describe hwirq and virq?
> If not, it would be useful if those terms were described.

Well, this is a ppc specific backend, so I'm not sure we need to
describe in there the way ppc interrupts work but heh ;-) Basically, on
powerpc nowadays, we disconnect "linux" irqs (virtual irqs) and
"hardware" irq numbers.

linux irqs are allocated dynamically and bound to a given PIC/hw irq
pair via irq_create_mapping() or one of the other superset of that
function.

In the case of something like the MPIC MSI backend, we first allocate a
HW vector (we have a bitmap of free vectors), then we map it to a new
virq with irq_create_mapping(). I think the FIXME is not needed.

Ben.
