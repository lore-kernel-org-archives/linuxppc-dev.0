Date: Tue, 22 Dec 1998 22:24:37 -0700 (MST)
From: john s jacobs anderson <jacobs@azstarnet.com>
To: Tom Harrington <tph@rmi.net>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: TurboMouse fix
In-Reply-To: <m0zsgMz-001BzRC@shell.rmi.net>
Message-ID: <Pine.LNX.3.96.981222221345.25791A-100000@lazarus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Dec 1998, Tom Harrington wrote:

> > > Hmm, maybe something in your header files?  ADB_WRITEREG is defined (on
> > > my system) in /usr/include/asm/adb_mouse.h.  Look for this file and see 
> > > what's there.
> > 
> > OMM, the /usr/include/asm dir is a symlink to asm-ppc in the kernel
> > source, which is 2.1.131. That file contains a struct def for
> > mouse_status, and that's all. The ADB_WRITEREG, etc. #defines are in
> > adb.h.
> 
> Err... hmm.  I can't quite account for that.  I did make a mistake in
> that the macro is defined in cuda.h, not adb_mouse.h, on my system.
> But I'm running a pretty basic R4 install, upgraded to 2.1.125.
> Maybe you chose different install options than I did?  IIRC I told
> it to give me every programming-related option available.

That's also what I did, IIRC. Keep in mind that while I'm booting off the
2.1.127 kernal, using BootX, all my kernel sources are 2.1.131. Am I wrong
to think that things might have moved around?

> 
> If you see the definition in adb.h on your box, then adding 
> "#include asm/adb.h", and deleting either adb_mouse.h or cuda.h,
> (whichever gcc doesn't like) should get it compiling.

Actually, it's not necessary to remove anything; just adding 
	
	#include <asm/adb.h>

below the last #include results in happy source, which complies into
a.out. Woo hoo! Running the code _does_ have an effect -- two to be exact.
Before running the code, left button was mouse1 and right button either
did nothing or produced seriously wacky results in a non-intuitive way.
After running the code, right button maps to mouse2! A step in the right
direction. However, left button is now mapped to some funky click-lock
like mode, where one click causes it to act like a depress-and-hold. You
have to double-click to get a single click effect, 4Xclick to 2Xclick. 

Any ideas why that's happening?

> Two of the most painful lessons of programming are:
> 1. Everyone makes the stupidest mistakes, all the time.
> 2. If you don't understand #1, you will still make stupid mistakes, but
> it will take you FOREVER to find them.

For me, 1. expresess itself via using numeric comparison operators in Perl
when I should use string comparison operators (I can't get it thru my head
that (==) != (eq) )

> Yes, I suggested that you might have made a stupid mistake.  That
> doesn't mean I was suggesting that _you_ are stupid.  If you do
> understand #1, you learn to look for stupid mistakes right from the
> start (I _still_ use "=" for "==" sometimes, but now I know to expect
> it).

Sorry -- I may over over-read your original reply. I'm touchy this time of
year -- all that Xmas cheer stuff.

> They could have just used the extended mouse protocol, after all.

Prrotocols? We don't need no steekin' protocols!

john.
jacobs@treefort.org
www.treefort.org/~jacobs 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
