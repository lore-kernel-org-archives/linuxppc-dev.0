Date: Mon, 24 Jun 2002 16:19:52 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cramfs for root filesystem?
Message-ID: <20020624161952.A28796@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that here,

http://penguinppc.org/embedded/howto/root-filesystem.html

it says:

> It turns out that cramfs is not supported for a root fs or initrd.
> Basically, the kernel checks a hardcoded list of supported
> filesystems and if the MAGIC number doesn't match it bails.

Then, a couple lines later it says this, which clearly implies
a read-only cramfs root fs is possible::

> ramfs from the 2.4 kernel is a simple filesystem ideal for use in a
> ramdisk. It can be used in combination with a cramfs read-only root
> filesystem, to mount writable filesystems on /tmp and /var, which
> typically need to be writable. This combination is ideal for
> systems which don't require persistent storage.

So, I figured I'd try cramfs as a root fs and see if I'm lucky
and the first statement is just a mistake, and I get:

	RAMDISK: Compressed image found at block 0                                      Freeing initrd memory: 1270k freed                                              cramfs: wrong magic                                                             Kernel panic: VFS: Unable to mount root fs on 01:00                              <0>Rebooting in 180 seconds..

Well, it appears maybe the first statement is correct.

Then again, the message seems to be coming from the cramfs
part of the system...

So when I made my cramfs, I used mkcramfs which I got today (jun 24 2002)
from sourceforge.  I noticed older versions had some notes about endianness.
This version seems to say that little-endian is the proper format for the
filesystem data, and this is what kind of cramfs it makes and the kernel
on a big endian machine like mine needs to do the necessary byte swapping
to handle it.  Also, I created the cramfs on an intel box (little endian)
so in any case the fs is little endian.

Does the linuxppc_2_4_devel kernel from bitkeeper
handle little-endian cramfs filesystems?  Or is there
a patch for this?  Or a patch to mkcramfs to make it
create a big-endian cramfs (despite threads I read saying
this is the wrong way to proceed.)

Or am I on the wrong track completely in trying to use
cramfs for a root filesystem?

Thanks,

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
