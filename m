Message-ID: <3BBDD64F.97B0057B@aps.anl.gov>
Date: Fri, 05 Oct 2001 10:48:31 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
References: <20011003130559.F31866@borg.org>
	 <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net>
	 <20011004092511.A3914@borg.org>
	 <20011004132953.B32269@cpe-24-221-152-185.az.sprintbbd.net> <20011005111145.C8157@borg.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:
>
> Then each day I have a script that does:
> - "bk changes" to see the "before" rev,
> - "bk pull" to get up to date,
> - "bk changes" to see "after" rev,
> - export of a patch between those two revs, apply that to my cvs.
>
> The problem is that some of the patches fail because the cvs file
> isn't in the state the patch expects.  Because I am still getting the
> bugs out, we aren't doing any work in the cvs tree, only bk stuff is
> going in there.

Why don't you use the cvs vendor branch to do most of the work for you,
rather than generating deltas yourself?

Every day you'd get the latest release tree from BK and do a cvs import of
this into your local repository, followed by the cvs checkout -j -j and
cvs commit to merge the changes into the main trunk - CVS keeps track of
the state the BK repository was in when it was last imported.

If you do this right, this should only bring up problems in the checkout
-j -j stage when some locally committed change conflicts with an imported
change, which is something you'd have to fix manually anyway.

Oh, and BTW the instructions that cvs import prints out about doing the
cvs checkout -j -j aren't quite right, you should really use the release
tags you gave to cvs import rather than the :yesterday it recommends.

I can give more detail on this approach if you're interested - we don't
import the linuxppc tree, automate it or do it daily, but do have a
standard procedure for this kind of handling of externally managed code
with CVS.

- Andrew
--
Perfection is reached, not when there is no longer anything to add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
