Message-Id: <200004111822.UAA12827@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems with Ethernet on PowerBook Wallstreet G3
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Tue, 11 Apr 2000 20:22:41 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm experiencing serious  problems  with  ethernet  on  my  PowerBook
Wallstreet G3; my hope that LinuxPPC 2000 would do some magic to make
it go away was in vain.

I have seen similar trouble reports (Josh Huber <huberj@wpi.edu>  and
Joseph Garcia <jpgarcia@execpc.com>; Tue, 8 Feb 2000: "BMAC eth prob-
lems..."), but never seen a solution...

Summary: outgoing traffic is extremely slow; outgoing TCP streams get
corrupted without notice.

* Ethernet is extremely slow when SENDING data.  While  incoming  FTP
  traffic  reaches  800...900  kB/s  (which  seems  ok  on  a 10 mbps
  network), outgoing traffic makes only 40...50 kB/s.

* Outgoing data gets corrupted: larger outgoing  FTP  file  transfers
  get  corrupted  every  now and then - gzip compressed data will not
  uncompress because of checksum errors,  and  checksuming  the  file
  before and after the FTP trasfer verifies this.

* NFS traffic seems to be a bit better (somewhat faster, a  lot  less
  corruption), but is still creeping slow.

* When using the PowerBook as NFS _server_, on the client I will  see
  error messages:

	nfs: server 10.0.0.3 not responding, still trying
	nfs: server 10.0.0.3 not responding, still trying
	nfs: server 10.0.0.3 OK
	nfs: server 10.0.0.3 OK
	...
	nfs: server 10.0.0.3 not responding, still trying
	nfs: server 10.0.0.3 not responding, still trying
	nfs: server 10.0.0.3 OK
	nfs: server 10.0.0.3 OK
	...
	nfs: server 10.0.0.3 not responding, still trying
	nfs: server 10.0.0.3 not responding, still trying
	nfs: server 10.0.0.3 OK
	nfs: server 10.0.0.3 OK

* The problem is persistent on all types of  network  connections;  I
  tried:

  - Connecting to a switching dual speed (10/100 mbps) hub
  - Connecting to a simple 10 mbps hub
  - direct connection using a crossover cable

  Network load is minimal, and  all  other  systems  don't  show  any
  problems. I see 0 collisions on the powerbook, and not many (<0.2%)
  on my other systems.

  The only indication of netwoprk problewms I've seen so far  is  the
  following:

	Apr  9 04:22:07 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 04:24:37 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 04:44:06 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 04:45:07 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 04:55:37 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 05:22:07 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 05:34:07 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 05:56:37 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 06:28:07 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)
	Apr  9 06:31:07 diddl arpwatch: 0:5:2:7:39:97 sent bad addr len (hard 0, prot 4)

  The address reported _is_ the ethernet address of my PowerBook, but
  unfortunately I'm not able to reproduce the situation  that  caused
  these  messages  to be logged, nor do I know what might have caused
  them.



This makes the system basicly unsuable for all network based work.

Any ideas what migh cause this type of problem - and how to fix it ?!?

Thanks in advance,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As in certain cults it is possible to kill a process if you know  its
true name.                      -- Ken Thompson and Dennis M. Ritchie

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
