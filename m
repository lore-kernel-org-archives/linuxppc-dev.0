To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: random ramblings on 8xx patches (long and tedious :-) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Jul 2004 10:09:59 EDT."
             <Pine.LNX.4.60.0407230947570.5108@localhost.localdomain>
Date: Fri, 23 Jul 2004 16:56:19 +0200
Message-Id: <20040723145625.08BAAC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0407230947570.5108@localhost.localdomain> you wrote:
>
> > There is at least 40 differnt models of 8xx processors.  Go  and  add
> > 82xx  and  85xx  and  52xx  and than start working down the 4xx, 7xx,
> > 74xx, ... lines? I think this gives a LONG list...
>
> possibly, but there's no need for it to be infinitely detailed.  if
> you look at arch/ppc/config.in, there's obviously a coarse
> categorization with things like CONFIG_6xx, CONFIG_8xx and so on.
> at the other extreme, there's specific models like CONFIG_ARCTIC2,
> etc.

But if I understood you right you intend to  use  this  selection  to
prevent the kconfig system to present options to the user which don't
apply  for this processor. So you need to know if this is for example
a MPC860, MPC860T or MPC860P because the latter two have a FEC so you
must enable the FEC options in kconfig, while the first one does not.
Or you need to know if it's MPC850 which  has  only  one  SCC,  or  a
MPC850DE, MPC850SR, or MPC850DSL which have two.

If you want to be consequent, and only present such config options to
the user that really apply to his hardware, then you  must  bite  the
bullet.

> if [ "$CONFIG_TQM823M" = "y" -o \
>         "$CONFIG_TQM850M" = "y" -o \
>         "$CONFIG_TQM855M" = "y" -o \
>         "$CONFIG_TQM860M" = "y" -o \
>         "$CONFIG_TQM862M" = "y" -o \
>         "$CONFIG_NSCU"    = "y" ]; then
>          define_bool     CONFIG_TQM8xxM  y
>
> so *someone* must have thought this approach was a good idea at some
> point. :-)

This is (1) something different (because all these use the very  same
board),  and  (2)  insignificant,  as  it it not part of the official
kernel tree.

> so the obvious question is, is there any value for more of this
> mid-level categorization?  if not, then we can just forget the idea
> and move on.

It was you who started this, with the intention to prevent  the  user
from  selecting bogus config options. [My opinion is that this is not
a  high  priority  issue;  if  we  can  provide  a  working   default
configuration  for a board this is fine; if the user changes this for
his requirements we have to assume that he knows what he is doing.
"UNIX  was not designed to stop you from doing stupid things, because
that would also stop you from doing clever things." - Doug Gwyn

> but if there is, no one says it has to be patched in all at once.

Arghh... Please don't. If we had different approaches in  the  kernel
depoending  on which processor family you're working with it would be
just worse.

> so, to start things off, here's a proposal.  if this kind of
> refinement would have made/will make your life easier, email me
> directly with the patch you'd like to see added.  i'll collect them

Please don't expect a patch from me.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The thing is, as you progress in the Craft,  you'll  learn  there  is
another rule... When you break rules, break 'em good and hard.
                                    - Terry Pratchett, _Wyrd Sisters_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
