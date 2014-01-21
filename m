Return-Path: <achandran@mvista.com>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E06072C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 00:15:09 +1100 (EST)
Received: by mail-pb0-f53.google.com with SMTP id md12so3348509pbc.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 05:15:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52DE1559.3010806@windriver.com>
References: <CAFdej02gyEuDDWwBa4wG01NVf_-wOysdWha+mi+Z+0YafiUAGQ@mail.gmail.com>
 <52DCDD6A.8080204@windriver.com>
 <CAFdej02vx3DDYUqG=4mO=B1fFw4apsnUtmjCcYoXDmfGdtNWPQ@mail.gmail.com>
 <52DE1559.3010806@windriver.com>
Date: Tue, 21 Jan 2014 18:45:02 +0530
Message-ID: <CAFdej01tsyJvBu=4yFcNZaa5cdbXLsryYSdF6pzsZPfzFdMB5g@mail.gmail.com>
Subject: Re: KGDB panics on p2020 target
From: Arun Chandran <achandran@mvista.com>
To: =?windows-1252?Q?=93tiejun=2Echen=94?= <tiejun.chen@windriver.com>
Content-Type: multipart/alternative; boundary=047d7b15ad4fcbbc3004f07acb78
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b15ad4fcbbc3004f07acb78
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 12:06 PM, "=E2=80=9Ctiejun.chen=E2=80=9D" <tiejun.c=
hen@windriver.com
> wrote:

