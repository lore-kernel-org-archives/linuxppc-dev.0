MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16609.11061.282732.479208@cargo.ozlabs.ibm.com>
Date: Tue, 29 Jun 2004 18:41:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Bob Doiron" <bob.doiron@amirix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Possbile bug in hashtable.S : add_hash_page
In-Reply-To: <NBBBIKIPCKOLLCLIHBIMMEPNEBAA.bob.doiron@amirix.com>
References: <NBBBIKIPCKOLLCLIHBIMMEPNEBAA.bob.doiron@amirix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob Doiron writes:

> However - r1 remains unchanged within the function. As it stands, it seems
> that an interrupt could come along and scrible on our return address by
> using the unchanged stack pointer. What I've been seeing is that when under

No - if an interrupt happens, it should decrement the stack pointer
before writing to the stack.  An interrupt should never modify
anything at or above the current stack pointer.

> heavy interrupt load (nfs mount kernel compile for example) my ppc gets
> stuck in a "here: jump here" loop right at the blr instruction listed above.
> Inspecting the stack @ 4(r1) showed that it did in fact have the address of
> the blr instruction there, which led me to beleive that it is getting
> corrupted by an interrupt. Simply changing the "4" offset in 4(r1) to 12
> makes for a rock stable kernel, but it's a horrific hack.

Well, it might be getting corrupted by an interrupt, in which case the
most likely cause is some code using a local array variable and
accessing outside the bounds of the array.  It's hard to see what that
code would be doing to put the address of the blr in that word of
memory though.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
