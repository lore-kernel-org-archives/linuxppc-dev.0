MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 8260 CPM DP ram free function
Date: Fri, 21 May 2004 16:52:06 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAE2@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Will you please get rid of those #ifdefs?  If the code works,
> just use it, if not, don't ask for a patch to be applied.
> There is no reason for this.

Ok

> The "host" functions should simply be removed and drivers
> should use kmalloc()/kfree(), manage their own alignment
> restrictions, since the 82xx is cache coherent.

Not sure how easy that would be. The host_alloc and dp_alloc gets called
at few times _before_ kmem_cache_init() is called, so a kmalloc call
panic()s the kernel.
I know, because I tried to use kmalloc for handling the linked lists for
the dp_alloc/free functions.

It would make allocating buffers in drivers easier.

> Let's clean this up and do it right if we are going to do it at all.
Cleaning up is always good.

Any more suggestions before I remove the #ifdefs and resubmit?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
