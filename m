Date: Mon, 26 Jun 2000 03:10:40 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: cort@fsmlabs.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Hash not zero-filled in hash_init()?
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000626025411.21802D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been experiencing random problems with 2.3/2.4 kernels, and, after
weeks of struggle, I found that the main culprit was an uninitialized hash
table.  Specifically, __clear_user(Hash, Hash_size) is commented out in
hash_init() of arch/ppc/mm/init.c.

Does anyone know why it should be commented out?  On NuBus Power Macs, due
to its discontiguous memory nature, the hash table location happens to be
at the same location all the time, and there is a very good chance that
some stale PTE remain from boot to boot.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
