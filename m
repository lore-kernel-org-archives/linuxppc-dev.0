Message-ID: <3970D1A4.CDB94884@wanadoo.fr>
Date: Sat, 15 Jul 2000 23:03:32 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test4 doesn't boot (solved)
References: <396F289B.7D5705EF@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
[]
> and then a never ending loop of
>
> kmod: failed to exec /sbin/modprobe -s -k binfmt-4c46, errno=8

Sorry to answer my own question, but I don't want to leave loose ends in
the list archives.

Took me a long time to hunt this down to a recent patch in
include/asm-ppc/elf.h which wasn't delivered to me by rsync.

The result was that the kernel didn't understand the ELF bin-format of
/sbin/init, then asked modprobe to load a module for the unknown format,
didn't understand the bin-format of /sbin/modprobe, etc ad infinitum.

The reason why this file wasn't sent to me by rsync was related to the
recent clock changes, which made me run sometimes with a wrong system
time. So what I learned from this story (apart from a lot about the
inner workings of kmod, execve, binfmt_elf, and the boot process) is:

Never use "rsync -au" while your system time is not correct!

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
