Message-ID: <3BEBDCC9.62669CF1@midrivers.com>
Date: Fri, 09 Nov 2001 06:40:25 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 -- a little console help, part 2
References: <3BEA8A5D.50A75CE7@midrivers.com> <3BEAA8D3.51ADDCC8@mvista.com> <20011109114403.J27549@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
>
> Ah, I think I know why this might be - are you using the 2_4_devel
> tree?
>
> All static executables segfaulted before reaching main until very
> recently: the 4xx's MMU makes it possible to actually enforce the
> execute permission bit on pages.  Since most processors don't allow
> this, however, there are heaps of bugs in userland (binutils etc.)
> where pages aren't marked executable that need to be.  In this case
> there was instruction just before the got that wasn't marked
> executable.
>
> For now, at least, I've disabled enforcement of the page execute
> permissions, because there's just too much stuff that breaks with it
> on.

What's the fix for this?  It sounds like I want to un-do that change
enforcing page execute permissions -- David, could you give me
a spot to look and a suggested patch?  anyone?

thanks,

Mark
--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
