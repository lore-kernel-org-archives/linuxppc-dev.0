Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x22e.google.com (mail-ua0-x22e.google.com
 [IPv6:2607:f8b0:400c:c08::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgxLp3DC7zF0xM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 09:01:06 +1100 (AEDT)
Received: by mail-ua0-x22e.google.com with SMTP id q8so12509576uae.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:01:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8737264c91.fsf@vajain21.in.ibm.com>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
 <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
 <8737264c91.fsf@vajain21.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 14 Feb 2018 09:01:02 +1100
Message-ID: <CAKTCnzkBm1L75NZ9n5u6BLHC3y119cfk_RuEJ=8HCxOwhoZO6Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param
 xmon=off
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2018 at 11:35 PM, Vaibhav Jain
<vaibhav@linux.vnet.ibm.com> wrote:
> Thanks for reviewing this patch Balbir
>
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> Any specific issue you've run into without this patch?
> Without this patch since xmon is still accessible via sysrq and there is
> no indication/warning on the xmon console mentioning that its is not
> fully functional. Specifically xmon-console would still allow user to
> set instruction/data breakpoint eventhough they wont work and will
> result in a kernel-oops.
>
> Below is command log illustrating this problem on one of my test system
> where I tried setting an instruction breakpoint on cmdline_proc_show()
> with xmon=off:
>
> ~# cat /proc/cmdline
> root=UUID=248ad10e-a272-4187-8672-5b25f701e8b9 ro xmon=off
>
> ~# echo 'x' > /proc/sysrq-trigger
> [  458.904802] sysrq: SysRq : Entering xmon
>
> [ snip ]
>
> 78:mon> ls cmdline_proc_show
> cmdline_proc_show: c0000000004196e0
> 78:mon> bi c0000000004196e0
> 78:mon> x
>
> ~# cat /proc/cmdline
> [  505.618702] Oops: Exception in kernel mode, sig: 5 [#1]
> [ snip ]
> [  505.620082] NIP [c0000000004196e4] cmdline_proc_show+0x4/0x60
> [  505.620136] LR [c0000000003b1db0] seq_read+0x130/0x5e0
> [  505.620177] Call Trace:
> [  505.620202] [c000200e5078fc00] [c0000000003b1d74] seq_read+0xf4/0x5e0 (unreliable)
> [  505.620267] [c000200e5078fca0] [c00000000040cae0] proc_reg_read+0xb0/0x110
> [  505.620322] [c000200e5078fcf0] [c00000000037687c] __vfs_read+0x6c/0x1b0
> [  505.620376] [c000200e5078fd90] [c000000000376a7c] vfs_read+0xbc/0x1b0
> [  505.620430] [c000200e5078fde0] [c00000000037724c] SyS_read+0x6c/0x110
> [  505.620485] [c000200e5078fe30] [c00000000000b320] system_call+0x58/0x6c
> [  505.620536] Instruction dump:
> [  505.620570] 3c82ff2a 7fe3fb78 38a00000 3884dee0 4bf98c05 60000000 38210030 e8010010
> [  505.620656] ebe1fff8 7c0803a6 4e800020 3c4c00d6 <38422120> 7c0802a6 f8010010 f821ff91
> [  505.620728] ---[ end trace eaf583921860b3de ]---
> [  506.629019]
> Trace/breakpoint trap
> ~#
>
>
>> I presume running xmon=off indicates we don't want xmon to take over in case of
>> panic/die/oops,
> I believe that when xmon console is available it should be fully
> functional rather than partially, otherwise it gets really confusing to
> the user as to why Instruction/Data break points arent working.
>

OK, so kernel breakpoints are broken with xmon=off and lead to oops as
opposed to passing them on to a kprobe handler perhaps?

Balbir Singh.
