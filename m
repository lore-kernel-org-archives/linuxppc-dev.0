Message-ID: <3883F17B.C67896FA@cns.canon.co.jp>
Date: Tue, 18 Jan 2000 13:52:12 +0900
From: Ouchi Masatomo <oouchi@cns.canon.co.jp>
Reply-To: oouchi@cns.canon.co.jp
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Question on booting FADS by NFS and /bin/sh (Re: LinuxPPC Embedded: root
 nfs boot problems.)
References: <382BC9B2.FDF9AD50@ctam.com.au> <382BE502.4CFC93BD@enib.fr> <382F4582.4F6882F2@ctam.com.au> <387D7DD5.DA4B1A68@cns.canon.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


May I ask you some basic question(s) 
booting MOTOROLA's FADS board by NFS
related to my last posting  
 
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200001/msg00086.html

<Question>
Q.1
  At first, mbxroot.min.tgz can be used for FADS ?

Q.2 
  Why these messages is out?
    (1)repeat of "NFS not responding" and "OK"
    (2)"error in loading shared libraries" and
        "libc.so.6: Out of memory"

[source]
  mpc8xx-2.2.13
 
[NFS Server]
  Linux  2.2.5-15 for i686 by Redhat ver 6.0
  IP=192.168.0.254
  defines client's name, MAC, IP, ... in /etc/bootbtab

  Files in Root_Path are from mbxroot.min.tgz.
  Those are sh and ls in /bin, /dev ,
  ld.so.1, libc-1.99.so, libc.so.6 -> libc-1.99.so, 
  libtermcap.so.2 -> libtermcap.so.2.0.8,
  libtermcap.so.2.0.8 in /lib.

[console]
 When booting, cosole messages are:

  ..........................
  eth0: CPM ENET Version 0.2, 00:00:85:30:30:31
  Sending BOOTP and RARP requests.... OK
  IP-Config: Got BOOTP answer from 192.168.0.254,
       my address is 192.168.0.100
  Looking up port of RPC 100003/2 on 192.168.0.254
  Looking up port of RPC 100005/1 on 192.168.0.254
  VFS: Mounted root (NFS filesystem) readonly.
  Freeing unused kernel memory: 40k init
  nfs: server 192.168.0.254 not responding, still trying
  nfs: server 192.168.0.254 OK
       ...... (*)
  nfs: server 192.168.0.254 not responding, still trying
  nfs: server 192.168.0.254 OK
  init: error in loading shared libraries
  libc.so.6: failed to map segment from shared object:
    Out of memory

*: repeats about 20 times.
   I tryed some times. About 20 is average value.
   Meanwhile there are many transmissions 
      FADS's udp-port 800 ------> NFS server's udp-port 2049
                                    128 bytes
      FADS's udp-port 800 <------ NFS server's udp-port 2049
                                    1132 bytes
   I don't know NFS protocol in detail.
   So I can't understand meaning of datagram.
--
  oouchi@cns.canon.co.jp

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
