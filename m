Message-Id: <m0zsgMz-001BzRC@shell.rmi.net>
From: tph@rmi.net (Tom Harrington)
Subject: Re: TurboMouse fix
To: jacobs@azstarnet.com (john s jacobs anderson)
Date: Tue, 22 Dec 1998 21:58:01 -0700 (MST)
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96.981222145001.10207B-100000@lazarus> from "john s jacobs anderson" at Dec 22, 98 02:59:42 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Hmm, maybe something in your header files?  ADB_WRITEREG is defined (on
> > my system) in /usr/include/asm/adb_mouse.h.  Look for this file and see 
> > what's there.
> 
> OMM, the /usr/include/asm dir is a symlink to asm-ppc in the kernel
> source, which is 2.1.131. That file contains a struct def for
> mouse_status, and that's all. The ADB_WRITEREG, etc. #defines are in
> adb.h.

Err... hmm.  I can't quite account for that.  I did make a mistake in
that the macro is defined in cuda.h, not adb_mouse.h, on my system.
But I'm running a pretty basic R4 install, upgraded to 2.1.125.
Maybe you chose different install options than I did?  IIRC I told
it to give me every programming-related option available.

If you see the definition in adb.h on your box, then adding 
"#include asm/adb.h", and deleting either adb_mouse.h or cuda.h,
(whichever gcc doesn't like) should get it compiling.

Can anyone else account for the header file discrepancy?

> > I'm surprised it complains about "ADB-WRITEREG" when the code uses
> > "ADB_WRITEREG".  You didn't happen to "fix" this while trimming the
> > file in pico, did you?
> 
> No, I screwed up while re-typing the error messages into my email.
> Nothing in between the --cut here-- and --cut here-- (or whatever you
> had delimiting the code) was changed. 
> 
> (Is it just me, or is everybody assuming I'm way more stupid than is
> necessary? I followed instructions, and when that didn't work, I provided
> the requested feedback, and so far I've got two condescending emails to
> show for it.) 

Two of the most painful lessons of programming are:
1. Everyone makes the stupidest mistakes, all the time.
2. If you don't understand #1, you will still make stupid mistakes, but
it will take you FOREVER to find them.

Yes, I suggested that you might have made a stupid mistake.  That
doesn't mean I was suggesting that _you_ are stupid.  If you do
understand #1, you learn to look for stupid mistakes right from the
start (I _still_ use "=" for "==" sometimes, but now I know to expect
it).

> > I really don't know if mousehack is useful (or even necessary) with a v4.0
> > TurboMouse.  I assume you've tried the "mousemode" command?
> 
> Well, Mark Abene(sp?) has said in this thread that mousehack doesn't work
> with the 4.0 balls. I've tried mousemode; the mouse just switches back.

Yeah, it sounds like the 4.0 TurboMouse is pretty weird in this regard.
They could have just used the extended mouse protocol, after all.

Tom


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
