Mime-Version: 1.0
Message-Id: <v04210100b40584bafd82@[206.173.234.246]>
In-Reply-To: <37DDC204.22888BE8@chpc.utah.edu>
References: <37DDC204.22888BE8@chpc.utah.edu>
Date: Wed, 15 Sep 1999 10:27:15 -0700
To: Lou Langholtz <ldl@chpc.utah.edu>, linuxppc-dev@lists.linuxppc.org
From: Randall R Schulz <rrschulz@cris.com>
Subject: Re: stty < /dev/modem blocks???
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lou,

As you know, the less-than (<) operator in all Unix shells opens the 
file name given as an argument before it executes the command. In 
order for an open() call on a TTY device to complete, the RS232 
hardware signals that indicate the presence of an active device 
connected to the port. In practice, this means that the DTR (data 
terminal ready) signal must be asserted before the open call will 
return. Because the TTY drivers are "slow" devices, the kernel wait 
call that synchronizes the application program's open() call with the 
serial hardware state is interruptable. That is why you can get out 
of the "hang" with a SIGINT (control-C).

The reason you're able to make the analogous thing work with 
/dev/pts/0 is that in place of waiting for a hardware signal, the PTY 
driver slave side (/dev/pts/nn) waits for an open on the 
corresponding controlling side (/dev/ptc/nn). If you're running X and 
you have a terminal window open, then there's a terminal emulator 
with the controlling side of /dev/pts/0 open and that allows your 
"stty </dev/pts/0" command to complete.

Randy Schulz
Mountain View, CA USA


At 21:33 -0600 9/13/99, Lou Langholtz wrote:
>On my 2.2.12 kernel with some hacks I've added I can't use stty to get
>the configuration info for /dev/ttyS0. stty < /dev/ttyS0 (aka
>/dev/modem) just hangs. strace stty < /dev/ttyS0 does the same thing.
>strace doesn't even show me any output. Ctrl-C kills the stty or strace
>but shouldn't stty work on the modem serial device to get the config
>info? Is it just the hacks I've added in my kernel perhaps? stty
>< /dev/pts/0 works just fine. Ideas?
>
>Thanks!!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
