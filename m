Message-Id: <v04003a00b5d629d4bebd@[24.66.67.194]>
In-Reply-To: <200009010352.UAA22371@marcus.allandria.com>
References: <Pine.GSO.4.10.10008311902200.4074-100000@weyl.math.psu.edu>
 from "Alexander Viro" at Aug 31, 2000 10:40:30 PM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 1 Sep 2000 23:04:26 -0500
To: flar@allandria.com, viro@math.psu.edu (Alexander Viro)
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Btree directories (Re: Status of HFS+ support)
Cc: dgatwood@deepspace.mklinux.org (David A. Gatwood), ak@suse.de (Andi Kleen),
        lord@sgi.com (Steve Lord), matthew@wil.cx (Matthew Wilcox),
        khalfmann@libra.de (Halfmann Klaus), roman@augan.com (Roman Zippel),
        linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:52 PM -0500 8/31/2000, flar@allandria.com wrote:
>Alexander Viro wrote:
>> On Thu, 31 Aug 2000 flar@allandria.com wrote:
>>
>> > Yes, HFS and HFS+ both have a CNID for each file or directory. It just
>>isn't
>> > entirely straightforward to search the catalog by this value, since
>>the key
>> > is a combination of parentCNID and name. The CNID is guaranteed to be
>>unique
>> > across a filesystem and there are a handful that are reserved for system
>> > files/directories such as the root (2) and the "parent of root" (1).
>>
>> OK. Are they preserved by rename()?
>
>There isn't anything preventing it. A rename() is messy enough because of the
>headache of moving around entries in the btree and updating all the implicit
>usage of the catalog key which depends on the filename. I don't think the
>MacOS actually preserves the CNID on a rename, tho. It's something that I
>think would be about the same complexity either way. The only thing you
>save by keeping the same CNID is changes to the extents overflow tree,
>which is usually empty anyway. (My code doesn't do rename() yet...)
[...]

I think the point of the CNIDs is that they are preserved on rename
(atleast, MacOS preserves them) so you can do things like open a file, do
some stuff, close it for a bit, then refind it by it's fine number and do
some more stuff with it, completely immune to the user shuffling files
around.

An example of this is the MacOS itself, which uses the CNID extensivley to
aid in resolving alias files. With aliases (iirc), MacOS stores the Parent
name and CNID, and the file name and CNID (and appleshare server info and a
bunch of other stuff), then when it resolves the alias, it looks up each
combination of these attributes, in whatever order apple figured would be
most reliable and least surprising to the user, in order to find the
original file. This makes alias files much more durable than a symlink
(pointing to a specific file/folder rather that just a pathname), and more
portable than a hard link (can point to any file or folder across any
volumes). Of course, it has neither the anonimity of a symlink nor the
absolute transparency of a hard link, but that's life.


(btw, my email is currently down for a bit pending some dns updates)

Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
