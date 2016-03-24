Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWBtx2wLmzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 03:38:01 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qWBtw3N4Mz9sBm
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 03:38:00 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 24 Mar 2016 22:07:57 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2OGbKAE5767572
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 22:07:21 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2OGbovd003777
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 22:07:53 +0530
Date: Thu, 24 Mar 2016 22:07:38 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH HACK 1/6] livepatch-test: Add more cases
Message-ID: <20160324163734.GA7493@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-03-24 22:04:00]:

> Not for merging.
> 

Hi Michael,

Loading the livepatch sample module, trigger following warning

Mar 24 21:44:59 ubuntu kernel: [   40.467580] sysfs: cannot create duplicate filename '/kernel/livepatch/livepatch_sample/vmlinux'
Mar 24 21:44:59 ubuntu kernel: [   40.467601] ------------[ cut here ]------------
Mar 24 21:44:59 ubuntu kernel: [   40.467603] WARNING: at fs/sysfs/dir.c:31
Mar 24 21:44:59 ubuntu kernel: [   40.467604] Modules linked in: livepatch_sample(+) rtc_generic autofs4 ibmvscsi
Mar 24 21:44:59 ubuntu kernel: [   40.467610] CPU: 5 PID: 1479 Comm: modprobe Not tainted 4.5.0+ #2
Mar 24 21:44:59 ubuntu kernel: [   40.467612] task: c000000039a1b800 ti: c00000003767c000 task.ti: c00000003767c000
Mar 24 21:44:59 ubuntu kernel: [   40.467614] NIP: c00000000038bddc LR: c00000000038bdd8 CTR: c000000000557b20
Mar 24 21:44:59 ubuntu kernel: [   40.467615] REGS: c00000003767f4b0 TRAP: 0700   Not tainted  (4.5.0+)
Mar 24 21:44:59 ubuntu kernel: [   40.467616] MSR: 8000000102029033 <SF,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 28222442  XER: 20000000
Mar 24 21:44:59 ubuntu kernel: [   40.467624] CFAR: c000000000a65fac SOFTE: 1 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR00: c00000000038bdd8 c00000003767f730 c0000000014c3d00 0000000000000054 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR04: c00000003fe49c58 c00000003fe5b4d8 0000000000000064 000000000000010f 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR08: 0000000000000007 c000000000ecb274 000000003ef80000 7461706576696c2f 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR12: 0000000000002200 c00000000fe80f00 d00000000155c498 c00000003767fdb0 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR16: 000000000000003d c0000000013cc318 0000000000000000 c000000000cf1510 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR20: c0000000013cc328 c000000001478f28 d000000001570cb8 d000000001570c98 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR24: c000000000cc0070 c000000001478f50 0000000000000000 d000000001570cb8 
Mar 24 21:44:59 ubuntu kernel: [   40.467624] GPR28: d0000000015708d0 c00000003c750870 c000000000cbfe68 c00000003a730000 
Mar 24 21:44:59 ubuntu kernel: [   40.467642] NIP [c00000000038bddc] sysfs_warn_dup+0x8c/0xc0
Mar 24 21:44:59 ubuntu kernel: [   40.467645] LR [c00000000038bdd8] sysfs_warn_dup+0x88/0xc0
Mar 24 21:44:59 ubuntu kernel: [   40.467645] Call Trace:
Mar 24 21:44:59 ubuntu kernel: [   40.467648] [c00000003767f730] [c00000000038bdd8] sysfs_warn_dup+0x88/0xc0 (unreliable)
Mar 24 21:44:59 ubuntu kernel: [   40.467650] [c00000003767f7b0] [c00000000038bfac] sysfs_create_dir_ns+0xdc/0x100
Mar 24 21:44:59 ubuntu kernel: [   40.467652] [c00000003767f7f0] [c00000000054b354] kobject_add_internal+0xe4/0x420
Mar 24 21:44:59 ubuntu kernel: [   40.467654] [c00000003767f880] [c00000000054ba34] kobject_init_and_add+0x64/0xa0
Mar 24 21:44:59 ubuntu kernel: [   40.467657] [c00000003767f900] [c000000000135e8c] klp_register_patch+0x1ac/0x3b0
Mar 24 21:44:59 ubuntu kernel: [   40.467659] [c00000003767f9e0] [d000000001570354] livepatch_init+0x34/0xc0 [livepatch_sample]
Mar 24 21:44:59 ubuntu kernel: [   40.467661] [c00000003767fa10] [c00000000000b5ac] do_one_initcall+0x12c/0x2a0
Mar 24 21:44:59 ubuntu kernel: [   40.467664] [c00000003767fae0] [c000000000a6647c] do_init_module+0x98/0x254
Mar 24 21:44:59 ubuntu kernel: [   40.467666] [c00000003767fb70] [c000000000163178] load_module+0x22c8/0x2a80
Mar 24 21:44:59 ubuntu kernel: [   40.467668] [c00000003767fd40] [c000000000163c90] SyS_finit_module+0x110/0x170
Mar 24 21:44:59 ubuntu kernel: [   40.467670] [c00000003767fe30] [c000000000009204] system_call+0x38/0xb4
Mar 24 21:44:59 ubuntu kernel: [   40.467671] Instruction dump:
Mar 24 21:44:59 ubuntu kernel: [   40.467672] 4182001c 7fe4fb78 38a01000 7fa3eb78 4bffa3bd 60000000 7c641b78 3c62ff82 
Mar 24 21:44:59 ubuntu kernel: [   40.467676] 7fc5f378 386392c0 486da175 60000000 <0fe00000> 7fe3fb78 4bf16c95 60000000 
Mar 24 21:44:59 ubuntu kernel: [   40.467680] ---[ end trace 77c74eaaf32878c5 ]---
Mar 24 21:44:59 ubuntu kernel: [   40.467681] kobject_add_internal failed for vmlinux with -EEXIST, don't try to register things with the same name in the same directory.
Mar 24 21:44:59 ubuntu kernel: [   40.467694] ------------[ cut here ]------------
Mar 24 21:44:59 ubuntu kernel: [   40.467696] WARNING: at lib/kobject.c:240
Mar 24 21:44:59 ubuntu kernel: [   40.467697] Modules linked in: livepatch_sample(+) rtc_generic autofs4 ibmvscsi
Mar 24 21:44:59 ubuntu kernel: [   40.467700] CPU: 5 PID: 1479 Comm: modprobe Tainted: G        W       4.5.0+ #2
Mar 24 21:44:59 ubuntu kernel: [   40.467702] task: c000000039a1b800 ti: c00000003767c000 task.ti: c00000003767c000
Mar 24 21:44:59 ubuntu kernel: [   40.467703] NIP: c00000000054b5ec LR: c00000000054b5e8 CTR: c000000000557b20
Mar 24 21:44:59 ubuntu kernel: [   40.467704] REGS: c00000003767f570 TRAP: 0700   Tainted: G        W        (4.5.0+)
Mar 24 21:44:59 ubuntu kernel: [   40.467706] MSR: 8000000102029033 <SF,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 28222448  XER: 20000000
Mar 24 21:44:59 ubuntu kernel: [   40.467711] CFAR: c000000000a65fac SOFTE: 1 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR00: c00000000054b5e8 c00000003767f7f0 c0000000014c3d00 000000000000007c 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR04: 0000000000000001 0000000000000000 000000000000008c 000000000000012b 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR08: 0000000000000007 0000000000000007 0000000000000001 6f64202c54534958 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR12: 0000000000002200 c00000000fe80f00 d00000000155c498 c00000003767fdb0 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR16: 000000000000003d c0000000013cc318 0000000000000000 c000000000cf1510 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR20: c0000000013cc328 c000000001478f28 d000000001570cb8 d000000001570c98 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR24: c000000000cc0070 c000000001478f50 0000000000000000 d000000001570cb8 
Mar 24 21:44:59 ubuntu kernel: [   40.467711] GPR28: d0000000015708d0 d000000001570cb8 ffffffffffffffef d0000000015708d0 
Mar 24 21:44:59 ubuntu kernel: [   40.467727] NIP [c00000000054b5ec] kobject_add_internal+0x37c/0x420
Mar 24 21:44:59 ubuntu kernel: [   40.467729] LR [c00000000054b5e8] kobject_add_internal+0x378/0x420
Mar 24 21:44:59 ubuntu kernel: [   40.467730] Call Trace:
Mar 24 21:44:59 ubuntu kernel: [   40.467732] [c00000003767f7f0] [c00000000054b5e8] kobject_add_internal+0x378/0x420 (unreliable)
Mar 24 21:44:59 ubuntu kernel: [   40.467734] [c00000003767f880] [c00000000054ba34] kobject_init_and_add+0x64/0xa0
Mar 24 21:44:59 ubuntu kernel: [   40.467736] [c00000003767f900] [c000000000135e8c] klp_register_patch+0x1ac/0x3b0
Mar 24 21:44:59 ubuntu kernel: [   40.467739] [c00000003767f9e0] [d000000001570354] livepatch_init+0x34/0xc0 [livepatch_sample]
Mar 24 21:44:59 ubuntu kernel: [   40.467741] [c00000003767fa10] [c00000000000b5ac] do_one_initcall+0x12c/0x2a0
Mar 24 21:44:59 ubuntu kernel: [   40.467743] [c00000003767fae0] [c000000000a6647c] do_init_module+0x98/0x254
Mar 24 21:44:59 ubuntu kernel: [   40.467745] [c00000003767fb70] [c000000000163178] load_module+0x22c8/0x2a80
Mar 24 21:44:59 ubuntu kernel: [   40.467747] [c00000003767fd40] [c000000000163c90] SyS_finit_module+0x110/0x170
Mar 24 21:44:59 ubuntu kernel: [   40.467749] [c00000003767fe30] [c000000000009204] system_call+0x38/0xb4
Mar 24 21:44:59 ubuntu kernel: [   40.467750] Instruction dump:
Mar 24 21:44:59 ubuntu kernel: [   40.467751] 60420000 3ce2ff83 38e75bf0 4bfffdcc 60420000 e8bf0000 3c82ff5f 3c62ff83 
Mar 24 21:44:59 ubuntu kernel: [   40.467755] 3884cd48 38635c88 4851a965 60000000 <0fe00000> 4bfffdc4 3ce2fff8 89070be3 
Mar 24 21:44:59 ubuntu kernel: [   40.467758] ---[ end trace 77c74eaaf32878c6 ]---

I am away for the long weekend, will help in testing next week.

Thanks,
Kamalesh.
