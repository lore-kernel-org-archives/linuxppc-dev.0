Message-ID: <3A65439E.85B8CD9F@mvista.com>
Date: Wed, 17 Jan 2001 02:02:54 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com> <3A643283.A20200E8@raleigh.ibm.com> <3A647BC7.15F669F3@mvista.com> <3A64A751.8AA527CF@mvista.com> <3A64C78E.90633885@mvista.com> <3A64E1AA.7F955CCA@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:

> The 405 core (and thus the many processors based on it) has a 64 entry
> tlb.  While debugging via a JTAG debugger I have observed that the
> tlb very quickly gets filled with entries for the current context.

Well, that's because we force it to do that.  Programs that have
a huge working set and run for an extended period will fill the
TLB.  Programs with small working sets will not if we actually
use the contexts properly, but we don't.  The way contexts are
used today, it is effectively flushing the TLB on every switch.
We do the same thing with VSIDs on the "bigger" processors, and
this isn't right either.  The Linux VM properly manages memory
contexts, and we should extend this into the PowerPC specific
software.

I have an LRU context algorithm for the 8xx, and I want to extend
this into the 4xx and even the other processors.  The idea is right,
but I need something that will scale beyond the small 16 contexts
of the 8xx.  I just don't have that yet.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
