From: Benjamin Herrenschmidt <bh40@calva.net>
To: Olaf Hering <olh@suse.de>,
        Michael Schmitz
 <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
Date: Tue, 26 Sep 2000 23:02:53 +0200
Message-Id: <19340821143437.3943@mailhost.mipsys.com>
In-Reply-To: <20000926204606.B467@suse.de>
References: <20000926204606.B467@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I've posted such a patch to debian-powerpc when one user there had this
>> problem. That was before I learned booting with yaboot avoids the problem.
>> If the resource conflict also happens on oldworld machines, I'd still
>> prefer some suggestions to foolproof the patch (as in: how can I figure
>> out if a region has been allocated by another card? What bits from the
>> config registers should I look at?).
>
>I have a precompiled benh Kernel at penguinppc.org/~olaf with Benhs current
>kerneltree, your patch is still needed - otherwise *kaboom*

Allocating a region is nasty. You must find a free physical region (2.2.x
has no support for that) and you must find one that is decoded by the
north bridge (we currently have no code for either reading or writing the
address space decode enable bits of Bandit and UniNorth).

That's step 2 of my PCI patches. I will a set of regions per hose (pci
controller, Apple ones can decode several non-contiguous regions).

With this done, we will be able to really allocate PCI space from the
kernel. I still have to check if the common PCI code provides enough
hooks so I can even add new decoded regions to Bandit/Uninorth, but
that's not terribly important.

One thing: I'd be interested in figuring out what happens if you simply
leave this nasty ATI BAR unassigned (write 0xffffffff and then 0 to it).
Will the controller fail ?

What I can do in the meantime is test that we are running _exactly_ on
this machine model, and them remap to a region we know is safe (that's
more or less what you patch do).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
