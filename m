Date: Thu, 4 Oct 2001 13:29:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
Message-ID: <20011004132953.B32269@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011003130559.F31866@borg.org> <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net> <20011004092511.A3914@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011004092511.A3914@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 04, 2001 at 09:25:12AM -0400, Kent Borg wrote:
>
> On Wed, Oct 03, 2001 at 11:32:45AM -0700, Tom Rini wrote:
> > Doing this daily isn't too horrid.  Use the rsync version and tag
> > a tree daily.  Thats more or less what I do.
>
> I might switch to that.
>
> But won't I still have a problem of our cvs expanding keywords
> breaking the next patch that gets too near them?
>
> > Yeap.  One thing you can try is to un-export the keywords first.  Ie
> > change them back into BK Id: %x% %..%
>
> I don't understand.

Okay.  Before you import from say rsync to CVS, go and change all of the
PPC files from:
BK Id: SCCS/s.setup.c 1.73 10/02/01 10:06:27 paulus
to:
BK Id: %F% %I% %G% %U% %#%

And then import.  The keyword section will always be the same, and CVS
should be quite.  I haven't tried this yet tho.

> > Smaller hunks and change 'em back into the unexported form?
>
> Again I don't think I understand what you mean by "unexported form".

Oh.  BK tags, which CVS chokes on have expanded and unxpanded forms
just like the CVS ones.

> Right now I am burning plenty of computrons and rattling the disk a
> lot (let's hear it for otherwise idle machines) by exporting two
> complete trees, running a slow perl script over both to remove
> expansions of dollar-Id, and now dollar-Revision, make my own diff
> -Nru of that, and then I guess I will have to patch by hand a zillion
> annoying recent changes to the placement dollar-Id in sparc64 files.
> And then I will tackle whatever I discover is still not patching after
> my modified perl script finishes running.

Ah, you're being too zellous in your attempts.  If you do -ko on the
import of files like sparc64, it will treat the $Id$ stuff as normal text.
This doesn't work on the BK ids which is chokes on anyhow.  The other
thing I do, since this isn't fully automated, is if files end up
being unhappy after CVS merge is to cat the original over 'em.  This
only works on files I don't change tho. :)

> I am starting to think that trying to run a shadow source code
> controlled repository is a mistake.  Am I dragging along unadvisable
> mental baggage from the old days of developing proprietary code?  Do I
> need to take a deep breath here, hold my nose, have faith in The
> Source, and leap??  Am I foolishly fighting Bitkeeper by trying to
> stick with cvs internally?  Do I need to just give in on Bitkeeper?

That's a bit for another 'discussion'.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
