Date: Tue, 18 Jul 2000 20:15:22 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux-2.4.0-test4 - problems in memory management?
In-Reply-To: <Pine.LNX.4.21.0007172015350.356-100000@sunapee.transcept.com>
Message-ID: <Pine.LNX.4.21.0007182007220.6653-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> If I boot Linux-2.4.0-test4 on RPX/Lite and try to "cat" a file I'm
> getting a "Bad address" error for some files. Writing, executing and
> low-level reading are Ok. In fact, I have to use "init=/bin/sh" to boot
> the kernel, since init from Busybox cannot even read /etc/inittab

After going all the way down from fread() to __copy_tofrom_user() it
appears that the later is at fault. It fails to copy large amounts of data
(216 bytes is enough to be a problem) to the pages that have just been
mmap'ed.

Replacing arch/ppc/lib/string.S with the version from 2.2.13-7 fixes the
problem. Linux-2.4.0-test4 appears to be functional after that!!! Feel
free to test.

Of course, it would be nice to know what exactly is broken in
__copy_tofrom_user(). Maybe next evening :-)

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
