From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910141119.NAA09122@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
In-Reply-To: <38062B18.A959825E@mondonet.net> from Mario Scarpa at "Oct 14, 1999 12:12:24 pm"
To: m.scarpa@mondonet.net (Mario Scarpa)
Date: Thu, 14 Oct 1999 13:19:17 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> alarm(0x2, 0x7ffff7b4, 0, 0x8, 0x7f7f7f7f) = 0
> open("/dev/ttyS0", O_RDWR|O_NONBLOCK)   = 3
> --- SIGALRM (Alarm clock) ---
> alarm(0, 0x1, 0, 0x8, 0x7f7f7f7f)       = 0
> rt_sigaction(0xe, 0x7ffff698, 0x7ffff728, 0x8) = 0
> write(2, "minicom: cannot open /dev/ttyS0:"..., 59minicom: cannot open /dev/ttyS0: No such file or directory
> ) = 59

The port blocks on open, and you get a timeout. 

The serial port won't open without carrier detected. minicom fails to set
the port characteristics properly (or the Mac serial driver doesn't honor
minicom's port settings), and gives a very confusing error message (open
/dev/ttyS0 timed out would have been more accurate). 

Set ttyS0 to ignore DCD with stty clocal </dev/ttyS0, perhaps.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
