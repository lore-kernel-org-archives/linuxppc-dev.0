Date: Wed, 6 Feb 2002 21:12:22 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Jeffery von Ronne <jronne@ics.uci.edu>
Cc: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
	Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: two aty128 frame buffers?
In-Reply-To: <20020206153744.E3189@reepicheep.ics.uci.edu>
Message-ID: <Pine.BSF.4.44.0202062110280.82577-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Feb 2002, Jeffery von Ronne wrote:

>
> On Wed, Feb 06, 2002 at 01:08:28AM +0100, Michel Dänzer wrote:
> > > I tried applying your hack to a virgin XF 4.2.0 source tree, and
> > > I get a signal 11 crash.  The last output shows the X server loading
> > > vgahw.
>
> I strated sprinkling the code with R128_TRACE messages, and as near as I can
> tell, the vgaHWGetIOBase is crashing.

You can't use 2 cards which require ISA IO (vgaHW uses ISA IO on rage128)
right now, because of the multiple busses on the G4 machines.  You can
comment out all the vgaHW calls and that will probably work, but without
doing that it will always crash on any ISA IO operation.  The reason is
because your second bus's ISA IO isn't mapped.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
