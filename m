From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>,
        <yellowdog-devel@lists.yellowdoglinux.com>
Subject: RFC: Changing default partition type for linux/ppc
Date: Fri, 7 Jul 2000 12:59:15 +0200
Message-Id: <20000707105915.30418@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all !

Currently, the default partition type used by Linux/PPC on mac partition
maps is Apple_UNIX_SVR2. This is historically the type used by Apple's A/
UX for its own partitions. However, I don't like it since it gives no
indication on the type of filesystem on the partition, and I see no
reason to keep it.

So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
Linux_swap (since ext2 is not the only filesystem Linux may put on
these). Using a different type for swap would help avoiding confusion.

If everyone is ok, we can then update pdisk, and on my side, I'll update
the kernel's root-auto-detect mecanism to take this into account. (The
kernel will currently find by itself a root partition if it has the above
type and the name "root" and no root= option was specified by the bootloader).

Any comments ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
