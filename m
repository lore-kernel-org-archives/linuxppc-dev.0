Date: Thu, 22 Mar 2001 20:41:46 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: st corruption
Message-ID: <Pine.LNX.4.05.10103222032400.552-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


(cfr. my posting on linux-kernel)

I'm seeing data corruption when writing to tape. Not when reading, not when
copying between disks.

The corruption affects 32 bytes on a 32-byte boundary. The corrupted data are
always a copy of the data exactly 10240 bytes before. Note that 32 bytes is the
cache line size of a 604e, while 10240 is the default block size for tar.
Perhaps a missing sync before PCI busmastering?

My hardware: CHRP LongTrail, HP C1536 DDS1 tape drive connected to Sym53c875.
The problem happens with 2.4.3-pre4, but also with the good old
2.4.0-test1-ac10. This means all backups I have may be corrupted :-(

Anybody out there with a SCSI tape drive who's willing to do some tests?
Someone already tried with a Pentium, but no corruption, so it may be a PPC
specific problem. Just create some large files, make md5sums, tar them to tape,
untar them from tape, and verify the md5sums. I see approx. 7 blocks of
corrupted data for 256 MB of data.

Many thanks in advance!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
