Subject: Re: IRQS on 6 Slot Macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Walther <trag@io.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <a04310101bbce0854283b@[199.170.89.118]>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>
	 <1067842481.17970.8.camel@gaston> <a04310106bbcd1501d614@[199.170.89.118]>
	 <1067937269.680.92.camel@gaston>  <a04310102bbcda40d92fc@[199.170.89.159]>
	 <1067985081.707.124.camel@gaston>  <a04310101bbce0854283b@[199.170.89.118]>
Content-Type: text/plain
Message-Id: <1068000383.692.132.camel@gaston>
Mime-Version: 1.0
Date: Wed, 05 Nov 2003 13:46:24 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-11-05 at 13:11, Jeff Walther wrote:
> At 09:32 +1100 11/05/2003, Benjamin Herrenschmidt wrote:
> >>  By iSeries, do you mean iBook and iMac?   Or is that something else?
> >>  I'm still kind of living in the PowerSurge world, with occasional
> >>  forays up to Beige G3.  :-)
> >
> >Nah ;) iSeries are IBM big boxes :) Though a G5 has about 256 interrupt
> >sources on his 2 openpics, but I doubt they are all used.
>
> How do they handle that physically?   Surely there are not 256
> separate wires?   Do they use an 8 wire bus and signal interrupts as
> if they were addresses?

Lots of them are internal to the K2 & U3 ASICs and the link between
those is over HyperTransport (though in the current setup, I don't
think they use HT interrupt facilities, they just wire U3 output
to one K2 output, possibly a GPIO, so you deal with them as cascaded
controllers, which prevents anything like interrupt affinity on SMP,
though it's not that bad as U3 IRQs so far only concern the i2c
controller in there.

They do have quite a bunch of lines going out though, some to slots,
other on GPIOs that can be used as IRQ inputs.

> >Isn't MESH an IBM part ? I may be confused... Also, I would have
> >expected MESH to be actually _inside_ GC, it isn't ?
>
> It is an Apple part.  I do not know for certain where it came from
> originally.  However, following the evolution of Apple design
> suggests that it's based on the NCR 53CF96.

8500 class machines also have a 53c94 (Curio) and I remember
seeing a document about an IBM "MESH" scsi controller, I suspect though
that both IBM and Apple may have picked the same original cell. I do
still think the MESH cell is actually inside GC though, as it is
inside later revs of Apple "mac-io" ASIC until paddington.

> The previous generation
> of machines, the PPC NuBus machines, included the PMac 8100 and 9100
> which used exactly the same CURIO chip as the x500 machines to
> provide the slow (5 MB/s) ethernet and used the NCR 53CF96 to provide
> the Fast SCSI bus.   Earlier machines (the Quadras) used the NCR
> 53C96 to handle their SCSI bus.   And, of course, the earlier
> machines used the NCR 53C80.

Ok. I need to look at the 53C96 specs to see if it's really similar
to MESH.

> Additionally, the 53CF96 chip in the 8100 is in a 100 pin, 20 X 30
> quad flat pack.   MESH is in exactly the same package.    This is not
> definitive, but suggests to me that MESH is simply a licensed 53CF96.
>
>
> MESH is a separate chip and is not contained in GC.   It would be
> kind of cool if MESH was in GC, because then one could implement the
> Fast SCSI bus on 7200s and the PCC Catalyst clones, but that's not
> the way it is....

Ok. Strange then. I was sure it was internal. It is internal to
Hydra (the "CHRP" MacIO chip).

> In my queue of projects (massive and ever lengthening) is to install
> a 53CF96 in place of a MESH and/or vice versa and see what happens.
> However, I wonder if a similar test could be done with software.   I
> assume that Linux implements some kind of driver to support MESH.
> Is there a driver for the 53CF96 which could be substituted or
> compared as an experiment.

Maybe, but one important thing with MESH is that it's behind a DBDMA
controller, which completely changes the way you actually use it.

> As an aside, it's too bad that CURIO's pinout is not available from
> AMD.   They have datasheets for several related chips on their site.
> I guess CURIO was a custom job for Apple or something.

It's a 53c94 afaik. We do have a driver for it. And Apple released
both their MESH and Curio drivers in darwin.

It would be interesting if someone acutally had time to review those
and find out which of the HW bugs they work around in darwin for which
we would need equivalent fixes in linux :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
