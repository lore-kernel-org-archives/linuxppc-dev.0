Message-ID: <3949F3E3.996DDC77@agelectronics.co.uk>
Date: Fri, 16 Jun 2000 10:31:15 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: copy_from_user in drivers/video/fbmem.c
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just ported the chips driver in 2.2 to the 69030 (now Asiliant, was
Intel, was C&T). I've found that writing to the frame buffer device
fails, because the underlying method in fbmem.c uses copy_from_user(),
and on PowerPC copy_from_user() cannot copy into uncached space.

Which do people think is wrong:
Is copy_from_user() on PPC wrong, because it can't write to uncached
space.
Is fbmem.c wrong, because it tries to use copy_from_user() to memory
mapped IO?

- Adrian Cox, AG Electronics

ps. On the 7400 this is fairly academic, as writing sequentially to a
cache line allocates it without the need for dcbz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
