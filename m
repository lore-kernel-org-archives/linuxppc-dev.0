Date: Sat, 11 Sep 1999 11:53:22 -0400 (EDT)
From: Alex Fishman <fosh@fosh.com>
To: Jules Bean <jmlb2@hermes.cam.ac.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kensington 'orbit' trackball - think's it's a turbomouse 5?
In-Reply-To: <Pine.SOL.4.10a.9909120418200.26060-100000@orange.csi.cam.ac.uk>
Message-ID: <Pine.LNX.3.96.990911115053.7386A-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Infact, the mouse really is a turbo mouse 5 in disguise, this is not the
problem, the problem is that the two buttons on the mouse are mapped to
one and two, you want them mapped to one and three (i.e.  The button on
the left is like the first button on a three button, the button on the
right is like the third button, and chording is like the second button).
TO accomplish this, type:

xmodmap -e "pointer = 1 3 2"

-Alex

On Sun, 12 Sep 1999, Jules Bean wrote:

> 
> Hi all..
> 
> I hope this is the right list to post to.  I *think* it's too technical
> for -user, but redirect me if not..
> 
> I've just installed LinuxPPC (actually, YDL) on my Dad's G3-upgraded 7350
> here, and everything is running nicely.
> 
> The machine has a trackball which calls itself a 'kensington orbit'.  I
> have browsed the mailing list archives and found a couple of threads
> talking about the badly behaved turbomouse.  Well, this trackball sounds a
> bit like that, except that it only has two buttons, not three.
> 
> At boot time, the kernel says:
> 
> [jules@sharpsburg jules]$ dmesg | egrep '^ADB' 
> ADB mouse at 3, handler 1 (TurboMouse 5)
> ADB mouse at 15, handler 1
> ADB mouse at 3, handler 1 (TurboMouse 5)
> ADB mouse at 15, handler 1
> ADB keyboard at 2, handler 1
> 
> When I'm in X, the mouse operates fine as a two-button mouse, except that
> it is sending buttons 1 and 2, rather than the more useful 1 and 3.
> 
> I can superficially fix this last using xmodmap pointer, although (AFAIK)
> there's no way of doing an 'emulate3buttons' trick at this stage.
> 
> I think there's something slightly odd going on here (hence my post to
> this mailing list) because of how mousemode behaves:
> 
> [root@sharpsburg jules]# /sbin/mousemode 3
> handler for addr 3 is 50
> [root@sharpsburg jules]# /sbin/mousemode 15
> handler for addr 15 is -1
> 
> Then, if I try to set things to handler 4, as suggested in emails I've
> found here abouts, I get:
> 
> [root@sharpsburg jules]# /sbin/mousemode 3 4
> handler for addr 3 was 50
> trying to set handler to 4...
> handler is now 50
> 
> 
> I can only make changes take effect by going 'via' handler -1.  Then, both
> buttons start being button 1!
> 
> Now, what I'd like to see, is either:
> 
> 1) The kernel giving buttons 1 and 3 for the two buttons, and button 2 if
> they are chorded
> 
> or
> 
> 2) The kernel giving buttons 1 and 3, and  XF86FBDev doing the chording
> (Emulate3Buttons doesn't work - maybe that's simply because the mouse
> gives buttons 1 and 2 by default).
> 
> I'm C-literate, and happy hacking kernel files to test out ideas.. any
> pointers appreciated.
> 
> Oh, I almost forgot.  You'll want to know this, I expect:
> 
> [jules@sharpsburg jules]$ uname -a
> Linux sharpsburg.habas.net 2.2.6-16bpmac #1 Thu Jul 29 16:04:31 MDT 1999
> ppc unknown
> 
> 
> Yours,
> 
> Jules Bean
> 
> /----------------+-------------------------------+---------------------\
> |  Jelibean aka  | jules@jellybean.co.uk         |  6 Evelyn Rd	       |
> |  Jules aka     | jules@debian.org              |  Richmond, Surrey   |
> |  Julian Bean   | jmlb2@hermes.cam.ac.uk        |  TW9 2TF *UK*       |
> +----------------+-------------------------------+---------------------+
> |  War doesn't demonstrate who's right... just who's left.             |
> |  When privacy is outlawed... only the outlaws have privacy.          |
> \----------------------------------------------------------------------/
> 
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
