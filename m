Date: Fri, 17 Mar 2000 13:18:08 +0100 (CET)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: linuxppc-embedded@lists.linuxppc.org
Subject: What is the catch with IDMA on MPC860?
Message-ID: <Pine.BSF.4.10.10003171104010.10581-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I must admit - I love DMA. A DMA a day keeps the
software away. But I repeatedly hear - both inhouse
and on this list that the MPC860 IDMA implementation
leaves somewhat to be wanted. Problem is, I can not
figure out what. MPC860 IDMA looks OK.

According to the documentation, the SDMA/IDMA (DSP-)
controller will perform a normal arbitration on the
internal U-bus and, when granted access, perform a
fast back-to-back transfer. In the IDMA case the
transfer will continue until exhaustion of the
(possibely chained) Buffer Descriptor (list.)
The SDMA will OTOH perform an alternating bus
cycle-steal transfer.

Dual address modes will even interface between
different bus sizes on source and target by grouping
data in the internal buffer memory, thus utilizing
the widest bus width possible on both read and write.


Revision C or later of the '860 will even perform
a single-address _burst_ transfer on IDMA channel 1.
This I would love to do from our in-house designed
frame grabber to main memory. Then I could avoid
disabling all interrupts while bursting. Meaning
I could still catch run-away situations on a
time-out basis. Today things simply lock up...

Sooo, what is really the problem with IDMA?

---

  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
