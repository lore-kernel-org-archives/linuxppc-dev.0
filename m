From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15720.42991.852001.315071@argo.ozlabs.ibm.com>
Date: Sun, 25 Aug 2002 19:48:31 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: acurtis@onz.com,
	Ppc Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 Memory Management
In-Reply-To: <3D6797F8.4000106@embeddededge.com>
References: <3D65C19C.2070503@embeddededge.com>
	<NCBBIINEHIPFGJPLBEIFAEBNDLAA.acurtis@onz.com>
	<15718.52527.24904.317204@argo.ozlabs.ibm.com>
	<3D6797F8.4000106@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> I was doing that as part of the 2.5 interrupt changes, but if you
> want to do it now we can try.  On the 8260 it's not as bad as the 8xx,
> but you have to ensure the legacy and PCI interrupts are outside of
> the internal controller and CPM ranges.

Well... the #define request_irq request_8xxirq merely means that
including anything that calls request_irq will cause the kernel link
to fail.  Which I assume you put in to make sure you weren't linking
in any drivers that might assume legacy ISA irq numbers.

By now you must have got the configs, makefiles, etc. sorted out so
that you aren't including any unwanted drivers.  So the #define can be
removed.  Removing the #define and changing all the calls to
request_8xxirq to request_irq won't actually change any object code or
any runtime behaviour, it'll just look cleaner in the source code. :)

PCI interrupts aren't a problem because the platform code assigns the
interrupt numbers for each slot, and the drivers then just use that
(i.e. pci_dev->irq), and if they don't we shoot them.

Legacy interrupts aren't a problem because you just don't include the
driver, or else you set up the header files etc. so that the driver
doesn't make the wrong assumptions (e.g. serial.h).  So I don't see
any need to avoid using interrupt numbers 0-15 in general.  We use
interrupts 0-15 on powermac (they are often DBDMA completion
interrupts) without any problems.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
