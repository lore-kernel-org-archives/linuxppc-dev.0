In-Reply-To: <Pine.GSO.4.10.9909160957530.21133-100000@ivy.sonytel.be>
Date: Thu, 16 Sep 1999 12:47:15 +0200
To: Geert Uytterhoeven <geert@sonycom.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter
Message-Id: <19990916124715.021257@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 16, 1999, Geert Uytterhoeven <geert@sonycom.com> wrote:

>After compiling a new kernel, I copy it to /boot (using a new name, of
>course),
>update the symlinks and rerun LILO. If I forget (one of) the last two steps,
>nothing bad happens.
>
>IMHO the best thing would be something like MILO on the Alpha. MILO is a
>small binary that contains device drivers and filesystems taken from the
>standard Linux kernel sources. Hence MILO knows about e.g. your ext2fs
>partition and fancy U2W-SCSI adapter. On Alpha the MILO binary is put on a
>MSDOS formatted partition. On PPC, you could store it on either a HFS or
MSDOS
>formatted partition, or use a LILO-alike scheme (raw-blocks). Even BootX
could
>load MILO under MacOS, if you want that.
>
>Combined, you would have a shared `high-level' booter, which is called by
>different `low-level' booters (FS (HFS/MSDOS), raw-blocks, BootX), depending
>on
>your taste and architecture:

I personally tend to think that the small HFS partition is not a so bad
idea. As several person pointed out, the boot block mecanism involves
fitting most of the primary booter in a small space, requires building a
map of the files it must access to, etc...

With a firmware able to load files from a simple file system, eventually
hidden from users, makes things a lot easier, you don't have to rebuild
maps each time you change a file, you can split your booter into several
files if you want to, etc...

For example, under linuxppc, we could mount this bootstrap HFS partition
on /boot, and just copy kernel to this in order to make them available to
the booter.

Of course, all this is specific to PowerMacs, other PPC machine needs a
different boot mecanism anyway.

Back to miBoot, I'll try to get it working first (it seems to work but
the kernel hangs, I don't know why yet and I won't have time to look into
this until this week-end). It doesn't solve all the problems since making
bootable CDs (which is my main goal for now) requires a valid driver on
the CD (only MacOS Toast can do that to my knowledge) and using this
trick to boot from the HD also requires a valid MacOS driver on the disk.

I do have some plans to extend the mecanism further and make a CD driver
to avoid relying on Toast and eventually a hard disk driver too (I do
have a prototype SCSI driver but this requires licenced patches from
Apple to make something really useable).


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
