Message-ID: <396684D7.92D4B672@ne.mediaone.net>
Date: Fri, 07 Jul 2000 21:33:11 -0400
From: mark phillips <msss@ne.mediaone.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: ppc NFS Server issues
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm having a problem trying to nfs mount directories on my target
system from my host. (i.e. target running nfs server)

I'm running an embedded planet mpc860T board. (Hard-Hat linux,
journeyman cdk v1.1).  I boot up with an
initrd filesystem which I put together myself.  In a nutshell,
I can mount the target volume on my host, but then attempting to
ls it, I get messages like: (/e is my mount point)

ls: /e/bin: No such file or directory
ls: /e/var: No such file or directory
ls: /e/proc: No such file or directory


I had to build some stuff from the RedHat 6.2 SRPMS:


nfs-utils-0.1.6.tar.gz
portmap-4_0-19_src.rpm
tcp_wrappers-7_6-10_src.rpm (portmap needed libs from these)


I managed to cross-compile portmap, nfsd, mountd, and exportfs
from these with very minor hacks.  (In particular, nfsd, mountd, and
exportfs
only needed me to remove the tools dependency (which built a ppc version

of rpcgen and then tried to run it on my pentium)
portmap printed out a lot of dangerous-looking warnings (like illegal
pointer-type kind of messages) but did compile.

All these programs run without complaining on my ppc target.

2 Questions:

   a) Am I going in the right direction? I compiled my kernel with nfs
server support, etc.  Do I need portmap, mountd, and nfsd? Or is there
a way to replace some of these with built-in kernel support?  Do I
need some of the other programs (like lockd?)

   b) Anyone have an idea what's going on here? Am I totally stupid
to cross-compile RedHat 6.2 SRPMS and expect them to work? Do I need to
comb through all the warnings and decide whether they're benign?

The remainder of this is information gathered to diagnose the problem.

Thanks,

Mark Phillips

