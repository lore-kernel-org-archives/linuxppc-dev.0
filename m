Message-ID: <3E74C280.3000608@elitedvb.net>
Date: Sun, 16 Mar 2003 19:29:20 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE corruption w/ 48 Bit addressing
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

i'm having a PPC-405 based board (IBM STB04500 if anyone cares), and i'm
using a Maxtor 6Y200L0, a 200GB harddisk drive.

Obviously this uses 48bit addressing, and i'm using linucppc 2.4.21-pre4
devel. The same bug occurs with 2.4.20 release.

Users report harddisk corruption, and a quick test showed, that data
written to 0x1800000000+x (LBA sector 0xC000000+x/512) is also written
to x. (direct O_LARGEFILE-access to /dev/discs0/disc).

This will of course corrupt the filesystem.

Now my questions:

  - is this a bug in the IDE low-level interface driver?
  - or maybe in the kernel?
  - or maybe fixed in newer versions?
  - why does the corruption start at this lba sector?


User reported that this occurs with different HDD models and brands,
too, but only with 48bit-drives. Everything else works perfectly.

felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
