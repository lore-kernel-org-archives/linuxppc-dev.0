Message-Id: <v04003a01b6115952b7fe@[24.70.162.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 16 Oct 2000 20:57:51 -0500
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: linux-pmac-stable SMP issues
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just picked up a 9600/200mp, and the first thing I did with it (well,
maybe the second or third thing) was install Debian to play with linux SMP
stuff (and later play with some IDE PCI cards).

Debian apparently ships with a UP kernel, so I rsynced with
linux-pmac-stable and compiled an SMP kernel.

The first thing I noticed is that some EXPORT_SYMBOLs are missing, namely:
global_irq_holder, global_irq_lock, global_irq_count, global_bh_count,
global_bh_lock, kernel_flag and synchronize_bh. These missing symbols
prevent modules like lockd and appletalk from loading. Adding these in
makes everything happy-happy.

The second thing I noticed is that "Processor 1 is stuck.". I seem to
recall this issue has been brought up once or twice before, but a look
through the mailing list archives didn't reveal any clues.

I vaguely recall the issue might be related to the booter used, I'm using
BootX 1.2.2 (from MacOS 9.0.4). Is there a different booter I should be
using to acheive full SMP functionality - hopefully one that allows easy
dual-booting?

merida:~$ uname -a
Linux merida 2.2.17 #1 SMP Sat Oct 14 14:34:02 CDT 2000 ppc unknown
merida:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.2/specs
gcc version 2.95.2 20000220 (Debian GNU/Linux)


Other than that, things work rather well, though 5 MB/s powermac scsi is
anything but spectacular (10MB/s made lots of stuff segfault) - leaves the
system feeling a tad sluggish compared to, say, my SGI Indigo2, but I
suppose that's not really a fair comparison to begin with. :)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
