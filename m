Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYGjT18pmzDvkB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 09:37:49 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id b35so37140999uaa.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 14:37:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161207092721.270fbc43@canb.auug.org.au>
References: <70A62042-92E6-414D-8FBD-BA0F5308944B@linux.vnet.ibm.com>
 <20161207092721.270fbc43@canb.auug.org.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 7 Dec 2016 09:37:46 +1100
Message-ID: <CAKTCnzmxjf+v3t-o7GwZkWp1Wrff+o0B6CAt0Ehp8gv3pdQTOA@mail.gmail.com>
Subject: Re: next-20161206 WARN@ mm/hugetlb.c:2918 during boot
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 linux-next <linux-next@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 7, 2016 at 9:27 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Sachin,
>
> [Just cc'ing a few more people]
>
> On Tue, 6 Dec 2016 21:11:46 +0530 Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>>
>> Following warning is displayed during todays next boot
>> on a Power8 LPAR. Kernel was built with pseries_le_defconfig.
>>
>> [    0.016702] ------------[ cut here ]------------
>> [    0.016708] WARNING: CPU: 1 PID: 1 at mm/hugetlb.c:2918 hugetlb_add_hstate+0x1e8/0x210
>> [    0.016709] Modules linked in:
>> [    0.016712] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc8-next-20161206 #2
>> [    0.016715] task: c0000003bacc0000 task.stack: c0000003bad00000
>> [    0.016717] NIP: c000000000cd30a0 LR: c000000000cd303c CTR: c00000000057d910
>> [    0.016719] REGS: c0000003bad03870 TRAP: 0700   Not tainted  (4.9.0-rc8-next-20161206)
>> [    0.016721] MSR: 8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>
>> [    0.016728]   CR: 88004022  XER: 2000000e
>> [    0.016730] CFAR: c00000000057db9c SOFTE: 1
>> GPR00: c000000000cd303c c0000003bad03af0 c000000000e84000 0000000000000014
>> GPR04: c000000000bb7927 0000000000000002 fffffffffffffff4 c000000000db4000
>> GPR08: c000000000d14000 0000000000000001 0000000000000000 0000000000000006
>> GPR12: 0000000088004028 c00000000ea70400 c00000000000ddd8 0000000000000000
>> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> GPR24: 0000000000000000 c000000000ca3614 0000000000000020 c000000000ec1228
>> GPR28: 0000000000001c78 c000000000faa9f0 0000000400000000 c000000000fac668
>> [    0.016767] NIP [c000000000cd30a0] hugetlb_add_hstate+0x1e8/0x210
>> [    0.016770] LR [c000000000cd303c] hugetlb_add_hstate+0x184/0x210
>> [    0.016771] Call Trace:
>> [    0.016773] [c0000003bad03af0] [c000000000cd303c] hugetlb_add_hstate+0x184/0x210 (unreliable)
>> [    0.016778] [c0000003bad03b80] [c000000000cb26ec] add_huge_page_size+0xa8/0xc8
>> [    0.016782] [c0000003bad03bb0] [c000000000cb27d8] hugetlbpage_init+0x60/0x1cc
>> [    0.016785] [c0000003bad03c40] [c00000000000d4e0] do_one_initcall+0x60/0x1c0
>> [    0.016788] [c0000003bad03d00] [c000000000ca4254] kernel_init_freeable+0x284/0x364
>> [    0.016791] [c0000003bad03dc0] [c00000000000ddf4] kernel_init+0x24/0x150
>> [    0.016795] [c0000003bad03e30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
>> [    0.016797] Instruction dump:
>> [    0.016799] 7d0807b4 394a0010 7d0a5036 3d02ffe9 7fbe5040 fbe83d80 41fc001c 3ce2fff3
>> [    0.016805] 89471fa4 2f8a0000 40fe000c 99271fa4 <0fe00000> 38210090 e8010010 eb61ffd8
>> [    0.016811] ---[ end trace 42481f903da18455 ]---
>> [    0.016882] pstore: using zlib compression
>>

I think Michael found this as well, its related to adding our gigantic
page to the hugetlb list
and the WARN_ON that Dave Hansen added (commit
a3a18061c987aa9da4f5d3cbb31a9e71e9d7191d)

I've not looked at this issue yet, Aneesh is aware of the issue as well

Balbir Singh.
