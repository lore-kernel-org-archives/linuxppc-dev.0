Date: Mon, 28 Jun 2004 16:31:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.5 bk tree on 8xx board ... so close
Message-ID: <20040628233119.GE28128@smtp.west.cox.net>
References: <Pine.LNX.4.60.0406281743170.4213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0406281743170.4213@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 28, 2004 at 05:48:07PM -0400, Robert P. J. Day wrote:

>   after messing with the kernel config of the latest "bk pull", and
> building a new kernel and ramdisk, i got:
>
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Mounted devfs on /dev
> Freeing unused kernel memory: 60k init
> Configuring localhost networking ...
> SIOCSIFADDR: No such device   (ignore, i tried to configure eth0)
> Mounting /proc filesystem ...
> Mounting /tmp filesystem ...
> There are no /dev/mtdblock devices here, aborting.  (no, not really)
> Clearing /var/log/msgs and starting syslogd ...
> I found portmap, so I'll start it now ...
> I found telnetd, so I'll start it now ...
> Bailing for testing purposes.
>
>
> BusyBox v1.00-pre10 (2004.06.24-
>
> ... and hang.
>
> so, from the above, i got
>
> 1) localhost networking configured
> 2) /proc mounted
> 3) /tmp (tmpfs) mounted
> 4) syslog, portmap and telnet starting
> 5) an exit from the startup script since i wanted to keep things
>    simple
>
> at that point, /etc/inittab has the line:
>
> ::respawn:-/bin/sh
>
> /bin/sh being, of course, a link to busybox.  i'm not sure what to
> make of the partial output, perhaps some problem with the serial or
> console port that the shell is trying to use.  so i guess it's on to
> poking around the console port, see if that's the issue.
>
> getting so close ...

Which serial driver did you use?  For me 8xx_UART does not work, but
CPM_UART will (it's still not quite correct, I have to config in both
SMC1 and SCC1 to get SMC1 to work, but I'm burried under a bunch of
other stuff right now).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
