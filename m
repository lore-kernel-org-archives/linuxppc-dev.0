Message-ID: <39A36A26.1291926E@amberdata.demon.co.uk>
Date: Wed, 23 Aug 2000 07:07:34 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: prep problems - a couple of questions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm encountering a couple of problems with 2.4.0-test3+ on PReP systems.
I've finally traced the major one down to the following: calling
request_region() in prep_setup_arch() causes the machine to stop.
Tracing it a little deeper, it is the call to kmalloc() inside
request_region() which actually fails. I'm guessing this is caused by
the changes to the slab allocator in 2.4.0-test3.

So it looks like we can't afford to call request_region() this early in
the game. Can anybody tell me when it is first safe to use it?

Secondly, once I hacked around that I discovered that the IDE acesses
are all coming out byteswapped (this includes the ID strings etc, not
just the data). This is caused by the addition of the '#if 0' in
include/asm-ppc/ide.h as follows:

#if 0
#undef insw
#define insw(port, buf, ns)     do {                            \
        ppc_ide_md.insw((port), (buf), (ns));                   \
} while (0)

#undef outsw
#define outsw(port, buf, ns)    do {                            \
        ppc_ide_md.outsw((port), (buf), (ns));                  \
} while (0)
#endif

This appears in 2.3.99-pre6. Anybody know why? If I take out the #if 0
the IDE drives work fine again...


Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
