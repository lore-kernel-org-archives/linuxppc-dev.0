Message-ID: <19981222132904.J16123@radicalmedia.com>
Date: Tue, 22 Dec 1998 13:29:04 -0500
From: Mark Abene <phiber@radicalmedia.com>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: TurboMouse fix
References: <m0zsJFT-001C3VC@shell.rmi.net> <Pine.LNX.3.96.981221225654.1012A-100000@lazarus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.981221225654.1012A-100000@lazarus>; from john s jacobs anderson on Mon, Dec 21, 1998 at 11:03:14PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Three things:

1) mousehack is **ONLY** for TurboMouse 5.0 trackballs!  Not two button 4.0's.
I had written a hack last year for my 4.0, but abandoned it when I got a 5.0.
The 4.0 would actually require kernel mods to the ADB code since the two buttons
send left and right arrow-key keycodes, and the kernel would have to recognize
that they were coming from a different ADB address in order to properly treat
them as mouse-button events.  Otherwise, the kernel just thinks you have two
keyboards.  At least in kernel 2.1.24, the adb code treats anything with 
dev-handler 2 as a keyboard, which in this case is faulty logic.

2) You should NEVER edit source code with pico, since it breaks wrapped lines
which turns source code into useless mulch.

3) Did you type in your error messages by hand?  The macro used in my program
is ADB_WRITEREG, with an underscore, not a hyphen.  It's no shock that the
hyphenated version is undefined, as it don't exist.

-Mark


On Mon, Dec 21, 1998 at 11:03:14PM -0700, john s jacobs anderson wrote:
> 
> <snip>
> 
> system: 7500 chasis with 166 MHz 604 card, 2.1.127 kernel. Kensington
> TurboMouse 4.0 (the 2 button kind), window maker 0.20.3
> 
> (do you need to know anything else? sorry, I'm still a wet behind the
> ears...)
> 
> exported mail to ~, trimmed file in pico, then `cc mousehack.c`.
> 
> gives :
> /tmp/cca082751.o: In function `sethandler':
> /tmp/cca082751.o(.text+0x148): undefined reference to `ADB-WRITEREG'
> (same error repeated at (.text+0x1dc) in function `moveadb'
>                         (.text+0x26c) in function `initreg2'
>                         (.text+0x364) in function `setreg2'
> collect2: ld returned 1 exit status
> 
> ack! what now? I'm drooling at the thought of a functional 2 button mouse,
> and if it only ends up working with v5.0 TurboMice, Santa might have to
> make a late delivery...
> 
> john.
> jacobs@treefort.org
> www.treefort.org/~jacobs/       <--- LinuxPPC notes'n'stuff... 
> 
...

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
