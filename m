Message-Id: <v04003a00b302028aecdb@[10.0.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 2 Mar 1999 16:17:42 -0500
To: linuxppc-user-digest@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: Paul Barrette <barretp@mcmail.cis.mcmaster.ca>
Subject: 2.2.x kernels and u grading software to minimum req.
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have 2.2.2 running on R4.  I read the
/usr/src/linux/Documentation/Changes file and noticed that there are a
number of updates needed (see below).  I have noticed problems with  tx
packets:
root ~># ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Bcast:127.255.255.255  Mask:255.0.0.0
          EtherTalk Phase 2 addr:0/0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:277 errors:0 dropped:0 overruns:0 frame:0
     >>>     TX packets:0 errors:79193 dropped:277 overruns:0 carrier:0 coll:0

eth0      Link encap:Ethernet  HWaddr 00:05:02:70:06:45
          inet addr:10.0.0.1  Bcast:10.0.0.255  Mask:255.255.255.0
          EtherTalk Phase 2 addr:65280/34
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6539 errors:0 dropped:0 overruns:0 frame:0
       >>>   TX packets:0 errors:0 dropped:6737 overruns:5 carrier:0 coll:0
          Interrupt:14 Base address:0x1000

ppp0      Link encap:Point-to-Point Protocol
          inet addr:130.113.xx  P-t-P:130.113.xx  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:350 errors:0 dropped:0 overruns:0 frame:0
        >>>  TX packets:0 errors:9477 dropped:341 overruns:0 carrier:0 coll:0

I'm not sure what TX does, but when I upgraded to net-tools-1.49 on an
intel RH 5.1 box, these errors (no ppp0 there) disappeared.  Problem is
that net-tools-1.49 doesn't compile without errors on linuxppc. (or I'm not
able to correct these errors).

I also noticed that the following pkgs need to be updated from the standard
R4 dist:
insmod (I compiled 2.1.121 a while ago), egcs-2.90.25 980302, ld,
libc-1.99.so, procps 1.2.7, pstree 16, net-tools1.432, NFS 2.2beta29,
util-linux 2.6

Now the $10 question, are there rpms around?  I had a look at
ftp.linuxppc.org, no luck except for egcs and libc (which I will download
and re try compilation.)

Should I be concerned with these (apart from net-tools I think I can squeek
by)?   Are others upgrading or noticing problems having done so?

>>>>>>>>>>
  Upgrade to at *least* these software revisions before thinking you've
encountered a bug!  If you're unsure what version you're currently
running, the suggested command should tell you.

- Kernel modules         2.1.121                 ; insmod -V
- Gnu C                  2.7.2.3                 ; gcc --version
- Binutils               2.8.1.0.23              ; ld -v
- Linux libc5 C Library  5.4.46                  ; ls -l /lib/libc.so.*
- Linux libc6 C Library  2.0.7pre6               ; ls -l /lib/libc.so.*
- Dynamic Linker (ld.so) 1.9.9                   ; ldd --version or ldd -v
- Linux C++ Library      2.7.2.8                 ; ls -l /usr/lib/libg++.so.*
- Procps                 1.2.9                   ; ps --version
- Procinfo               15                      ; procinfo -v
- Psmisc                 17                      ; pstree -V
- Net-tools              1.49                    ; hostname -V
- Loadlin                1.6a
- Sh-utils               1.16                    ; basename --v
- Autofs                 3.1.1                   ; automount --version
- NFS                    2.2beta40               ; showmount --version
- Bash                   1.14.7                  ; bash -version
- Ncpfs                  2.2.0                   ; ncpmount -v
- Pcmcia-cs              3.0.7                   ; cardmgr -V
- PPP                    2.3.5                   ; pppd -v
- Util-linux             2.9g                    ; chsh -v


--
Paul Barrette
Ph.D. candidate, dept. of Classics
System Administrator
McMaster University

umbra loco deerat; qua postquam parte resedit
Dis genitus vates et fila sonantia movit,
umbra loco venit.                  (Ov. Met. 10. 88 ff.)
http://www.humanities.mcmaster.ca/~barrette/



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
