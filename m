Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 32CC867B76
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Sep 2006 04:07:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Stupid Telnet Question
Date: Sun, 10 Sep 2006 11:07:36 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871064A53C4@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using ELDK 4.0 on a custom PPC74xx board, and NFS mounting the root
file system.  When I use the default NFS directory (e.g.
/opt/eldk_4.0/ppc_74xx) read-write, I can telnet into the board fine
(after modifying /etc/xinetd.d/telnet of course).

But this default directory is overkill for my future needs, so I'd like
to use a smaller root file system (but still NFS mount it).  As a start,
I looked at the ramdisk in ppc_74xx/images.  I unzipped the ramdisk, and
NFS mounted that as the root file system.

I'd also like to have the root file system mounted read-only.  So I
attempted to fix all the obvious problems I ran into with mounting ELDK
ramdisk filesystem read-only.  This consisted of:

1) "mount -n" ing everything that needed to be mounted, so /etc/mtab
wasn't updated
2) Creating a tmpfs /tmp ramdisk
3) Symlinking /var to /tmp/var, so I can run syslog
4) Symlinking /dev to /tmp/dev, so I can mknod devices in the /etc/rc.sh
script.  For starters, I just copied the contents of ELDK_MAKEDEV into
that script, but I will prune it down as I find device files I don't
need.  This way the devices can be read-write.
5) Putting those same devices in the /tmp/dev directory so that I could
solve the "Unable to open initial console" chicken-egg problem of no
device files being present when the root fs is mounted before the rc.sh
script runs.

The above steps work in-so-far as I can boot the board and work from the
serial console.  Now I'd like to get telnet working.  When I just telnet
locally from the serial console to the board (using the loopback IP
127.0.0.1) the telnet daemon connects, but the login program doesn't
give me a chance to type a username or login. =20

Question: What stupid thing have I done to cause this and how can I fix
it?

-------------------------------------------------
This is what my console session looks like:

# telnet 127.0.0.1

Entering character mode
Escape character is '^]'.


Linux 2.6.14 (172.16.5.11) (17:13 on Tuesday, 22 November 2011)

Login incorrect

Login incorrect

Login incorrect


Login incorrect
Connection closed by foreign host.

-------------------------------------------------
And here's what syslog is saying:

Nov 22 17:15:08 172 authpriv.info xinetd[1025]: START: telnet pid=3D1037
from=3D172.16.1.199
Nov 22 17:15:08 172 authpriv.notice login: FAILED LOGIN 1 FROM
172.16.1.199 FOR (null), Authentication failure
Nov 22 17:15:08 172 authpriv.notice login: FAILED LOGIN 2 FROM
172.16.1.199 FOR (null), Authentication failure
Nov 22 17:15:08 172 authpriv.notice login: FAILED LOGIN 3 FROM
172.16.1.199 FOR (null), Authentication failure
Nov 22 17:15:08 172 authpriv.notice login: FAILED LOGIN SESSION FROM
172.16.1.199 FOR (null), Authentication faie
