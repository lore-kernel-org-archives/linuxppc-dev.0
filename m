Date: Tue, 16 Apr 2002 18:16:52 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: 2.5 (or beyond) arch-specific boot modules
Message-ID: <20020416181652.X6003@altus.drgw.net>
References: <0204151811.AA07988@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204151811.AA07988@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Mon, Apr 15, 2002 at 11:11:48AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 15, 2002 at 11:11:48AM -0700, Michael Sokolov wrote:
>
> Troy Benjegerdes <hozer@drgw.net> wrote:
>
> > Above all, *readable* code, because otherwise someone changes something,
> > and inadvertently breaks machines that they don't have to test on.
>
> We've got this one settled in favor of ELF section magic to add machines, which
> works for both of us.

Good.

Something along these lines we might want to think about eventually is if
the 2.5 changes for initramfs and making everything a module actually go
through is to make all the board-specific init a module.

Granted, this brings up all kinds of other issues, but I do think they can
be dealt with.

boot would probably go something like this:

Init MMU
find initramfs filesystem image
unpack it
load init module to figure out what machine we are
load board-specific init modules
init pci & other IO
etc..


>
> > If better functionality for the user is your goal, you can't achieve it by
> > designing code around that goal. (Unless, of course, you're Apple computer
> > and have large resources for QA and testing, and design the hardware
> > yourself)
>
> I do design the hardware myself now. But the company I take example from is
> DEC, not Apple.

Heh ;)

Well, for technical users, that's great.. DEC never did much for the
'average' computer user. ;)

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
