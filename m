Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 23D9068335
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 03:26:19 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Sep 2005 19:26:12 +0200
References: <20050919153747.78ACC352682@atlas.denx.de>
In-Reply-To: <20050919153747.78ACC352682@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509191926.12736.david.jander@protonic.nl>
Subject: Re: Which way to store log in flash on mpc8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi again,

Thanks for helping,

On Monday 19 September 2005 17:37, Wolfgang Denk wrote:
>[...]
> Can you provide a little more details? The MTD / JFFS2 code  in  this
> kernel  is  not too old, andwe use it in a couple of projects without
> such problems.

Ok, good you asked, because I am willing to debug the problem until I get to 
the point where it fails, but I will need help, because I am not at home in 
jffs2 source-code nor its CVS history.

Here are more details:

Kernel: Denx CVS from around july 2005 or something. AFAIK there are no 
further modifications other than BSP-specific stuff to the MTD code since 
that day, so I won't bother upgrading any further right now.

Hardware: MPC852T custom board with a 32Mbyte mirror-bit flash-chip (x16 bus)

Software: System based on ELDK-3.1.1. Intended flash-layout and use:
  rootfs     : 10Mb, ro, hardly ever changed
  app        : 6Mb, ro, changed on software-upgrade by replacing partition.
  log+config : 12Mb, rw

The log+config partition is extremely oversized, because we are aware of the 
inefficiency of jffs2 for such purposes, we have the available space and we 
want to stay out of trouble. Syslog writes to 4 log-files which are limited 
in size to 50..100kbyte each. Logs are then rotated and one rotated copy is 
kept. Maximum flash use is around 800kbyte for logs + 50kbyte for config 
data. On a 12Mbyte partition, that shouldn't get us into trouble AFAIK.

> > waiting for GC. I have debugged that problem a little bit, and
> > definitely, the FLASH access works ok, and the chip is new. No CRC- or
> > read-errors, but still gc.c crashes.
>
> Can you provide soem more information for debugging?

Unfortunately right now I don't have debug messages, because since I installed 
a kernel with debugging turned on in the jffs2 driver, the problem hasn't 
repeated. I am working on that.

What happened: System boots, all fs are mounted. The first app that writes 
something to the log-partition (in this case a config file that is 
overwritten) causes the GC thread for that partition to crash with a BUG() in 
line 139 of gc.c, and the application freezes forever. Since GC is dead, all 
further write-accesses to that partition also hang forever.

The problem seems to ocurr after a few times power-cycling the board. We never 
intended it to shut-down nicely, if it is at all ever shut-down, so it must 
be able to survive quite a few power-cycles without breaking.

After a few more power-cycles, the problem is gone again. Each time GC kicks 
in, it does something, but it crashes before finishing the job, so each time 
the numbers reported by the printk() in line 138 change, and eventually it 
work again.

My big question: Is it at all possible that gc.c comes to that BUG() in line 
139 because of anything other than a bug in jffs2-code?
I mean, if hardware really was a problem, then I should also get at least 
CRC-errors from jffs2, shouldn't I? IMHO at least, jffs2 should be robust 
enough to not crash on flash-errors, shouldn't it?

Also, I am pretty certain that the hardware is good.... but you never know...

> > The version of mtd/jffs2 drivers in that kernel seem to be from
> > march/2005 cvs code, but when I read the following, I get even more
> > scared:
> > http://www.linux-mtd.infradead.org/source.html#kernelversions
>
> Don't worry. We backported the MTD / JFFS2 code. See the  history  of
> changes on our CVS or git server.

I am having trouble finding the right history, but that could be due to the 
fact that I am not very good at CVS (we use subversion which is slightly 
different) ;-)
The logs of almost all files in fs/jffs2/ which I have say that the actual 
version corresponds to the CVS-snapshot of March 13, 2005, and that the 
previous version of April 2004 is broken.
Which files were modified _after_ March 13, 2005? 
(A hint to what command options or tools to use to browse cvs-logs more easily 
at this point is appreciated... I am using cervisia).

> > This must be a very common task (to store logfiles in flash), but I just
> > can't seem to find the right way to do it.
>
> Note that log files may cause a lot of trouble  when  using  a  JFFS2
> file  system. Youmay want to addd a buffering layer, like pramfs in a
> dedicated RAM area (SRAM ideally).

I know about the problems jffs2 has with logfiles and alikes. I am still 
thinking about what would be the most robust way of coping with this, and 
until now, oversized partitions with log-rotation on size seems to do the 
trick. I don't want to loose log-data on power-loss so I don't feel so 
comfortable with buffering much of it in RAM.

Best Regards,

-- 
David Jander
Protonic Holland.
