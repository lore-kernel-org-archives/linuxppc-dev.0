Mime-Version: 1.0
Message-Id: <a04310101bbce0854283b@[199.170.89.118]>
In-Reply-To: <1067985081.707.124.camel@gaston>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>	
 <1067842481.17970.8.camel@gaston>
 <a04310106bbcd1501d614@[199.170.89.118]>	
 <1067937269.680.92.camel@gaston>
 <a04310102bbcda40d92fc@[199.170.89.159]> <1067985081.707.124.camel@gaston>
Date: Tue, 4 Nov 2003 20:11:39 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 09:32 +1100 11/05/2003, Benjamin Herrenschmidt wrote:
>>  By iSeries, do you mean iBook and iMac?   Or is that something else?
>>  I'm still kind of living in the PowerSurge world, with occasional
>>  forays up to Beige G3.  :-)
>
>Nah ;) iSeries are IBM big boxes :) Though a G5 has about 256 interrupt
>sources on his 2 openpics, but I doubt they are all used.

How do they handle that physically?   Surely there are not 256
separate wires?   Do they use an 8 wire bus and signal interrupts as
if they were addresses?

>Isn't MESH an IBM part ? I may be confused... Also, I would have
>expected MESH to be actually _inside_ GC, it isn't ?

It is an Apple part.  I do not know for certain where it came from
originally.  However, following the evolution of Apple design
suggests that it's based on the NCR 53CF96.   The previous generation
of machines, the PPC NuBus machines, included the PMac 8100 and 9100
which used exactly the same CURIO chip as the x500 machines to
provide the slow (5 MB/s) ethernet and used the NCR 53CF96 to provide
the Fast SCSI bus.   Earlier machines (the Quadras) used the NCR
53C96 to handle their SCSI bus.   And, of course, the earlier
machines used the NCR 53C80.

Additionally, the 53CF96 chip in the 8100 is in a 100 pin, 20 X 30
quad flat pack.   MESH is in exactly the same package.    This is not
definitive, but suggests to me that MESH is simply a licensed 53CF96.


MESH is a separate chip and is not contained in GC.   It would be
kind of cool if MESH was in GC, because then one could implement the
Fast SCSI bus on 7200s and the PCC Catalyst clones, but that's not
the way it is....

In my queue of projects (massive and ever lengthening) is to install
a 53CF96 in place of a MESH and/or vice versa and see what happens.
However, I wonder if a similar test could be done with software.   I
assume that Linux implements some kind of driver to support MESH.
Is there a driver for the 53CF96 which could be substituted or
compared as an experiment.

As an aside, it's too bad that CURIO's pinout is not available from
AMD.   They have datasheets for several related chips on their site.
I guess CURIO was a custom job for Apple or something.

>>  There is no PLD between the PCI interrupt pins and GC on the S900
>>  board.  But, since Umax designed the board, they certainly could have
>>  added one.   They already did that quirky E100 hack to PCI slot 1.
>>  I haven't dug into that, but I'd like to know how they made that
>>  work.  Does an Enet card require an interrupt?  Does it ever master
>>  the PCI bus?
>
>Yes, especially recent ones, they need both.

Thank you.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
