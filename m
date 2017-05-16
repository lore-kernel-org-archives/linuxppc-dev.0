Return-Path: <keescook@google.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wS0K0446dzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 00:32:19 +1000 (AEST)
Received: by mail-io0-x236.google.com with SMTP id f102so94411900ioi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 07:32:19 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <878tlxoy62.fsf@concordia.ellerman.id.au>
References: <20170515191949.GA13641@gmail.com>
 <878tlxoy62.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 16 May 2017 07:32:16 -0700
Message-ID: <CAGXu5jK86RkgsWFdtSuGoZzuRZt4cqJcU4YSTjn=irv0Pbu3Rw@mail.gmail.com>
Subject: Re: kernel BUG at mm/usercopy.c:72!
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Laura Abbott <labbott@redhat.com>, gromero@br.ibm.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 16, 2017 at 4:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> [Cc'ing the relevant folks]
>
> Breno Leitao <leitao@debian.org> writes:
>> Hello,
>>
>> Kernel 4.12-rc1 is showing a bug when I try it on a POWER8 virtual
>> machine. Justing SSHing into the machine causes this issue.
>>
>>       [23.138124] usercopy: kernel memory overwrite attempt detected to d000000003d80030 (mm_struct) (560 bytes)
>>       [23.138195] ------------[ cut here ]------------
>>       [23.138229] kernel BUG at mm/usercopy.c:72!
>>       [23.138252] Oops: Exception in kernel mode, sig: 5 [#3]
>>       [23.138280] SMP NR_CPUS=2048
>>       [23.138280] NUMA
>>       [23.138302] pSeries
>>       [23.138330] Modules linked in:
>>       [23.138354] CPU: 4 PID: 2215 Comm: sshd Tainted: G      D         4.12.0-rc1+ #9
>>       [23.138395] task: c0000001e272dc00 task.stack: c0000001e27b0000
>>       [23.138430] NIP: c000000000342358 LR: c000000000342354 CTR: c0000000006eb060
>>       [23.138472] REGS: c0000001e27b3a00 TRAP: 0700   Tainted: G      D          (4.12.0-rc1+)
>>       [23.138513] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
>>       [23.138517]   CR: 28004222  XER: 20000000
>>       [23.138565] CFAR: c000000000b34500 SOFTE: 1
>>       [23.138565] GPR00: c000000000342354 c0000001e27b3c80 c00000000142a000 000000000000005e
>>       [23.138565] GPR04: c0000001ffe0ade8 c0000001ffe21bf8 2920283536302062 79746573290d0a74
>>       [23.138565] GPR08: 0000000000000007 c000000000f61864 00000001feeb0000 3064206f74206465
>>       [23.138565] GPR12: 0000000000004400 c00000000fb42600 0000000000000015 00000000545bdc40
>>       [23.138565] GPR16: 00000000545c49c8 000001000b4b8890 00007ffff78c26f0 00000000545cf000
>>       [23.138565] GPR20: 00000000546109c8 000000000000c7e8 0000000054610010 00007ffff78c22e8
>>       [23.138565] GPR24: 00000000545c8c40 c0000000ff6bcef0 c0000000001e5220 0000000000000230
>>       [23.138565] GPR28: d000000003d80260 0000000000000000 0000000000000230 d000000003d80030
>>       [23.138920] NIP [c000000000342358] __check_object_size+0x88/0x2d0
>>       [23.138956] LR [c000000000342354] __check_object_size+0x84/0x2d0
>>       [23.138990] Call Trace:
>>       [23.139006] [c0000001e27b3c80] [c000000000342354] __check_object_size+0x84/0x2d0 (unreliable)
>>       [23.139056] [c0000001e27b3d00] [c0000000009f5ba8] bpf_prog_create_from_user+0xa8/0x1a0
>>       [23.139099] [c0000001e27b3d60] [c0000000001e5d30] do_seccomp+0x120/0x720
>>       [23.139136] [c0000001e27b3dd0] [c0000000000fd53c] SyS_prctl+0x2ac/0x6b0
>>       [23.139172] [c0000001e27b3e30] [c00000000000af84] system_call+0x38/0xe0
>>       [23.139218] Instruction dump:
>>       [23.139240] 60000000 60420000 3c82ff94 3ca2ff9d 38841788 38a5e868 3c62ff95 7fc8f378
>>       [23.139283] 7fe6fb78 386310c0 487f2169 60000000 <0fe00000> 60420000 2ba30010 409d018c
>>       [23.139328] ---[ end trace 1a1dc952a4b7c4af ]---
>>
>> I found that kernel 4.11 does not have this issue. I also found that, if
>> I revert 517e1fbeb65f5eade8d14f46ac365db6c75aea9b, I do not see the
>> problem.
>>
>> On the other side, if I cherry-pick commit
>> 517e1fbeb65f5eade8d14f46ac365db6c75aea9b into 4.11, I start seeing the
>> same issue also on 4.11.
>
> Yeah it looks like powerpc also suffers from the same bug that arm64
> used to, ie. virt_addr_valid() will return true for some vmalloc
> addresses.
>
> virt_addr_valid() is used pretty widely, I'm not sure if we can just fix
> it without other fallout. I'll dig a bit more tomorrow if no one beats
> me to it.
>
> Kees, depending on how that turns out we may ask you to revert
> 517e1fbeb65f ("mm/usercopy: Drop extra is_vmalloc_or_module() check").

That's fine by me. Let me know what you think would be best.

Laura, I don't see much harm in putting this back in place. It seems
like it's just a matter of efficiency to have it removed?

-Kees

-- 
Kees Cook
Pixel Security
