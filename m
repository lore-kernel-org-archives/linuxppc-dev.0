To: linuxppc-dev@lists.linuxppc.org
Subject: fs corruption with 2.4.0-test11
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 03 Mar 2001 13:13:01 +0100
Message-ID: <m3zof3125u.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

This is a quite vague report, but I want to mention it anyway.  I've
been running

    2.4.0-test11 #1 Mon Nov 20

since Nov 20, without problems, in fact I haven't had any strange
problems with this 2.5 y old beige G3 (apart from the fact that
beige G3's can't write the swim3 floppy).

This kernel was the last that compiled and booted, 2.4.0 (or maybe
one of the 2.4.0 rsync trees) compiled but didn't boot.

Vanilla 2.4.2 didn't compile, but luckily, Paul's rsync tree did today:

    Linux appel.lilypond.org 2.4.2 #1 Sat Mar 3 11:55:48 CET 2001 ppc unknown

so, I'm trying that one now.

I used Franz Sirl's gcc snapshot (recompiled for debian)

    ftp://dev.linuxppc.org/users/fsirl/R5/SRPMS/gcc-2.95.3-2f.src.rpm

the least buggy available at that time.


Jan.


root@appel:/# mount -oremount,ro /
root@appel:/# e2fsck /dev/hda2
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/hda2: clean, 98122/494016 files, 535898/986616 blocks
root@appel:/# e2fsck -y -f /dev/hda2
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Inode 462242 is in use, but has dtime set.  Fix? yes

Inode 462242 has imagic flag set.  Clear? yes

Inode 462241 has illegal block(s).  Clear? yes

Illegal block #-1 (544366925) in inode 462241.  CLEARED.
Illegal block #-2 (824193568) in inode 462241.  CLEARED.
Illegal block #-3 (842086968) in inode 462241.  CLEARED.
Inode 462241, i_size is 7307970468567320294, should be 4096.  Fix? yes

Pass 2: Checking directory structure
i_faddr for inode 462241 (/usr/include/SDL/SDL_byteorder.h) is 1818586738, should be zero.
Clear? yes

i_frag for inode 462241 (/usr/include/SDL/SDL_byteorder.h) is 58, should be zero
d be zero.
Clear? yes

i_frag for inode 462241 (/usr/include/SDL/SDL_byteorder.h) is 58, should be zero.
Clear? yes

i_fsize for inode 462241 (/usr/include/SDL/SDL_byteorder.h) is 32, should be zero.
Clear? yes

i_file_acl for inode 462241 (/usr/include/SDL/SDL_byteorder.h) is 1701867617, should be zero.
Clear? yes

Inode 462242 (/usr/include/SDL/SDL_cdrom.h) is an illegal block device.


root@appel:/# mount -oremount,ro /


--
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