(A few curious things...
Note that the uid for portmap is 1, while everyone else's is root?
Why do some ps entries get bracketed while others do not?  (This is the
busybox ps)
Why doesn't rcpinfo show the names (like portmap, mountd, nfsd?)

********** Output of several commands on the TARGET (ppc)

ls -l
dr-xr-xr-x   16 root     root           0 Dec 31 16:08 proc
drwxr-xr-x   14 root     root        4096 Jul  6  2000 mnt
drwxr-xr-x    3 root     root        1024 Jul  5  2000 usr
drwxr-xr-x    3 root     root        1024 Jul  7  2000 etc
drwxr-xr-x    3 root     root        1024 Jul  5  2000 opt
drwxrwxr-x    2     1000 root        2048 Jul  7  2000 bin
drwxrwxr-x    3 root     root        1024 Jul  6  2000 dev
drwxrwxr-x    2     1000 root        1024 Jul  7  2000 lib
drwxr-xr-x    5 root     root        1024 Jul  7  2000 var
lrwxrwxrwx    1 root     root           3 Jul  7  2000 sbin -> bin
-rw-r--r--    1 root     root           0 Jul  7  2000 remote.cap

sh-2.03# exportfs -av
exporting :/

sh-2.03# rpcinfo -p
   program vers proto   port
    100000    2   tcp    111
    100000    2   udp    111
    100005    1   udp    619
    100005    1   tcp    621
    100005    2   udp    624
    100005    2   tcp    626
    100005    3   udp    629
    100005    3   tcp    631
    100003    2   udp   2049

sh-2.03# ps
  PID  Uid      Gid State Command
    1 root     root     S init
    2 root     root     S [kflushd]
    3 root     root     S [kupdate]
    4 root     root     S [kpiod]
    5 root     root     S [kswapd]
    6 root     root     S [rpciod]
   12 root     root     S /bin/sh
   14 1        root     S /bin/portmap
   16 root     root     S /bin/inetd
   19 root     root     S mountd
   21 root     root     S [nfsd]
   26 root     root     R ps
sh-2.03#




**************** tcptrace dump: (hope I caught the interesting stuff!)


19:51:39.591889 eth0 > slave.658 > remote.sunrpc: udp 56
19:51:39.594068 eth0 < remote.sunrpc > slave.658: udp 28
19:51:39.595987 eth0 > slave.659 > remote.sunrpc: S
1668782859:1668782859(0) win 32120 <mss 1460,sackOK,timestamp 147556
0,nop,wscale 0> (DF)
19:51:39.596601 eth0 < remote.sunrpc > slave.659: S
124091899:124091899(0) ack 1668782860 win 32120 <mss
1460,sackOK,timestamp 5613 147556,nop,wscale 0> (DF)
19:51:39.596738 eth0 > slave.659 > remote.sunrpc: . 1:1(0) ack 1 win
32120 <nop,nop,timestamp 147556 5613> (DF)
19:51:39.597528 eth0 > slave.659 > remote.sunrpc: P 1:45(44) ack 1 win
32120 <nop,nop,timestamp 147556 5613> (DF)
19:51:39.598148 eth0 < remote.sunrpc > slave.659: . 1:1(0) ack 45 win
32120 <nop,nop,timestamp 5614 147556> (DF)
19:51:39.600665 eth0 < remote.sunrpc > slave.659: P 1:213(212) ack 45
win 32120 <nop,nop,timestamp 5614 147556> (DF)
19:51:39.600777 eth0 > slave.659 > remote.sunrpc: . 45:45(0) ack 213 win
32120 <nop,nop,timestamp 147556 5614> (DF)
19:51:39.601506 eth0 > slave.659 > remote.sunrpc: F 45:45(0) ack 213 win
32120 <nop,nop,timestamp 147556 5614> (DF)
19:51:39.602030 eth0 < remote.sunrpc > slave.659: . 213:213(0) ack 46
win 32120 <nop,nop,timestamp 5614 147556> (DF)
19:51:39.602544 eth0 > slave.660 > remote.623: udp 104
19:51:39.602948 eth0 < remote.sunrpc > slave.659: F 213:213(0) ack 46
win 32120 <nop,nop,timestamp 5614 147556> (DF)
19:51:39.603074 eth0 > slave.659 > remote.sunrpc: . 46:46(0) ack 214 win
32120 <nop,nop,timestamp 147556 5614> (DF)
19:51:39.604769 eth0 < remote.258913 > slave.nfs: 136 lookup [|nfs]
19:51:39.605026 eth0 > slave.nfs > remote.258913: reply ok 128 lookup fh
Unknown/1
19:51:39.608467 eth0 < remote.258914 > slave.nfs: 136 lookup [|nfs]
19:51:39.608698 eth0 > slave.nfs > remote.258914: reply ok 128 lookup fh
Unknown/1
19:51:39.610817 eth0 < remote.258915 > slave.nfs: 140 lookup [|nfs]
19:51:39.611036 eth0 > slave.nfs > remote.258915: reply ok 128 lookup fh
Unknown/1
19:51:39.612833 eth0 < remote.258916 > slave.nfs: 128 getattr [|nfs]
19:51:39.613049 eth0 > slave.nfs > remote.258916: reply ok 96 getattr
REG 100644 ids 0/0 sz 16
19:51:39.614355 eth0 < remote.258917 > slave.nfs: 140 read [|nfs]
19:51:39.614727 eth0 > slave.nfs > remote.258917: reply ok 116 read
19:51:39.617059 eth0 < remote.623 > slave.660: udp 60
19:51:39.617649 eth0 > slave.662 > remote.sunrpc: udp 56
19:51:39.619822 eth0 < remote.sunrpc > slave.662: udp 28
19:51:39.620834 eth0 > slave.844133990 > remote.nfs: 128 getattr [|nfs]
19:51:39.621867 eth0 < remote.nfs > slave.844133990: reply ok 96 getattr
DIR 40755 ids 0/0 sz 1024
19:51:40.108233 eth0 < remote.258918 > slave.nfs: 140 lookup [|nfs]
19:51:40.108967 eth0 > slave.nfs > remote.258918: reply ok 128 lookup fh
Unknown/1
19:51:42.255057 eth0 > slave.860911206 > remote.nfs: 136 readdir [|nfs]
19:51:42.256679 eth0 < remote.nfs > slave.860911206: reply ok 308
readdir offset 1 size 58421 eof
19:51:42.257290 eth0 > slave.877688422 > remote.nfs: 136 lookup [|nfs]
19:51:42.258221 eth0 < remote.nfs > slave.877688422: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.259946 eth0 > slave.894465638 > remote.nfs: 136 lookup [|nfs]
19:51:42.260902 eth0 < remote.nfs > slave.894465638: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.261972 eth0 > slave.911242854 > remote.nfs: 136 lookup [|nfs]
19:51:42.262914 eth0 < remote.nfs > slave.911242854: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.263993 eth0 > slave.928020070 > remote.nfs: 136 lookup [|nfs]
19:51:42.264952 eth0 < remote.nfs > slave.928020070: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.265999 eth0 > slave.944797286 > remote.nfs: 136 lookup [|nfs]
19:51:42.266951 eth0 < remote.nfs > slave.944797286: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.268000 eth0 > slave.961574502 > remote.nfs: 136 lookup [|nfs]
19:51:42.268951 eth0 < remote.nfs > slave.961574502: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.270000 eth0 > slave.978351718 > remote.nfs: 136 lookup [|nfs]
19:51:42.270950 eth0 < remote.nfs > slave.978351718: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.272002 eth0 > slave.995128934 > remote.nfs: 136 lookup [|nfs]
19:51:42.272951 eth0 < remote.nfs > slave.995128934: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.274031 eth0 > slave.1011906150 > remote.nfs: 136 lookup [|nfs]
19:51:42.274976 eth0 < remote.nfs > slave.1011906150: reply ok 28 lookup
ERROR: No such file or directory
19:51:42.276025 eth0 > slave.1028683366 > remote.nfs: 136 lookup [|nfs]
19:51:42.276976 eth0 < remote.nfs > slave.1028683366: reply ok 28 lookup
ERROR: No such file or directory
19:51:45.108293 eth0 < remote.258919 > slave.nfs: 140 lookup [|nfs]
19:51:45.109081 eth0 > slave.nfs > remote.258919: reply ok 128 lookup fh
Unknown/1


******* files on the target
(each of these are a single line, composer wraps them on me!)


/var/lib/nfs/etab:

/
(rw,async,wdelay,hide,insecure,no_root_squash,no_all_squash,subtree_check,mapping=identity,anonuid=-2,anongid=-2)

/var/lib/nfs/rmtab:

63.216.181.80:/

/var/lib/nfs/xtab:

/
63.216.181.80(rw,async,wdelay,hide,insecure,no_root_squash,no_all_squash,subtree_check,mapping=identity,anonuid=-2,anongid=-2)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
