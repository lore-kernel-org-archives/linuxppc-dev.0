Subject: reloading pbbuttonsd causes oops on 2.6.6
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1084360211.4289.17.camel@localhost>
Mime-Version: 1.0
Date: Wed, 12 May 2004 13:10:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I get this when I have a usb keyboard+mouse attached and then do
/etc/init.d/pbbuttonsd reload (which IIRC sends a HUP to pbbuttonsd
which then rescans for new HID devices)

Oops: kernel access of bad area, sig: 11 [#1]
NIP: 5A5A5A58 LR: C028E508 SP: EE287E10 REGS: ee287d60 TRAP: 0401    Not
tainted
MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = ee76b990[2725] 'pbbuttonsd' THREAD: ee286000Last syscall: 5
GPR00: 5A5A5A5A EE287E10 EE76B990 EF2EF0CC EE57A928 00000000 DD90F99C
EE287DA0
GPR08: 00000000 00000000 C0405DAC 00000005 80000488
NIP [5a5a5a58] 0x5a5a5a58
LR [c028e508] input_accept_process+0x3c/0x44
Call trace:
 [c02910c8] evdev_open+0x64/0x104
 [c028f46c] input_open_file+0x98/0x1cc
 [c006895c] chrdev_open+0xe0/0x16c
 [c005d758] dentry_open+0x15c/0x230
 [c005d5f8] filp_open+0x64/0x68
 [c005daac] sys_open+0x68/0xa0
 [c0005d60] ret_from_syscall+0x0/0x44

Soeren


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
