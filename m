Subject: Re: IRQS on 6 Slot Macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Walther <trag@io.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <a04310100bbce446f4c17@[199.170.89.149]>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>
	 <1067842481.17970.8.camel@gaston> <a04310106bbcd1501d614@[199.170.89.118]>
	 <1067937269.680.92.camel@gaston>  <a04310102bbcda40d92fc@[199.170.89.159]>
	 <1067985081.707.124.camel@gaston> <a04310101bbce0854283b@[199.170.89.118]>
	 <1068000383.692.132.camel@gaston>  <a04310100bbce446f4c17@[199.170.89.149]>
Content-Type: text/plain
Message-Id: <1068016722.12704.148.camel@gaston>
Mime-Version: 1.0
Date: Wed, 05 Nov 2003 18:18:43 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It went internal after the PowerSurge machines.   The Beige G3 lacks
> a Fast SCSI bus and SCSI isn't built in after that.  However,
> according to an Apple Tech note, one of the Blue & White chips has an
> internal MESH cell because some part of the OS or firmware expects to
> find a MESH.   However, the MESH connections are not carried to the
> exterior of the chip.

Well, it's not that the OS/firm expect a MESH... It's that the B&W G3
and the early Yikes G4 used the Paddington ASIC which contain a MESH...
Apple didn't produce a entire new ASIC line just to strip it from there.

Next MacIO chip is KeyLargo (coming with UniNorth that is AGP machines)
and this one doesn't have MESH anymore.

> The SCSI cell in CURIO is a 53C94, but CURIO provides SCSI, ethernet
> and serial port support all in one chip.   So the pinout of the 53C94
> doesn't tell one about the pinout of CURIO, except it does identify
> some of the pins which must be present on CURIO somewhere.

Ah ? Interesting. I though like for MESH that the ESCC and MACE were
also part of GC. They do appear as cells of GC in the OF device
tree, so it may be that they just "split" the ASIC for production
reasons.

> In fact, a great deal of the pinout of GC would be revealed if one
> had a pinout for CURIO, because much of what GC does is connect to
> CURIO.
>
> It's interesting that the drivers are available in Darwin.  Thank
> you.  I'm going to have to brush off those programming skills, I
> think.   That's such a huge learning curve in my case, though.
>
> CURIO was used from the NuBus power macs (or was it first in the AV
> Quadras?) through the x500 series.   It had quite a long life.   It
> is marked AM79C950KC.
>
> >It would be interesting if someone acutally had time to review those
> >and find out which of the HW bugs they work around in darwin for which
> >we would need equivalent fixes in linux :)
>
> Yes, it would.
>
> Jeff Walther
>
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
