Return-Path: <jstancek@redhat.com>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6pTs2tsXzDqNM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 11:10:09 +1100 (AEDT)
Date: Mon, 23 Jan 2017 19:10:00 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: mpe@ellerman.id.au, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org
Cc: Artem Savkov <asavkov@redhat.com>, Herton Krzesinski <hkrzesin@redhat.com>,
 jstancek@redhat.com
Message-ID: <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
In-Reply-To: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
Subject: [bug] stack protector panics on v4.10-rc1+
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm running into panics with stack protector enabled on ppc64le
lpar (IBM,8408-E8E), starting with:

commit 6533b7c16ee5712041b4e324100550e02a9a5dda
Author: Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Tue Nov 22 11:49:30 2016 +0100
    powerpc: Initial stack protector (-fstack-protector) support

CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y

For example (it crashes at various places):
[    1.028466] systemd[1]: Set hostname to <localhost.localdomain>. 
[    1.036105] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: c000000000ad2250 
[    1.036105]  
[    1.036124] CPU: 5 PID: 168 Comm: dracut-rootfs-g Tainted: G        W       4.0.0+ #11 
[    1.036131] Call Trace: 
[    1.036141] [c0000000fe113a80] [c000000000af13e8] dump_stack+0xa0/0xdc (unreliable) 
[    1.036153] [c0000000fe113ab0] [c000000000ae5138] panic+0x110/0x2bc 
[    1.036163] [c0000000fe113b40] [c0000000000dd664] __stack_chk_fail+0x24/0x30 
[    1.036172] [c0000000fe113ba0] [c000000000ad2250] wait_for_completion+0x190/0x1a0 
[    1.036182] [c0000000fe113c20] [c000000000221920] stop_one_cpu+0x110/0x1b0 
[    1.036191] [c0000000fe113d00] [c000000000134a58] sched_exec+0xf8/0x180 
[    1.036200] [c0000000fe113d60] [c0000000003b0f74] SyS_execve+0x414/0xb10 
[    1.036210] [c0000000fe113e30] [c000000000009308] system_call+0x38/0xb4 
[    1.052902] Rebooting in 10 seconds.. 

I tried applying this commit on older kernels, and every kernel I tried, going
back as far as 3.10 was panic-ing early during boot on stack corruption.
I tried gcc-4.8.5-11.el7, and Fedora 25's gcc-6.3.1-1.fc25 with same result.

(gdb) disassemble wait_for_completion
Dump of assembler code for function wait_for_completion:
...
   0xc000000000c6642c <+140>:   ld      r9,-28688(r13)
   0xc000000000c66430 <+144>:   xor.    r8,r8,r9
   0xc000000000c66434 <+148>:   li      r9,0
   0xc000000000c66438 <+152>:   bne-    0xc000000000c665d8 <wait_for_completion+568>
...
   0xc000000000c665d8 <+568>:   bl      0xc0000000000f5c68 <__stack_chk_fail+8>

I came across following gcc commit:
  https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=0d55f4d0aeaeb16629a2c07c96a190695b83a7e6
which mentions offset above:
  "If TARGET_THREAD_SSP_OFFSET is defined, use -0x7010(13) resp.
   -0x7008(2) instead of reading __stack_chk_guard variable."

It looks like it's not reading canary value from __stack_chk_guard variable.
atm. I'm not sure where -28688(r13) falls in ppc kernel (somewhere near paca struct?).

Is anyone else seeing these panics?

Regards,
Jan
