Message-Id: <200102082208.RAA22218@mal-ach.watson.ibm.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>,
	Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
	linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: Message from Cort Dougan <cort@fsmlabs.com>
   of "Thu, 08 Feb 2001 14:28:55 MST." <20010208142855.J24312@hq.fsmlabs.com>
Date: Thu, 08 Feb 2001 17:08:32 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Cort Dougan writes:

} that the port is not using the PowerPC architecture as intended.  By not
} utilizing the hardware assists, the port is not performing at its optimal
} level.

Cort> I have data, and have written a paper with Victor and Paul, showing that we
Cort> get performance _increases_ by not using the PowerPC MMU architecture as
Cort> intended.  I think the PPC architecture intentions for the hash table and
Cort> TLB and very very poor and restrictive.  The 603 was a good step forward
Cort> but the 750, 7400 and follow-ons have been steps backwards from this good
Cort> start.

	Your paper was a very novel and good solution to a performance
problem that you detected in the VMM design.  I already mentioned one of
the problems with the VMM design causing double misses on write faults.
Let me reference the reasoning that Orran Krieger, Marc Auslander, and I
wrote to you about in March 1999 after Orran attended your talk at OSDI:

	"Your paper discussess an approach to handling hash table misses
quickly, but that begs the question of why your design has so many hash
table misses that it is important to handle them quickly.  In the Research
OS that I am working on (targetting PowerPC architecture, among others),
we assume that hash table misses are so infrequent, that we handle them as
in-core page faults.  With a hash table 4 times the size of physical
memory, and a good spread of entries across them, this seems reasonable.  I
got the impression that misses in your system are more frequent because
you allocate new VSIDs rather than unmap multiple pages from the page
table.  If so, I guess that you can't be exploiting the dirty bit in the
page/hash table entry, and hence get double misses on write faults.

	"We also disagree with one of your main conclusions: that
processors should not handle TLB misses in HW.  I think that software
handling of TLB misses is an idea whose time as come ... and gone :-)
Hardware made sense in the past when you wanted to look at a whole pile of
entiries at the same time with specialized HW.  Then, for a while it was
more efficient to do things in SW and avoid the HW complexity.  Now, with
speculative execution and super-scaler highly pipelined processors,
handling them in SW means that you suffer a huge performance penalty
because you introduce a barrier/bubble on every TLB miss.  With HW you can
freeze the pipeline and handle the miss with much reduced cost."

	You and Paul and Victor did some excellent work, but you need to
keep in mind what implicit assumptions about processor design determined
whether the VMM design was an overall win.  We can have a discussion about
whether the hardware improvements which make the VMM design less
adventageous are themselves the right strategy, but many commercial
processors are following that path after careful study of all options.

	Your VMM design was correct for a specific, narrow class of
processors.  We do not agree with your premise that the criteria for a
good processor design is whether it can utilize your VMM design.

	As I said before, one needs to consider the microarchitecture
design and implementation of new processors before one can make sweeping
statements about which VMM design is best.  You can create a wonderful
engineer solution, but are you solving the problem or simply masking a
symptom?

Cheers, David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598
URL: http://www.research.ibm.com/people/d/dje/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
