In-Reply-To: <Pine.LNX.4.10.10003241443040.21215-100000@opal.biophys.uni-duesseldorf.de>
Date: Fri, 24 Mar 2000 15:10:12 +0100
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, geert@linux-m68k.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000324151012.019222@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 24, 2000, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>> Don't touch the resources which correspond to assigned PCI bus addresses
>> because they correspond to the address ranges to which chip decoders
>> respond. Lying in this area makes dynamic allocation and hotplugging
>> impossible by giving the resource allocator the impression that some area
>> is free. Rather attach asubtree to the already existing device resources.
>
>So it's perfectly legal for resources within the same device to overlap?
>WTF does X not tolerate this and disables the overlapping one?
>
>(Side note: X also reports the mem resources in reverse order, or maybe
>sorted by end address, and disables the larger of the two apertures
>because it saw the smaller one first, even though the smaller one is
>completely embedded in the larger).
>
>I'm not sure adding subtrees will help - I guess X might go ahead and
>disable the main resources anyway. Will the subtree resources remain
>accessible in that case?

Two things:

 - It's not legal to have overlapping BARs (well, maybe it is if they are
doing hard decoding), but it's out of spec. At least, that's my
understanding of the spec. ATI does this, so we need a workaround.

 - X will always try to fix any PCI conflict it finds, with or without
fbdev drivers. That's what I understands after discussing with some X
coders. To handle various OSes and all sort of legacy crap, X has to play
weird tricks with PCI and no-one in the XFree group wants to change this.
They don't want to make this remapping optional neither for support
reasons, so we have to make sure there's no conflict detected by X so it
doesn't try to mess with assignements.

However, Egbert is working on improving the X PCI interface so that we
know in the kernel what's going on the PCI bus and can keep kernel
resources in sync. I beleive we can use this not-yet-existing mecanism to
"hide" some of those stuffs to X if really necessary.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
