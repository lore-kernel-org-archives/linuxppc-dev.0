Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6q2r5N4szDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 11:35:16 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0O0YG5J071548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 19:35:14 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 285vexr450-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 19:35:13 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 23 Jan 2017 17:35:12 -0700
Subject: Re: [bug] stack protector panics on v4.10-rc1+
To: Jan Stancek <jstancek@redhat.com>, mpe@ellerman.id.au,
 christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org
References: <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
Cc: Artem Savkov <asavkov@redhat.com>, Herton Krzesinski <hkrzesin@redhat.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 23 Jan 2017 16:35:06 -0800
MIME-Version: 1.0
In-Reply-To: <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d6abc506-5c1b-fbee-de04-23df7f591324@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2017 04:10 PM, Jan Stancek wrote:
> Hi,
> 
> I'm running into panics with stack protector enabled on ppc64le
> lpar (IBM,8408-E8E), starting with:
> 
> commit 6533b7c16ee5712041b4e324100550e02a9a5dda
> Author: Christophe Leroy <christophe.leroy@c-s.fr>
> Date:   Tue Nov 22 11:49:30 2016 +0100
>     powerpc: Initial stack protector (-fstack-protector) support
> 
> CONFIG_HAVE_CC_STACKPROTECTOR=y
> CONFIG_CC_STACKPROTECTOR=y
> # CONFIG_CC_STACKPROTECTOR_NONE is not set
> # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
> CONFIG_CC_STACKPROTECTOR_STRONG=y
> 
> For example (it crashes at various places):
> [    1.028466] systemd[1]: Set hostname to <localhost.localdomain>. 
> [    1.036105] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: c000000000ad2250 
> [    1.036105]  
> [    1.036124] CPU: 5 PID: 168 Comm: dracut-rootfs-g Tainted: G        W       4.0.0+ #11 
> [    1.036131] Call Trace: 
> [    1.036141] [c0000000fe113a80] [c000000000af13e8] dump_stack+0xa0/0xdc (unreliable) 
> [    1.036153] [c0000000fe113ab0] [c000000000ae5138] panic+0x110/0x2bc 
> [    1.036163] [c0000000fe113b40] [c0000000000dd664] __stack_chk_fail+0x24/0x30 
> [    1.036172] [c0000000fe113ba0] [c000000000ad2250] wait_for_completion+0x190/0x1a0 
> [    1.036182] [c0000000fe113c20] [c000000000221920] stop_one_cpu+0x110/0x1b0 
> [    1.036191] [c0000000fe113d00] [c000000000134a58] sched_exec+0xf8/0x180 
> [    1.036200] [c0000000fe113d60] [c0000000003b0f74] SyS_execve+0x414/0xb10 
> [    1.036210] [c0000000fe113e30] [c000000000009308] system_call+0x38/0xb4 
> [    1.052902] Rebooting in 10 seconds.. 
> 
> I tried applying this commit on older kernels, and every kernel I tried, going
> back as far as 3.10 was panic-ing early during boot on stack corruption.
> I tried gcc-4.8.5-11.el7, and Fedora 25's gcc-6.3.1-1.fc25 with same result.
> 
> (gdb) disassemble wait_for_completion
> Dump of assembler code for function wait_for_completion:
> ...
>    0xc000000000c6642c <+140>:   ld      r9,-28688(r13)
>    0xc000000000c66430 <+144>:   xor.    r8,r8,r9
>    0xc000000000c66434 <+148>:   li      r9,0
>    0xc000000000c66438 <+152>:   bne-    0xc000000000c665d8 <wait_for_completion+568>
> ...
>    0xc000000000c665d8 <+568>:   bl      0xc0000000000f5c68 <__stack_chk_fail+8>
> 
> I came across following gcc commit:
>   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=0d55f4d0aeaeb16629a2c07c96a190695b83a7e6
> which mentions offset above:
>   "If TARGET_THREAD_SSP_OFFSET is defined, use -0x7010(13) resp.
>    -0x7008(2) instead of reading __stack_chk_guard variable."
> 
> It looks like it's not reading canary value from __stack_chk_guard variable.
> atm. I'm not sure where -28688(r13) falls in ppc kernel (somewhere near paca struct?).
> 
> Is anyone else seeing these panics?

I believe there was some discussion in the following thread:

https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg112813.html

-Tyrel

> 
> Regards,
> Jan
> 
