Message-ID: <20030805131112.59750.qmail@web8007.mail.in.yahoo.com>
Date: Tue, 5 Aug 2003 06:11:12 -0700 (PDT)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Static linking /Shared Library  Application Errors.
To: linuxppc-embedded@lists.linuxppc.org
Cc: wd@denx.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello ,
I am trying to execute certain fileutils application
like cp ,ls ..
These applications are compiled using the Glibc 2.2.3

The problem is if i compile the applications
Statically
and try to execute the command cp,ls ..i get the
segmentation fault error.Please let me know the proper
compiler options  for static linking.

the make file i have used is as follows

-----------------------------------------------------
CC=powerpc-linux-gcc
CFLAGS=-msoft-float -D_SOFT_FLOAT -mcpu=860
LDLIBS=
LDFLAGS+=--static

EXECS = cat chgrp chmod chown cmp cp dd grep l ln ls
mkdir mkfifo mknod \
        more mv rm rmdir sync touch vi
OBJS = cat.o chgrp.o chmod.o chown.o cmp.o cp.o dd.o
grep.o l.o ln.o ls.o \
        mkdir.o mkfifo.o mknod.o more.o mv.o rm.o
rmdir.o sync.o touch.o vi.o

all: $(EXECS)

$(EXECS): $(OBJS)
        $(CC) $(LDFLAGS) -o $@ $@.o $(LDLIBS)



----------------------------------------------------

Then i tried to eliminate the problem by using shared
library that is put the ld.so.1 file and libc.so.6
file in the /lib directory of the ramdisk .
The problem is the library files are too big in size.
libc is 5.1mb and ld.so.1 is .5mb

inorder to create a ramdisk image i have used the
initrd.sudo scrip file form the denx SELF package.
: ${IRD_SIZE:=4096k}

dd if=/dev/zero of=$IMAGE bs=$IRD_SIZE count=1
2>/dev/null

If the IRD_SIZE is 4096 then the ramdisk image does
not get created since the library file is too big so i
changed it too 8192k then a proper ramdisk image is
created.
but then when i create the kernel Multi image and
download it i get the following error .
------------------------------------------------------
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
RAMDISK: Compressed image found at block 0
Kernel panic: Out of memory and no killable
processes...

Rebooting in 180 seconds..
------------------------------------------------------
I have tried to increse the ramdisk size by setting
default ramdisk size to 8192 in the kernel menu config
option ..but still same error.

So please tell me which is the best method ..and also
the remedies for the above problem.
1.should i use statick linking
2.shared library ..

Thanking you

Regards,
Rekha.c


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
