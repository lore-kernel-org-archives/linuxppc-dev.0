Date: Wed, 5 Jul 2000 23:47:32 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE quirk
Message-ID: <Pine.LNX.4.21.0007052235430.3700-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been tinkering with the IDE drive on my MBX board.
The path to the drive goes,

MPC821 <----> QSpan PCI Bridge <----> WinBond W83C553F <===> Drive

I have things semi-working, but there is a problem with writing
to the drive.  If I do a raw dump into /dev/hda, say using the
2.2.13 kernel "README" file,

  # dd if=README of=/dev/hda

(that file is about 26 blocks long (13k)) it *appears* to write fine,
but there is a problem.  If I read back 2MB of data, I will see what
I wrote,

# dd if=/dev/hda of=RES01 bs=1k count=2000

(examine on host NFS system)
00000000: 094c 696e 7578 206b 6572 6e65 6c20 7265  .Linux kernel re
00000010: 6c65 6173 6520 322e 322e 7878 0a0a 5468  lease 2.2.xx..Th
00000020: 6573 6520 6172 6520 7468 6520 7265 6c65  ese are the rele
...

but if I repeat the read, I see the following,

# dd if=/dev/hda of=RES02 bs=1k count=2000

00000000: 094c 0000 7578 0000 6572 0000 6c20 0000  .L..ux..er..l ..
00000010: 6c65 0000 6520 0000 322e 0000 0a0a 0000  le..e ..2.......
00000020: 6573 0000 6172 0000 7468 0000 7265 0000  es..ar..th..re..

Every other halfword does not "stick" on the drive.  I confirmed this
by reading the data back with EPPCBug's "iop" command.  I believe that in
the first case above, the data was being read out of the drive cache
and/or Linux buffer cache so it looked fine, but after reading back 2MB
the drive cache (/Linux buffer cache) gets flushed so the real data is
being pulled in.  The drive cache is only 58KB.

Reading/writing sectors with "iop" works fine on this system under
EPPCBug (data sticks between cold boots), so I believe that the data
path is Ok.

So I'm trying to figure out what is preventing the data from "commiting"
to the hard drive under Linux.  I went as far as printk'ing the
bytes and register contents in

  arch/ppc/kernel/m8xx_setup.c:m8xx_ide_outsw()

and everything looks fine just before it hits the disk with ide_outsw().

I'll keep digging, but if anyone knows any magic to get this to behave
properly, please share.  I'm going to look at PIO mode settings next...

Info:
  MontaVista 2.2.13 kernel with hacks to bring IDE alive.
  MontaVista CDK target image NFS root directory, /dev/hda* entries
    created manually.
  gcc version 2.95.2 19991024 (release), built from raw sources.

I can post test programs/debug output if that would help.  There
is just so much I figured I'd wait for some intial feedback before
posting any of it.

Thanks,
-Jamie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
