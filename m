From: Felipe Trevisan Amaro <famaro@PARKS.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain;
  charset="iso-8859-1"
Subject: Out of Memory problem with kernel 2.4.4
Date: Wed, 7 Nov 2001 11:13:40 -0500
MIME-Version: 1.0
Message-Id: <01110711134000.01365@felipe.parks.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm developing an embedded router with MPC850 and kernel 2.4.4-denx
(linux-2.4.4-2001-07-23). It seems to be working ok, but when I do a
stressing troughput test all system crashes.
In this test each trial is 1000 seconds long and the error appear when the
lan inteface receives ethernet packets (128 or 192 packet-size) in a rate
bigger than the wan interface can handle. The system run out of  free memory
and hangs up. This are some messages :
...
eth0: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth0: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth0: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
...
VM: killing process in.telnetd
Out of Memory: Killed process 50 (sh).
Out of Memory: Killed process 1 (init).
__alloc_pages: 0-order allocation failed.
VM: killing process sh
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 52 (init).
Out of Memory: Killed process 1 (init).
__alloc_pages: 0-order allocation failed.
VM: killing process sh
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 54 (init).
...
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 1 (init).
Out of Memory: Killed process 1 (init).
...

When I was monitoring /proc/meminfo I saw the free memory becoming near the
limit of /proc/sys/vm/freepages  (128 pages or 512kb) and then the processes
start to be killed by the kernel. The problem is the system don't get out of
this error condition ( the test has already been stopped) .

Any help or tips would be greatly appreciated.


Thanks,

Felipe Trevisan Amaro

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
