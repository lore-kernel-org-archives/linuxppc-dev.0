Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFFA05C@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'acurtis@onz.com'" <acurtis@onz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Debugging Network Performance
Date: Wed, 5 Jun 2002 08:18:23 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen,

With my 200MHz 8260 based board, using kernel 2.4.19-pre7,
I fetch a large file (~50Mb) with ftp, and send it to /dev/null
  get large_file /dev/null
and I obtain the following performance:
  50216878 bytes received in 5.52 seconds (9090508 bytes/s)

About 8977 kbytes/sec! This is around the maximum for a 100Mbps link.

In 10Mbps half duplex, I achieve a

The connection is in half duplex on the board side,
and full duplex on the ftp server (It crosses a switch).
Switching to full duplex for both does not affect the performance.

If the performance drops in 100Mbps full duplex, the problem might be
one of configuration between your BCM switch and the external switch.

Are both ends of the link (between your BCM switch and external switch)
set to auto-negotiation? If you disable auto-negociation on one side
only (you force it in full duplex for example), you should also the other to
full duplex.
That is important, and caused me hours of research. ;-)

Hope this helps.

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
