Message-ID: <3BBDE5AF.1A7D5673@mvista.com>
Date: Fri, 05 Oct 2001 12:54:07 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@labs.mot.com>
Cc: John_McRoberts@mitel.com,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hard disk and segmentation violation.
References: <85256ADC.00515614.00@kanmta01.software.mitel.com> <3BBDDF94.9728840D@labs.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> ..... Still I don't yet have a good
> grasp on what space can be mapped 1:1 .....


You shouldn't be concerned about this mapping.  ALL device drivers
should perform the ioremap() in their device initialization functions,
in which case there isn't any mapping problem.  There are some unique
cases when porting boards or processors that early mapping is necessary,
but this is not the place for mapping the resources used by device
drivers that initialize normally.  Please do not add any resource
mapping in the memory management initialization functions.

In summary (which has been written too many times already), the user
space is first two or three gigabyte virtual address region (zero to
0x7fffffff or 0xbfffffff).  Anything mapped in this area obviously
conflicts with user mapping.  The region between 0x80000000 and
0xbfffffff may be user or kernel space depending upon the kernel
configuration and board requirements.
The kernel virtual space is
always the top gigabyte.  With the exception of some special case
initialization mapping I mentioned above, the kernel VM allocator
dynamically allocates in the proper address spaces.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
