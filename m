Date: Fri, 17 Sep 1999 10:32:30 +1000
Message-Id: <199909170032.KAA13065@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199909160742.JAA00362@piglet.cpu.lu> (message from Michel
	Lanners on Thu, 16 Sep 1999 09:42:09 +0200 (CEST))
Subject: Re: New booter (about quik)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199909160742.JAA00362@piglet.cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners <mlan@cpu.lu> wrote:

> No, quik is a two-part boot process. quik installs a first-stage boot
> loader in the boot block of a disk partition. I admit I am not sure if
> this partition needs to be a HFS partition, or if it can be an ext2
> partition... (Paul?)

No, it needs to be an ext2 partition.  AFAIK the first 1k of an HFS
partition isn't free.

The way that the older OF boots from a hard disk partition is that it
uses a couple of fields in the partition table entry which give the
location of the bootstrap in terms of the start and length of a
contiguous set of blocks in the partition.  OF just loads those blocks
into memory and jumps to them.  The quik installer program sets those
fields to point to the first 2 blocks of the partition.

So in principle it would be possible to put the quik first-stage
bootstrap on an HFS partition.  You would just have it as a contiguous
HFS file somewhere and set the partition table entry to point to it.

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
