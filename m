Message-Id: <v04003a00b5e80ad96727@[24.70.162.14]>
In-Reply-To: <Pine.LNX.4.10.10009151505490.378-100000@cassiopeia.home>
References: <F14441D40E5AD3118886005004607AD10BDDA5@MAIL1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 15 Sep 2000 12:40:38 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        "Halfmann, Klaus" <khalfmann@libra.de>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Status of HFS+ support
Cc: "'linux-fsdevel@vger.kernel.org '" <linux-fsdevel@vger.kernel.org>,
        "'linuxppc-dev@lists.linuxppc.org '" <linuxppc-dev@lists.linuxppc.org>,
        "'flar@allandria.com '" <flar@allandria.com>,
        "'Olaf Hering'" <olh@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:07 AM -0500 9/15/2000, Geert Uytterhoeven wrote:
>On Fri, 15 Sep 2000, Halfmann, Klaus wrote:
>> Today I can announce a bit of progress:
>>
>> The following tools currently work (readonly):
>>
>> hpmount ,hpumount, hpls, hpcd, hpcopy.
>
>No hpfsck (or even a hpvalidate)? Having a tool to _verify_ (I'm not speaking
>about correcting yet) the correctness of a filesystem is very interesting.

Checking an hfs or hfs+ filesystem is very very easy.

I could picture walking down the catalog btree and check to see that the
sidelinks and downlinks all agree on which node they're pointing at, and
while you're at it, make sure the nodes don't point to garbage.

You'd then probably repeat that procedure on the Extents btree.

After that's done, you'd probably walk the leaf nodes of the catalog tree
to check that the filesystem heiarchy is still sane. After that, it would
probably follow to walk the leaf nodes in the extents btree and check for
overlaps, then compare it with the volume bitmap.

There's probably a few other checks that would be good too, like checking
for stale extents records or something.

Repairing an HFS(+) drive is a whole other matter entirely. Saying "This
ain't no journaling filesystem" would be an understatement of galactic
proportions (which, I should add, would also make threading the filesystem
very painful). Consider that when you insert a new leaf node into one of
the btrees, you have at the absolute very least 5 pointers to update. Power
goes out? oops, now 2 of those pointers are pointing at one node, and 2 are
pointing at some other node, and one's full of garbage 'cause the HD didn't
get a chance to write out the whole node. Which pointers are correct? who
knows, I don't think apple ever documented a prefered serialization order
for any of the fs changes.

imho, the only reliable way to repair a crashed HFS(+) drive is with a hex
editor.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
