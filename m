Date: Thu, 11 Apr 2002 16:28:49 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: andrew may <acmay@acmay.homeip.net>, Armin <akuster@pacbell.net>,
	John Tyner <jtyner@cs.ucr.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020411162849.F18158@ecam.san.rr.com>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net> <20020411153642.C18158@ecam.san.rr.com> <20020411231056.GJ759@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020411231056.GJ759@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 04:10:56PM -0700, Tom Rini wrote:
> On Thu, Apr 11, 2002 at 03:36:42PM -0700, andrew may wrote:
>
> > This patch is to remove the need for the BASE BAUD define.
>
> Only if you get this information from somewhere else, yes?  This isn't
> currently something we grab from OpenBIOS, or could, right?

If you look at the patch you see the only thing we need to know is the clock
rate of the CPU. Then you can to a mfdcr() to calc the base baud. If there
is an external clock then we need the basebaud from somewhere else.

We dumped OpenBIOS and put on PPCBoot, but I think OpenBIOS provides the
clock speed.

> > If we ever start
> > trying to get a single kernel to build for multiple 405 boards that run at
> > various clock rates it becomes helpful to calc the base baud for the serial
> > ports rather than forcing it at compile time.
>
> If we ever start trying to get a single kernel to build for multiple 405
> boards something has gone wrong. :)
>
> More seriously, if someone wants to try and do that there's lots of
> other things which would need to be changed first.

Yes there is a lot of work to do, but I would like to see it happen.
Right now we have to do seperate builds for our custum board and one for
our Walnut boards and that is a pain.

I though it would be good to start small and see how things go, before another
fork got started :).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
