Message-Id: <199905241534.KAA24850@lists.linuxppc.org>
Date: Mon, 24 May 1999 17:14:49 +0200 (CEST)
From: laures@esiea.fr
Subject: Initio miles tests :-(
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK so far it's not really good...

Let's begin by what's working...

mke2fs /dev/disk-on-miles is ok
fsck too

mount -t hfs
mount -t ext2 as well

cp a 2M file (kernel) ok, not corrupted when cp back to mesh (gzip'ed
and de-gzip'ed succesfully)

umount ok after cping this small file.


Now what doesn't work...

pdisk /dev/disk-on-miles destroy the partition map if re-written, even
just renaming a partition

mke2fs -c gives a kernel panic ("kernel stack overflow")

cp /usr/src/linux/* /mnt/disk-on miles/ goes ok few... and then I got
this kind of lines (several times):
scsi: aborting command due to timeout: pid 20175, scsi1, channel 0,
id5, lun0, Write (6) 04 9C 45 80 00
SCSI bus is being reset for host 1 channel 0
the kernel "panics" soon after

I got his behaviour also when cping 10 megs of files (/boot/*) and
issuing umount when done.

Finally hdparm -Tt gives a kernel panic, or smth just under

Each time the ext2 partition is completely screwed, I must reformat to
continue tests, the hfs is screwed once over 2.
I think I will go on with a ramdisk !

So I guess the patch wasn't enough...

Any way of investigation someone ?


-- 
Guillaume Laurès - student @ ESIEA (www.esiea.fr)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
