Date: Mon, 5 Apr 2004 23:53:18 +0200
From: Kiko Piris <linuxppc@pirispons.net>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040405215318.GA2822@mortadelo.pirispons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Yesterday I compiled vanilla 2.6.5 (plus laptop-mode patch).

Today I noticed an oops when resuming from sleep.

Here's what I get on the screen console:

---8<---
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7] 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
tumbler: i2c is not initialized
Oops: kernel access of bad area, sig: 11 [#1]
NIP: DA378C3C LR: DA468E0C SP: D4F13D70 REGS: d4f13cc0 TRAP: 0301    Not tainted
MSR: 0000b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 00000006, DSISR: 40000000
TASK = d74920c0[1233] 'pmud' Last syscall: 54
GPR00: DA468E0C D4F13D70 D74920C0 00000000 00000040 00000000 00000000 00000040
GPR08: 00000002 FFFFFFFF D74920C0 00000000 2DE985CF
Call trace:
 [da468e0c] snapper_set_capture_source+0x28/0x38 [snd_powermac]
 [da46936c] tumbler_resume+0xa0/0x138 [snd_powermac]
 [da466318] snd_pmac_resume+0xf4/0xf8 [snd_powermac]
 [da466364] snd_pmac_sleep_notify+0x48/0x54 [snd_powermac]
 [c030788c] 0xc030788c
 [c0307fe0] 0xc0307fe0
 [c03084c4] 0xc03084c4
 [c0308d2c] 0xc0308d2c
 [c0067c04] sys_ioctl+0xdc/0x2f4
 [c0007600] ret_from_syscall+0x0/0x44
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
--->8---

And the system is completely hung (I've copied it by hand, so I could
have made a mistake typing).

I've noticed that if I put the iBook to sleep having unloaded alsa, it
resumes ok. Having alsa loaded, I can reproduce it 100% of the times.


Some info about my system:

* Debian Sid up2date.

* Kernel config, if needed, is uploaded at
http://www.pirispons.net/bulma/llista/iBook/

$ cat /proc/version
Linux version 2.6.5 (root@sacarino) (gcc version 3.3.3 (Debian 20040401)) #1 Sun Apr 4 14:23:10 CEST 2004

$ cat /proc/cpuinfo
processor       : 0
cpu             : 750FX
temperature     : 47 C (uncalibrated)
clock           : 400MHz
revision        : 2.3 (pvr 7000 0203)
bogomips        : 793.71
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld


Please, let me know if I can provide any additional information.

Many thanks in advance

--
Kiko

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
