From: flar@allandria.com
Message-Id: <200009160501.WAA02418@marcus.allandria.com>
Subject: Re: Status of HFS+ support
To: nicoya@apia.dhs.org (Tony Mantler)
Date: Fri, 15 Sep 2000 22:01:06 -0700 (PDT)
Cc: geert@linux-m68k.org (Geert Uytterhoeven),
        khalfmann@libra.de (Halfmann Klaus),
        linux-fsdevel@vger.kernel.org ('linux-fsdevel@vger.kernel.org '),
        linuxppc-dev@lists.linuxppc.org ('linuxppc-dev@lists.linuxppc.org '),
        olh@suse.de ('Olaf Hering')
In-Reply-To: <v04003a00b5e80ad96727@[24.70.162.14]> from "Tony Mantler" at Sep 15, 2000 12:40:38 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tony Mantler wrote:
> Checking an hfs or hfs+ filesystem is very very easy.

Well, I don't know that I'd call it very easy, but it's certainly easier
than trying to actually fix it. :)

> I could picture walking down the catalog btree and check to see that the
> sidelinks and downlinks all agree on which node they're pointing at, and
> while you're at it, make sure the nodes don't point to garbage.
>
> You'd then probably repeat that procedure on the Extents btree.
>
> After that's done, you'd probably walk the leaf nodes of the catalog tree
> to check that the filesystem heiarchy is still sane. After that, it would
> probably follow to walk the leaf nodes in the extents btree and check for
> overlaps, then compare it with the volume bitmap.
>
> There's probably a few other checks that would be good too, like checking
> for stale extents records or something.

That all sounds reasonable. Probably wouldn't even take that long, and
would likely prove the correctness or incorrectness of the code in some
instances. The thing that would be a pain to check but very important
is to check the sorting order in all trees. I may even try to get something
running this weekend if I get a chance.

> Repairing an HFS(+) drive is a whole other matter entirely. Saying "This
> ain't no journaling filesystem" would be an understatement of galactic
> proportions (which, I should add, would also make threading the filesystem
> very painful). Consider that when you insert a new leaf node into one of
> the btrees, you have at the absolute very least 5 pointers to update. Power
> goes out? oops, now 2 of those pointers are pointing at one node, and 2 are
> pointing at some other node, and one's full of garbage 'cause the HD didn't
> get a chance to write out the whole node. Which pointers are correct? who
> knows, I don't think apple ever documented a prefered serialization order
> for any of the fs changes.

Yes, it is a bit of a mess.

> imho, the only reliable way to repair a crashed HFS(+) drive is with a hex
> editor.

Well, automated tools can fix some of the damage. I've had good luck fixing
drives with Norton Utilities, although there are some problems it chokes on.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
