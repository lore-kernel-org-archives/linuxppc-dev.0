Date: Wed, 3 Dec 2003 04:44:16 -0500 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: userspace testing an ati fb driver
Message-ID: <Pine.LNX.4.50L0.0312030435240.3077-100000@rosencrantz.pok.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: random <eger-temp_addy-1071049257.71afe9@theboonies.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On my Powerbook, /proc/iomem lists 0xb0000000-0xb000ffff as the location
of the programming registers for my ATI Radeon R250 Lf.

This seems to be the same spot XFree86 finds in its log:
(II) RADEON(0): MMIO registers at 0xb0000000

I've been trying to mimic the XFree86 fb accel code to make a Linux 2.6 fb
port, but i've had little luck. To try to pare down the new code, I've
written a userspace program which will open "/dev/mem" and then mmap in
this file starting at '0xb0000000' going for 0x10000 bytes.  Poking at the
"registers" there seems to have no effect; reading from these "registers"
(for example, to verify the engine idling) indicates that I'm perhaps
reading from the wrong place in memory, i.e. the engine never indicates
that it's idle.  Any ideas?

-eger david

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
