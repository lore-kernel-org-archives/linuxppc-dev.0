To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: Jan Nieuwenhuizen <janneke@gnu.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-ben0 doesn't see ide1
References: <m3adzddmfh.fsf@appel.lilypond.org>
	<20010930122211.2cf9b2f7.jpgarcia@execpc.com>
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 01 Oct 2001 20:00:51 +0200
In-Reply-To: <20010930122211.2cf9b2f7.jpgarcia@execpc.com> ("Joseph P. Garcia"'s message of "Sun, 30 Sep 2001 12:22:11 -0500")
Message-ID: <m3g093jl4c.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Joseph P. Garcia" <jpgarcia@execpc.com> writes:

> Rack this up as an OF bug on some systems I think.  I got it too
> (Wallstreet2/300).  The OF IDE nodes request what look like twice
> memory as much as they need.  Linux doesn't even use most of it
> anyway.

Ok.  Forgot to mention, I've got a beige G3/233.

> Quick fix? halve all the resource sizes of the ide nodes. (DMA's space also does this).  I don't know what the long term fix would be.

Thanks.  I couldn't find it rightaway, but then changed:

root@appel:/usr/src/linux# diff -pu drivers/ide/ide-pmac.c.orig drivers/ide/ide-pmac.c
--- drivers/ide/ide-pmac.c.orig	Tue Sep 25 18:27:37 2001
+++ drivers/ide/ide-pmac.c	Mon Oct  1 19:15:21 2001
@@ -576,6 +576,7 @@ pmac_ide_probe(void)
 		if (i >= MAX_HWIFS)
 			break;

+		np->addrs[0].size >>= 2;
 		pmac_ide[i].reg_resource = request_OF_resource(np, 0, "  (mac-io IDE IO)");
 		if (!pmac_ide[i].reg_resource) {
 			printk(KERN_ERR "ide-pmac(%s): can't request IO resource !\n", np->name);


And it works, sort of.  There's still an error, but all seems to go well...

pmac_ide: enabling IDE bus ID 0
pmac_ide: enabling IDE bus ID 1
ide-pmac(ide): can't request DMA resource !
hda: QUANTUM FIREBALL SE4.3A, ATA DISK drive
hdc: MATSHITA CR-587, ATAPI CD/DVD-ROM drive
hdd: ST313021A, ATA DISK drive
ide0 at 0xd4089000-0xd4089007,0xd4089160 on irq 13
ide1 at 0xd408d000-0xd408d007,0xd408d160 on irq 14
hda: Enabling MultiWord DMA 2
hda: 8418816 sectors (4310 MB) w/80KiB Cache, CHS=14848/9/63, (U)DMA
hdd: 25434228 sectors (13022 MB) w/512KiB Cache, CHS=25232/16/63
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [mac] p1 p2 p3
 /dev/ide/host1/bus0/target1/lun0: [mac] p1 p2 p3 p4 p5


I also see:

PCI: Cannot allocate resource region 1 of device 00:12.0
  got res[1000:10ff] for resource 1 of ATI Technologies Inc 3D Rage Pro 215GP

Jan.

--
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
