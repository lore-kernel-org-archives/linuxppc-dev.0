Message-Id: <200009210353.XAA24224@mal-ach.watson.ibm.com>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, paulus@linuxcare.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Wed, 20 Sep 2000 22:40:50 EDT." <39C97532.3A0ADE15@mvista.com>
Date: Wed, 20 Sep 2000 23:53:28 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Dan Malek writes:

Dan> Really (seriously)?  I always thought if the Linux VM used a different
Dan> structure and method of accessing page tables (upper entries are more
Dan> than just a software address pointer for example), we could really
Dan> optimize the PowerPC kernel.

Dan> Toss out some ideas......I'm listening :-).

	PowerPC Linux appears to be generating many hash table misses
because it allocates a new VSID rather than unmap multiple pages from the
page table.  This also meants that PowerPC Linux cannot be exploiting the
dirty bit in the page/hash table entry and presumably encounters double
misses on write faults.

	In the K42 Research Operating System, on which I work, we assume
that hash table misses are so infrequent that we handle them as in-core
page faults.  With a hash table 4 times the size of physical memory, and a
good spread of entries across them, this seems reasonable.  On the PowerPC
architecture, one normally should not be encountering enough hash table
misses so that handling them quickly is an issue.

	The software TLB trick using the Linux VM page table is neat, but
with speculative execution and superscalar, highly-pipelined processors,
handling them in SW means that you suffer a huge performance penalty
because you introduce a barrier / bubble on every TLB miss.  With hardware
TLB handling, the processor can freeze the pipeline and handle the miss
with much reduced cost.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
