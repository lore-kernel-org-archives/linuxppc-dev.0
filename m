Message-ID: <38584BA3.5AA60056@ctam.com.au>
Date: Thu, 16 Dec 1999 13:17:08 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com> <38583159.AF0E44C9@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I forgot to include the nfsd debug output.  It's at the end of this message.  It's
quite long but I can see that it is reading the /dev/console, /bin/sh,
/lib/termcap, /lib/libc, etc.  It resolves symbolic links fine.  So why does it
stop.  Has everything be read ?  Is it a console I/O problem ?  Has network traffic
just stopped ?  Has the CPU crashed ?

Hope someone can give me a few pointers.

Brendan.


Brendan Simon wrote:

> Jim Chapman wrote:
>
> > Also, try running your NFS server in the foreground in a debug mode if
> > it isn't being used by other hosts. This will display exactly what files
> > are being accessed. You should see lots of directories, shared libraries
> > etc being read. I use
> >
> > # rpc.nfsd -F -d call
>
> I did this.  It seems that /bin/sh is found and that the file /lib/ld.so.1 is
> being read, but it just stops.  I don't know if the 860 has crashed or what ?  I
> will try running a program via an nfs mount from another linux box and see what
> the nfsd debug output should look like.  Other than that I'm lost.  Any ideas
> how I can test the reliability of the ethernet driver on the 860 system ?
>
> Is it possible to use kgdb in anyway.  I have never used kgdb before so I'm not
> sure what it can do for me.

nfsd[10594] 12/16/99 13:02 getattr [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      50808950 02 d21e
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min n:dev
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/dev
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/dev n:console
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/dev/console
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 readlink [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/dev/console
nfsd[10594] 12/16/99 13:02  ttyS0
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/dev n:ttyS0
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/dev/ttyS0
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min n:sbin
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/sbin
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/sbin n:init
nfsd[10594] 12/16/99 13:02 result: 2
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min n:etc
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/etc
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/etc n:init
nfsd[10594] 12/16/99 13:02 result: 2
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min n:bin
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/bin
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:02 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/bin n:init
nfsd[10594] 12/16/99 13:02 result: 2
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/bin n:sh
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/bin/sh
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/bin/sh: 4096 bytes at 0
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min n:lib
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/lib
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/lib n:ld.so.1
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/lib/ld.so.1
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 0
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 32768

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 36864

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 40960

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 45056

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 49152

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 53248

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 57344

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 61440

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/bin/sh: 4096 bytes at 360448
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/bin/sh: 4096 bytes at 364544
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/bin/sh: 4096 bytes at 368640
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/bin/sh: 4096 bytes at 372736
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 4096
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 8192
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 12288

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 16384

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 20480

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 24576

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/ld.so.1: 4096 bytes at 28672

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/etc n:ld.so.preload
nfsd[10594] 12/16/99 13:02 result: 2
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/etc n:ld.so.cache
nfsd[10594] 12/16/99 13:02 result: 2
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/lib n:libtermcap.so.2
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/lib/libtermcap.so.2
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 readlink [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2
nfsd[10594] 12/16/99 13:02  libtermcap.so.2.0.8
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/lib n:libtermcap.so.2.0.8
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/lib/libtermcap.so.2.0.8

nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 0
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 4096
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 8192
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 12288
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 16384
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 20480
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 24576
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libtermcap.so.2.0.8: 4096
bytes at 28672
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/lib n:libc.so.6
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/lib/libc.so.6
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 readlink [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc.so.6
nfsd[10594] 12/16/99 13:02  libc-1.99.so
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 lookup [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      fh:/sys/ctam-root-min/lib n:libc-1.99.so
nfsd[10594] 12/16/99 13:02      new_fh = /sys/ctam-root-min/lib/libc-1.99.so
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
0
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
4096
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
8192
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
12288
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:03 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
16384
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
20480
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
24576
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
28672
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
655360
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
659456
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
663552
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
667648
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
671744
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
675840
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
679936
nfsd[10594] 12/16/99 13:02 result: 0
nfsd[10594] 12/16/99 13:02 read [1 70/1/1 10:00:04 203.21.127.150 0.0]
nfsd[10594] 12/16/99 13:02      /sys/ctam-root-min/lib/libc-1.99.so: 4096 bytes at
684032
nfsd[10594] 12/16/99 13:02 result: 0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
