Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <waite@skycomputers.com>
To: Roland Dreier <roland@topspin.com>
Subject: Re: NFS root woes: No init found
Date: Wed, 4 Dec 2002 17:36:16 -0500
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200212041635.31861.waite@skycomputers.com> <52bs41besd.fsf@topspin.com>
In-Reply-To: <52bs41besd.fsf@topspin.com>
MIME-Version: 1.0
Message-Id: <200212041736.16628.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried that but things look pretty happy. Here is the output I get with
tcpdump -vvv -s 1500 host seblade2

I know this NFS root is set up because other PPC boxes use it for NFS root. I
am pretty stumped.

17:32:19.528377 seblade2.800 > dayton.sunrpc:  [udp sum ok] udp 56 (DF) (ttl
64, id 0, len 84)
17:32:19.528732 dayton.sunrpc > seblade2.800:  [udp sum ok] udp 28 (DF) (ttl
64, id 0, len 56)
17:32:19.559211 seblade2.800 > dayton.sunrpc:  [udp sum ok] udp 56 (DF) (ttl
64, id 0, len 84)
17:32:19.559469 dayton.sunrpc > seblade2.800:  [udp sum ok] udp 28 (DF) (ttl
64, id 0, len 56)
17:32:19.579903 seblade2.800 > dayton.32771:  [udp sum ok] udp 56 (DF) (ttl
64, id 0, len 84)
17:32:19.585120 dayton.32771 > seblade2.800:  [udp sum ok] udp 60 (DF) (ttl
64, id 0, len 88)
17:32:19.585790 seblade2.159747 > dayton.nfs: 100 getattr fh Unknown/1 (DF)
(ttl 64, id 0, len 128)
17:32:19.585865 dayton.nfs > seblade2.159747: reply ok 96 getattr DIR 40755
ids 0/0 sz 4096  (DF) (ttl 64, id 0, len 124)
17:32:19.586681 seblade2.159748 > dayton.nfs: 100 fsstat fh Unknown/1 (DF)
(ttl 64, id 0, len 128)
17:32:19.586781 dayton.nfs > seblade2.159748: reply ok 48 fsstat [|nfs] (DF)
(ttl 64, id 0, len 76)
17:32:19.615317 seblade2.159749 > dayton.nfs: 108 lookup fh Unknown/1 "dev"
(DF) (ttl 64, id 0, len 136)
17:32:19.615396 dayton.nfs > seblade2.159749: reply ok 128 lookup fh Unknown/1
DIR 40755 ids 0/0 sz 77824 nlink 17 rdev ffffffff fsid 306 nodeid 246c8
a/m/ctime 1039040869.000000 1039039592.000000 1039039592.000000  (DF) (ttl
64, id 0, len 156)
17:32:19.616315 seblade2.159750 > dayton.nfs: 112 lookup fh Unknown/1
"console" (DF) (ttl 64, id 0, len 140)
17:32:19.616353 dayton.nfs > seblade2.159750: reply ok 128 lookup fh Unknown/1
CHR 20600 ids 504/0 sz 0 nlink 1 rdev 501 fsid 306 nodeid 247e4 a/m/ctime
1015747714.000000 1027439792.000000 1039029441.000000  (DF) (ttl 64, id 0,
len 156)
17:32:19.628334 seblade2.159751 > dayton.nfs: 108 lookup fh Unknown/1 "bin"
(DF) (ttl 64, id 0, len 136)
17:32:19.628400 dayton.nfs > seblade2.159751: reply ok 128 lookup fh Unknown/1
DIR 40755 ids 0/0 sz 4096 nlink 2 rdev ffffffff fsid 306 nodeid 1d38b9
a/m/ctime 1039040880.000000 1026358299.000000 1030454764.000000  (DF) (ttl
64, id 0, len 156)
17:32:19.629347 seblade2.159752 > dayton.nfs: 116 lookup fh Unknown/1
"ash.static" (DF) (ttl 64, id 0, len 144)
17:32:19.629382 dayton.nfs > seblade2.159752: reply ok 128 lookup fh Unknown/1
REG 100755 ids 0/0 sz 522456 nlink 1 rdev ffffffff fsid 306 nodeid 1d38f8
a/m/ctime 1039040880.000000 1015669398.000000 1030454763.000000  (DF) (ttl
64, id 0, len 156)
17:32:19.640029 seblade2.159753 > dayton.nfs: 112 read fh Unknown/1 4096 bytes
@ 0 (DF) (ttl 64, id 0, len 140)
17:32:19.640181 dayton > seblade2: (frag 51580:1244@2960) (ttl 64, len 1264)
17:32:19.640192 dayton > seblade2: (frag 51580:1480@1480+) (ttl 64, len 1500)
17:32:19.640201 dayton.nfs > seblade2.159753: reply ok 1472 read REG 100755
ids 0/0 sz 522456 nlink 1 rdev ffffffff fsid 306 nodeid 1d38f8 a/m/ctime
1039041139.000000 1015669398.000000 1030454763.000000  (frag 51580:1480@0+)
(ttl 64, len 1500)




Thanks
Brian

> One thing that sometimes helps in debugging these problems is to use
> an ethernet sniffer to see what your target is really getting from the
> NFS server.  You can use something like "tcpdump -vvv -s 1500", or
> something fancier like ethereal.  Then you can see whether the target
> ever even tries to read the init file, etc.
>
> Best,
>   Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
