Message-ID: <3805BF27.1944652E@fadata.bg>
Date: Thu, 14 Oct 1999 14:31:51 +0300
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Mario Scarpa <m.scarpa@mondonet.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: serial on lombard
References: <199910141119.NAA09122@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> 
> > alarm(0x2, 0x7ffff7b4, 0, 0x8, 0x7f7f7f7f) = 0
> > open("/dev/ttyS0", O_RDWR|O_NONBLOCK)   = 3
> > --- SIGALRM (Alarm clock) ---
> > alarm(0, 0x1, 0, 0x8, 0x7f7f7f7f)       = 0
> > rt_sigaction(0xe, 0x7ffff698, 0x7ffff728, 0x8) = 0
> > write(2, "minicom: cannot open /dev/ttyS0:"..., 59minicom: cannot open /dev/ttyS0: No such file or directory
> > ) = 59
> 
> The port blocks on open, and you get a timeout.

But there is O_NONBLOCK, and according to POSIX, 
" ... if O_NONBLOCK flags is set or if CLOCAL has been set,
  the open() function shall return immediately without
  waiting for the connection."

Note that this is the/a way to set CLOCAL -- open the device with O_NONBLOCK
and then tcsetattr() or whatever.

> 
> The serial port won't open without carrier detected. minicom fails to set
> the port characteristics properly (or the Mac serial driver doesn't honor
> minicom's port settings), and gives a very confusing error message (open
> /dev/ttyS0 timed out would have been more accurate).
> 
> Set ttyS0 to ignore DCD with stty clocal </dev/ttyS0, perhaps.

This should help, but the problem is in the driver.

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
