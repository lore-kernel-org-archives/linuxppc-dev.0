Date: Thu, 9 Dec 1999 17:25:29 +0100
From: Damien MERCIER <mercier@etca.fr>
Message-Id: <199912091625.RAA26156@natuna.etca.fr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems with ext2 ramdisk
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am a complete newbie concerning Linux/PPC (I know Linux/x86 far better), and
I am in the process of making a good starting point for future developement on
an ipEngine. I have one big problem concerning the ramdisk. The card boots from
flash with a 6M initial ramdisk (mounted RW) with ext2 filesystem correctly.
However, after a few modifications on the ramdisk, the free inodes and free
blocks seems completely stupid, and I can no more write to the ramdisk.
The free blocks and inodes list seems correct (at least reported by dumpe2fs).

Perhaps it's a common problem, but nobody seems to mention it on the list. A
transcript of a session follows. Don't flame me, I know that e2fsck and
dumpe2fs on a mounted filesystem are kind of heretic...

BTW, the same exemple works ok on an x86 ! I made also some other tests on
the ipEngine with kernel 2.2.13 (with and without bse's patches) and with
the prebuilt 2.2.0-preX that comes with the card with the same results. I
have looked on the kernel sources with no luck till now.

 Please help !

PS: I tested with minix filesystem, but was unable to make the ramdisk boot,
till I realized that minix was not endian independant... Sigh, my host is an
x86.


Just after boot...
*********************

# df /tmp
Filesystem         1024-blocks  Used Available Capacity Mounted on
/dev/ram                5755    4541     1153     80%   /

# dumpe2fs /dev/ram
...
Group 0: (Blocks 1 -- 6143)
  Block bitmap at 3 (+2), Inode bitmap at 4 (+3)
  Inode table at 5 (+4)
  1214 free blocks, 2280 free inodes, 32 directories
  Free blocks: 4853, 4894, 4925-4926, 4934-6143
  Free inodes: 158, 793, 795-3072

# dd if=/dev/zero of=/tmp/tempo bs=1024 count=1024
1024+0 records in
1024+0 records out

# dumpe2fs /dev/ram
...
Group 0: (Blocks 1 -- 6143)
  Block bitmap at 3 (+2), Inode bitmap at 4 (+3)
  Inode table at 5 (+4)
  2 free blocks, 65535 free inodes, 32 directories
  Free blocks: 4853, 4894, 4925-4926, 5963-6143
  Free inodes: 793, 795-3072

# df /tmp
Filesystem         1024-blocks  Used Available Capacity Mounted on
/dev/ram                5755    5570      124     98%   /

# \rm -f /tmp/tempo

# df /tmp
Filesystem         1024-blocks  Used Available Capacity Mounted on
/dev/ram                5755    4541     1153     80%   /

# dd if=/dev/zero of=/tmp/tempo bs=1024 count=1024
dd: /tmp/tempo: No space left on device

# ll /tmp/tempo
ls: /tmp/tempo: No such file or directory

# df /tmp
Filesystem         1024-blocks  Used Available Capacity Mounted on
/dev/ram                5755    4541     1153     80%   /

# touch /tmp/test
touch: /tmp/test: No space left on device

# dumpe2fs /dev/ram
...
Group 0: (Blocks 1 -- 6143)
  Block bitmap at 3 (+2), Inode bitmap at 4 (+3)
  Inode table at 5 (+4)
  1031 free blocks, 0 free inodes, 32 directories
  Free blocks: 4853, 4894, 4925-4926, 4934-6143
  Free inodes: 158, 793, 795-3072

# mount -o remount,ro /

# e2fsck -f /dev/ram

# mount -o remount,rw /

# dumpe2fs /dev/ram
...
Group 0: (Blocks 1 -- 6143)
  Block bitmap at 3 (+2), Inode bitmap at 4 (+3)
  Inode table at 5 (+4)
  7 free blocks, 1 free inodes, 32 directories
  Free blocks: 4853, 4894, 4925-4927, 4935-6143
  Free inodes: 158, 794-3072

/-------------------------------------------------------------
| Damien MERCIER                      
| DGA / DCE / CTA / GIP               | email: mercier@etca.fr
| 16bis Avenue Prieur de la Cote d'Or | Phone: +33 1 42319957
| 94114 Arcueil Cedex       FRANCE    |   FAX: +33 1 42319964
|    http://www.etca.fr/CTA/gip/Projets/Retine/Index.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
