From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15439.64102.68217.293733@argo.ozlabs.ibm.com>
Date: Thu, 24 Jan 2002 23:13:26 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: OpenPIC_NumInitSenses
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Who was it that wanted this horrible hack in open_pic.c?

	/* Needed because of the way we overload EPIC on a standard
	 * Open PIC structure.
	 */
	if (OpenPIC_NumInitSenses > NumSources)
		NumSources = OpenPIC_NumInitSenses;

I am about to add an openpic_set_sources function which will let us
handle the distributed openpic in IBM pSeries machines more cleanly
and also allow us to remove this hack.

openpic_set_sources takes three arguments: a range of openpic IRQ
numbers (first irq and number of irqs) and a pointer to the ioremapped
interrupt source registers.  If the pointer is NULL it is taken to
mean that the irqs use the standard openpic interrupt source
registers.  openpic_set_sources also sets NumSources to first_irq +
num_irqs if that value is larger than NumSources, and if NumSources is
set by openpic_set_sources, then openpic_init doesn't use the value
from the openpic registers.  (Thus openpic_set_sources must be called
*before* openpic_init, but after you have set OpenPIC_Addr.)

Thus if you want to say how many interrupt sources there are, you will
be able to do that with openpic_set_sources(0, num_sources, NULL).
If you want to say that there are 16 sources in the standard locations
plus another 16 at some other location, you could do

	openpic_set_sources(0, 16, NULL);
	openpic_set_sources(16, 16, ioremap(isr_base, 16 * 32));

(Actually maybe I should let openpic_set_sources do the ioremap.)

Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
