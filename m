Date: Mon, 12 Jan 2004 08:32:17 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc trees, what is going on ?
Message-ID: <20040112073217.GC20938@iliana>
References: <20040110084155.GA19817@iliana> <16385.63143.132872.395486@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <16385.63143.132872.395486@cargo.ozlabs.ibm.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 12, 2004 at 12:21:43PM +1100, Paul Mackerras wrote:
> Sven Luther writes:
>
> > Last year, there was linuxppc_2_4 and the -benh tree. But since december
> > 24, this tree doesn't seem to be touched anymore, and a new linuxppc-2.4
> > tree is used.
>
> The linuxppc_2_4* trees were set up before Marcelo moved over to using
> BitKeeper to maintain his 2.4 tree.  As such, the linuxppc_2_4* trees
> are not descendents of Marcelo's tree, according to BK, and are
> updated by applying patches to the linux_2_4 tree, which then get
> pulled from there into linuxppc_2_4, and from there into
> linuxppc_2_4_devel and linuxppc_2_4_benh.
>
> Now that Marcelo is using BK, this process means extra unnecessary
> work.  Also, there are problems in those trees that have accumulated
> over the years and that can't be solved in any simple way - there are
> tag conflicts which keep popping up, and files have been renamed,
> which gets confusing when changes made upstream to
> arch/ppc/boot/Makefile get applied by BK to
> arch/ppc/boot/prep/Makefile in the linuxppc_2_4 tree, since BK thinks
> they are the same file.
>
> The linuxppc-2.4 tree is a descendent of Marcelo's tree, and as such
> we can pull changes that Marcelo makes in his tree directly into the
> linuxppc-2.4 tree.

Ok, thanks for the explanation. Maybe i missed the mail, but if not, it
would have been cool to announce this clearly, so people don't get
surprised.

> > Are we supposed to move to the linuxppc-2.4 tree, and if so, what is
> > the rationale behind this change.
>
> The idea of the linuxppc-2.4 tree is that it would stay closer to
> Marcelo's tree, which would make my job in sending updates to Marcelo
> easier.
>
> In fact, for any substantial body of work which you want to have me
> send to Marcelo, the best thing is to create a clone of Marcelo's
> linux-2.4 tree, check your changes into that, and make it available
> for me to pull from.  I can then pull from that and push the
> changeset(s) into the tree that Marcelo pulls from.  That tree can
> then also be pulled into the linuxppc-2.4 tree to make the changes
> available there before Marcelo pulls them.

Ok.

> > Furthermore, 2.4.24 was released, and the linuxppc-2.4 now contains
> > TAG: v2.4.24, and a bit later there is a Changeset marked as "Import
> > 2.4.24 final tree". There used to be TAGS like TAG: v2.4.23_linuxppc_2_4
> > which i used to take snapshots for releasing debian powerpc kernel
> > packages. Will there still be those, did they simply get forgotten,
> > should i sync with the v2.4.24 tags, or am i missing something.
>
> 2.4.24 was a bit strange.  Marcelo was doing the 2.4.24-pre series as
> usual, but then released a 2.4.24 final with just a few changes from
> 2.4.23, and transferred all the changes that he had been accumulating
> in 2.4.24-pre into 2.4.25-pre.  The linuxppc_2_4* trees haven't been
> updated to reflect that yet.

Ok, anyway linuxppc_2_4 is supposed to be dead. But my point was, from
which TAG should i extract kernels from the linuxppc-2.4 to make debian
packages ? I tried the v2.4.24 tag, which seemed ok, but the version was
still 2.4.24-rc1. I guess this was a problem due to the haste of the
2.4.24 release or something, but it would be nice if it was clear which
tag we should export.

> What Marcelo did in his tree is to create a branch off the 2.4.23
> release, checked in a few patches and then tagged that as 2.4.24.  He
> then pulled those changes back into the main trunk (so to speak, BK
> doesn't really have the concept of a "main trunk") and then released
> 2.4.25-pre4.

Ok.

> So far we haven't been tagging the points at which we merge Marcelo's
> tree into linuxppc-2.4.  The linuxppc-2.4 tree will have Marcelo's
> tags in it but those tags will be the same as in Marcelo's tree.

So ?

> Development in 2.4 should be pretty much coming to a close, with all
> new development being done in 2.6 now.  The linuxppc_2_4_devel tree
> will stay around for historical reference but I would prefer not to
> see new stuff go in there.

Yep, but 2.4 will still be used as the basis for distributions kernels
for some time to come, especially for debian, as i doubt we will be
ableto move to 2.6 in the current state of debian-installer development,
and probably 2.6 is not yet mature enough on all the 11 arch we
officially support.

Come to mind, the linuxppc-2.4 tree probably will not support newer
pmacs, which means i should instead track the -benh tree or something.

> > BTW, while we were at renaming stuffs, would it not have been better to
> > use linuxppc-2.6 instead of the linuxppc-2.5 we currently have ?
>
> That would be a good idea.

:)

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
