Date: Sun, 28 Jan 2001 15:24:51 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: scsi debug info before and after mesh locks up
Message-ID: <20010128152451.A20458@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de> <20010127163115.B2695@allspice.cs.swarthmore.edu> <20010127195924.A19744@allspice.cs.swarthmore.edu> <20010127202500.A21618@allspice.cs.swarthmore.edu> <20010127213401.A26295@allspice.cs.swarthmore.edu> <20010128000929.A9218@allspice.cs.swarthmore.edu> <20010128001147.B9218@allspice.cs.swarthmore.edu> <20010128021658.A18189@allspice.cs.swarthmore.edu> <20010128021758.B18189@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <20010128021758.B18189@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sun, Jan 28, 2001 at 02:17:59AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

And here's more info: the result of "echo scsi dump 1 > /proc/scsi/scsi"
before and a few times after it freezes.  Can anyone help me make sense
of this?  I guess I need to dig into the source to see what the SCSI
command numbers correspond to.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=scsidump-before

Dump of scsi host parameters:
 0 0 0 : 0 00000000
 0 0 0 : 0 00000000


Dump of scsi command parameters:
h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result
(  0)  0:0: 0: 0 ( 08:00   10    0    2 ffffffff 1) (0 5 0x 0) (3000    0    0) 0x28 0x00 0x00000000
(  1)  0:0: 0: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    0    0) 0x00 0x00 0x00000000
(  2)  0:0: 1: 0 ( 08:16 983056    0    2 ffffffff 1) (0 5 0x 0) (3000    0    0) 0x2a 0x00 0x00000000
(  3)  0:0: 1: 0 ( 08:16 999438    0    2 ffffffff 1) (0 5 0x 0) (3000    0    0) 0x2a 0x00 0x00000000
(  4)  0:0: 3: 0 ( 00:00    0    0    0 ffffffff 0) (0 1 0x 0) (4050    0    0) 0x1e 0x00 0x00000000
(  5)  0:0: 3: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    0    0) 0x00 0x00 0x00000000
h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result
Dump of pending block device requests
Dump of pending block device requests
Dump of pending block device requests
wait_for_request = c0172244

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=scsidump-after

Dump of scsi host parameters:
 0 2 2 : 0 00000000
 0 0 0 : 0 00000000


Dump of scsi command parameters:
h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result
(  0)  0:0: 0: 0 ( 08:00   10    0    2 ffffffff 1) (0 5 0x 0) (3000    0    0) 0x28 0x00 0x00000000
(  1)  0:0: 0: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    0    0) 0x00 0x00 0x00000000
(  2)  0:0: 1: 0 ( 08:16 606220    2    2    1 1) (0 5 0x 0) (3000    0    0) 0x2a 0x00 0x00000000
(  3)  0:0: 1: 0 ( 08:16 622628    0    2 ffffffff 1) (0 5 0x 0) (3000    0    0) 0x2a 0x00 0x00000000
(  4)  0:0: 3: 0 ( 15:02    0    0    0    1 0) (0 1 0x 0) (20050    0    0) 0x5d 0x00 0x00000000
(  5)  0:0: 3: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    0    0) 0x00 0x00 0x00000000
h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result
Dump of pending block device requests
Dump of pending block device requests
Dump of pending block device requests
wait_for_request = c0172244

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=scsidump-way-after

Dump of scsi host parameters:
 0 0 0 : 0 00000000
 0 0 0 : 0 00000000


Dump of scsi command parameters:
h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result
(  0)  0:0: 0: 0 ( 08:00   10    0    2 ffffffff 1) (0 5 0x 0) (3000    0    0) 0x28 0x00 0x00000000
(  1)  0:0: 0: 0 ( 00:00    0    0    0 ffffffff 0) (0 0 0x 0) (   0    0    0) 0x00 0x00 0x00000000
(  2)  0:0: 1: 0 ( 08:16 606224    0    2 ffffffff 0) (0 5 0x 0) (3000    0    0) 0x2a 0x00 0x06000000
(  3)  0:0: 1: 0 ( 08:16 999438    0    2 ffffffff 0) (0 5 0x 0) (3000    0    0) 0x2a 0x00 0x00000000
(  4)  0:0: 3: 0 ( 00:00    0    0    0 ffffffff 0) (0 1 0x 0) (20050    0    0) 0x5d 0x00 0x06000000
(  5)  0:0: 3: 0 ( 00:00    0    0    0 ffffffff 0) (0 1 0x 0) (2050    0    0) 0x00 0x00 0x06000000
h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result
Dump of pending block device requests
Dump of pending block device requests
Dump of pending block device requests
wait_for_request = c0172244


--BOKacYhQ+x31HxR3--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
