Message-Id: <200102081900.OAA25574@mal-ach.watson.ibm.com>
To: paulus@linuxcare.com.au
cc: Dan Malek <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: Message from Paul Mackerras <paulus@linuxcare.com.au>
   of "Thu, 08 Feb 2001 11:48:49 +1100." <14977.60657.871016.955014@diego.linuxcare.com.au>
Date: Thu, 08 Feb 2001 14:00:07 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul,

	The POWER and PowerPC architectures specifically were designed
with the larger "virtual" address space in mind.  Yes, a single context
cannot see more than 32-bit address space at a time, but an operating
system can utilize that for more efficent access to a larger address
space.  Maybe the current HIGHMEM implementation is an anomaly, but it is
important to be open to these alternate perspecives.

	Also, as Dan said, the current PowerPC port is avoiding many of
the PowerPC architecture's design features for VMM.  While "mostly
incorrect use of the MMU" may be a little strong, I would agree with Dan
that the port is not using the PowerPC architecture as intended.  By not
utilizing the hardware assists, the port is not performing at its optimal
level.

	For instance, the rotating VSIDs are blowing away internally
cached information about mappings and forcing the processor to recreate
translations more often than necessary.  That causes a performance
degradation.  Pre-heating the TLB can be good under certain circumstances.

	As I have mentioned before, the current design appears to be
generating many hash table misses because it allocates a new VSID rather
than unmapping multiple pages from the page table.  This also means that
it cannot be exploiting the dirty bit in the page/hash table entry and
presumably encounters double misses on write faults.

	One really needs to consider the design model for the PowerPC
architecture and some of the microarchitecture optimizations utilizing the
greater chip area in newer PowerPC processor implementations to know how
to structure the PowerPC Linux VMM for best performance.  One needs to
consider these issues when arguing for a design to defer work (like TLB
entries) as well as considering the details of *how* the deferral is
implemented (VSID shuffling) relative to the perceived benefit.

	We really need to get more IBM PowerPC and kernel VMM experts
involved to explore the best design given the Linux kernel's abstractions
and limitations in the VMM space.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