> On 01/21/2014 02:04 PM, Arun Chandran wrote:
>
>> On Mon, Jan 20, 2014 at 1:55 PM, "=EF=BF=BDtiejun.chen=EF=BF=BD"
>> <tiejun.chen@windriver.com>wrote:
>>
>>  On 01/17/2014 03:52 PM, Arun Chandran wrote:
>>>
>>>  Hi,
>>>>
>>>> I am testing kgdb on freescale p2020 target.
>>>>
>>>> In target
>>>> ------------
>>>>
>>>> 1)
>>>> root@freescale-p2020ds:~# uname -a
>>>> Linux freescale-p2020ds 3.10.20-rt14+ #9 SMP Thu Jan 16 16:32:15 IST
>>>> 2014
>>>> ppc GNU/Linux
>>>>
>>>> 2)
>>>> root@freescale-p2020ds:~# cat /proc/cpuinfo
>>>> processor       : 0
>>>> cpu             : e500v2
>>>> clock           : 999.990008MHz
>>>> revision        : 4.0 (pvr 8021 1040)
>>>> bogomips        : 124.99
>>>>
>>>> processor       : 1
>>>> cpu             : e500v2
>>>> clock           : 999.990008MHz
>>>> revision        : 4.0 (pvr 8021 1040)
>>>> bogomips        : 124.99
>>>>
>>>> total bogomips  : 249.99
>>>> timebase        : 62499376
>>>> platform        : P2020 DS
>>>> model           : fsl,P2020DS
>>>> Memory          : 768 MB
>>>>
>>>> 3)
>>>> freescale-p2020ds:~# echo "ttyS1,115200" >
>>>> /sys/module/kgdboc/parameters/kgdoc
>>>>
>>>> 4) I set up host (settings given below); Then I send   "SysRq : DEBUG"
>>>>
>>>> In host
>>>> ----------
>>>> (gdb) target remote /dev/ttyS0
>>>> Remote debugging using /dev/ttyS0
>>>> kgdb_breakpoint () at kernel/debug/debug_core.c:1013
>>>> 1013 arch_kgdb_breakpoint();
>>>> (gdb) b sys_sync
>>>> Breakpoint 1 at 0xc0167288: file fs/sync.c, line 103.
>>>> (gdb) c
>>>> Continuing.
>>>>
>>>> I am able to take control in host; after that I am setting breakpoint =
at
>>>> "sys_sync"
>>>>
>>>> In target
>>>> ------------
>>>> root@freescale-p2020ds:~# for i in 1 2 3 4 5 6 7 8 9
>>>>
>>>>  do
>>>>> sync
>>>>> done
>>>>>
>>>>>
>>>> In host
>>>> ----------
>>>> Breakpoint 1, sys_sync () at fs/sync.c:103
>>>> 103 {
>>>> (gdb) c
>>>> Continuing.
>>>>
>>>> Breakpoint is hit only one time instead of 9 times; after that target
>>>> hangs.
>>>>
>>>>
>>> I recommend you try upstream to take a further look at this, instead of
>>> that Freescale distribution. As I recall currently KGDB works well in
>>> 85xx
>>> case in ML.
>>>
>>
>>
>> Many thanks for your suggestion.
>>
>> I tested the same thing on linux-3.12.y (
>> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-
>> stable.git/log/?id=3Drefs%2Ftags%2Fv3.12.8&h=3Dlinux-3.12.y
>> ).
>>
>>
> Please go powerpc tree,
>
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>
> git checkout next
>
>
Yes It works fine on that tree.. Seems my problem is solved by commit
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch=
/powerpc/kernel/kgdb.c?id=3D8258e268c15a29c09d7c88d91a948bdf729433d8

Thank you for the help.

>
>
>> root@p2020ds:~# uname -a
>> Linux freescale-p2020ds 3.12.8 #136 SMP Tue Jan 21 11:14:13 IST 2014 ppc
>> GNU/Linux
>>
>>
>> The breakpoint I placed at "sys_sync" is hit only once. After that my gd=
b
>> command "continue" does not make further
>> hits. And the target is hung. It is not even responding to my further
>> sending of "SysRq : DEBUG"
>>
>> I have attached my .config
>>
>>
>>
>>>
>>>
>>>  Then i tried to send "SysRq : DEBUG" in target kernel panics.
>>>>
>>>> I have pasted the panic below.
>>>>
>>>> #########################################
>>>> SysRq : DEBUG
>>>> Kernel panic - not syncing: Recursive entry to debugger
>>>>
>>>>
>>> The kernel already trap into kgdb_handle_exception() with the debug
>>> exception while triggering that break point, but again you trigger
>>> another
>>> debug exception by SysRq. Actually KGDB can't handle such this recursiv=
e
>>> behavior, so KGDB always call kgdb_reenter_check() to prevent this
>>> scenario
>>> with this call trace.
>>>
>>>
>>>  I am doing it because the target is hung after the initial breakpoint =
is
>> hit.
>>
>
> This is just what I mean. Although looks your kernel is hung, actually
> your kernel is already in kgdb exception handler previously. So after you
> send break by SysRq to debug, its not allowed by current kgdb scheme as I
> said. The following call trace also show this path explicitly.
>
> Tiejun
>
>
>
>>
>>  static int kgdb_reenter_check(struct kgdb_state *ks)
>>> {
>>>          unsigned long addr;
>>>
>>>          if (atomic_read(&kgdb_active) !=3D raw_smp_processor_id())
>>>                  return 0;
>>>          ...
>>>
>>>          if (exception_level > 1) {
>>>                  dump_stack();
>>>                  panic("Recursive entry to debugger");
>>>          }
>>>
>>>
>>> Tiejun
>>>
>>>   CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6
>>>
>>>> Call Trace:
>>>> [effe5d10] [c0008060] show_stack+0x4c/0x168 (unreliable)
>>>> [effe5d50] [c0588878] panic+0xe4/0x224
>>>> [effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/0x1f8
>>>> [effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
>>>> [effe5e00] [c057e7e0] program_check_exception+0x10c/0x264
>>>> [effe5e10] [c000f660] ret_from_except_full+0x0/0x4c
>>>> --- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8
>>>>       LR =3D __handle_sysrq+0x154/0x1cc
>>>> [effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)
>>>> [effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218
>>>> [effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174
>>>> [effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8
>>>> [effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/0x2a8
>>>> [effe5fc0] [c00b5720] handle_irq_event+0x44/0x74
>>>> [effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c
>>>> [effe5ff0] [c000d58c] call_handle_irq+0x18/0x28
>>>> [c4f91b10] [c0004f60] do_IRQ+0x150/0x224
>>>> [c4f91b40] [c000f6ac] ret_from_except+0x0/0x18
>>>> --- Exception: 501 at rpcauth_lookup_credcache+0x138/0x2a4
>>>>       LR =3D rpcauth_lookup_credcache+0xb8/0x2a4
>>>> [c4f91c00] [24002424] 0x24002424 (unreliable)
>>>> [c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac
>>>> [c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/0x124
>>>> [c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330
>>>> [c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4
>>>> [c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8
>>>> [c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c
>>>> [c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/0x168
>>>> [c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/0x194
>>>> [c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8
>>>> [c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824
>>>> [c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/0x8c
>>>> [c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c
>>>> [c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4
>>>> [c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44
>>>> [c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c
>>>> --- Exception: c01 at 0xff08a98
>>>>       LR =3D 0xfed53e8
>>>> CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6
>>>> Call Trace:
>>>> [effe5bb0] [c0008060] show_stack+0x4c/0x168 (unreliable)
>>>> [effe5bf0] [c00b2cac] kgdb_handle_exception+0x1c4/0x1f8
>>>> [effe5c40] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
>>>> [effe5c50] [c057e7e0] program_check_exception+0x10c/0x264
>>>> [effe5c60] [c000f660] ret_from_except_full+0x0/0x4c
>>>> --- Exception: 700 at kgdb_panic_event+0x1c/0x3c
>>>>       LR =3D notifier_call_chain+0x60/0xb0
>>>> [effe5d20] [00000000]    (nil) (unreliable)
>>>> [effe5d40] [c05819dc] __atomic_notifier_call_chain+0x14/0x24
>>>> [effe5d50] [c05888a8] panic+0x114/0x224
>>>> [effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/0x1f8
>>>> [effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
>>>> [effe5e00] [c057e7e0] program_check_exception+0x10c/0x264
>>>> [effe5e10] [c000f660] ret_from_except_full+0x0/0x4c
>>>> --- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8
>>>>       LR =3D __handle_sysrq+0x154/0x1cc
>>>> [effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)
>>>> [effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218
>>>> [effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174
>>>> [effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8
>>>> [effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/0x2a8
>>>> [effe5fc0] [c00b5720] handle_irq_event+0x44/0x74
>>>> [effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c
>>>> [effe5ff0] [c000d58c] call_handle_irq+0x18/0x28
>>>> [c4f91b10] [c0004f60] do_IRQ+0x150/0x224
>>>> [c4f91b40] [c000f6ac] ret_from_except+0x0/0x18
>>>> --- Exception: 501 at rpcauth_lookup_credcache+0x138/0x2a4
>>>>       LR =3D rpcauth_lookup_credcache+0xb8/0x2a4
>>>> [c4f91c00] [24002424] 0x24002424 (unreliable)
>>>> [c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac
>>>> [c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/0x124
>>>> [c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330
>>>> [c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4
>>>> [c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8
>>>> [c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c
>>>> [c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/0x168
>>>> [c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/0x194
>>>> [c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8
>>>> [c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824
>>>> [c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/0x8c
>>>> [c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c
>>>> [c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4
>>>> [c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44
>>>> [c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c
>>>> --- Exception: c01 at 0xff08a98
>>>>       LR =3D 0xfed53e8
>>>>
>>>>
>>>> ########################################################
>>>>
>>>> Could you please share your thoughts on this issue?
>>>>
>>>> I have also attached my kernel .config.
>>>>
>>>> Regards,
>>>> Arun C
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linuxppc-dev mailing list
>>>> Linuxppc-dev@lists.ozlabs.org
>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>
>>>>
>>>>
>>>
>>
>

--047d7b15ad4fcbbc3004f07acb78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Jan 21, 2014 at 12:06 PM, &quot;=E2=80=9Ctiejun.chen=E2=80=
=9D&quot; <span dir=3D"ltr">&lt;<a href=3D"mailto:tiejun.chen@windriver.com=
" target=3D"_blank">tiejun.chen@windriver.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D""><div class=3D"h5">On 01/21/2014 02:04 PM, =
Arun Chandran wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On Mon, Jan 20, 2014 at 1:55 PM, &quot;=EF=BF=BDtiejun.chen=EF=BF=BD&quot;<=
br>
&lt;<a href=3D"mailto:tiejun.chen@windriver.com" target=3D"_blank">tiejun.c=
hen@windriver.com</a>&gt;<u></u>wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On 01/17/2014 03:52 PM, Arun Chandran wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Hi,<br>
<br>
I am testing kgdb on freescale p2020 target.<br>
<br>
In target<br>
------------<br>
<br>
1)<br>
root@freescale-p2020ds:~# uname -a<br>
Linux freescale-p2020ds 3.10.20-rt14+ #9 SMP Thu Jan 16 16:32:15 IST 2014<b=
r>
ppc GNU/Linux<br>
<br>
2)<br>
root@freescale-p2020ds:~# cat /proc/cpuinfo<br>
processor =C2=A0 =C2=A0 =C2=A0 : 0<br>
cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : e500v2<br>
clock =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 999.990008MHz<br>
revision =C2=A0 =C2=A0 =C2=A0 =C2=A0: 4.0 (pvr 8021 1040)<br>
bogomips =C2=A0 =C2=A0 =C2=A0 =C2=A0: 124.99<br>
<br>
processor =C2=A0 =C2=A0 =C2=A0 : 1<br>
cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : e500v2<br>
clock =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 999.990008MHz<br>
revision =C2=A0 =C2=A0 =C2=A0 =C2=A0: 4.0 (pvr 8021 1040)<br>
bogomips =C2=A0 =C2=A0 =C2=A0 =C2=A0: 124.99<br>
<br>
total bogomips =C2=A0: 249.99<br>
timebase =C2=A0 =C2=A0 =C2=A0 =C2=A0: 62499376<br>
platform =C2=A0 =C2=A0 =C2=A0 =C2=A0: P2020 DS<br>
model =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : fsl,P2020DS<br>
Memory =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 768 MB<br>
<br>
3)<br>
freescale-p2020ds:~# echo &quot;ttyS1,115200&quot; &gt;<br>
/sys/module/kgdboc/parameters/<u></u>kgdoc<br>
<br>
4) I set up host (settings given below); Then I send =C2=A0 &quot;SysRq : D=
EBUG&quot;<br>
<br>
In host<br>
----------<br>
(gdb) target remote /dev/ttyS0<br>
Remote debugging using /dev/ttyS0<br>
kgdb_breakpoint () at kernel/debug/debug_core.c:1013<br>
1013 arch_kgdb_breakpoint();<br>
(gdb) b sys_sync<br>
Breakpoint 1 at 0xc0167288: file fs/sync.c, line 103.<br>
(gdb) c<br>
Continuing.<br>
<br>
I am able to take control in host; after that I am setting breakpoint at<br=
>
&quot;sys_sync&quot;<br>
<br>
In target<br>
------------<br>
root@freescale-p2020ds:~# for i in 1 2 3 4 5 6 7 8 9<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
do<br>
sync<br>
done<br>
<br>
</blockquote>
<br>
In host<br>
----------<br>
Breakpoint 1, sys_sync () at fs/sync.c:103<br>
103 {<br>
(gdb) c<br>
Continuing.<br>
<br>
Breakpoint is hit only one time instead of 9 times; after that target<br>
hangs.<br>
<br>
</blockquote>
<br>
I recommend you try upstream to take a further look at this, instead of<br>
that Freescale distribution. As I recall currently KGDB works well in 85xx<=
br>
case in ML.<br>
</blockquote>
<br>
<br>
Many thanks for your suggestion.<br>
<br>
I tested the same thing on linux-3.12.y (<br>
<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable=
.git/log/?id=3Drefs%2Ftags%2Fv3.12.8&amp;h=3Dlinux-3.12.y" target=3D"_blank=
">https://git.kernel.org/cgit/<u></u>linux/kernel/git/stable/linux-<u></u>s=
table.git/log/?id=3Drefs%<u></u>2Ftags%2Fv3.12.8&amp;h=3Dlinux-3.12.<u></u>=
y</a><br>

).<br>
<br>
</blockquote>
<br></div></div>
Please go powerpc tree,<br>
<br>
git clone git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/b=
enh/powerpc.git" target=3D"_blank">git.kernel.org/pub/scm/<u></u>linux/kern=
el/git/benh/powerpc.<u></u>git</a><br>
<br>
git checkout next<div class=3D"im"><br></div></blockquote><div><br></div><d=
iv>Yes It works fine on that tree.. Seems my problem is solved by commit</d=
iv><div><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/li=
nux.git/commit/arch/powerpc/kernel/kgdb.c?id=3D8258e268c15a29c09d7c88d91a94=
8bdf729433d8">https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.g=
it/commit/arch/powerpc/kernel/kgdb.c?id=3D8258e268c15a29c09d7c88d91a948bdf7=
29433d8</a><br>
</div><div><br></div><div>Thank you for the help.</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><di=
v class=3D"im">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
root@p2020ds:~# uname -a<br>
Linux freescale-p2020ds 3.12.8 #136 SMP Tue Jan 21 11:14:13 IST 2014 ppc<br=
>
GNU/Linux<br>
<br>
<br>
The breakpoint I placed at &quot;sys_sync&quot; is hit only once. After tha=
t my gdb<br>
command &quot;continue&quot; does not make further<br>
hits. And the target is hung. It is not even responding to my further<br>
sending of &quot;SysRq : DEBUG&quot;<br>
<br>
I have attached my .config<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Then i tried to send &quot;SysRq : DEBUG&quot; in target kernel panics.<br>
<br>
I have pasted the panic below.<br>
<br>
##############################<u></u>###########<br>
SysRq : DEBUG<br>
Kernel panic - not syncing: Recursive entry to debugger<br>
<br>
</blockquote>
<br>
The kernel already trap into kgdb_handle_exception() with the debug<br>
exception while triggering that break point, but again you trigger another<=
br>
debug exception by SysRq. Actually KGDB can&#39;t handle such this recursiv=
e<br>
behavior, so KGDB always call kgdb_reenter_check() to prevent this scenario=
<br>
with this call trace.<br>
<br>
<br>
</blockquote>
I am doing it because the target is hung after the initial breakpoint is<br=
>
hit.<br>
</blockquote>
<br></div>
This is just what I mean. Although looks your kernel is hung, actually your=
 kernel is already in kgdb exception handler previously. So after you send =
break by SysRq to debug, its not allowed by current kgdb scheme as I said. =
The following call trace also show this path explicitly.<span class=3D""><f=
ont color=3D"#888888"><br>

<br>
Tiejun</font></span><div class=3D""><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
static int kgdb_reenter_check(struct kgdb_state *ks)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long addr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (atomic_read(&amp;kgdb_active) !=3D ra=
w_smp_processor_id())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (exception_level &gt; 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dump_stack();=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panic(&quot;R=
ecursive entry to debugger&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
Tiejun<br>
<br>
=C2=A0 CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Call Trace:<br>
[effe5d10] [c0008060] show_stack+0x4c/0x168 (unreliable)<br>
[effe5d50] [c0588878] panic+0xe4/0x224<br>
[effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/<u></u>0x1f8<br>
[effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/<u></u>0x80<br>
[effe5e00] [c057e7e0] program_check_exception+0x10c/<u></u>0x264<br>
[effe5e10] [c000f660] ret_from_except_full+0x0/0x4c<br>
--- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D __handle_sysrq+0x154/0x1cc<br>
[effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)<br>
[effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218<br>
[effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174<br>
[effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8<br>
[effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/<u></u>0x2a8<br>
[effe5fc0] [c00b5720] handle_irq_event+0x44/0x74<br>
[effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c<br>
[effe5ff0] [c000d58c] call_handle_irq+0x18/0x28<br>
[c4f91b10] [c0004f60] do_IRQ+0x150/0x224<br>
[c4f91b40] [c000f6ac] ret_from_except+0x0/0x18<br>
--- Exception: 501 at rpcauth_lookup_credcache+<u></u>0x138/0x2a4<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D rpcauth_lookup_credcache+0xb8/<u></u>0x2a4<br>
[c4f91c00] [24002424] 0x24002424 (unreliable)<br>
[c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac<br>
[c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/<u></u>0x124<br>
[c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330<br>
[c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4<br>
[c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8<br>
[c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c<br>
[c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/<u></u>0x168<br>
[c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/<u></u>0x194<br>
[c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8<br>
[c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824<br>
[c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/<u></u>0x8c<br>
[c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c<br>
[c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4<br>
[c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44<br>
[c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c<br>
--- Exception: c01 at 0xff08a98<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D 0xfed53e8<br>
CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6<br>
Call Trace:<br>
[effe5bb0] [c0008060] show_stack+0x4c/0x168 (unreliable)<br>
[effe5bf0] [c00b2cac] kgdb_handle_exception+0x1c4/<u></u>0x1f8<br>
[effe5c40] [c0010038] kgdb_handle_breakpoint+0x4c/<u></u>0x80<br>
[effe5c50] [c057e7e0] program_check_exception+0x10c/<u></u>0x264<br>
[effe5c60] [c000f660] ret_from_except_full+0x0/0x4c<br>
--- Exception: 700 at kgdb_panic_event+0x1c/0x3c<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D notifier_call_chain+0x60/0xb0<br>
[effe5d20] [00000000] =C2=A0 =C2=A0(nil) (unreliable)<br>
[effe5d40] [c05819dc] __atomic_notifier_call_chain+<u></u>0x14/0x24<br>
[effe5d50] [c05888a8] panic+0x114/0x224<br>
[effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/<u></u>0x1f8<br>
[effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/<u></u>0x80<br>
[effe5e00] [c057e7e0] program_check_exception+0x10c/<u></u>0x264<br>
[effe5e10] [c000f660] ret_from_except_full+0x0/0x4c<br>
--- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D __handle_sysrq+0x154/0x1cc<br>
[effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)<br>
[effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218<br>
[effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174<br>
[effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8<br>
[effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/<u></u>0x2a8<br>
[effe5fc0] [c00b5720] handle_irq_event+0x44/0x74<br>
[effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c<br>
[effe5ff0] [c000d58c] call_handle_irq+0x18/0x28<br>
[c4f91b10] [c0004f60] do_IRQ+0x150/0x224<br>
[c4f91b40] [c000f6ac] ret_from_except+0x0/0x18<br>
--- Exception: 501 at rpcauth_lookup_credcache+<u></u>0x138/0x2a4<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D rpcauth_lookup_credcache+0xb8/<u></u>0x2a4<br>
[c4f91c00] [24002424] 0x24002424 (unreliable)<br>
[c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac<br>
[c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/<u></u>0x124<br>
[c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330<br>
[c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4<br>
[c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8<br>
[c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c<br>
[c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/<u></u>0x168<br>
[c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/<u></u>0x194<br>
[c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8<br>
[c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824<br>
[c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/<u></u>0x8c<br>
[c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c<br>
[c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4<br>
[c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44<br>
[c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c<br>
--- Exception: c01 at 0xff08a98<br>
=C2=A0 =C2=A0 =C2=A0 LR =3D 0xfed53e8<br>
<br>
<br>
##############################<u></u>##########################<br>
<br>
Could you please share your thoughts on this issue?<br>
<br>
I have also attached my kernel .config.<br>
<br>
Regards,<br>
Arun C<br>
<br>
<br>
<br>
______________________________<u></u>_________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/<u></u>listinfo/linuxppc-dev</a><br>
<br>
<br>
</blockquote>
<br>
</blockquote>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div></div>

--047d7b15ad4fcbbc3004f07acb78--
