Message-ID: <39744BAA.6E5984DA@wanadoo.fr>
Date: Tue, 18 Jul 2000 14:20:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: strace doesn't work on 2.4.0-testX
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

now that the 2.4.0-testX kernel series seems to stabilize (famous last
words...), I am trying to understand some of the basic showstoppers. One
of them is the impossibility to use the loop device for mounting files
as filesystems, for example ramdisk images.

I would like to know whether this is a problem with mount (since one
cannot mount hfs CDs either) or with the loop device which used to be
broken for a long time. In order to see anything, I am trying to use
strace.

The problem is that strace stopped working somewhere between
2.4.0-test1-ac18 and -ac21 (I have both kernels and verified just
moments ago). It still doesn't work with 2.4.0-test5-pre2. Is this a
known problem or am I doing something wrong? I haven't seen anything on
the linux-kernel list (in the l-k archives, the last message with a
similar subject is from 1996), so it could be a ppc-related problem.

What strace is doing now looks like:

[root@chezmoi /tmp]# strace mount -o loop ramdisk.image
/mnt/ram1
execve("/bin/mount", ["mount", "-o", "loop", "ramdisk.image",
"/mnt/ram1"], [/* 29 vars */]) = 0
memlock: Invalid argument
Couldn't lock into memory, exiting.

That is, it just repeats the command and gives the output. In pre-ac18,
there were 48 lines, looking like

execve("/bin/mount", ["mount", "-o", "loop", "ramdisk.image",
"/mnt/ram1"], [/*
25 vars */]) = 0
brk(0)                                  = 0x10022470
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
[and so on, up to:]
write(2, "memlock: Invalid argument\n", 26memlock: Invalid argument
) = 26
write(2, "Couldn\'t lock into memory, exiti"..., 36Couldn't lock into
memory, ex
iting.
) = 36
exit(1)                                 = ?

Any ideas?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
