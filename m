Message-Id: <199909160742.JAA00362@piglet.cpu.lu>
Date: Thu, 16 Sep 1999 09:42:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: New booter (about quik)
To: bierman@apple.com
cc: erbenson@alaska.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v0313030ab405d00a6b8a@[17.202.21.235]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Sep, this message from Peter Bierman echoed through cyberspace:
>>the bootblock method works on most OF machines since there are plenty
>>of people using quik to do it, its the newworld machines that are
>>either different or broken, however they have a flashable ROM so
>>apple can fix this oversight.
> 
> I haven't used quik, but I'm guessing it patches OF so that OF can read a
> booter somewhere? This would be similar to System Disk for OldWorld
> machines, which patches OF, and then points it at a loader partition which
> contains an expanded XCOFF binary (the same binary as the booter, just in a
> format that OldWorld OF can load and execute.)

No, quik is a two-part boot process. quik installs a first-stage boot
loader in the boot block of a disk partition. I admit I am not sure if
this partition needs to be a HFS partition, or if it can be an ext2
partition... (Paul?)

The first-stage then loads the second-stage based on its physical block
assignment on disk, not based on any filesystem code. It's only the
second-stage that includes filesystem code, and which loads the kernel
from the root ext2 partition.

Apart from the HFS partition that might be needed for the bootblock
installation (i.e. it can be a partition as small as your tools allow
you to create it), I think this is a clean boot method... the
second-stage can include any filesystem code you want, and you can
update that part independantly of all the others.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
