Message-ID: <390DB320.DC787D62@ssh.com>
Date: Mon, 01 May 2000 19:38:56 +0300
From: Arto Vuori <avuori@ssh.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 8260 io and caches
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm currently trying to get linux running on EST SBC8260 board. I had
some problems with serial ports. Initially it just sent some garbage. I
found that serial port driver doesn't initialize BRG division factor in
SCCR register even though it assumes that it should be set to 0. I
modified my bootloader to initialize it and output looks now much
better.

There still seems to be some problems with caches. Everything is just
fine with caches disabled, but if i enable caches output doesn't look
correct. Adding some flush_dcache_range() calls to uart.c seems to fix
that problem, but shouldn't rx & tx buffers be allocated from some non
cacheable region??

Thanks

Arto

--
Arto Vuori
a-mail: avuori@ssh.com
mobile:	+358 40 754 5223

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
