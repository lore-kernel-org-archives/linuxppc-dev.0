Date: Wed, 12 Jul 2000 14:44:44 -0700
From: Stu Palmer <whistler@bitmuncher.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: late 2.3/2.4.0-{pre,test} work?
Message-ID: <20000712144444.A18972@delirium.bitmuncher.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello.  Newbie post with newbie questions.  Searched the archives and
didn't turn up much.  I'm going for the absolute latest kernels,
finding various icky little things, and using icky little patches to
get around them.  As I'd think it would be a duplication of effort,
I've come to ask.

1) Is there any work being done to make the late 2.3.x kernels or the
   2.4-test series PPC-friendly?  Most traffic seems to be stabilizing
   2.2 and/or getting 2.2 supported on the latest boxes.  (Also
   phrased, "Where's the 2.4.x rsync/CVS repository?")

2) If not, where can I send/put patches for this stuff?  Aside from
   the main code problems on l-k, the ppc support has these two fun
   things:
    * local_{irq,bh}_count seem to be defined as arrays in themselves,
      whereas other ports #define them into references to a struct.
      Bottom line: gcc thinks eg. local_bh_count() in the non-specific
      kernel bits to be an invalid object type when arch-ppc defines
      local_bh_count[] .  My current nasty patch creates lots of
      warnings about redefining those two symbols.
    * a few things that like nvram support break when nvram is set to
      compile as a module; the object chain breaks.  It should be
      forced into the kernel, yes?  (stuff like atyfb, ...)

For reference, I'm attempting compiles/loads on a Lombard Powerbook
G3.

If these are are RTFM, FAQ's, or already fixed somewhere, please
accept my humble apologies and send me a reference to the fixes/
patches.  Thanks for getting PPC this far.

SJP
__
--  "Will he ever figure out that we gave him an 'Etch-A-Sketch'?"
                                           -Dilbert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
