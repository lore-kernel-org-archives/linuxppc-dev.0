Message-ID: <3C9F6E67.2030503@embeddededge.com>
Date: Mon, 25 Mar 2002 13:37:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Neil Horman <nhorman@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: question regarding organization of the pte hash table
References: <3C9E2500.4477166B@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Horman wrote:

> .... use of the PPC860 MMU (my processor in question),

The MPC8xx family processors don't use a hash table.  We just use a two-level
Linux page table and fill the TLBs using the software table walk as described
in the manual.

> .... memory context (CASID) using that same

The MPC8xx identifies 16 possible ASIDs, plus a global identifier we use
in the kernel.  The sixteen ASIDs are assigned to the 16 most active memory
contexts.  If we require the use of a memory context that does not have an
ASID assigned, we invalidate one of the existing ones and claim it.

To minimize source code changes, we try to utilize as much common code as
possible.  Sometimes, the same 'hash' functions are called on processors that
don't use hash tables, because there is some TLB side effect we still want to
cause.  Anything hash table related is skipped, but the TLB management is still
applied.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
