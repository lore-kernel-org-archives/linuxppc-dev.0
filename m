Mime-Version: 1.0
Message-Id: <p06100200bd4c49c3daeb@[192.168.0.23]>
Date: Fri, 20 Aug 2004 21:04:23 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.6 hoses 2.4 on old-world?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Been running a 2.4 kernel on my PowerTowerPro for a long time. Over
the months I've tried building 2.6.x, and succeeded for the first
time last night with 2.6.8-rc1. Tried booting (via BootX of course),
but lost all video immediately (completely black on the console, thin
green pinstripes when I [blindly] start X).

Rebooted to the default 2.4 but I'm hosed: The first part of the boot
starts, and sometime shortly after I get to the yellow Welcome to
Yellowdog lettering, then I'm seeing a lot of "/dev/null, read-only
file system" messages, and I'm dropped (after a root password) in a
shell with the prompt

	(Repair filesystem) N #

where N starts at one and increases if I type certain things at the
prompt, like "ls."

/etc/mtab shows:

	/dev/sda6 / ext3 rw 0 0
	none /proc proc rw 0 0

But if I try e2fsck /dev/sda6, I get 'couldn't open /dev/null
(read-only file system)' despite what mtab says. I can't seem to
umount anything to try remounting.

I was running journaled in 2.4, and I might have forgotten to build
in ext3 support in 2.6 - did this hose my installation? It's been
such a long time since I had to fsck anything, am I forgetting
something simple?


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
