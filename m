From: kd@flaga.is
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <0025677D.006A7F31.00@notes.flaga.is>
Date: Wed, 26 May 1999 19:23:13 +0000
Subject: Networking strangeness (MPC823)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Finally we managed to debug the hardware and get Linux to recognise the NFS
server (Serving the rootfilesystem).
"Everything" seems to work (ping, shell, ls, ......) but when using ping on
the MPC823 hardware (which is custom
made) to ping itself we get strange error that I have never seen before on
AlphaLinux and I386Linux. The error message
goes below. Does anyone know what is causing this problem? The error
message "Neighbour table overflow" is printed
out in net/ipv4/route.c, i.e. it is a kernel error message. I am using
mbxroot.full as a nfsmounted root file system (from
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/).

Thanks,

K.D.

The ping output. ping command is given on the mpc823 board. IP address
192.168.145.220 is the mpc823 board. IP address 192.168.145.222 is the NFS
server.

# ping 192.168.145.220
PING 192.168.145.220 (192.168.145.220): 56 data bytes
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.145.220 64 chars, ret=-1
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.145.220 64 chars, ret=-1
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.145.220 64 chars, ret=-1
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.145.220 64 chars, ret=-1

ping: wrote 192.168.145.220 64 chars, ret=-1
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.145.220 64 chars, ret=-1
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.145.220 64 chars, ret=-1

--- 192.168.145.220 ping statistics ---
6 packets transmitted, 0 packets received, 100% packet loss
# ping 192.168.145.222
PING 192.168.145.222 (192.168.145.222): 56 data bytes
64 bytes from 192.168.145.222: icmp_seq=0 ttl=64 time=3.8 ms
64 bytes from 192.168.145.222: icmp_seq=1 ttl=64 time=2.2 ms
64 bytes from 192.168.145.222: icmp_seq=2 ttl=64 time=2.2 ms
64 bytes from 192.168.145.222: icmp_seq=3 ttl=64 time=2.2 ms
64 bytes from 192.168.145.222: icmp_seq=4 ttl=64 time=2.2 ms
64 bytes from 192.168.145.222: icmp_seq=5 ttl=64 time=2.2 ms
64 bytes from 192.168.145.222: icmp_seq=6 ttl=64 time=2.2 ms

--- 192.168.145.222 ping statistics ---
7 packets transmitted, 7 packets received, 0% packet loss
round-trip min/avg/max = 2.2/2.4/3.8 ms




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
