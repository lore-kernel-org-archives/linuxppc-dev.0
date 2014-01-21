Return-Path: <achandran@mvista.com>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A24B32C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 17:04:23 +1100 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rp16so2942424pbb.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 22:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52DCDD6A.8080204@windriver.com>
References: <CAFdej02gyEuDDWwBa4wG01NVf_-wOysdWha+mi+Z+0YafiUAGQ@mail.gmail.com>
 <52DCDD6A.8080204@windriver.com>
Date: Tue, 21 Jan 2014 11:34:20 +0530
Message-ID: <CAFdej02vx3DDYUqG=4mO=B1fFw4apsnUtmjCcYoXDmfGdtNWPQ@mail.gmail.com>
Subject: Re: KGDB panics on p2020 target
From: Arun Chandran <achandran@mvista.com>
To: =?windows-1252?Q?=93tiejun=2Echen=94?= <tiejun.chen@windriver.com>
Content-Type: multipart/mixed; boundary=047d7b15ad4f7d7da804f074c770
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b15ad4f7d7da804f074c770
Content-Type: multipart/alternative; boundary=047d7b15ad4f7d7da204f074c76e

--047d7b15ad4f7d7da204f074c76e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 1:55 PM, "=93tiejun.chen=94"
<tiejun.chen@windriver.com>wrote:

> On 01/17/2014 03:52 PM, Arun Chandran wrote:
>
>> Hi,
>>
>> I am testing kgdb on freescale p2020 target.
>>
>> In target
>> ------------
>>
>> 1)
>> root@freescale-p2020ds:~# uname -a
>> Linux freescale-p2020ds 3.10.20-rt14+ #9 SMP Thu Jan 16 16:32:15 IST 201=
4
>> ppc GNU/Linux
>>
>> 2)
>> root@freescale-p2020ds:~# cat /proc/cpuinfo
>> processor       : 0
>> cpu             : e500v2
>> clock           : 999.990008MHz
>> revision        : 4.0 (pvr 8021 1040)
>> bogomips        : 124.99
>>
>> processor       : 1
>> cpu             : e500v2
>> clock           : 999.990008MHz
>> revision        : 4.0 (pvr 8021 1040)
>> bogomips        : 124.99
>>
>> total bogomips  : 249.99
>> timebase        : 62499376
>> platform        : P2020 DS
>> model           : fsl,P2020DS
>> Memory          : 768 MB
>>
>> 3)
>> freescale-p2020ds:~# echo "ttyS1,115200" >
>> /sys/module/kgdboc/parameters/kgdoc
>>
>> 4) I set up host (settings given below); Then I send   "SysRq : DEBUG"
>>
>> In host
>> ----------
>> (gdb) target remote /dev/ttyS0
>> Remote debugging using /dev/ttyS0
>> kgdb_breakpoint () at kernel/debug/debug_core.c:1013
>> 1013 arch_kgdb_breakpoint();
>> (gdb) b sys_sync
>> Breakpoint 1 at 0xc0167288: file fs/sync.c, line 103.
>> (gdb) c
>> Continuing.
>>
>> I am able to take control in host; after that I am setting breakpoint at
>> "sys_sync"
>>
>> In target
>> ------------
>> root@freescale-p2020ds:~# for i in 1 2 3 4 5 6 7 8 9
>>
>>> do
>>> sync
>>> done
>>>
>>
>> In host
>> ----------
>> Breakpoint 1, sys_sync () at fs/sync.c:103
>> 103 {
>> (gdb) c
>> Continuing.
>>
>> Breakpoint is hit only one time instead of 9 times; after that target
>> hangs.
>>
>
> I recommend you try upstream to take a further look at this, instead of
> that Freescale distribution. As I recall currently KGDB works well in 85x=
x
> case in ML.


Many thanks for your suggestion.

I tested the same thing on linux-3.12.y (
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/log/?i=
d=3Drefs%2Ftags%2Fv3.12.8&h=3Dlinux-3.12.y
).


root@p2020ds:~# uname -a
Linux freescale-p2020ds 3.12.8 #136 SMP Tue Jan 21 11:14:13 IST 2014 ppc
GNU/Linux


The breakpoint I placed at "sys_sync" is hit only once. After that my gdb
command "continue" does not make further
hits. And the target is hung. It is not even responding to my further
sending of "SysRq : DEBUG"

I have attached my .config


>
>
>
>> Then i tried to send "SysRq : DEBUG" in target kernel panics.
>>
>> I have pasted the panic below.
>>
>> #########################################
>> SysRq : DEBUG
>> Kernel panic - not syncing: Recursive entry to debugger
>>
>
> The kernel already trap into kgdb_handle_exception() with the debug
> exception while triggering that break point, but again you trigger anothe=
r
> debug exception by SysRq. Actually KGDB can't handle such this recursive
> behavior, so KGDB always call kgdb_reenter_check() to prevent this scenar=
io
> with this call trace.
>
>
I am doing it because the target is hung after the initial breakpoint is
hit.


> static int kgdb_reenter_check(struct kgdb_state *ks)
> {
>         unsigned long addr;
>
>         if (atomic_read(&kgdb_active) !=3D raw_smp_processor_id())
>                 return 0;
>         ...
>
>         if (exception_level > 1) {
>                 dump_stack();
>                 panic("Recursive entry to debugger");
>         }
>
>
> Tiejun
>
>  CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6
>> Call Trace:
>> [effe5d10] [c0008060] show_stack+0x4c/0x168 (unreliable)
>> [effe5d50] [c0588878] panic+0xe4/0x224
>> [effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/0x1f8
>> [effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
>> [effe5e00] [c057e7e0] program_check_exception+0x10c/0x264
>> [effe5e10] [c000f660] ret_from_except_full+0x0/0x4c
>> --- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8
>>      LR =3D __handle_sysrq+0x154/0x1cc
>> [effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)
>> [effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218
>> [effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174
>> [effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8
>> [effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/0x2a8
>> [effe5fc0] [c00b5720] handle_irq_event+0x44/0x74
>> [effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c
>> [effe5ff0] [c000d58c] call_handle_irq+0x18/0x28
>> [c4f91b10] [c0004f60] do_IRQ+0x150/0x224
>> [c4f91b40] [c000f6ac] ret_from_except+0x0/0x18
>> --- Exception: 501 at rpcauth_lookup_credcache+0x138/0x2a4
>>      LR =3D rpcauth_lookup_credcache+0xb8/0x2a4
>> [c4f91c00] [24002424] 0x24002424 (unreliable)
>> [c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac
>> [c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/0x124
>> [c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330
>> [c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4
>> [c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8
>> [c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c
>> [c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/0x168
>> [c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/0x194
>> [c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8
>> [c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824
>> [c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/0x8c
>> [c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c
>> [c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4
>> [c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44
>> [c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c
>> --- Exception: c01 at 0xff08a98
>>      LR =3D 0xfed53e8
>> CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6
>> Call Trace:
>> [effe5bb0] [c0008060] show_stack+0x4c/0x168 (unreliable)
>> [effe5bf0] [c00b2cac] kgdb_handle_exception+0x1c4/0x1f8
>> [effe5c40] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
>> [effe5c50] [c057e7e0] program_check_exception+0x10c/0x264
>> [effe5c60] [c000f660] ret_from_except_full+0x0/0x4c
>> --- Exception: 700 at kgdb_panic_event+0x1c/0x3c
>>      LR =3D notifier_call_chain+0x60/0xb0
>> [effe5d20] [00000000]    (nil) (unreliable)
>> [effe5d40] [c05819dc] __atomic_notifier_call_chain+0x14/0x24
>> [effe5d50] [c05888a8] panic+0x114/0x224
>> [effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/0x1f8
>> [effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
>> [effe5e00] [c057e7e0] program_check_exception+0x10c/0x264
>> [effe5e10] [c000f660] ret_from_except_full+0x0/0x4c
>> --- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8
>>      LR =3D __handle_sysrq+0x154/0x1cc
>> [effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)
>> [effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218
>> [effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174
>> [effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8
>> [effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/0x2a8
>> [effe5fc0] [c00b5720] handle_irq_event+0x44/0x74
>> [effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c
>> [effe5ff0] [c000d58c] call_handle_irq+0x18/0x28
>> [c4f91b10] [c0004f60] do_IRQ+0x150/0x224
>> [c4f91b40] [c000f6ac] ret_from_except+0x0/0x18
>> --- Exception: 501 at rpcauth_lookup_credcache+0x138/0x2a4
>>      LR =3D rpcauth_lookup_credcache+0xb8/0x2a4
>> [c4f91c00] [24002424] 0x24002424 (unreliable)
>> [c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac
>> [c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/0x124
>> [c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330
>> [c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4
>> [c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8
>> [c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c
>> [c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/0x168
>> [c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/0x194
>> [c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8
>> [c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824
>> [c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/0x8c
>> [c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c
>> [c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4
>> [c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44
>> [c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c
>> --- Exception: c01 at 0xff08a98
>>      LR =3D 0xfed53e8
>>
>>
>> ########################################################
>>
>> Could you please share your thoughts on this issue?
>>
>> I have also attached my kernel .config.
>>
>> Regards,
>> Arun C
>>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>

--047d7b15ad4f7d7da204f074c76e
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Jan 20, 2014 at 1:55 PM, &quot;=93tiejun.chen=94&quot; <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:tiejun.chen@windriver.com" target=3D"_b=
lank">tiejun.chen@windriver.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D""><div class=3D"h5">On 01/17/2014 03:52 PM, =
Arun Chandran wrote:<br>

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
processor =A0 =A0 =A0 : 0<br>
cpu =A0 =A0 =A0 =A0 =A0 =A0 : e500v2<br>
clock =A0 =A0 =A0 =A0 =A0 : 999.990008MHz<br>
revision =A0 =A0 =A0 =A0: 4.0 (pvr 8021 1040)<br>
bogomips =A0 =A0 =A0 =A0: 124.99<br>
<br>
processor =A0 =A0 =A0 : 1<br>
cpu =A0 =A0 =A0 =A0 =A0 =A0 : e500v2<br>
clock =A0 =A0 =A0 =A0 =A0 : 999.990008MHz<br>
revision =A0 =A0 =A0 =A0: 4.0 (pvr 8021 1040)<br>
bogomips =A0 =A0 =A0 =A0: 124.99<br>
<br>
total bogomips =A0: 249.99<br>
timebase =A0 =A0 =A0 =A0: 62499376<br>
platform =A0 =A0 =A0 =A0: P2020 DS<br>
model =A0 =A0 =A0 =A0 =A0 : fsl,P2020DS<br>
Memory =A0 =A0 =A0 =A0 =A0: 768 MB<br>
<br>
3)<br>
freescale-p2020ds:~# echo &quot;ttyS1,115200&quot; &gt;<br>
/sys/module/kgdboc/parameters/<u></u>kgdoc<br>
<br>
4) I set up host (settings given below); Then I send =A0 &quot;SysRq : DEBU=
G&quot;<br>
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
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
do<br>
sync<br>
done<br>
</blockquote>
<br>
In host<br>
----------<br>
Breakpoint 1, sys_sync () at fs/sync.c:103<br>
103 {<br>
(gdb) c<br>
Continuing.<br>
<br>
Breakpoint is hit only one time instead of 9 times; after that target hangs=
.<br>
</blockquote>
<br></div></div>
I recommend you try upstream to take a further look at this, instead of tha=
t Freescale distribution. As I recall currently KGDB works well in 85xx cas=
e in ML.</blockquote><div><br></div><div>Many thanks for your suggestion.</=
div>
<div><br></div><div>I tested the same thing on=A0linux-3.12.y (</div><div><=
a href=3D"https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.=
git/log/?id=3Drefs%2Ftags%2Fv3.12.8&amp;h=3Dlinux-3.12.y">https://git.kerne=
l.org/cgit/linux/kernel/git/stable/linux-stable.git/log/?id=3Drefs%2Ftags%2=
Fv3.12.8&amp;h=3Dlinux-3.12.y</a>).<br>
</div><div><br></div><div><br></div><div><div>root@p2020ds:~# uname -a</div=
><div>Linux freescale-p2020ds 3.12.8 #136 SMP Tue Jan 21 11:14:13 IST 2014 =
ppc GNU/Linux</div></div><div><br></div><div><br></div><div>The breakpoint =
I placed at &quot;sys_sync&quot; is hit only once. After that my gdb comman=
d &quot;continue&quot; does not make further=A0</div>
<div>hits. And the target is hung. It is not even responding to my further =
sending of &quot;SysRq : DEBUG&quot;</div><div><br></div><div>I have attach=
ed my .config</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,2=
04,204);border-left-style:solid;padding-left:1ex">
<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
Then i tried to send &quot;SysRq : DEBUG&quot; in target kernel panics.<br>
<br>
I have pasted the panic below.<br>
<br>
##############################<u></u>###########<br>
SysRq : DEBUG<br>
Kernel panic - not syncing: Recursive entry to debugger<br>
</blockquote>
<br></div>
The kernel already trap into kgdb_handle_exception() with the debug excepti=
on while triggering that break point, but again you trigger another debug e=
xception by SysRq. Actually KGDB can&#39;t handle such this recursive behav=
ior, so KGDB always call kgdb_reenter_check() to prevent this scenario with=
 this call trace.<br>

<br></blockquote><div>=A0</div><div>I am doing it because the target is hun=
g after the initial breakpoint is hit.</div><div>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">

static int kgdb_reenter_check(struct kgdb_state *ks)<br>
{<br>
=A0 =A0 =A0 =A0 unsigned long addr;<br>
<br>
=A0 =A0 =A0 =A0 if (atomic_read(&amp;kgdb_active) !=3D raw_smp_processor_id=
())<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
=A0 =A0 =A0 =A0 ...<br>
<br>
=A0 =A0 =A0 =A0 if (exception_level &gt; 1) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dump_stack();<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 panic(&quot;Recursive entry to debugger&quo=
t;);<br>
=A0 =A0 =A0 =A0 }<br>
<br>
<br>
Tiejun =A0<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div><div class=3D"h5">
CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6<br>
Call Trace:<br>
[effe5d10] [c0008060] show_stack+0x4c/0x168 (unreliable)<br>
[effe5d50] [c0588878] panic+0xe4/0x224<br>
[effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/<u></u>0x1f8<br>
[effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/<u></u>0x80<br>
[effe5e00] [c057e7e0] program_check_exception+0x10c/<u></u>0x264<br>
[effe5e10] [c000f660] ret_from_except_full+0x0/0x4c<br>
--- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8<br>
=A0 =A0 =A0LR =3D __handle_sysrq+0x154/0x1cc<br>
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
=A0 =A0 =A0LR =3D rpcauth_lookup_credcache+0xb8/<u></u>0x2a4<br>
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
=A0 =A0 =A0LR =3D 0xfed53e8<br>
CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6<br>
Call Trace:<br>
[effe5bb0] [c0008060] show_stack+0x4c/0x168 (unreliable)<br>
[effe5bf0] [c00b2cac] kgdb_handle_exception+0x1c4/<u></u>0x1f8<br>
[effe5c40] [c0010038] kgdb_handle_breakpoint+0x4c/<u></u>0x80<br>
[effe5c50] [c057e7e0] program_check_exception+0x10c/<u></u>0x264<br>
[effe5c60] [c000f660] ret_from_except_full+0x0/0x4c<br>
--- Exception: 700 at kgdb_panic_event+0x1c/0x3c<br>
=A0 =A0 =A0LR =3D notifier_call_chain+0x60/0xb0<br>
[effe5d20] [00000000] =A0 =A0(nil) (unreliable)<br>
[effe5d40] [c05819dc] __atomic_notifier_call_chain+<u></u>0x14/0x24<br>
[effe5d50] [c05888a8] panic+0x114/0x224<br>
[effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/<u></u>0x1f8<br>
[effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/<u></u>0x80<br>
[effe5e00] [c057e7e0] program_check_exception+0x10c/<u></u>0x264<br>
[effe5e10] [c000f660] ret_from_except_full+0x0/0x4c<br>
--- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8<br>
=A0 =A0 =A0LR =3D __handle_sysrq+0x154/0x1cc<br>
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
=A0 =A0 =A0LR =3D rpcauth_lookup_credcache+0xb8/<u></u>0x2a4<br>
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
=A0 =A0 =A0LR =3D 0xfed53e8<br>
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
<br></div></div>
______________________________<u></u>_________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/<u></u>listinfo/linuxppc-dev</a><br>
<br>
</blockquote>
<br>
</blockquote></div><br></div></div>

--047d7b15ad4f7d7da204f074c76e--

--047d7b15ad4f7d7da804f074c770
Content-Type: application/octet-stream; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqorbvhv0

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L3Bv
d2VycGMgMy4xMi44IEtlcm5lbCBDb25maWd1cmF0aW9uCiMKIyBDT05GSUdfUFBDNjQgaXMgbm90
IHNldAoKIwojIFByb2Nlc3NvciBzdXBwb3J0CiMKIyBDT05GSUdfUFBDX0JPT0szU18zMiBpcyBu
b3Qgc2V0CkNPTkZJR19QUENfODV4eD15CiMgQ09ORklHX1BQQ184eHggaXMgbm90IHNldAojIENP
TkZJR180MHggaXMgbm90IHNldAojIENPTkZJR180NHggaXMgbm90IHNldAojIENPTkZJR19FMjAw
IGlzIG5vdCBzZXQKQ09ORklHX0U1MDA9eQojIENPTkZJR19QUENfRTUwME1DIGlzIG5vdCBzZXQK
Q09ORklHX0ZTTF9FTUJfUEVSRk1PTj15CkNPTkZJR19GU0xfRU1CX1BFUkZfRVZFTlQ9eQpDT05G
SUdfRlNMX0VNQl9QRVJGX0VWRU5UX0U1MDA9eQpDT05GSUdfQk9PS0U9eQpDT05GSUdfRlNMX0JP
T0tFPXkKQ09ORklHX1BQQ19GU0xfQk9PSzNFPXkKIyBDT05GSUdfUEhZU182NEJJVCBpcyBub3Qg
c2V0CkNPTkZJR19TUEU9eQpDT05GSUdfUFBDX01NVV9OT0hBU0g9eQpDT05GSUdfUFBDX0JPT0sz
RV9NTVU9eQojIENPTkZJR19QUENfTU1fU0xJQ0VTIGlzIG5vdCBzZXQKQ09ORklHX1NNUD15CkNP
TkZJR19OUl9DUFVTPTIKQ09ORklHX1BQQ19ET09SQkVMTD15CkNPTkZJR19QUEMzMj15CkNPTkZJ
R18zMkJJVD15CkNPTkZJR19XT1JEX1NJWkU9MzIKIyBDT05GSUdfQVJDSF9QSFlTX0FERFJfVF82
NEJJVCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfRE1BX0FERFJfVF82NEJJVCBpcyBub3Qgc2V0
CkNPTkZJR19NTVU9eQojIENPTkZJR19IQVZFX1NFVFVQX1BFUl9DUFVfQVJFQSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FRURfUEVSX0NQVV9FTUJFRF9GSVJTVF9DSFVOSyBpcyBub3Qgc2V0CkNPTkZJ
R19OUl9JUlFTPTUxMgpDT05GSUdfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09ORklHX0hBVkVfTEFU
RU5DWVRPUF9TVVBQT1JUPXkKQ09ORklHX1RSQUNFX0lSUUZMQUdTX1NVUFBPUlQ9eQpDT05GSUdf
TE9DS0RFUF9TVVBQT1JUPXkKQ09ORklHX1JXU0VNX1hDSEdBRERfQUxHT1JJVEhNPXkKQ09ORklH
X0FSQ0hfSEFTX0lMT0cyX1UzMj15CkNPTkZJR19HRU5FUklDX0hXRUlHSFQ9eQpDT05GSUdfUFBD
PXkKQ09ORklHX0VBUkxZX1BSSU5USz15CkNPTkZJR19HRU5FUklDX05WUkFNPXkKQ09ORklHX1ND
SEVEX09NSVRfRlJBTUVfUE9JTlRFUj15CkNPTkZJR19BUkNIX01BWV9IQVZFX1BDX0ZEQz15CkNP
TkZJR19QUENfT0Y9eQpDT05GSUdfUFBDX1VEQkdfMTY1NTA9eQpDT05GSUdfR0VORVJJQ19UQlNZ
TkM9eQpDT05GSUdfQVVESVRfQVJDSD15CkNPTkZJR19HRU5FUklDX0JVRz15CiMgQ09ORklHX0VQ
QVBSX0JPT1QgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9VSU1BR0U9eQpDT05GSUdfQVJDSF9I
SUJFUk5BVElPTl9QT1NTSUJMRT15CkNPTkZJR19BUkNIX1NVU1BFTkRfUE9TU0lCTEU9eQojIENP
TkZJR19QUENfRENSX05BVElWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19EQ1JfTU1JTyBpcyBu
b3Qgc2V0CkNPTkZJR19BUkNIX1NVUFBPUlRTX0RFQlVHX1BBR0VBTExPQz15CkNPTkZJR19BUkNI
X1NVUFBPUlRTX1VQUk9CRVM9eQpDT05GSUdfUFBDX0FEVl9ERUJVR19SRUdTPXkKQ09ORklHX1BQ
Q19BRFZfREVCVUdfSUFDUz0yCkNPTkZJR19QUENfQURWX0RFQlVHX0RBQ1M9MgpDT05GSUdfUFBD
X0FEVl9ERUJVR19EVkNTPTAKQ09ORklHX1BQQ19FTVVMQVRFX1NTVEVQPXkKQ09ORklHX0RFRkNP
TkZJR19MSVNUPSIvbGliL21vZHVsZXMvJFVOQU1FX1JFTEVBU0UvLmNvbmZpZyIKQ09ORklHX0lS
UV9XT1JLPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0lOSVRfRU5WX0FSR19MSU1JVD0z
MgpDT05GSUdfQ1JPU1NfQ09NUElMRT0iIgojIENPTkZJR19DT01QSUxFX1RFU1QgaXMgbm90IHNl
dApDT05GSUdfTE9DQUxWRVJTSU9OPSIiCiMgQ09ORklHX0xPQ0FMVkVSU0lPTl9BVVRPIGlzIG5v
dCBzZXQKQ09ORklHX0RFRkFVTFRfSE9TVE5BTUU9Iihub25lKSIKQ09ORklHX1NXQVA9eQpDT05G
SUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CkNPTkZJR19QT1NJWF9NUVVFVUU9
eQpDT05GSUdfUE9TSVhfTVFVRVVFX1NZU0NUTD15CiMgQ09ORklHX0ZIQU5ETEUgaXMgbm90IHNl
dApDT05GSUdfQVVESVQ9eQojIENPTkZJR19BVURJVFNZU0NBTEwgaXMgbm90IHNldAojIENPTkZJ
R19BVURJVF9MT0dJTlVJRF9JTU1VVEFCTEUgaXMgbm90IHNldAoKIwojIElSUSBzdWJzeXN0ZW0K
IwpDT05GSUdfR0VORVJJQ19JUlFfU0hPVz15CkNPTkZJR19HRU5FUklDX0lSUV9TSE9XX0xFVkVM
PXkKQ09ORklHX0lSUV9ET01BSU49eQojIENPTkZJR19JUlFfRE9NQUlOX0RFQlVHIGlzIG5vdCBz
ZXQKQ09ORklHX0lSUV9GT1JDRURfVEhSRUFESU5HPXkKQ09ORklHX1NQQVJTRV9JUlE9eQpDT05G
SUdfR0VORVJJQ19USU1FX1ZTWVNDQUxMX09MRD15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRT
PXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQpDT05GSUdfR0VORVJJQ19DTU9T
X1VQREFURT15CgojCiMgVGltZXJzIHN1YnN5c3RlbQojCkNPTkZJR19USUNLX09ORVNIT1Q9eQpD
T05GSUdfTk9fSFpfQ09NTU9OPXkKIyBDT05GSUdfSFpfUEVSSU9ESUMgaXMgbm90IHNldApDT05G
SUdfTk9fSFpfSURMRT15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JFU19USU1FUlM9eQoK
IwojIENQVS9UYXNrIHRpbWUgYW5kIHN0YXRzIGFjY291bnRpbmcKIwpDT05GSUdfVElDS19DUFVf
QUNDT1VOVElORz15CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NUPXkKIyBDT05GSUdfQlNEX1BST0NF
U1NfQUNDVF9WMyBpcyBub3Qgc2V0CiMgQ09ORklHX1RBU0tTVEFUUyBpcyBub3Qgc2V0CgojCiMg
UkNVIFN1YnN5c3RlbQojCkNPTkZJR19UUkVFX1JDVT15CiMgQ09ORklHX1BSRUVNUFRfUkNVIGlz
IG5vdCBzZXQKQ09ORklHX1JDVV9TVEFMTF9DT01NT049eQpDT05GSUdfUkNVX0ZBTk9VVD0zMgpD
T05GSUdfUkNVX0ZBTk9VVF9MRUFGPTE2CiMgQ09ORklHX1JDVV9GQU5PVVRfRVhBQ1QgaXMgbm90
IHNldAojIENPTkZJR19SQ1VfRkFTVF9OT19IWiBpcyBub3Qgc2V0CiMgQ09ORklHX1RSRUVfUkNV
X1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX05PQ0JfQ1BVIGlzIG5vdCBzZXQKQ09ORklH
X0lLQ09ORklHPXkKQ09ORklHX0lLQ09ORklHX1BST0M9eQpDT05GSUdfTE9HX0JVRl9TSElGVD0x
NApDT05GSUdfQ0dST1VQUz15CiMgQ09ORklHX0NHUk9VUF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJ
R19DR1JPVVBfRlJFRVpFUj15CkNPTkZJR19DR1JPVVBfREVWSUNFPXkKQ09ORklHX0NQVVNFVFM9
eQpDT05GSUdfUFJPQ19QSURfQ1BVU0VUPXkKQ09ORklHX0NHUk9VUF9DUFVBQ0NUPXkKQ09ORklH
X1JFU09VUkNFX0NPVU5URVJTPXkKQ09ORklHX01FTUNHPXkKQ09ORklHX01FTUNHX1NXQVA9eQoj
IENPTkZJR19NRU1DR19TV0FQX0VOQUJMRUQgaXMgbm90IHNldApDT05GSUdfTUVNQ0dfS01FTT15
CkNPTkZJR19DR1JPVVBfUEVSRj15CkNPTkZJR19DR1JPVVBfU0NIRUQ9eQpDT05GSUdfRkFJUl9H
Uk9VUF9TQ0hFRD15CkNPTkZJR19DRlNfQkFORFdJRFRIPXkKIyBDT05GSUdfUlRfR1JPVVBfU0NI
RUQgaXMgbm90IHNldApDT05GSUdfQkxLX0NHUk9VUD15CiMgQ09ORklHX0RFQlVHX0JMS19DR1JP
VVAgaXMgbm90IHNldAojIENPTkZJR19DSEVDS1BPSU5UX1JFU1RPUkUgaXMgbm90IHNldApDT05G
SUdfTkFNRVNQQUNFUz15CkNPTkZJR19VVFNfTlM9eQpDT05GSUdfSVBDX05TPXkKQ09ORklHX1VT
RVJfTlM9eQpDT05GSUdfUElEX05TPXkKQ09ORklHX05FVF9OUz15CkNPTkZJR19VSURHSURfU1RS
SUNUX1RZUEVfQ0hFQ0tTPXkKQ09ORklHX1NDSEVEX0FVVE9HUk9VUD15CkNPTkZJR19NTV9PV05F
Uj15CiMgQ09ORklHX1NZU0ZTX0RFUFJFQ0FURUQgaXMgbm90IHNldAojIENPTkZJR19SRUxBWSBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lOSVRSRD15CkNPTkZJR19JTklUUkFNRlNfU09VUkNF
PSIiCkNPTkZJR19SRF9HWklQPXkKQ09ORklHX1JEX0JaSVAyPXkKQ09ORklHX1JEX0xaTUE9eQpD
T05GSUdfUkRfWFo9eQpDT05GSUdfUkRfTFpPPXkKIyBDT05GSUdfUkRfTFo0IGlzIG5vdCBzZXQK
IyBDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApDT05GSUdfU1lTQ1RMPXkK
Q09ORklHX0FOT05fSU5PREVTPXkKQ09ORklHX1NZU0NUTF9FWENFUFRJT05fVFJBQ0U9eQpDT05G
SUdfRVhQRVJUPXkKQ09ORklHX1NZU0NUTF9TWVNDQUxMPXkKQ09ORklHX0tBTExTWU1TPXkKIyBD
T05GSUdfS0FMTFNZTVNfQUxMIGlzIG5vdCBzZXQKQ09ORklHX1BSSU5USz15CkNPTkZJR19CVUc9
eQpDT05GSUdfRUxGX0NPUkU9eQpDT05GSUdfQkFTRV9GVUxMPXkKQ09ORklHX0ZVVEVYPXkKQ09O
RklHX0VQT0xMPXkKQ09ORklHX1NJR05BTEZEPXkKQ09ORklHX1RJTUVSRkQ9eQpDT05GSUdfRVZF
TlRGRD15CkNPTkZJR19TSE1FTT15CkNPTkZJR19BSU89eQpDT05GSUdfRU1CRURERUQ9eQpDT05G
SUdfSEFWRV9QRVJGX0VWRU5UUz15CgojCiMgS2VybmVsIFBlcmZvcm1hbmNlIEV2ZW50cyBBbmQg
Q291bnRlcnMKIwpDT05GSUdfUEVSRl9FVkVOVFM9eQojIENPTkZJR19ERUJVR19QRVJGX1VTRV9W
TUFMTE9DIGlzIG5vdCBzZXQKQ09ORklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKQ09ORklHX1NMVUJf
REVCVUc9eQojIENPTkZJR19DT01QQVRfQlJLIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xBQiBpcyBu
b3Qgc2V0CkNPTkZJR19TTFVCPXkKIyBDT05GSUdfU0xPQiBpcyBub3Qgc2V0CkNPTkZJR19TTFVC
X0NQVV9QQVJUSUFMPXkKIyBDT05GSUdfUFJPRklMSU5HIGlzIG5vdCBzZXQKQ09ORklHX1RSQUNF
UE9JTlRTPXkKQ09ORklHX0hBVkVfT1BST0ZJTEU9eQpDT05GSUdfS1BST0JFUz15CiMgQ09ORklH
X0pVTVBfTEFCRUwgaXMgbm90IHNldApDT05GSUdfVVBST0JFUz15CiMgQ09ORklHX0hBVkVfNjRC
SVRfQUxJR05FRF9BQ0NFU1MgaXMgbm90IHNldApDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElH
TkVEX0FDQ0VTUz15CkNPTkZJR19BUkNIX1VTRV9CVUlMVElOX0JTV0FQPXkKQ09ORklHX0tSRVRQ
Uk9CRVM9eQpDT05GSUdfSEFWRV9JT1JFTUFQX1BST1Q9eQpDT05GSUdfSEFWRV9LUFJPQkVTPXkK
Q09ORklHX0hBVkVfS1JFVFBST0JFUz15CkNPTkZJR19IQVZFX0FSQ0hfVFJBQ0VIT09LPXkKQ09O
RklHX0hBVkVfRE1BX0FUVFJTPXkKQ09ORklHX1VTRV9HRU5FUklDX1NNUF9IRUxQRVJTPXkKQ09O
RklHX0dFTkVSSUNfU01QX0lETEVfVEhSRUFEPXkKQ09ORklHX0hBVkVfUkVHU19BTkRfU1RBQ0tf
QUNDRVNTX0FQST15CkNPTkZJR19IQVZFX0RNQV9BUElfREVCVUc9eQpDT05GSUdfSEFWRV9BUkNI
X0pVTVBfTEFCRUw9eQpDT05GSUdfSEFWRV9SQ1VfVEFCTEVfRlJFRT15CkNPTkZJR19BUkNIX0hB
VkVfTk1JX1NBRkVfQ01QWENIRz15CkNPTkZJR19BUkNIX1dBTlRfSVBDX1BBUlNFX1ZFUlNJT049
eQpDT05GSUdfSEFWRV9NT0RfQVJDSF9TUEVDSUZJQz15CkNPTkZJR19NT0RVTEVTX1VTRV9FTEZf
UkVMQT15CkNPTkZJR19DTE9ORV9CQUNLV0FSRFM9eQpDT05GSUdfT0xEX1NJR1NVU1BFTkQ9eQpD
T05GSUdfT0xEX1NJR0FDVElPTj15CgojCiMgR0NPVi1iYXNlZCBrZXJuZWwgcHJvZmlsaW5nCiMK
IyBDT05GSUdfR0NPVl9LRVJORUwgaXMgbm90IHNldAojIENPTkZJR19IQVZFX0dFTkVSSUNfRE1B
X0NPSEVSRU5UIGlzIG5vdCBzZXQKQ09ORklHX1NMQUJJTkZPPXkKQ09ORklHX1JUX01VVEVYRVM9
eQpDT05GSUdfQkFTRV9TTUFMTD0wCkNPTkZJR19NT0RVTEVTPXkKIyBDT05GSUdfTU9EVUxFX0ZP
UkNFX0xPQUQgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVf
Rk9SQ0VfVU5MT0FEPXkKQ09ORklHX01PRFZFUlNJT05TPXkKIyBDT05GSUdfTU9EVUxFX1NSQ1ZF
UlNJT05fQUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NJRyBpcyBub3Qgc2V0CkNPTkZJ
R19TVE9QX01BQ0hJTkU9eQpDT05GSUdfQkxPQ0s9eQpDT05GSUdfTEJEQUY9eQpDT05GSUdfQkxL
X0RFVl9CU0c9eQpDT05GSUdfQkxLX0RFVl9CU0dMSUI9eQpDT05GSUdfQkxLX0RFVl9JTlRFR1JJ
VFk9eQpDT05GSUdfQkxLX0RFVl9USFJPVFRMSU5HPXkKIyBDT05GSUdfQkxLX0NNRExJTkVfUEFS
U0VSIGlzIG5vdCBzZXQKCiMKIyBQYXJ0aXRpb24gVHlwZXMKIwpDT05GSUdfUEFSVElUSU9OX0FE
VkFOQ0VEPXkKIyBDT05GSUdfQUNPUk5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQUlY
X1BBUlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19PU0ZfUEFSVElUSU9OPXkKQ09ORklHX0FNSUdB
X1BBUlRJVElPTj15CiMgQ09ORklHX0FUQVJJX1BBUlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19N
QUNfUEFSVElUSU9OPXkKQ09ORklHX01TRE9TX1BBUlRJVElPTj15CkNPTkZJR19CU0RfRElTS0xB
QkVMPXkKQ09ORklHX01JTklYX1NVQlBBUlRJVElPTj15CkNPTkZJR19TT0xBUklTX1g4Nl9QQVJU
SVRJT049eQpDT05GSUdfVU5JWFdBUkVfRElTS0xBQkVMPXkKIyBDT05GSUdfTERNX1BBUlRJVElP
TiBpcyBub3Qgc2V0CkNPTkZJR19TR0lfUEFSVElUSU9OPXkKIyBDT05GSUdfVUxUUklYX1BBUlRJ
VElPTiBpcyBub3Qgc2V0CkNPTkZJR19TVU5fUEFSVElUSU9OPXkKQ09ORklHX0tBUk1BX1BBUlRJ
VElPTj15CkNPTkZJR19FRklfUEFSVElUSU9OPXkKIyBDT05GSUdfU1lTVjY4X1BBUlRJVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NNRExJTkVfUEFSVElUSU9OIGlzIG5vdCBzZXQKCiMKIyBJTyBT
Y2hlZHVsZXJzCiMKQ09ORklHX0lPU0NIRURfTk9PUD15CkNPTkZJR19JT1NDSEVEX0RFQURMSU5F
PXkKQ09ORklHX0lPU0NIRURfQ0ZRPXkKQ09ORklHX0NGUV9HUk9VUF9JT1NDSEVEPXkKIyBDT05G
SUdfREVGQVVMVF9ERUFETElORSBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0NGUT15CiMgQ09O
RklHX0RFRkFVTFRfTk9PUCBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0lPU0NIRUQ9ImNmcSIK
Q09ORklHX1BBREFUQT15CkNPTkZJR19BU04xPW0KQ09ORklHX0lOTElORV9TUElOX1VOTE9DS19J
UlE9eQpDT05GSUdfSU5MSU5FX1JFQURfVU5MT0NLPXkKQ09ORklHX0lOTElORV9SRUFEX1VOTE9D
S19JUlE9eQpDT05GSUdfSU5MSU5FX1dSSVRFX1VOTE9DSz15CkNPTkZJR19JTkxJTkVfV1JJVEVf
VU5MT0NLX0lSUT15CkNPTkZJR19NVVRFWF9TUElOX09OX09XTkVSPXkKQ09ORklHX0ZSRUVaRVI9
eQojIENPTkZJR19QUENfWElDUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19JQ1BfTkFUSVZFIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFBDX0lDUF9IViBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19JQ1Nf
UlRBUyBpcyBub3Qgc2V0CiMgQ09ORklHX0dFX0ZQR0EgaXMgbm90IHNldAoKIwojIFBsYXRmb3Jt
IHN1cHBvcnQKIwojIENPTkZJR19QUENfQ0VMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19DRUxM
X05BVElWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BRMkFEUyBpcyBub3Qgc2V0CkNPTkZJR19GU0xf
U09DX0JPT0tFPXkKIyBDT05GSUdfQlNDOTEzMV9SREIgaXMgbm90IHNldAojIENPTkZJR19DMjkz
X1BDSUUgaXMgbm90IHNldAojIENPTkZJR19NUEM4NTQwX0FEUyBpcyBub3Qgc2V0CiMgQ09ORklH
X01QQzg1NjBfQURTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDODV4eF9DRFMgaXMgbm90IHNldAoj
IENPTkZJR19NUEM4NXh4X01EUyBpcyBub3Qgc2V0CiMgQ09ORklHX01QQzg1MzZfRFMgaXMgbm90
IHNldApDT05GSUdfTVBDODV4eF9EUz15CiMgQ09ORklHX01QQzg1eHhfUkRCIGlzIG5vdCBzZXQK
IyBDT05GSUdfUDEwMTBfUkRCIGlzIG5vdCBzZXQKIyBDT05GSUdfUDEwMjJfRFMgaXMgbm90IHNl
dAojIENPTkZJR19QMTAyMl9SREsgaXMgbm90IHNldAojIENPTkZJR19QMTAyM19SRFMgaXMgbm90
IHNldAojIENPTkZJR19TT0NSQVRFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0tTSTg1NjAgaXMgbm90
IHNldAojIENPTkZJR19YRVNfTVBDODV4eCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUWF9HUDMgaXMg
bm90IHNldAojIENPTkZJR19UUU04NTQwIGlzIG5vdCBzZXQKIyBDT05GSUdfVFFNODU0MSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RRTTg1NDggaXMgbm90IHNldAojIENPTkZJR19UUU04NTU1IGlzIG5v
dCBzZXQKIyBDT05GSUdfVFFNODU2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NCQzg1NDggaXMgbm90
IHNldAojIENPTkZJR19QUEE4NTQ4IGlzIG5vdCBzZXQKIyBDT05GSUdfR0VfSU1QM0EgaXMgbm90
IHNldAojIENPTkZJR19QMjA0MV9SREIgaXMgbm90IHNldAojIENPTkZJR19QMzA0MV9EUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1A0MDgwX0RTIGlzIG5vdCBzZXQKIyBDT05GSUdfUDUwMjBfRFMgaXMg
bm90IHNldAojIENPTkZJR19QNTA0MF9EUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19RRU1VX0U1
MDAgaXMgbm90IHNldAojIENPTkZJR19QUENfV1NQIGlzIG5vdCBzZXQKIyBDT05GSUdfS1ZNX0dV
RVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfRVBBUFJfUEFSQVZJUlQgaXMgbm90IHNldApDT05GSUdf
UFBDX1NNUF9NVVhFRF9JUEk9eQojIENPTkZJR19JUElDIGlzIG5vdCBzZXQKQ09ORklHX01QSUM9
eQojIENPTkZJR19NUElDX1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0VQQVBSX0hWX1BJ
QyBpcyBub3Qgc2V0CiMgQ09ORklHX01QSUNfV0VJUkQgaXMgbm90IHNldAojIENPTkZJR19NUElD
X01TR1IgaXMgbm90IHNldApDT05GSUdfUFBDX0k4MjU5PXkKIyBDT05GSUdfUFBDX1JUQVMgaXMg
bm90IHNldAojIENPTkZJR19NTUlPX05WUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBJQ19VM19I
VF9JUlFTIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzEwNiBpcyBub3Qgc2V0CiMgQ09ORklH
X1BQQ185NzBfTkFQIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX1A3X05BUCBpcyBub3Qgc2V0Cgoj
CiMgQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nCiMKIyBDT05GSUdfQ1BVX0ZSRVEgaXMgbm90IHNldAoK
IwojIENQVUlkbGUgZHJpdmVyCiMKCiMKIyBDUFUgSWRsZQojCiMgQ09ORklHX0NQVV9JRExFIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVJDSF9ORUVEU19DUFVfSURMRV9DT1VQTEVEIGlzIG5vdCBzZXQK
IyBDT05GSUdfUVVJQ0NfRU5HSU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1BNMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZTTF9VTEkxNTc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0lNUExFX0dQSU8gaXMg
bm90IHNldAoKIwojIEtlcm5lbCBvcHRpb25zCiMKIyBDT05GSUdfSElHSE1FTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0haXzEwMCBpcyBub3Qgc2V0CkNPTkZJR19IWl8yNTA9eQojIENPTkZJR19IWl8z
MDAgaXMgbm90IHNldAojIENPTkZJR19IWl8xMDAwIGlzIG5vdCBzZXQKQ09ORklHX0haPTI1MApD
T05GSUdfU0NIRURfSFJUSUNLPXkKIyBDT05GSUdfUFJFRU1QVF9OT05FIGlzIG5vdCBzZXQKQ09O
RklHX1BSRUVNUFRfVk9MVU5UQVJZPXkKIyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0CkNPTkZJ
R19CSU5GTVRfRUxGPXkKIyBDT05GSUdfQ09SRV9EVU1QX0RFRkFVTFRfRUxGX0hFQURFUlMgaXMg
bm90IHNldApDT05GSUdfQklORk1UX1NDUklQVD15CiMgQ09ORklHX0hBVkVfQU9VVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0JJTkZNVF9NSVNDIGlzIG5vdCBzZXQKQ09ORklHX0NPUkVEVU1QPXkKQ09O
RklHX01BVEhfRU1VTEFUSU9OPXkKQ09ORklHX01BVEhfRU1VTEFUSU9OX0ZVTEw9eQojIENPTkZJ
R19NQVRIX0VNVUxBVElPTl9IV19VTklNUExFTUVOVEVEIGlzIG5vdCBzZXQKQ09ORklHX0lPTU1V
X0hFTFBFUj15CkNPTkZJR19TV0lPVExCPXkKQ09ORklHX0hPVFBMVUdfQ1BVPXkKQ09ORklHX0FS
Q0hfQ1BVX1BST0JFX1JFTEVBU0U9eQpDT05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZX0hPVFBMVUc9
eQpDT05GSUdfQVJDSF9IQVNfV0FMS19NRU1PUlk9eQpDT05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZ
X0hPVFJFTU9WRT15CkNPTkZJR19LRVhFQz15CiMgQ09ORklHX0NSQVNIX0RVTVAgaXMgbm90IHNl
dAojIENPTkZJR19JUlFfQUxMX0NQVVMgaXMgbm90IHNldApDT05GSUdfQVJDSF9GTEFUTUVNX0VO
QUJMRT15CkNPTkZJR19GTEFUTUVNPXkKQ09ORklHX0ZMQVRfTk9ERV9NRU1fTUFQPXkKQ09ORklH
X0hBVkVfTUVNQkxPQ0s9eQpDT05GSUdfSEFWRV9NRU1CTE9DS19OT0RFX01BUD15CiMgQ09ORklH
X0hBVkVfQk9PVE1FTV9JTkZPX05PREUgaXMgbm90IHNldApDT05GSUdfUEFHRUZMQUdTX0VYVEVO
REVEPXkKQ09ORklHX1NQTElUX1BUTE9DS19DUFVTPTQKQ09ORklHX0NPTVBBQ1RJT049eQpDT05G
SUdfTUlHUkFUSU9OPXkKIyBDT05GSUdfUEhZU19BRERSX1RfNjRCSVQgaXMgbm90IHNldApDT05G
SUdfWk9ORV9ETUFfRkxBRz0xCkNPTkZJR19CT1VOQ0U9eQpDT05GSUdfTkVFRF9CT1VOQ0VfUE9P
TD15CkNPTkZJR19WSVJUX1RPX0JVUz15CiMgQ09ORklHX0tTTSBpcyBub3Qgc2V0CkNPTkZJR19E
RUZBVUxUX01NQVBfTUlOX0FERFI9NDA5NgpDT05GSUdfQ1JPU1NfTUVNT1JZX0FUVEFDSD15CiMg
Q09ORklHX0NMRUFOQ0FDSEUgaXMgbm90IHNldAojIENPTkZJR19GUk9OVFNXQVAgaXMgbm90IHNl
dAojIENPTkZJR19DTUEgaXMgbm90IHNldAojIENPTkZJR19aQlVEIGlzIG5vdCBzZXQKQ09ORklH
X1BQQ180S19QQUdFUz15CkNPTkZJR19GT1JDRV9NQVhfWk9ORU9SREVSPTExCiMgQ09ORklHX0NN
RExJTkVfQk9PTCBpcyBub3Qgc2V0CkNPTkZJR19FWFRSQV9UQVJHRVRTPSIiCkNPTkZJR19TVVNQ
RU5EPXkKQ09ORklHX1NVU1BFTkRfRlJFRVpFUj15CiMgQ09ORklHX0hJQkVSTkFUSU9OIGlzIG5v
dCBzZXQKQ09ORklHX1BNX1NMRUVQPXkKQ09ORklHX1BNX1NMRUVQX1NNUD15CiMgQ09ORklHX1BN
X0FVVE9TTEVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BNX1dBS0VMT0NLUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1BNX1JVTlRJTUUgaXMgbm90IHNldApDT05GSUdfUE09eQojIENPTkZJR19QTV9ERUJV
RyBpcyBub3Qgc2V0CiMgQ09ORklHX1dRX1BPV0VSX0VGRklDSUVOVF9ERUZBVUxUIGlzIG5vdCBz
ZXQKQ09ORklHX1NFQ0NPTVA9eQojIENPTkZJR19JU0FfRE1BX0FQSSBpcyBub3Qgc2V0CgojCiMg
QnVzIG9wdGlvbnMKIwpDT05GSUdfWk9ORV9ETUE9eQojIENPTkZJR19ORUVEX0RNQV9NQVBfU1RB
VEUgaXMgbm90IHNldApDT05GSUdfTkVFRF9TR19ETUFfTEVOR1RIPXkKQ09ORklHX0ZTTF9TT0M9
eQpDT05GSUdfRlNMX1BNQz15CkNPTkZJR19GU0xfTEJDPXkKQ09ORklHX1BQQ19QQ0lfQ0hPSUNF
PXkKIyBDT05GSUdfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0RPTUFJTlMgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lfU1lTQ0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDQ0FSRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0hBU19SQVBJRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfTk9OU1RBVElDX0tF
Uk5FTCBpcyBub3Qgc2V0CgojCiMgQWR2YW5jZWQgc2V0dXAKIwojIENPTkZJR19BRFZBTkNFRF9P
UFRJT05TIGlzIG5vdCBzZXQKCiMKIyBEZWZhdWx0IHNldHRpbmdzIGZvciBhZHZhbmNlZCBjb25m
aWd1cmF0aW9uIG9wdGlvbnMgYXJlIHVzZWQKIwpDT05GSUdfTE9XTUVNX1NJWkU9MHgzMDAwMDAw
MApDT05GSUdfTE9XTUVNX0NBTV9OVU09MwpDT05GSUdfUEFHRV9PRkZTRVQ9MHhjMDAwMDAwMApD
T05GSUdfS0VSTkVMX1NUQVJUPTB4YzAwMDAwMDAKQ09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MDAw
MDAwMDAKQ09ORklHX1BIWVNJQ0FMX0FMSUdOPTB4MDQwMDAwMDAKQ09ORklHX1RBU0tfU0laRT0w
eGMwMDAwMDAwCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19Q
QUNLRVQ9eQpDT05GSUdfUEFDS0VUX0RJQUc9eQpDT05GSUdfVU5JWD15CkNPTkZJR19VTklYX0RJ
QUc9bQpDT05GSUdfWEZSTT15CkNPTkZJR19YRlJNX0FMR089eQpDT05GSUdfWEZSTV9VU0VSPXkK
IyBDT05GSUdfWEZSTV9TVUJfUE9MSUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9NSUdSQVRF
IGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9TVEFUSVNUSUNTIGlzIG5vdCBzZXQKQ09ORklHX1hG
Uk1fSVBDT01QPW0KQ09ORklHX05FVF9LRVk9bQojIENPTkZJR19ORVRfS0VZX01JR1JBVEUgaXMg
bm90IHNldApDT05GSUdfSU5FVD15CkNPTkZJR19JUF9NVUxUSUNBU1Q9eQpDT05GSUdfSVBfQURW
QU5DRURfUk9VVEVSPXkKIyBDT05GSUdfSVBfRklCX1RSSUVfU1RBVFMgaXMgbm90IHNldApDT05G
SUdfSVBfTVVMVElQTEVfVEFCTEVTPXkKQ09ORklHX0lQX1JPVVRFX01VTFRJUEFUSD15CkNPTkZJ
R19JUF9ST1VURV9WRVJCT1NFPXkKQ09ORklHX0lQX1JPVVRFX0NMQVNTSUQ9eQpDT05GSUdfSVBf
UE5QPXkKQ09ORklHX0lQX1BOUF9ESENQPXkKQ09ORklHX0lQX1BOUF9CT09UUD15CkNPTkZJR19J
UF9QTlBfUkFSUD15CkNPTkZJR19ORVRfSVBJUD15CiMgQ09ORklHX05FVF9JUEdSRV9ERU1VWCBp
cyBub3Qgc2V0CkNPTkZJR19ORVRfSVBfVFVOTkVMPXkKQ09ORklHX0lQX01ST1VURT15CkNPTkZJ
R19JUF9NUk9VVEVfTVVMVElQTEVfVEFCTEVTPXkKQ09ORklHX0lQX1BJTVNNX1YxPXkKQ09ORklH
X0lQX1BJTVNNX1YyPXkKQ09ORklHX1NZTl9DT09LSUVTPXkKQ09ORklHX05FVF9JUFZUST1tCkNP
TkZJR19JTkVUX0FIPW0KQ09ORklHX0lORVRfRVNQPW0KQ09ORklHX0lORVRfSVBDT01QPW0KQ09O
RklHX0lORVRfWEZSTV9UVU5ORUw9bQpDT05GSUdfSU5FVF9UVU5ORUw9eQpDT05GSUdfSU5FVF9Y
RlJNX01PREVfVFJBTlNQT1JUPXkKQ09ORklHX0lORVRfWEZSTV9NT0RFX1RVTk5FTD15CkNPTkZJ
R19JTkVUX1hGUk1fTU9ERV9CRUVUPXkKQ09ORklHX0lORVRfTFJPPXkKQ09ORklHX0lORVRfRElB
Rz15CkNPTkZJR19JTkVUX1RDUF9ESUFHPXkKQ09ORklHX0lORVRfVURQX0RJQUc9bQpDT05GSUdf
VENQX0NPTkdfQURWQU5DRUQ9eQpDT05GSUdfVENQX0NPTkdfQklDPW0KQ09ORklHX1RDUF9DT05H
X0NVQklDPXkKQ09ORklHX1RDUF9DT05HX1dFU1RXT09EPW0KQ09ORklHX1RDUF9DT05HX0hUQ1A9
bQpDT05GSUdfVENQX0NPTkdfSFNUQ1A9bQpDT05GSUdfVENQX0NPTkdfSFlCTEE9bQpDT05GSUdf
VENQX0NPTkdfVkVHQVM9bQpDT05GSUdfVENQX0NPTkdfU0NBTEFCTEU9bQpDT05GSUdfVENQX0NP
TkdfTFA9bQpDT05GSUdfVENQX0NPTkdfVkVOTz1tCkNPTkZJR19UQ1BfQ09OR19ZRUFIPW0KQ09O
RklHX1RDUF9DT05HX0lMTElOT0lTPW0KQ09ORklHX0RFRkFVTFRfQ1VCSUM9eQojIENPTkZJR19E
RUZBVUxUX1JFTk8gaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0iY3ViaWMiCkNP
TkZJR19UQ1BfTUQ1U0lHPXkKQ09ORklHX0lQVjY9eQpDT05GSUdfSVBWNl9QUklWQUNZPXkKQ09O
RklHX0lQVjZfUk9VVEVSX1BSRUY9eQpDT05GSUdfSVBWNl9ST1VURV9JTkZPPXkKIyBDT05GSUdf
SVBWNl9PUFRJTUlTVElDX0RBRCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUNl9BSD1tCkNPTkZJR19J
TkVUNl9FU1A9bQpDT05GSUdfSU5FVDZfSVBDT01QPW0KQ09ORklHX0lQVjZfTUlQNj15CkNPTkZJ
R19JTkVUNl9YRlJNX1RVTk5FTD1tCkNPTkZJR19JTkVUNl9UVU5ORUw9bQpDT05GSUdfSU5FVDZf
WEZSTV9NT0RFX1RSQU5TUE9SVD1tCkNPTkZJR19JTkVUNl9YRlJNX01PREVfVFVOTkVMPW0KQ09O
RklHX0lORVQ2X1hGUk1fTU9ERV9CRUVUPW0KIyBDT05GSUdfSU5FVDZfWEZSTV9NT0RFX1JPVVRF
T1BUSU1JWkFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfU0lUPW0KIyBDT05GSUdfSVBWNl9T
SVRfNlJEIGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfTkRJU0NfTk9ERVRZUEU9eQpDT05GSUdfSVBW
Nl9UVU5ORUw9bQojIENPTkZJR19JUFY2X0dSRSBpcyBub3Qgc2V0CkNPTkZJR19JUFY2X01VTFRJ
UExFX1RBQkxFUz15CkNPTkZJR19JUFY2X1NVQlRSRUVTPXkKIyBDT05GSUdfSVBWNl9NUk9VVEUg
aXMgbm90IHNldApDT05GSUdfTkVUV09SS19TRUNNQVJLPXkKIyBDT05GSUdfTkVUV09SS19QSFlf
VElNRVNUQU1QSU5HIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUj15CiMgQ09ORklHX05FVEZJ
TFRFUl9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9BRFZBTkNFRCBpcyBub3Qg
c2V0CgojCiMgQ29yZSBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19ORVRGSUxURVJf
TkVUTElOSz1tCkNPTkZJR19ORVRGSUxURVJfTkVUTElOS19MT0c9bQpDT05GSUdfTkZfQ09OTlRS
QUNLPW0KQ09ORklHX05GX0NPTk5UUkFDS19TRUNNQVJLPXkKQ09ORklHX05GX0NPTk5UUkFDS19Q
Uk9DRlM9eQpDT05GSUdfTkZfQ09OTlRSQUNLX0ZUUD1tCkNPTkZJR19ORl9DT05OVFJBQ0tfSVJD
PW0KQ09ORklHX05GX0NPTk5UUkFDS19CUk9BRENBU1Q9bQpDT05GSUdfTkZfQ09OTlRSQUNLX05F
VEJJT1NfTlM9bQpDT05GSUdfTkZfQ09OTlRSQUNLX1NJUD1tCkNPTkZJR19ORl9DVF9ORVRMSU5L
PW0KQ09ORklHX05GX05BVD1tCkNPTkZJR19ORl9OQVRfTkVFREVEPXkKIyBDT05GSUdfTkZfTkFU
X0FNQU5EQSBpcyBub3Qgc2V0CkNPTkZJR19ORl9OQVRfRlRQPW0KQ09ORklHX05GX05BVF9JUkM9
bQpDT05GSUdfTkZfTkFUX1NJUD1tCiMgQ09ORklHX05GX05BVF9URlRQIGlzIG5vdCBzZXQKQ09O
RklHX05FVEZJTFRFUl9YVEFCTEVTPW0KCiMKIyBYdGFibGVzIGNvbWJpbmVkIG1vZHVsZXMKIwpD
T05GSUdfTkVURklMVEVSX1hUX01BUks9bQoKIwojIFh0YWJsZXMgdGFyZ2V0cwojCkNPTkZJR19O
RVRGSUxURVJfWFRfVEFSR0VUX0NPTk5TRUNNQVJLPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJH
RVRfTE9HPW0KQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfTkVUTUFQPW0KQ09ORklHX05FVEZJ
TFRFUl9YVF9UQVJHRVRfTkZMT0c9bQpDT05GSUdfTkVURklMVEVSX1hUX1RBUkdFVF9SRURJUkVD
VD1tCkNPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX1NFQ01BUks9bQpDT05GSUdfTkVURklMVEVS
X1hUX1RBUkdFVF9UQ1BNU1M9bQoKIwojIFh0YWJsZXMgbWF0Y2hlcwojCkNPTkZJR19ORVRGSUxU
RVJfWFRfTUFUQ0hfQ09OTlRSQUNLPW0KQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9QT0xJQ1k9
bQpDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1NUQVRFPW0KQ09ORklHX0lQX1NFVD1tCkNPTkZJ
R19JUF9TRVRfTUFYPTI1NgpDT05GSUdfSVBfU0VUX0JJVE1BUF9JUD1tCkNPTkZJR19JUF9TRVRf
QklUTUFQX0lQTUFDPW0KQ09ORklHX0lQX1NFVF9CSVRNQVBfUE9SVD1tCkNPTkZJR19JUF9TRVRf
SEFTSF9JUD1tCkNPTkZJR19JUF9TRVRfSEFTSF9JUFBPUlQ9bQpDT05GSUdfSVBfU0VUX0hBU0hf
SVBQT1JUSVA9bQpDT05GSUdfSVBfU0VUX0hBU0hfSVBQT1JUTkVUPW0KQ09ORklHX0lQX1NFVF9I
QVNIX05FVD1tCkNPTkZJR19JUF9TRVRfSEFTSF9ORVRQT1JUPW0KQ09ORklHX0lQX1NFVF9IQVNI
X05FVElGQUNFPW0KQ09ORklHX0lQX1NFVF9MSVNUX1NFVD1tCkNPTkZJR19JUF9WUz1tCkNPTkZJ
R19JUF9WU19JUFY2PXkKIyBDT05GSUdfSVBfVlNfREVCVUcgaXMgbm90IHNldApDT05GSUdfSVBf
VlNfVEFCX0JJVFM9MTIKCiMKIyBJUFZTIHRyYW5zcG9ydCBwcm90b2NvbCBsb2FkIGJhbGFuY2lu
ZyBzdXBwb3J0CiMKQ09ORklHX0lQX1ZTX1BST1RPX1RDUD15CkNPTkZJR19JUF9WU19QUk9UT19V
RFA9eQpDT05GSUdfSVBfVlNfUFJPVE9fQUhfRVNQPXkKQ09ORklHX0lQX1ZTX1BST1RPX0VTUD15
CkNPTkZJR19JUF9WU19QUk9UT19BSD15CkNPTkZJR19JUF9WU19QUk9UT19TQ1RQPXkKCiMKIyBJ
UFZTIHNjaGVkdWxlcgojCkNPTkZJR19JUF9WU19SUj1tCkNPTkZJR19JUF9WU19XUlI9bQpDT05G
SUdfSVBfVlNfTEM9bQpDT05GSUdfSVBfVlNfV0xDPW0KQ09ORklHX0lQX1ZTX0xCTEM9bQpDT05G
SUdfSVBfVlNfTEJMQ1I9bQpDT05GSUdfSVBfVlNfREg9bQpDT05GSUdfSVBfVlNfU0g9bQpDT05G
SUdfSVBfVlNfU0VEPW0KQ09ORklHX0lQX1ZTX05RPW0KCiMKIyBJUFZTIFNIIHNjaGVkdWxlcgoj
CkNPTkZJR19JUF9WU19TSF9UQUJfQklUUz04CgojCiMgSVBWUyBhcHBsaWNhdGlvbiBoZWxwZXIK
IwpDT05GSUdfSVBfVlNfRlRQPW0KQ09ORklHX0lQX1ZTX05GQ1Q9eQpDT05GSUdfSVBfVlNfUEVf
U0lQPW0KCiMKIyBJUDogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfTkZfREVGUkFH
X0lQVjQ9bQpDT05GSUdfTkZfQ09OTlRSQUNLX0lQVjQ9bQpDT05GSUdfTkZfQ09OTlRSQUNLX1BS
T0NfQ09NUEFUPXkKQ09ORklHX0lQX05GX0lQVEFCTEVTPW0KQ09ORklHX0lQX05GX0ZJTFRFUj1t
CkNPTkZJR19JUF9ORl9UQVJHRVRfUkVKRUNUPW0KQ09ORklHX0lQX05GX1RBUkdFVF9VTE9HPW0K
Q09ORklHX05GX05BVF9JUFY0PW0KQ09ORklHX0lQX05GX1RBUkdFVF9NQVNRVUVSQURFPW0KIyBD
T05GSUdfTkZfTkFUX1BQVFAgaXMgbm90IHNldAojIENPTkZJR19ORl9OQVRfSDMyMyBpcyBub3Qg
c2V0CkNPTkZJR19JUF9ORl9NQU5HTEU9bQpDT05GSUdfSVBfTkZfUkFXPW0KCiMKIyBJUHY2OiBO
ZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19ORl9ERUZSQUdfSVBWNj1tCkNPTkZJR19O
Rl9DT05OVFJBQ0tfSVBWNj1tCkNPTkZJR19JUDZfTkZfSVBUQUJMRVM9bQpDT05GSUdfSVA2X05G
X01BVENIX0lQVjZIRUFERVI9bQpDT05GSUdfSVA2X05GX0ZJTFRFUj1tCkNPTkZJR19JUDZfTkZf
VEFSR0VUX1JFSkVDVD1tCkNPTkZJR19JUDZfTkZfTUFOR0xFPW0KQ09ORklHX0lQNl9ORl9SQVc9
bQpDT05GSUdfQlJJREdFX05GX0VCVEFCTEVTPW0KQ09ORklHX0JSSURHRV9FQlRfQlJPVVRFPW0K
Q09ORklHX0JSSURHRV9FQlRfVF9GSUxURVI9bQpDT05GSUdfQlJJREdFX0VCVF9UX05BVD1tCkNP
TkZJR19CUklER0VfRUJUXzgwMl8zPW0KQ09ORklHX0JSSURHRV9FQlRfQU1PTkc9bQpDT05GSUdf
QlJJREdFX0VCVF9BUlA9bQpDT05GSUdfQlJJREdFX0VCVF9JUD1tCkNPTkZJR19CUklER0VfRUJU
X0lQNj1tCkNPTkZJR19CUklER0VfRUJUX0xJTUlUPW0KQ09ORklHX0JSSURHRV9FQlRfTUFSSz1t
CkNPTkZJR19CUklER0VfRUJUX1BLVFRZUEU9bQpDT05GSUdfQlJJREdFX0VCVF9TVFA9bQpDT05G
SUdfQlJJREdFX0VCVF9WTEFOPW0KQ09ORklHX0JSSURHRV9FQlRfQVJQUkVQTFk9bQpDT05GSUdf
QlJJREdFX0VCVF9ETkFUPW0KQ09ORklHX0JSSURHRV9FQlRfTUFSS19UPW0KQ09ORklHX0JSSURH
RV9FQlRfUkVESVJFQ1Q9bQpDT05GSUdfQlJJREdFX0VCVF9TTkFUPW0KQ09ORklHX0JSSURHRV9F
QlRfTE9HPW0KQ09ORklHX0JSSURHRV9FQlRfVUxPRz1tCkNPTkZJR19CUklER0VfRUJUX05GTE9H
PW0KIyBDT05GSUdfSVBfRENDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNl
dAojIENPTkZJR19SRFMgaXMgbm90IHNldAojIENPTkZJR19USVBDIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVRNIGlzIG5vdCBzZXQKIyBDT05GSUdfTDJUUCBpcyBub3Qgc2V0CkNPTkZJR19TVFA9eQpD
T05GSUdfR0FSUD15CkNPTkZJR19NUlA9eQpDT05GSUdfQlJJREdFPXkKQ09ORklHX0JSSURHRV9J
R01QX1NOT09QSU5HPXkKQ09ORklHX0JSSURHRV9WTEFOX0ZJTFRFUklORz15CkNPTkZJR19IQVZF
X05FVF9EU0E9eQpDT05GSUdfVkxBTl84MDIxUT15CkNPTkZJR19WTEFOXzgwMjFRX0dWUlA9eQpD
T05GSUdfVkxBTl84MDIxUV9NVlJQPXkKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKQ09ORklH
X0xMQz15CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19JUFggaXMgbm90IHNldAoj
IENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklH
X0xBUEIgaXMgbm90IHNldAojIENPTkZJR19QSE9ORVQgaXMgbm90IHNldAojIENPTkZJR19JRUVF
ODAyMTU0IGlzIG5vdCBzZXQKQ09ORklHX05FVF9TQ0hFRD15CgojCiMgUXVldWVpbmcvU2NoZWR1
bGluZwojCkNPTkZJR19ORVRfU0NIX0NCUT1tCkNPTkZJR19ORVRfU0NIX0hUQj1tCkNPTkZJR19O
RVRfU0NIX0hGU0M9bQpDT05GSUdfTkVUX1NDSF9QUklPPW0KQ09ORklHX05FVF9TQ0hfTVVMVElR
PW0KQ09ORklHX05FVF9TQ0hfUkVEPW0KQ09ORklHX05FVF9TQ0hfU0ZCPW0KQ09ORklHX05FVF9T
Q0hfU0ZRPW0KQ09ORklHX05FVF9TQ0hfVEVRTD1tCkNPTkZJR19ORVRfU0NIX1RCRj1tCkNPTkZJ
R19ORVRfU0NIX0dSRUQ9bQpDT05GSUdfTkVUX1NDSF9EU01BUks9bQpDT05GSUdfTkVUX1NDSF9O
RVRFTT1tCkNPTkZJR19ORVRfU0NIX0RSUj1tCkNPTkZJR19ORVRfU0NIX01RUFJJTz1tCkNPTkZJ
R19ORVRfU0NIX0NIT0tFPW0KQ09ORklHX05FVF9TQ0hfUUZRPW0KQ09ORklHX05FVF9TQ0hfQ09E
RUw9bQpDT05GSUdfTkVUX1NDSF9GUV9DT0RFTD1tCiMgQ09ORklHX05FVF9TQ0hfRlEgaXMgbm90
IHNldApDT05GSUdfTkVUX1NDSF9JTkdSRVNTPW0KQ09ORklHX05FVF9TQ0hfUExVRz1tCgojCiMg
Q2xhc3NpZmljYXRpb24KIwpDT05GSUdfTkVUX0NMUz15CkNPTkZJR19ORVRfQ0xTX0JBU0lDPW0K
Q09ORklHX05FVF9DTFNfVENJTkRFWD1tCkNPTkZJR19ORVRfQ0xTX1JPVVRFND1tCkNPTkZJR19O
RVRfQ0xTX0ZXPW0KQ09ORklHX05FVF9DTFNfVTMyPW0KQ09ORklHX0NMU19VMzJfUEVSRj15CkNP
TkZJR19DTFNfVTMyX01BUks9eQpDT05GSUdfTkVUX0NMU19SU1ZQPW0KQ09ORklHX05FVF9DTFNf
UlNWUDY9bQpDT05GSUdfTkVUX0NMU19GTE9XPW0KQ09ORklHX05FVF9DTFNfQ0dST1VQPXkKQ09O
RklHX05FVF9FTUFUQ0g9eQpDT05GSUdfTkVUX0VNQVRDSF9TVEFDSz0zMgpDT05GSUdfTkVUX0VN
QVRDSF9DTVA9bQpDT05GSUdfTkVUX0VNQVRDSF9OQllURT1tCkNPTkZJR19ORVRfRU1BVENIX1Uz
Mj1tCkNPTkZJR19ORVRfRU1BVENIX01FVEE9bQpDT05GSUdfTkVUX0VNQVRDSF9URVhUPW0KQ09O
RklHX05FVF9FTUFUQ0hfSVBTRVQ9bQpDT05GSUdfTkVUX0NMU19BQ1Q9eQpDT05GSUdfTkVUX0FD
VF9QT0xJQ0U9bQpDT05GSUdfTkVUX0FDVF9HQUNUPW0KQ09ORklHX0dBQ1RfUFJPQj15CkNPTkZJ
R19ORVRfQUNUX01JUlJFRD1tCkNPTkZJR19ORVRfQUNUX0lQVD1tCkNPTkZJR19ORVRfQUNUX05B
VD1tCkNPTkZJR19ORVRfQUNUX1BFRElUPW0KQ09ORklHX05FVF9BQ1RfU0lNUD1tCkNPTkZJR19O
RVRfQUNUX1NLQkVESVQ9bQpDT05GSUdfTkVUX0FDVF9DU1VNPW0KQ09ORklHX05FVF9DTFNfSU5E
PXkKQ09ORklHX05FVF9TQ0hfRklGTz15CiMgQ09ORklHX0RDQiBpcyBub3Qgc2V0CkNPTkZJR19E
TlNfUkVTT0xWRVI9eQojIENPTkZJR19CQVRNQU5fQURWIGlzIG5vdCBzZXQKQ09ORklHX09QRU5W
U1dJVENIPW0KIyBDT05GSUdfVlNPQ0tFVFMgaXMgbm90IHNldAojIENPTkZJR19ORVRMSU5LX01N
QVAgaXMgbm90IHNldApDT05GSUdfTkVUTElOS19ESUFHPW0KIyBDT05GSUdfTkVUX01QTFNfR1NP
IGlzIG5vdCBzZXQKQ09ORklHX1JQUz15CkNPTkZJR19SRlNfQUNDRUw9eQpDT05GSUdfWFBTPXkK
Q09ORklHX05FVFBSSU9fQ0dST1VQPXkKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05GSUdf
QlFMPXkKQ09ORklHX05FVF9GTE9XX0xJTUlUPXkKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENP
TkZJR19ORVRfUEtUR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1RDUFBST0JFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0RST1BfTU9OSVRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTVJBRElP
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJEQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNldApD
T05GSUdfRklCX1JVTEVTPXkKIyBDT05GSUdfV0lSRUxFU1MgaXMgbm90IHNldAojIENPTkZJR19X
SU1BWCBpcyBub3Qgc2V0CiMgQ09ORklHX1JGS0lMTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF85
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0NBSUYgaXMgbm90IHNldAojIENPTkZJR19DRVBIX0xJQiBp
cyBub3Qgc2V0CiMgQ09ORklHX05GQyBpcyBub3Qgc2V0CgojCiMgRGV2aWNlIERyaXZlcnMKIwoK
IwojIEdlbmVyaWMgRHJpdmVyIE9wdGlvbnMKIwpDT05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIv
c2Jpbi9ob3RwbHVnIgpDT05GSUdfREVWVE1QRlM9eQpDT05GSUdfREVWVE1QRlNfTU9VTlQ9eQpD
T05GSUdfU1RBTkRBTE9ORT15CkNPTkZJR19QUkVWRU5UX0ZJUk1XQVJFX0JVSUxEPXkKQ09ORklH
X0ZXX0xPQURFUj15CkNPTkZJR19GSVJNV0FSRV9JTl9LRVJORUw9eQpDT05GSUdfRVhUUkFfRklS
TVdBUkU9IiIKQ09ORklHX0ZXX0xPQURFUl9VU0VSX0hFTFBFUj15CiMgQ09ORklHX0RFQlVHX0RS
SVZFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0RFVlJFUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NZU19IWVBFUlZJU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVJJQ19DUFVfREVWSUNFUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RNQV9TSEFSRURfQlVGRkVSIGlzIG5vdCBzZXQKCiMKIyBCdXMg
ZGV2aWNlcwojCiMgQ09ORklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CkNPTkZJR19NVEQ9eQojIENP
TkZJR19NVERfVEVTVFMgaXMgbm90IHNldAojIENPTkZJR19NVERfUkVEQk9PVF9QQVJUUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01URF9DTURMSU5FX1BBUlRTIGlzIG5vdCBzZXQKQ09ORklHX01URF9P
Rl9QQVJUUz15CiMgQ09ORklHX01URF9BUjdfUEFSVFMgaXMgbm90IHNldAoKIwojIFVzZXIgTW9k
dWxlcyBBbmQgVHJhbnNsYXRpb24gTGF5ZXJzCiMKQ09ORklHX01URF9CTEtERVZTPXkKQ09ORklH
X01URF9CTE9DSz15CiMgQ09ORklHX0ZUTCBpcyBub3Qgc2V0CiMgQ09ORklHX05GVEwgaXMgbm90
IHNldAojIENPTkZJR19JTkZUTCBpcyBub3Qgc2V0CiMgQ09ORklHX1JGRF9GVEwgaXMgbm90IHNl
dAojIENPTkZJR19TU0ZEQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NNX0ZUTCBpcyBub3Qgc2V0CiMg
Q09ORklHX01URF9PT1BTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1NXQVAgaXMgbm90IHNldAoK
IwojIFJBTS9ST00vRmxhc2ggY2hpcCBkcml2ZXJzCiMKQ09ORklHX01URF9DRkk9eQojIENPTkZJ
R19NVERfSkVERUNQUk9CRSBpcyBub3Qgc2V0CkNPTkZJR19NVERfR0VOX1BST0JFPXkKIyBDT05G
SUdfTVREX0NGSV9BRFZfT1BUSU9OUyBpcyBub3Qgc2V0CkNPTkZJR19NVERfTUFQX0JBTktfV0lE
VEhfMT15CkNPTkZJR19NVERfTUFQX0JBTktfV0lEVEhfMj15CkNPTkZJR19NVERfTUFQX0JBTktf
V0lEVEhfND15CiMgQ09ORklHX01URF9NQVBfQkFOS19XSURUSF84IGlzIG5vdCBzZXQKIyBDT05G
SUdfTVREX01BUF9CQU5LX1dJRFRIXzE2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX01BUF9CQU5L
X1dJRFRIXzMyIGlzIG5vdCBzZXQKQ09ORklHX01URF9DRklfSTE9eQpDT05GSUdfTVREX0NGSV9J
Mj15CiMgQ09ORklHX01URF9DRklfSTQgaXMgbm90IHNldAojIENPTkZJR19NVERfQ0ZJX0k4IGlz
IG5vdCBzZXQKQ09ORklHX01URF9DRklfSU5URUxFWFQ9eQpDT05GSUdfTVREX0NGSV9BTURTVEQ9
eQojIENPTkZJR19NVERfQ0ZJX1NUQUEgaXMgbm90IHNldApDT05GSUdfTVREX0NGSV9VVElMPXkK
IyBDT05GSUdfTVREX1JBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9ST00gaXMgbm90IHNldAoj
IENPTkZJR19NVERfQUJTRU5UIGlzIG5vdCBzZXQKCiMKIyBNYXBwaW5nIGRyaXZlcnMgZm9yIGNo
aXAgYWNjZXNzCiMKIyBDT05GSUdfTVREX0NPTVBMRVhfTUFQUElOR1MgaXMgbm90IHNldAojIENP
TkZJR19NVERfUEhZU01BUCBpcyBub3Qgc2V0CkNPTkZJR19NVERfUEhZU01BUF9PRj15CiMgQ09O
RklHX01URF9QTEFUUkFNIGlzIG5vdCBzZXQKCiMKIyBTZWxmLWNvbnRhaW5lZCBNVEQgZGV2aWNl
IGRyaXZlcnMKIwojIENPTkZJR19NVERfREFUQUZMQVNIIGlzIG5vdCBzZXQKQ09ORklHX01URF9N
MjVQODA9eQpDT05GSUdfTTI1UFhYX1VTRV9GQVNUX1JFQUQ9eQojIENPTkZJR19NVERfU1NUMjVM
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1NMUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1BI
UkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX01URFJBTSBpcyBub3Qgc2V0CkNPTkZJR19NVERf
QkxPQ0syTVREPW0KCiMKIyBEaXNrLU9uLUNoaXAgRGV2aWNlIERyaXZlcnMKIwojIENPTkZJR19N
VERfRE9DRzMgaXMgbm90IHNldApDT05GSUdfTVREX05BTkRfRUNDPXkKIyBDT05GSUdfTVREX05B
TkRfRUNDX1NNQyBpcyBub3Qgc2V0CkNPTkZJR19NVERfTkFORD15CiMgQ09ORklHX01URF9OQU5E
X0VDQ19CQ0ggaXMgbm90IHNldAojIENPTkZJR19NVERfU01fQ09NTU9OIGlzIG5vdCBzZXQKIyBD
T05GSUdfTVREX05BTkRfREVOQUxJIGlzIG5vdCBzZXQKQ09ORklHX01URF9OQU5EX0lEUz15CiMg
Q09ORklHX01URF9OQU5EX0RJU0tPTkNISVAgaXMgbm90IHNldAojIENPTkZJR19NVERfTkFORF9E
T0NHNCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9OQU5EX05BTkRTSU0gaXMgbm90IHNldApDT05G
SUdfTVREX05BTkRfUExBVEZPUk09eQpDT05GSUdfTVREX05BTkRfRlNMX0VMQkM9eQojIENPTkZJ
R19NVERfTkFORF9GU0xfSUZDIGlzIG5vdCBzZXQKQ09ORklHX01URF9OQU5EX0ZTTF9VUE09eQoj
IENPTkZJR19NVERfT05FTkFORCBpcyBub3Qgc2V0CgojCiMgTFBERFIgZmxhc2ggbWVtb3J5IGRy
aXZlcnMKIwojIENPTkZJR19NVERfTFBERFIgaXMgbm90IHNldAojIENPTkZJR19NVERfVUJJIGlz
IG5vdCBzZXQKQ09ORklHX0RUQz15CkNPTkZJR19PRj15CgojCiMgRGV2aWNlIFRyZWUgYW5kIE9w
ZW4gRmlybXdhcmUgc3VwcG9ydAojCkNPTkZJR19QUk9DX0RFVklDRVRSRUU9eQojIENPTkZJR19P
Rl9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19PRl9GTEFUVFJFRT15CkNPTkZJR19PRl9FQVJM
WV9GTEFUVFJFRT15CkNPTkZJR19PRl9BRERSRVNTPXkKQ09ORklHX09GX0lSUT15CkNPTkZJR19P
Rl9ORVQ9eQpDT05GSUdfT0ZfTURJTz15CkNPTkZJR19PRl9NVEQ9eQojIENPTkZJR19QQVJQT1JU
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVY9eQojIENPTkZJR19CTEtfREVWX0ZEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZf
TE9PUD15CkNPTkZJR19CTEtfREVWX0xPT1BfTUlOX0NPVU5UPTgKIyBDT05GSUdfQkxLX0RFVl9D
UllQVE9MT09QIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfRFJCRD1tCiMgQ09ORklHX0RSQkRf
RkFVTFRfSU5KRUNUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTkJEPW0KQ09ORklHX0JM
S19ERVZfUkFNPXkKQ09ORklHX0JMS19ERVZfUkFNX0NPVU5UPTE2CkNPTkZJR19CTEtfREVWX1JB
TV9TSVpFPTEzMTA3MgojIENPTkZJR19CTEtfREVWX1hJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NE
Uk9NX1BLVENEVkQgaXMgbm90IHNldAojIENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0hEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQkQgaXMgbm90
IHNldAoKIwojIE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX1NFTlNPUlNfTElTM0xWMDJEIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUQ1MjVYX0RQT1QgaXMgbm90IHNldAojIENPTkZJR19EVU1NWV9JUlEg
aXMgbm90IHNldAojIENPTkZJR19JQ1M5MzJTNDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNRUxf
U1NDIGlzIG5vdCBzZXQKIyBDT05GSUdfRU5DTE9TVVJFX1NFUlZJQ0VTIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVBEUzk4MDJBTFMgaXMgbm90IHNldAojIENPTkZJR19JU0wyOTAwMyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lTTDI5MDIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UU0wyNTUwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19CSDE3ODAgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0JIMTc3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVBEUzk5MFggaXMgbm90IHNl
dAojIENPTkZJR19ITUM2MzUyIGlzIG5vdCBzZXQKIyBDT05GSUdfRFMxNjgyIGlzIG5vdCBzZXQK
IyBDT05GSUdfVElfREFDNzUxMiBpcyBub3Qgc2V0CiMgQ09ORklHX0JNUDA4NV9JMkMgaXMgbm90
IHNldAojIENPTkZJR19CTVAwODVfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NXSVRDSF9G
U0E5NDgwIGlzIG5vdCBzZXQKIyBDT05GSUdfTEFUVElDRV9FQ1AzX0NPTkZJRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NSQU0gaXMgbm90IHNldAojIENPTkZJR19DMlBPUlQgaXMgbm90IHNldAoKIwoj
IEVFUFJPTSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQUk9NX0FUMjQgaXMgbm90IHNldAojIENPTkZJ
R19FRVBST01fQVQyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV9MRUdBQ1kgaXMgbm90IHNl
dAojIENPTkZJR19FRVBST01fTUFYNjg3NSBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV85M0NY
NiBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV85M1hYNDYgaXMgbm90IHNldAoKIwojIFRleGFz
IEluc3RydW1lbnRzIHNoYXJlZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5lCiMKIyBDT05GSUdf
U0VOU09SU19MSVMzX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTElTM19JMkMgaXMg
bm90IHNldAoKIwojIEFsdGVyYSBGUEdBIGZpcm13YXJlIGRvd25sb2FkIG1vZHVsZQojCiMgQ09O
RklHX0FMVEVSQV9TVEFQTCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0lERT15CiMgQ09ORklHX0lE
RSBpcyBub3Qgc2V0CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19TQ1NJX01PRD15
CiMgQ09ORklHX1JBSURfQVRUUlMgaXMgbm90IHNldApDT05GSUdfU0NTST15CkNPTkZJR19TQ1NJ
X0RNQT15CiMgQ09ORklHX1NDU0lfVEdUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ORVRMSU5L
IGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfUFJPQ19GUz15CgojCiMgU0NTSSBzdXBwb3J0IHR5cGUg
KGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RFVl9TRD15CiMgQ09ORklHX0NIUl9E
RVZfU1QgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX09TU1QgaXMgbm90IHNldApDT05GSUdf
QkxLX0RFVl9TUj15CkNPTkZJR19CTEtfREVWX1NSX1ZFTkRPUj15CkNPTkZJR19DSFJfREVWX1NH
PXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNldApDT05GSUdfU0NTSV9NVUxUSV9MVU49
eQpDT05GSUdfU0NTSV9DT05TVEFOVFM9eQojIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1NDQU5fQVNZTkMgaXMgbm90IHNldAoKIwojIFNDU0kgVHJhbnNwb3J0
cwojCiMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GQ19B
VFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0lTQ1NJX0FUVFJTPW0KIyBDT05GSUdfU0NTSV9T
QVNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19MSUJTQVMgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0xPV0xFVkVMPXkK
Q09ORklHX0lTQ1NJX1RDUD1tCiMgQ09ORklHX0lTQ1NJX0JPT1RfU1lTRlMgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX1VGU0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX0xJQkZDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTElCRkNPRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0RIIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9PU0RfSU5JVElBVE9S
IGlzIG5vdCBzZXQKQ09ORklHX0FUQT15CiMgQ09ORklHX0FUQV9OT05TVEFOREFSRCBpcyBub3Qg
c2V0CkNPTkZJR19BVEFfVkVSQk9TRV9FUlJPUj15CkNPTkZJR19TQVRBX1BNUD15CgojCiMgQ29u
dHJvbGxlcnMgd2l0aCBub24tU0ZGIG5hdGl2ZSBpbnRlcmZhY2UKIwojIENPTkZJR19TQVRBX0FI
Q0lfUExBVEZPUk0gaXMgbm90IHNldAojIENPTkZJR19TQVRBX0ZTTCBpcyBub3Qgc2V0CkNPTkZJ
R19BVEFfU0ZGPXkKCiMKIyBTRkYgY29udHJvbGxlcnMgd2l0aCBjdXN0b20gRE1BIGludGVyZmFj
ZQojCkNPTkZJR19BVEFfQk1ETUE9eQoKIwojIFNBVEEgU0ZGIGNvbnRyb2xsZXJzIHdpdGggQk1E
TUEKIwojIENPTkZJR19TQVRBX0hJR0hCQU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9NViBp
cyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUkNBUiBpcyBub3Qgc2V0CgojCiMgUEFUQSBTRkYgY29u
dHJvbGxlcnMgd2l0aCBCTURNQQojCiMgQ09ORklHX1BBVEFfQVJBU0FOX0NGIGlzIG5vdCBzZXQK
CiMKIyBQSU8tb25seSBTRkYgY29udHJvbGxlcnMKIwojIENPTkZJR19QQVRBX1BMQVRGT1JNIGlz
IG5vdCBzZXQKCiMKIyBHZW5lcmljIGZhbGxiYWNrIC8gbGVnYWN5IGRyaXZlcnMKIwpDT05GSUdf
TUQ9eQpDT05GSUdfQkxLX0RFVl9NRD1tCiMgQ09ORklHX01EX0xJTkVBUiBpcyBub3Qgc2V0CiMg
Q09ORklHX01EX1JBSUQwIGlzIG5vdCBzZXQKQ09ORklHX01EX1JBSUQxPW0KIyBDT05GSUdfTURf
UkFJRDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfTURfUkFJRDQ1NiBpcyBub3Qgc2V0CkNPTkZJR19N
RF9NVUxUSVBBVEg9bQojIENPTkZJR19NRF9GQVVMVFkgaXMgbm90IHNldAojIENPTkZJR19CQ0FD
SEUgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9ETT1tCiMgQ09ORklHX0RNX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfRE1fQ1JZUFQgaXMgbm90IHNldApDT05GSUdfRE1fU05BUFNIT1Q9bQoj
IENPTkZJR19ETV9USElOX1BST1ZJU0lPTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0NBQ0hF
IGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fTUlSUk9SIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fUkFJ
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX1pFUk8gaXMgbm90IHNldAojIENPTkZJR19ETV9NVUxU
SVBBVEggaXMgbm90IHNldAojIENPTkZJR19ETV9ERUxBWSBpcyBub3Qgc2V0CkNPTkZJR19ETV9V
RVZFTlQ9eQojIENPTkZJR19ETV9GTEFLRVkgaXMgbm90IHNldAojIENPTkZJR19ETV9WRVJJVFkg
aXMgbm90IHNldAojIENPTkZJR19ETV9TV0lUQ0ggaXMgbm90IHNldAojIENPTkZJR19UQVJHRVRf
Q09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ0lOVE9TSF9EUklWRVJTIGlzIG5vdCBzZXQKQ09O
RklHX05FVERFVklDRVM9eQpDT05GSUdfTUlJPXkKQ09ORklHX05FVF9DT1JFPXkKQ09ORklHX0JP
TkRJTkc9bQojIENPTkZJR19EVU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpFUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lGQiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9URUFNIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUFDVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYTEFOIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUQ09OU09MRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFBPTEwgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKQ09ORklHX1RVTj1tCkNP
TkZJR19WRVRIPW0KIyBDT05GSUdfTkxNT04gaXMgbm90IHNldAoKIwojIENBSUYgdHJhbnNwb3J0
IGRyaXZlcnMKIwoKIwojIERpc3RyaWJ1dGVkIFN3aXRjaCBBcmNoaXRlY3R1cmUgZHJpdmVycwoj
CiMgQ09ORklHX05FVF9EU0FfTVY4OEU2WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0RTQV9N
Vjg4RTYwNjAgaXMgbm90IHNldAojIENPTkZJR19ORVRfRFNBX01WODhFNlhYWF9ORUVEX1BQVSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9EU0FfTVY4OEU2MTMxIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0RTQV9NVjg4RTYxMjNfNjFfNjUgaXMgbm90IHNldApDT05GSUdfRVRIRVJORVQ9eQpDT05G
SUdfTkVUX1ZFTkRPUl9BUkM9eQojIENPTkZJR19BUkNfRU1BQyBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9DQURFTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9CUk9BRENPTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9DQUxYRURBX1hHTUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfRE5F
VCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfVkVORE9SX0ZSRUVTQ0FMRT15CkNPTkZJR19GU0xfUFFf
TURJTz15CiMgQ09ORklHX0ZTTF9YR01BQ19NRElPIGlzIG5vdCBzZXQKQ09ORklHX0dJQU5GQVI9
eQojIENPTkZJR19ORVRfVkVORE9SX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX01JQ1JPQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfTkFUU0VNSSBpcyBub3Qgc2V0CiMgQ09ORklHX0VUSE9DIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0hfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TRUVRIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl9TVE1JQ1JPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9WSUEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1dJWk5FVCBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfWElMSU5YIGlzIG5vdCBzZXQKQ09ORklHX1BIWUxJQj15CgojCiMg
TUlJIFBIWSBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX0FUODAzWF9QSFkgaXMgbm90IHNldAoj
IENPTkZJR19BTURfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFSVkVMTF9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19EQVZJQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1FTRU1JX1BIWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xYVF9QSFkgaXMgbm90IHNldAojIENPTkZJR19DSUNBREFfUEhZIGlz
IG5vdCBzZXQKQ09ORklHX1ZJVEVTU0VfUEhZPXkKIyBDT05GSUdfU01TQ19QSFkgaXMgbm90IHNl
dAojIENPTkZJR19CUk9BRENPTV9QSFkgaXMgbm90IHNldAojIENPTkZJR19CQ004N1hYX1BIWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lDUExVU19QSFkgaXMgbm90IHNldAojIENPTkZJR19SRUFMVEVL
X1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX05BVElPTkFMX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NURTEwWFAgaXMgbm90IHNldAojIENPTkZJR19MU0lfRVQxMDExQ19QSFkgaXMgbm90IHNldAoj
IENPTkZJR19NSUNSRUxfUEhZIGlzIG5vdCBzZXQKQ09ORklHX0ZJWEVEX1BIWT15CiMgQ09ORklH
X01ESU9fQklUQkFORyBpcyBub3Qgc2V0CiMgQ09ORklHX01ESU9fQlVTX01VWF9NTUlPUkVHIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUlDUkVMX0tTODk5NU1BIGlzIG5vdCBzZXQKQ09ORklHX1BQUD1t
CiMgQ09ORklHX1BQUF9CU0RDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQX0RFRkxBVEUgaXMg
bm90IHNldAojIENPTkZJR19QUFBfRklMVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQX01QUEUg
aXMgbm90IHNldAojIENPTkZJR19QUFBfTVVMVElMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQ
T0UgaXMgbm90IHNldAojIENPTkZJR19QUFBfQVNZTkMgaXMgbm90IHNldAojIENPTkZJR19QUFBf
U1lOQ19UVFkgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQKQ09ORklHX1NMSEM9
bQoKIwojIFVTQiBOZXR3b3JrIEFkYXB0ZXJzCiMKIyBDT05GSUdfVVNCX0NBVEMgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfS0FXRVRIIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9QRUdBU1VTPXkKIyBD
T05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNldAojIENPTkZJR19VU0JfUlRMODE1MiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVBIRVRIIGlz
IG5vdCBzZXQKIyBDT05GSUdfV0xBTiBpcyBub3Qgc2V0CgojCiMgRW5hYmxlIFdpTUFYIChOZXR3
b3JraW5nIG9wdGlvbnMpIHRvIHNlZSB0aGUgV2lNQVggZHJpdmVycwojCiMgQ09ORklHX1dBTiBp
cyBub3Qgc2V0CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAoKIwojIElucHV0IGRldmljZSBzdXBw
b3J0CiMKQ09ORklHX0lOUFVUPXkKQ09ORklHX0lOUFVUX0ZGX01FTUxFU1M9bQojIENPTkZJR19J
TlBVVF9QT0xMREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfU1BBUlNFS01BUCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX01BVFJJWEtNQVAgaXMgbm90IHNldAoKIwojIFVzZXJsYW5kIGlu
dGVyZmFjZXMKIwojIENPTkZJR19JTlBVVF9NT1VTRURFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX0pPWURFViBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9FVkRFVj1tCiMgQ09ORklHX0lOUFVU
X0VWQlVHIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBEZXZpY2UgRHJpdmVycwojCiMgQ09ORklHX0lO
UFVUX0tFWUJPQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTU9VU0UgaXMgbm90IHNldAoj
IENPTkZJR19JTlBVVF9KT1lTVElDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RBQkxFVCBp
cyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5QVVRfTUlTQyBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgSS9PIHBvcnRzCiMKQ09ORklHX1NF
UklPPXkKQ09ORklHX1NFUklPX0k4MDQyPXkKQ09ORklHX1NFUklPX1NFUlBPUlQ9eQpDT05GSUdf
U0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VS
SU9fWElMSU5YX1hQU19QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BTFRFUkFfUFMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUFMyTVVMVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklP
X0FSQ19QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BUEJQUzIgaXMgbm90IHNldAojIENP
TkZJR19TRVJJT19PTFBDX0FQU1AgaXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qg
c2V0CgojCiMgQ2hhcmFjdGVyIGRldmljZXMKIwpDT05GSUdfVFRZPXkKQ09ORklHX1ZUPXkKQ09O
RklHX0NPTlNPTEVfVFJBTlNMQVRJT05TPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfVlRf
Q09OU09MRV9TTEVFUD15CkNPTkZJR19IV19DT05TT0xFPXkKIyBDT05GSUdfVlRfSFdfQ09OU09M
RV9CSU5ESU5HIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg5OF9QVFlTPXkKQ09ORklHX0RFVlBUU19N
VUxUSVBMRV9JTlNUQU5DRVM9eQpDT05GSUdfTEVHQUNZX1BUWVM9eQpDT05GSUdfTEVHQUNZX1BU
WV9DT1VOVD0yNTYKIyBDT05GSUdfU0VSSUFMX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKIyBDT05G
SUdfTl9HU00gaXMgbm90IHNldAojIENPTkZJR19UUkFDRV9TSU5LIGlzIG5vdCBzZXQKIyBDT05G
SUdfUFBDX0VQQVBSX0hWX0JZVEVDSEFOIGlzIG5vdCBzZXQKQ09ORklHX0RFVktNRU09eQoKIwoj
IFNlcmlhbCBkcml2ZXJzCiMKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklBTF84MjUw
X0RFUFJFQ0FURURfT1BUSU9OUz15CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklH
X1NFUklBTF84MjUwX0RNQT15CkNPTkZJR19TRVJJQUxfODI1MF9OUl9VQVJUUz0yCkNPTkZJR19T
RVJJQUxfODI1MF9SVU5USU1FX1VBUlRTPTIKQ09ORklHX1NFUklBTF84MjUwX0VYVEVOREVEPXkK
Q09ORklHX1NFUklBTF84MjUwX01BTllfUE9SVFM9eQpDT05GSUdfU0VSSUFMXzgyNTBfU0hBUkVf
SVJRPXkKQ09ORklHX1NFUklBTF84MjUwX0RFVEVDVF9JUlE9eQpDT05GSUdfU0VSSUFMXzgyNTBf
UlNBPXkKQ09ORklHX1NFUklBTF84MjUwX0ZTTD15CiMgQ09ORklHX1NFUklBTF84MjUwX0RXIGlz
IG5vdCBzZXQKCiMKIyBOb24tODI1MCBzZXJpYWwgcG9ydCBzdXBwb3J0CiMKIyBDT05GSUdfU0VS
SUFMX0tHREJfTk1JIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX01BWDMxMDAgaXMgbm90IHNl
dAojIENPTkZJR19TRVJJQUxfTUFYMzEwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9VQVJU
TElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09SRV9D
T05TT0xFPXkKQ09ORklHX0NPTlNPTEVfUE9MTD15CiMgQ09ORklHX1NFUklBTF9PRl9QTEFURk9S
TSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TQ0NOWFAgaXMgbm90IHNldAojIENPTkZJR19T
RVJJQUxfVElNQkVSREFMRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFfSlRBR1VB
UlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJBX1VBUlQgaXMgbm90IHNldAojIENP
TkZJR19TRVJJQUxfWElMSU5YX1BTX1VBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQVJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0ZTTF9MUFVBUlQgaXMgbm90IHNldAojIENPTkZJ
R19TRVJJQUxfU1RfQVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfVFRZX1BSSU5USyBpcyBub3Qgc2V0
CiMgQ09ORklHX0hWQ19VREJHIGlzIG5vdCBzZXQKQ09ORklHX0lQTUlfSEFORExFUj1tCiMgQ09O
RklHX0lQTUlfUEFOSUNfRVZFTlQgaXMgbm90IHNldApDT05GSUdfSVBNSV9ERVZJQ0VfSU5URVJG
QUNFPW0KQ09ORklHX0lQTUlfU0k9bQpDT05GSUdfSVBNSV9XQVRDSERPRz1tCkNPTkZJR19JUE1J
X1BPV0VST0ZGPW0KQ09ORklHX0hXX1JBTkRPTT15CiMgQ09ORklHX0hXX1JBTkRPTV9USU1FUklP
TUVNIGlzIG5vdCBzZXQKQ09ORklHX05WUkFNPXkKIyBDT05GSUdfUjM5NjQgaXMgbm90IHNldAoj
IENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0
CkNPTkZJR19JMkM9eQpDT05GSUdfSTJDX0JPQVJESU5GTz15CkNPTkZJR19JMkNfQ09NUEFUPXkK
Q09ORklHX0kyQ19DSEFSREVWPXkKIyBDT05GSUdfSTJDX01VWCBpcyBub3Qgc2V0CkNPTkZJR19J
MkNfSEVMUEVSX0FVVE89eQoKIwojIEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAojCgojCiMgSTJD
IHN5c3RlbSBidXMgZHJpdmVycyAobW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNoaXApCiMK
Q09ORklHX0kyQ19NUEM9eQojIENPTkZJR19JMkNfT0NPUkVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1BDQV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QWEFfUENJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1NJTVRFQyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19YSUxJTlggaXMg
bm90IHNldAoKIwojIEV4dGVybmFsIEkyQy9TTUJ1cyBhZGFwdGVyIGRyaXZlcnMKIwojIENPTkZJ
R19JMkNfRElPTEFOX1UyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQVJQT1JUX0xJR0hUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1RBT1NfRVZNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1RJ
TllfVVNCIGlzIG5vdCBzZXQKCiMKIyBPdGhlciBJMkMvU01CdXMgYnVzIGRyaXZlcnMKIwojIENP
TkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DT1JFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
QlVTIGlzIG5vdCBzZXQKQ09ORklHX1NQST15CiMgQ09ORklHX1NQSV9ERUJVRyBpcyBub3Qgc2V0
CkNPTkZJR19TUElfTUFTVEVSPXkKCiMKIyBTUEkgTWFzdGVyIENvbnRyb2xsZXIgRHJpdmVycwoj
CiMgQ09ORklHX1NQSV9BTFRFUkEgaXMgbm90IHNldAojIENPTkZJR19TUElfQklUQkFORyBpcyBu
b3Qgc2V0CkNPTkZJR19TUElfRlNMX0xJQj15CiMgQ09ORklHX1NQSV9GU0xfU1BJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1BJX0ZTTF9EU1BJIGlzIG5vdCBzZXQKQ09ORklHX1NQSV9GU0xfRVNQST15
CiMgQ09ORklHX1NQSV9QWEEyWFhfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX1NDMThJUzYw
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9YQ09NTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9Y
SUxJTlggaXMgbm90IHNldAojIENPTkZJR19TUElfREVTSUdOV0FSRSBpcyBub3Qgc2V0CgojCiMg
U1BJIFByb3RvY29sIE1hc3RlcnMKIwojIENPTkZJR19TUElfU1BJREVWIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1BJX1RMRTYyWDAgaXMgbm90IHNldAojIENPTkZJR19IU0kgaXMgbm90IHNldAoKIwoj
IFBQUyBzdXBwb3J0CiMKQ09ORklHX1BQUz15CiMgQ09ORklHX1BQU19ERUJVRyBpcyBub3Qgc2V0
CgojCiMgUFBTIGNsaWVudHMgc3VwcG9ydAojCiMgQ09ORklHX1BQU19DTElFTlRfS1RJTUVSIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFBTX0NMSUVOVF9MRElTQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQ
U19DTElFTlRfR1BJTyBpcyBub3Qgc2V0CgojCiMgUFBTIGdlbmVyYXRvcnMgc3VwcG9ydAojCgoj
CiMgUFRQIGNsb2NrIHN1cHBvcnQKIwpDT05GSUdfUFRQXzE1ODhfQ0xPQ0s9eQpDT05GSUdfUFRQ
XzE1ODhfQ0xPQ0tfR0lBTkZBUj15CgojCiMgRW5hYmxlIFBIWUxJQiBhbmQgTkVUV09SS19QSFlf
VElNRVNUQU1QSU5HIHRvIHNlZSB0aGUgYWRkaXRpb25hbCBjbG9ja3MuCiMKQ09ORklHX0FSQ0hf
V0FOVF9PUFRJT05BTF9HUElPTElCPXkKQ09ORklHX0dQSU9fREVWUkVTPXkKIyBDT05GSUdfR1BJ
T0xJQiBpcyBub3Qgc2V0CiMgQ09ORklHX1cxIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfU1VQ
UExZIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfQVZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdN
T04gaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMIGlzIG5vdCBzZXQKQ09ORklHX1dBVENIRE9H
PXkKQ09ORklHX1dBVENIRE9HX0NPUkU9eQojIENPTkZJR19XQVRDSERPR19OT1dBWU9VVCBpcyBu
b3Qgc2V0CgojCiMgV2F0Y2hkb2cgRGV2aWNlIERyaXZlcnMKIwojIENPTkZJR19TT0ZUX1dBVENI
RE9HIGlzIG5vdCBzZXQKQ09ORklHX0JPT0tFX1dEVD1tCkNPTkZJR19CT09LRV9XRFRfREVGQVVM
VF9USU1FT1VUPTM4CgojCiMgVVNCLWJhc2VkIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfVVNC
UENXQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19TU0JfUE9TU0lCTEU9eQoKIwojIFNvbmljcyBT
aWxpY29uIEJhY2twbGFuZQojCiMgQ09ORklHX1NTQiBpcyBub3Qgc2V0CkNPTkZJR19CQ01BX1BP
U1NJQkxFPXkKCiMKIyBCcm9hZGNvbSBzcGVjaWZpYyBBTUJBCiMKIyBDT05GSUdfQkNNQSBpcyBu
b3Qgc2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01GRF9D
T1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FTMzcxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1BN
SUNfQURQNTUyMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9DUk9TX0VDIGlzIG5vdCBzZXQKIyBD
T05GSUdfUE1JQ19EQTkwM1ggaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MDUyX1NQSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNTJfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RB
OTA1NSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjMgaXMgbm90IHNldAojIENPTkZJR19N
RkRfTUMxM1hYWF9TUEkgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUMxM1hYWF9JMkMgaXMgbm90
IHNldAojIENPTkZJR19IVENfUEFTSUMzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0tFTVBMRCBp
cyBub3Qgc2V0CiMgQ09ORklHX01GRF84OFBNODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4
UE04MDUgaXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTg2MFggaXMgbm90IHNldAojIENPTkZJ
R19NRkRfTUFYNzc2ODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYNzc2OTMgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfTUFYODkwNyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQVg4OTI1IGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5OTcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFY
ODk5OCBpcyBub3Qgc2V0CiMgQ09ORklHX0VaWF9QQ0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1ZJUEVSQk9BUkQgaXMgbm90IHNldAojIENPTkZJR19NRkRfUkVUVSBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9QQ0Y1MDYzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SQzVUNTgzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX1NFQ19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NJNDc2WF9D
T1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X1NNU0MgaXMgbm90IHNldAojIENPTkZJR19BQlg1MDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9TVE1QRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TWVNDT04gaXMgbm90IHNldAojIENP
TkZJR19NRkRfVElfQU0zMzVYX1RTQ0FEQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9MUDg3ODgg
aXMgbm90IHNldAojIENPTkZJR19NRkRfUEFMTUFTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjEw
NVggaXMgbm90IHNldAojIENPTkZJR19UUFM2NTA3WCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9U
UFM2NTA5MCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUFM2NTIxNyBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9UUFM2NTg2WCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UUFM4MDAzMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RXTDQwMzBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDYwNDBfQ09S
RSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklH
X01GRF9MTTM1MzMgaXMgbm90IHNldAojIENPTkZJR19NRkRfVEMzNTg5WCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9UTUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfSTJDIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0FSSVpPTkFfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dN
ODQwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTTgzMVhfSTJDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1dNODMxWF9TUEkgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004MzUwX0kyQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9XTTg5OTQgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1Ig
aXMgbm90IHNldAojIENPTkZJR19NRURJQV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGlj
cyBzdXBwb3J0CiMKIyBDT05GSUdfRFJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVkdBU1RBVEUgaXMg
bm90IHNldApDT05GSUdfVklERU9fT1VUUFVUX0NPTlRST0w9eQojIENPTkZJR19GQiBpcyBub3Qg
c2V0CiMgQ09ORklHX0VYWU5PU19WSURFTyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9M
Q0RfU1VQUE9SVCBpcyBub3Qgc2V0CgojCiMgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0
CiMKQ09ORklHX1ZHQV9DT05TT0xFPXkKIyBDT05GSUdfVkdBQ09OX1NPRlRfU0NST0xMQkFDSyBp
cyBub3Qgc2V0CkNPTkZJR19EVU1NWV9DT05TT0xFPXkKIyBDT05GSUdfU09VTkQgaXMgbm90IHNl
dAoKIwojIEhJRCBzdXBwb3J0CiMKQ09ORklHX0hJRD1tCiMgQ09ORklHX0hJRFJBVyBpcyBub3Qg
c2V0CiMgQ09ORklHX1VISUQgaXMgbm90IHNldApDT05GSUdfSElEX0dFTkVSSUM9bQoKIwojIFNw
ZWNpYWwgSElEIGRyaXZlcnMKIwojIENPTkZJR19ISURfQTRURUNIIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX0FDUlVYIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FQUExFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX0FQUExFSVIgaXMgbm90IHNldAojIENPTkZJR19ISURfQVVSRUFMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX0JFTEtJTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DSEVSUlkgaXMg
bm90IHNldAojIENPTkZJR19ISURfQ0hJQ09OWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DWVBS
RVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0RSQUdPTlJJU0UgaXMgbm90IHNldAojIENPTkZJ
R19ISURfRU1TX0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VMRUNPTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9FTE8gaXMgbm90IHNldAojIENPTkZJR19ISURfRVpLRVkgaXMgbm90IHNldAoj
IENPTkZJR19ISURfSE9MVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0hVSU9OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX0tFWVRPVUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tZRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9VQ0xPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dBTFRP
UCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9HWVJBVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9JQ0FERSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9UV0lOSEFOIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX0tFTlNJTkdUT04gaXMgbm90IHNldAojIENPTkZJR19ISURfTENQT1dFUiBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9MRU5PVk9fVFBLQkQgaXMgbm90IHNldAojIENPTkZJR19ISURfTE9H
SVRFQ0ggaXMgbm90IHNldAojIENPTkZJR19ISURfTUFHSUNNT1VTRSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9NSUNST1NPRlQgaXMgbm90IHNldAojIENPTkZJR19ISURfTU9OVEVSRVkgaXMgbm90
IHNldAojIENPTkZJR19ISURfTVVMVElUT1VDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9OVFJJ
RyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9PUlRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9Q
QU5USEVSTE9SRCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9QRVRBTFlOWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9QSUNPTENEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BSSU1BWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0hJRF9ST0NDQVQgaXMgbm90IHNldAojIENPTkZJR19ISURfU0FJVEVLIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX1NBTVNVTkcgaXMgbm90IHNldAojIENPTkZJR19ISURfU1BF
RURMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NURUVMU0VSSUVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX1NVTlBMVVMgaXMgbm90IHNldAojIENPTkZJR19ISURfR1JFRU5BU0lBIGlzIG5v
dCBzZXQKIyBDT05GSUdfSElEX1NNQVJUSk9ZUExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9U
SVZPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1RPUFNFRUQgaXMgbm90IHNldAojIENPTkZJR19I
SURfVEhSVVNUTUFTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1hJTk1PIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1pFUk9QTFVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1pZREFDUk9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX1NFTlNPUl9IVUIgaXMgbm90IHNldAoKIwojIFVTQiBISUQg
c3VwcG9ydAojCkNPTkZJR19VU0JfSElEPW0KIyBDT05GSUdfSElEX1BJRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9ISURERVYgaXMgbm90IHNldAoKIwojIFVTQiBISUQgQm9vdCBQcm90b2NvbCBk
cml2ZXJzCiMKIyBDT05GSUdfVVNCX0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NT1VTRSBp
cyBub3Qgc2V0CgojCiMgSTJDIEhJRCBzdXBwb3J0CiMKIyBDT05GSUdfSTJDX0hJRCBpcyBub3Qg
c2V0CkNPTkZJR19VU0JfT0hDSV9MSVRUTEVfRU5ESUFOPXkKQ09ORklHX1VTQl9TVVBQT1JUPXkK
Q09ORklHX1VTQl9DT01NT049eQpDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15CkNPTkZJR19VU0I9
eQojIENPTkZJR19VU0JfREVCVUcgaXMgbm90IHNldApDT05GSUdfVVNCX0FOTk9VTkNFX05FV19E
RVZJQ0VTPXkKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09ORklHX1VTQl9ERUZB
VUxUX1BFUlNJU1Q9eQojIENPTkZJR19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAojIENP
TkZJR19VU0JfT1RHX1dISVRFTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdfQkxBQ0tM
SVNUX0hVQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NT04gaXMgbm90IHNldAojIENPTkZJR19V
U0JfV1VTQl9DQkFGIGlzIG5vdCBzZXQKCiMKIyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMK
IwojIENPTkZJR19VU0JfQzY3WDAwX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9YSENJX0hD
RCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQpDT05GSUdfVVNCX0VIQ0lfUk9PVF9I
VUJfVFQ9eQojIENPTkZJR19VU0JfRUhDSV9UVF9ORVdTQ0hFRCBpcyBub3Qgc2V0CkNPTkZJR19V
U0JfRlNMX01QSF9EUl9PRj15CiMgQ09ORklHX1hQU19VU0JfSENEX1hJTElOWCBpcyBub3Qgc2V0
CkNPTkZJR19VU0JfRUhDSV9GU0w9eQpDT05GSUdfVVNCX0VIQ0lfSENEX1BQQ19PRj15CiMgQ09O
RklHX1VTQl9FSENJX0hDRF9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PWFUyMTBI
UF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTE2WF9IQ0QgaXMgbm90IHNldAojIENP
TkZJR19VU0JfSVNQMTc2MF9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTM2Ml9IQ0Qg
aXMgbm90IHNldAojIENPTkZJR19VU0JfRlVTQkgyMDBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0ZPVEcyMTBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09IQ0lfSENEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NMODExX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SOEE2NjU5
N19IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfSENEX1RFU1RfTU9ERSBpcyBub3Qgc2V0Cgoj
CiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0FDTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9QUklOVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1dETSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9UTUMgaXMgbm90IHNldAoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGRl
cGVuZHMgb24gU0NTSSBidXQgQkxLX0RFVl9TRCBtYXkKIwoKIwojIGFsc28gYmUgbmVlZGVkOyBz
ZWUgVVNCX1NUT1JBR0UgSGVscCBmb3IgbW9yZSBpbmZvCiMKQ09ORklHX1VTQl9TVE9SQUdFPXkK
IyBDT05GSUdfVVNCX1NUT1JBR0VfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFH
RV9SRUFMVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfREFUQUZBQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0ZSRUVDT00gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U1RPUkFHRV9JU0QyMDAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9VU0JBVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFIwOSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TVE9SQUdFX1NERFI1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0pVTVBTSE9U
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfQUxBVURBIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NUT1JBR0VfT05FVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9L
QVJNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0NZUFJFU1NfQVRBQ0IgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9FTkVfVUI2MjUwIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
SW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EV0MzIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0NISVBJREVBIGlzIG5vdCBzZXQKCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKIyBD
T05GSUdfVVNCX1NFUklBTCBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2NlbGxhbmVvdXMgZHJpdmVy
cwojCiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FTUkyNiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9BRFVUVVggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VWU0VH
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JJTzUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9M
RUdPVE9XRVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTENEIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0xFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVBSRVNTX0NZN0M2MyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9DWVRIRVJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lETU9VU0UgaXMg
bm90IHNldAojIENPTkZJR19VU0JfRlRESV9FTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FQ
UExFRElTUExBWSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TSVNVU0JWR0EgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfTEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfVFJBTkNFVklCUkFUT1IgaXMg
bm90IHNldAojIENPTkZJR19VU0JfSU9XQVJSSU9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RF
U1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfRUhTRVRfVEVTVF9GSVhUVVJFIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0lTSUdIVEZXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1lVUkVYIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0VaVVNCX0ZYMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9IU0lD
X1VTQjM1MDMgaXMgbm90IHNldAoKIwojIFVTQiBQaHlzaWNhbCBMYXllciBkcml2ZXJzCiMKIyBD
T05GSUdfVVNCX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX05PUF9VU0JfWENFSVYgaXMgbm90IHNl
dAojIENPTkZJR19BTTMzNVhfUEhZX1VTQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVNVTkdfVVNC
MlBIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVNVTkdfVVNCM1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9JU1AxMzAxIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JDQVJfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX0dBREdFVCBpcyBub3Qgc2V0CkNPTkZJR19NTUM9eQojIENPTkZJR19N
TUNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NTUNfVU5TQUZFX1JFU1VNRSBpcyBub3Qgc2V0
CiMgQ09ORklHX01NQ19DTEtHQVRFIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QvU0RJTyBDYXJkIERy
aXZlcnMKIwpDT05GSUdfTU1DX0JMT0NLPXkKQ09ORklHX01NQ19CTE9DS19NSU5PUlM9OApDT05G
SUdfTU1DX0JMT0NLX0JPVU5DRT15CiMgQ09ORklHX1NESU9fVUFSVCBpcyBub3Qgc2V0CiMgQ09O
RklHX01NQ19URVNUIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QvU0RJTyBIb3N0IENvbnRyb2xsZXIg
RHJpdmVycwojCkNPTkZJR19NTUNfU0RIQ0k9eQpDT05GSUdfTU1DX1NESENJX0lPX0FDQ0VTU09S
Uz15CkNPTkZJR19NTUNfU0RIQ0lfQklHX0VORElBTl8zMkJJVF9CWVRFX1NXQVBQRVI9eQpDT05G
SUdfTU1DX1NESENJX1BMVEZNPW0KQ09ORklHX01NQ19TREhDSV9PRl9FU0RIQz1tCiMgQ09ORklH
X01NQ19TREhDSV9PRl9ITFdEIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DX1NQSSBpcyBub3Qgc2V0
CiMgQ09ORklHX01NQ19WVUIzMDAgaXMgbm90IHNldAojIENPTkZJR19NTUNfVVNIQyBpcyBub3Qg
c2V0CiMgQ09ORklHX01FTVNUSUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVXX0xFRFMgaXMgbm90
IHNldAojIENPTkZJR19BQ0NFU1NJQklMSVRZIGlzIG5vdCBzZXQKQ09ORklHX0VEQUM9eQpDT05G
SUdfRURBQ19MRUdBQ1lfU1lTRlM9eQojIENPTkZJR19FREFDX0RFQlVHIGlzIG5vdCBzZXQKQ09O
RklHX0VEQUNfTU1fRURBQz1tCkNPTkZJR19FREFDX01QQzg1WFg9bQpDT05GSUdfUlRDX0xJQj15
CkNPTkZJR19SVENfQ0xBU1M9eQpDT05GSUdfUlRDX0hDVE9TWVM9eQpDT05GSUdfUlRDX1NZU1RP
SEM9eQpDT05GSUdfUlRDX0hDVE9TWVNfREVWSUNFPSJydGMwIgojIENPTkZJR19SVENfREVCVUcg
aXMgbm90IHNldAoKIwojIFJUQyBpbnRlcmZhY2VzCiMKQ09ORklHX1JUQ19JTlRGX1NZU0ZTPXkK
Q09ORklHX1JUQ19JTlRGX1BST0M9eQpDT05GSUdfUlRDX0lOVEZfREVWPXkKIyBDT05GSUdfUlRD
X0lOVEZfREVWX1VJRV9FTVVMIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9URVNUIGlzIG5v
dCBzZXQKCiMKIyBJMkMgUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENfRFJWX0RTMTMwNyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9EUzE2NzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMzIzMiBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfTUFYNjkwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlM1QzM3
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwOCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfSVNMMTIwMjIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1gxMjA1IGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0YyMTI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9QQ0Y4NTIzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTYzIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDFU
ODAgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0JRMzJLIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9TMzUzOTBBIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9GTTMxMzAgaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX1JYODU4MSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
Ulg4MDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9FTTMwMjcgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX1JWMzAyOUMyIGlzIG5vdCBzZXQKCiMKIyBTUEkgUlRDIGRyaXZlcnMKIwoj
IENPTkZJR19SVENfRFJWX000MVQ5MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQxVDk0
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzEzMDUgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0RTMTM5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTUFYNjkwMiBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfUjk3MDEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JT
NUMzNDggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMzIzNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfUENGMjEyMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg0NTgxIGlz
IG5vdCBzZXQKCiMKIyBQbGF0Zm9ybSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfRFJWX0NNT1M9
eQojIENPTkZJR19SVENfRFJWX0RTMTI4NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMx
NTExIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1NTMgaXMgbm90IHNldAojIENPTkZJ
R19SVENfRFJWX0RTMTc0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfU1RLMTdUQTggaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX000OFQ4NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19E
UlZfTTQ4VDM1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUNTkgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX01TTTYyNDIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0JRNDgw
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlA1QzAxIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9WMzAyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMyNDA0IGlzIG5vdCBz
ZXQKCiMKIyBvbi1DUFUgUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENfRFJWX0dFTkVSSUMgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1NOVlMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X01PWEFSVCBpcyBub3Qgc2V0CgojCiMgSElEIFNlbnNvciBSVEMgZHJpdmVycwojCiMgQ09ORklH
X1JUQ19EUlZfSElEX1NFTlNPUl9USU1FIGlzIG5vdCBzZXQKQ09ORklHX0RNQURFVklDRVM9eQoj
IENPTkZJR19ETUFERVZJQ0VTX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBETUEgRGV2aWNlcwojCkNP
TkZJR19BU1lOQ19UWF9FTkFCTEVfQ0hBTk5FTF9TV0lUQ0g9eQojIENPTkZJR19EV19ETUFDX0NP
UkUgaXMgbm90IHNldAojIENPTkZJR19EV19ETUFDIGlzIG5vdCBzZXQKQ09ORklHX0ZTTF9ETUE9
eQojIENPTkZJR19USU1CX0RNQSBpcyBub3Qgc2V0CkNPTkZJR19ETUFfRU5HSU5FPXkKQ09ORklH
X0RNQV9PRj15CgojCiMgRE1BIENsaWVudHMKIwojIENPTkZJR19BU1lOQ19UWF9ETUEgaXMgbm90
IHNldAojIENPTkZJR19ETUFURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVYRElTUExBWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRfRFJJVkVSUyBpcyBu
b3Qgc2V0CgojCiMgVmlydGlvIGRyaXZlcnMKIwojIENPTkZJR19WSVJUSU9fTU1JTyBpcyBub3Qg
c2V0CgojCiMgTWljcm9zb2Z0IEh5cGVyLVYgZ3Vlc3Qgc3VwcG9ydAojCiMgQ09ORklHX1NUQUdJ
TkcgaXMgbm90IHNldAoKIwojIEhhcmR3YXJlIFNwaW5sb2NrIGRyaXZlcnMKIwojIENPTkZJR19N
QUlMQk9YIGlzIG5vdCBzZXQKQ09ORklHX0lPTU1VX1NVUFBPUlQ9eQpDT05GSUdfT0ZfSU9NTVU9
eQoKIwojIFJlbW90ZXByb2MgZHJpdmVycwojCiMgQ09ORklHX1NURV9NT0RFTV9SUFJPQyBpcyBu
b3Qgc2V0CgojCiMgUnBtc2cgZHJpdmVycwojCiMgQ09ORklHX1BNX0RFVkZSRVEgaXMgbm90IHNl
dAojIENPTkZJR19FWFRDT04gaXMgbm90IHNldAojIENPTkZJR19NRU1PUlkgaXMgbm90IHNldAoj
IENPTkZJR19JSU8gaXMgbm90IHNldAojIENPTkZJR19QV00gaXMgbm90IHNldApDT05GSUdfSVJR
Q0hJUD15CiMgQ09ORklHX0lQQUNLX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFU0VUX0NPTlRS
T0xMRVIgaXMgbm90IHNldAojIENPTkZJR19GTUMgaXMgbm90IHNldAoKIwojIEZpbGUgc3lzdGVt
cwojCkNPTkZJR19FWFQyX0ZTPXkKQ09ORklHX0VYVDJfRlNfWEFUVFI9eQojIENPTkZJR19FWFQy
X0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfU0VDVVJJVFkgaXMgbm90
IHNldAojIENPTkZJR19FWFQyX0ZTX1hJUCBpcyBub3Qgc2V0CkNPTkZJR19FWFQzX0ZTPXkKIyBD
T05GSUdfRVhUM19ERUZBVUxUU19UT19PUkRFUkVEIGlzIG5vdCBzZXQKQ09ORklHX0VYVDNfRlNf
WEFUVFI9eQojIENPTkZJR19FWFQzX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0VY
VDNfRlNfU0VDVVJJVFkgaXMgbm90IHNldApDT05GSUdfRVhUNF9GUz15CiMgQ09ORklHX0VYVDRf
RlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUNF9GU19TRUNVUklUWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0VYVDRfREVCVUcgaXMgbm90IHNldApDT05GSUdfSkJEPXkKIyBDT05GSUdf
SkJEX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0pCRDI9eQojIENPTkZJR19KQkQyX0RFQlVHIGlz
IG5vdCBzZXQKQ09ORklHX0ZTX01CQ0FDSEU9eQojIENPTkZJR19SRUlTRVJGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0dGUzJfRlMgaXMgbm90IHNldAojIENPTkZJR19PQ0ZTMl9GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0JUUkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTklMRlMyX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19FWFBPUlRGUz1tCkNPTkZJR19GSUxFX0xP
Q0tJTkc9eQpDT05GSUdfRlNOT1RJRlk9eQpDT05GSUdfRE5PVElGWT15CkNPTkZJR19JTk9USUZZ
X1VTRVI9eQojIENPTkZJR19GQU5PVElGWSBpcyBub3Qgc2V0CkNPTkZJR19RVU9UQT15CiMgQ09O
RklHX1FVT1RBX05FVExJTktfSU5URVJGQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJJTlRfUVVP
VEFfV0FSTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX1FVT1RBX0RFQlVHIGlzIG5vdCBzZXQKIyBD
T05GSUdfUUZNVF9WMSBpcyBub3Qgc2V0CiMgQ09ORklHX1FGTVRfVjIgaXMgbm90IHNldApDT05G
SUdfUVVPVEFDVEw9eQojIENPTkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVT
RV9GUyBpcyBub3Qgc2V0CgojCiMgQ2FjaGVzCiMKIyBDT05GSUdfRlNDQUNIRSBpcyBub3Qgc2V0
CgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCkNPTkZJR19JU085NjYwX0ZTPW0KQ09ORklH
X0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQpDT05GSUdfVURGX0ZTPW0KQ09ORklHX1VERl9OTFM9
eQoKIwojIERPUy9GQVQvTlQgRmlsZXN5c3RlbXMKIwpDT05GSUdfRkFUX0ZTPXkKQ09ORklHX01T
RE9TX0ZTPW0KQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBBR0U9NDM3
CkNPTkZJR19GQVRfREVGQVVMVF9JT0NIQVJTRVQ9Imlzbzg4NTktMSIKQ09ORklHX05URlNfRlM9
eQojIENPTkZJR19OVEZTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRGU19SVyBpcyBub3Qg
c2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9eQpDT05GSUdfUFJP
Q19LQ09SRT15CkNPTkZJR19QUk9DX1NZU0NUTD15CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15
CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15CiMgQ09ORklHX1RNUEZTX1BPU0lYX0FDTCBp
cyBub3Qgc2V0CiMgQ09ORklHX1RNUEZTX1hBVFRSIGlzIG5vdCBzZXQKIyBDT05GSUdfSFVHRVRM
Ql9QQUdFIGlzIG5vdCBzZXQKQ09ORklHX0NPTkZJR0ZTX0ZTPW0KQ09ORklHX01JU0NfRklMRVNZ
U1RFTVM9eQojIENPTkZJR19BREZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VDUllQVF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hGU1BMVVNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlzIG5v
dCBzZXQKQ09ORklHX0pGRlMyX0ZTPXkKQ09ORklHX0pGRlMyX0ZTX0RFQlVHPTAKQ09ORklHX0pG
RlMyX0ZTX1dSSVRFQlVGRkVSPXkKIyBDT05GSUdfSkZGUzJfRlNfV0JVRl9WRVJJRlkgaXMgbm90
IHNldAojIENPTkZJR19KRkZTMl9TVU1NQVJZIGlzIG5vdCBzZXQKQ09ORklHX0pGRlMyX0ZTX1hB
VFRSPXkKQ09ORklHX0pGRlMyX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19KRkZTMl9GU19TRUNVUklU
WT15CiMgQ09ORklHX0pGRlMyX0NPTVBSRVNTSU9OX09QVElPTlMgaXMgbm90IHNldApDT05GSUdf
SkZGUzJfWkxJQj15CiMgQ09ORklHX0pGRlMyX0xaTyBpcyBub3Qgc2V0CkNPTkZJR19KRkZTMl9S
VElNRT15CiMgQ09ORklHX0pGRlMyX1JVQklOIGlzIG5vdCBzZXQKIyBDT05GSUdfTE9HRlMgaXMg
bm90IHNldAojIENPTkZJR19DUkFNRlMgaXMgbm90IHNldAojIENPTkZJR19TUVVBU0hGUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX09NRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19IUEZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19QU1RPUkUgaXMg
bm90IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVUZTX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfRjJGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JLX0ZJTEVTWVNU
RU1TPXkKQ09ORklHX05GU19GUz15CkNPTkZJR19ORlNfVjI9eQpDT05GSUdfTkZTX1YzPXkKQ09O
RklHX05GU19WM19BQ0w9eQpDT05GSUdfTkZTX1Y0PXkKIyBDT05GSUdfTkZTX1NXQVAgaXMgbm90
IHNldAojIENPTkZJR19ORlNfVjRfMSBpcyBub3Qgc2V0CkNPTkZJR19ST09UX05GUz15CiMgQ09O
RklHX05GU19VU0VfTEVHQUNZX0ROUyBpcyBub3Qgc2V0CkNPTkZJR19ORlNfVVNFX0tFUk5FTF9E
TlM9eQpDT05GSUdfTkZTRD1tCkNPTkZJR19ORlNEX1YyX0FDTD15CkNPTkZJR19ORlNEX1YzPXkK
Q09ORklHX05GU0RfVjNfQUNMPXkKQ09ORklHX05GU0RfVjQ9eQojIENPTkZJR19ORlNEX0ZBVUxU
X0lOSkVDVElPTiBpcyBub3Qgc2V0CkNPTkZJR19MT0NLRD15CkNPTkZJR19MT0NLRF9WND15CkNP
TkZJR19ORlNfQUNMX1NVUFBPUlQ9eQpDT05GSUdfTkZTX0NPTU1PTj15CkNPTkZJR19TVU5SUEM9
eQpDT05GSUdfU1VOUlBDX0dTUz15CkNPTkZJR19SUENTRUNfR1NTX0tSQjU9bQojIENPTkZJR19T
VU5SUENfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19DRVBIX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NP
REFfRlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMgaXMgbm90IHNldApDT05GSUdfTkxTPXkK
Q09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiCkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV83NzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODUwIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjEg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjQgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjkgaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQ
QUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90IHNldAojIENP
TkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV8x
MjUxIGlzIG5vdCBzZXQKQ09ORklHX05MU19BU0NJST1tCkNPTkZJR19OTFNfSVNPODg1OV8xPXkK
IyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzMg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzYgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfOSBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfMTQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNSBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19LT0k4X1IgaXMgbm90IHNldAojIENPTkZJR19OTFNfS09JOF9VIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX01BQ19ST01BTiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNf
Q0VMVElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19DRU5URVVSTyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19NQUNfQ1JPQVRJQU4gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX0NZUklM
TElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19HQUVMSUMgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfTUFDX0dSRUVLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19JQ0VMQU5EIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX01BQ19JTlVJVCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNf
Uk9NQU5JQU4gaXMgbm90IHNldAojIENPTkZJR19OTFNfTUFDX1RVUktJU0ggaXMgbm90IHNldApD
T05GSUdfTkxTX1VURjg9bQojIENPTkZJR19ETE0gaXMgbm90IHNldApDT05GSUdfQklOQVJZX1BS
SU5URj15CgojCiMgTGlicmFyeSByb3V0aW5lcwojCkNPTkZJR19CSVRSRVZFUlNFPXkKQ09ORklH
X0dFTkVSSUNfU1RSTkNQWV9GUk9NX1VTRVI9eQpDT05GSUdfR0VORVJJQ19TVFJOTEVOX1VTRVI9
eQpDT05GSUdfR0VORVJJQ19ORVRfVVRJTFM9eQpDT05GSUdfR0VORVJJQ19JTz15CkNPTkZJR19Q
RVJDUFVfUldTRU09eQojIENPTkZJR19DUkNfQ0NJVFQgaXMgbm90IHNldApDT05GSUdfQ1JDMTY9
eQpDT05GSUdfQ1JDX1QxMERJRj15CkNPTkZJR19DUkNfSVRVX1Q9bQpDT05GSUdfQ1JDMzI9eQoj
IENPTkZJR19DUkMzMl9TRUxGVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMl9TTElDRUJZOD15
CiMgQ09ORklHX0NSQzMyX1NMSUNFQlk0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfU0FSV0FU
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzMyX0JJVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQzcg
aXMgbm90IHNldApDT05GSUdfTElCQ1JDMzJDPXkKIyBDT05GSUdfQ1JDOCBpcyBub3Qgc2V0CkNP
TkZJR19aTElCX0lORkxBVEU9eQpDT05GSUdfWkxJQl9ERUZMQVRFPXkKQ09ORklHX0xaT19DT01Q
UkVTUz1tCkNPTkZJR19MWk9fREVDT01QUkVTUz15CkNPTkZJR19YWl9ERUM9eQojIENPTkZJR19Y
Wl9ERUNfWDg2IGlzIG5vdCBzZXQKQ09ORklHX1haX0RFQ19QT1dFUlBDPXkKIyBDT05GSUdfWFpf
REVDX0lBNjQgaXMgbm90IHNldAojIENPTkZJR19YWl9ERUNfQVJNIGlzIG5vdCBzZXQKIyBDT05G
SUdfWFpfREVDX0FSTVRIVU1CIGlzIG5vdCBzZXQKIyBDT05GSUdfWFpfREVDX1NQQVJDIGlzIG5v
dCBzZXQKQ09ORklHX1haX0RFQ19CQ0o9eQojIENPTkZJR19YWl9ERUNfVEVTVCBpcyBub3Qgc2V0
CkNPTkZJR19ERUNPTVBSRVNTX0daSVA9eQpDT05GSUdfREVDT01QUkVTU19CWklQMj15CkNPTkZJ
R19ERUNPTVBSRVNTX0xaTUE9eQpDT05GSUdfREVDT01QUkVTU19YWj15CkNPTkZJR19ERUNPTVBS
RVNTX0xaTz15CkNPTkZJR19URVhUU0VBUkNIPXkKQ09ORklHX1RFWFRTRUFSQ0hfS01QPW0KQ09O
RklHX1RFWFRTRUFSQ0hfQk09bQpDT05GSUdfVEVYVFNFQVJDSF9GU009bQpDT05GSUdfSEFTX0lP
TUVNPXkKQ09ORklHX0hBU19JT1BPUlQ9eQpDT05GSUdfSEFTX0RNQT15CkNPTkZJR19DUFVfUk1B
UD15CkNPTkZJR19EUUw9eQpDT05GSUdfTkxBVFRSPXkKQ09ORklHX0dFTkVSSUNfQVRPTUlDNjQ9
eQpDT05GSUdfQVJDSF9IQVNfQVRPTUlDNjRfREVDX0lGX1BPU0lUSVZFPXkKQ09ORklHX0xSVV9D
QUNIRT1tCiMgQ09ORklHX0FWRVJBR0UgaXMgbm90IHNldApDT05GSUdfQ0xaX1RBQj15CiMgQ09O
RklHX0NPUkRJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0REUiBpcyBub3Qgc2V0CkNPTkZJR19NUElM
SUI9bQpDT05GSUdfT0lEX1JFR0lTVFJZPXkKCiMKIyBLZXJuZWwgaGFja2luZwojCgojCiMgcHJp
bnRrIGFuZCBkbWVzZyBvcHRpb25zCiMKIyBDT05GSUdfUFJJTlRLX1RJTUUgaXMgbm90IHNldApD
T05GSUdfREVGQVVMVF9NRVNTQUdFX0xPR0xFVkVMPTQKIyBDT05GSUdfRFlOQU1JQ19ERUJVRyBp
cyBub3Qgc2V0CgojCiMgQ29tcGlsZS10aW1lIGNoZWNrcyBhbmQgY29tcGlsZXIgb3B0aW9ucwoj
CkNPTkZJR19ERUJVR19JTkZPPXkKIyBDT05GSUdfREVCVUdfSU5GT19SRURVQ0VEIGlzIG5vdCBz
ZXQKQ09ORklHX0VOQUJMRV9XQVJOX0RFUFJFQ0FURUQ9eQpDT05GSUdfRU5BQkxFX01VU1RfQ0hF
Q0s9eQpDT05GSUdfRlJBTUVfV0FSTj0xMDI0CiMgQ09ORklHX1NUUklQX0FTTV9TWU1TIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVBREFCTEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5VU0VEX1NZ
TUJPTFMgaXMgbm90IHNldApDT05GSUdfREVCVUdfRlM9eQojIENPTkZJR19IRUFERVJTX0NIRUNL
IGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0VDVElPTl9NSVNNQVRDSCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFQlVHX0ZPUkNFX1dFQUtfUEVSX0NQVSBpcyBub3Qgc2V0CkNPTkZJR19NQUdJQ19T
WVNSUT15CkNPTkZJR19ERUJVR19LRVJORUw9eQoKIwojIE1lbW9yeSBEZWJ1Z2dpbmcKIwojIENP
TkZJR19ERUJVR19QQUdFQUxMT0MgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19PQkpFQ1RTIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0xVQl9ERUJVR19PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NMVUJf
U1RBVFMgaXMgbm90IHNldApDT05GSUdfSEFWRV9ERUJVR19LTUVNTEVBSz15CiMgQ09ORklHX0RF
QlVHX0tNRU1MRUFLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1RBQ0tfVVNBR0UgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19WTSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX01FTU9SWV9J
TklUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUEVSX0NQVV9NQVBTIGlzIG5vdCBzZXQKQ09O
RklHX0hBVkVfREVCVUdfU1RBQ0tPVkVSRkxPVz15CiMgQ09ORklHX0RFQlVHX1NUQUNLT1ZFUkZM
T1cgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TSElSUSBpcyBub3Qgc2V0CgojCiMgRGVidWcg
TG9ja3VwcyBhbmQgSGFuZ3MKIwojIENPTkZJR19MT0NLVVBfREVURUNUT1IgaXMgbm90IHNldApD
T05GSUdfREVURUNUX0hVTkdfVEFTSz15CkNPTkZJR19ERUZBVUxUX0hVTkdfVEFTS19USU1FT1VU
PTEyMAojIENPTkZJR19CT09UUEFSQU1fSFVOR19UQVNLX1BBTklDIGlzIG5vdCBzZXQKQ09ORklH
X0JPT1RQQVJBTV9IVU5HX1RBU0tfUEFOSUNfVkFMVUU9MAojIENPTkZJR19QQU5JQ19PTl9PT1BT
IGlzIG5vdCBzZXQKQ09ORklHX1BBTklDX09OX09PUFNfVkFMVUU9MApDT05GSUdfU0NIRURfREVC
VUc9eQojIENPTkZJR19TQ0hFRFNUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfVElNRVJfU1RBVFMg
aXMgbm90IHNldAoKIwojIExvY2sgRGVidWdnaW5nIChzcGlubG9ja3MsIG11dGV4ZXMsIGV0Yy4u
LikKIwojIENPTkZJR19ERUJVR19SVF9NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRfTVVU
RVhfVEVTVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1BJTkxPQ0sgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19NVVRFWEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfV1dfTVVURVhf
U0xPV1BBVEggaXMgbm90IHNldAojIENPTkZJR19ERUJVR19MT0NLX0FMTE9DIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFJPVkVfTE9DS0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfU1RBVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX0xPQ0tJTkdfQVBJX1NFTEZURVNUUyBpcyBub3Qgc2V0CkNPTkZJR19TVEFDS1RSQUNFPXkK
IyBDT05GSUdfREVCVUdfS09CSkVDVCBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19CVUdWRVJCT1NF
PXkKIyBDT05GSUdfREVCVUdfV1JJVEVDT1VOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xJ
U1QgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X05PVElGSUVSUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0NSRURFTlRJQUxTIGlzIG5vdCBz
ZXQKCiMKIyBSQ1UgRGVidWdnaW5nCiMKIyBDT05GSUdfU1BBUlNFX1JDVV9QT0lOVEVSIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkNVX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19SQ1VfQ1BV
X1NUQUxMX1RJTUVPVVQ9MjEKIyBDT05GSUdfUkNVX0NQVV9TVEFMTF9JTkZPIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkNVX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfQkxPQ0tfRVhUX0RF
VlQgaXMgbm90IHNldAojIENPTkZJR19OT1RJRklFUl9FUlJPUl9JTkpFQ1RJT04gaXMgbm90IHNl
dAojIENPTkZJR19GQVVMVF9JTkpFQ1RJT04gaXMgbm90IHNldAojIENPTkZJR19MQVRFTkNZVE9Q
IGlzIG5vdCBzZXQKQ09ORklHX05PUF9UUkFDRVI9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9UUkFD
RVI9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9HUkFQSF9UUkFDRVI9eQpDT05GSUdfSEFWRV9EWU5B
TUlDX0ZUUkFDRT15CkNPTkZJR19IQVZFX0ZUUkFDRV9NQ09VTlRfUkVDT1JEPXkKQ09ORklHX0hB
VkVfU1lTQ0FMTF9UUkFDRVBPSU5UUz15CkNPTkZJR19UUkFDRV9DTE9DSz15CkNPTkZJR19SSU5H
X0JVRkZFUj15CkNPTkZJR19FVkVOVF9UUkFDSU5HPXkKQ09ORklHX0NPTlRFWFRfU1dJVENIX1RS
QUNFUj15CkNPTkZJR19UUkFDSU5HPXkKQ09ORklHX1RSQUNJTkdfU1VQUE9SVD15CkNPTkZJR19G
VFJBQ0U9eQojIENPTkZJR19GVU5DVElPTl9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19JUlFT
T0ZGX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX1RSQUNFUiBpcyBub3Qgc2V0CkNP
TkZJR19FTkFCTEVfREVGQVVMVF9UUkFDRVJTPXkKIyBDT05GSUdfRlRSQUNFX1NZU0NBTExTIGlz
IG5vdCBzZXQKIyBDT05GSUdfVFJBQ0VSX1NOQVBTSE9UIGlzIG5vdCBzZXQKQ09ORklHX0JSQU5D
SF9QUk9GSUxFX05PTkU9eQojIENPTkZJR19QUk9GSUxFX0FOTk9UQVRFRF9CUkFOQ0hFUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BST0ZJTEVfQUxMX0JSQU5DSEVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U1RBQ0tfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JT19UUkFDRSBpcyBub3Qg
c2V0CkNPTkZJR19LUFJPQkVfRVZFTlQ9eQpDT05GSUdfVVBST0JFX0VWRU5UPXkKQ09ORklHX1BS
T0JFX0VWRU5UUz15CiMgQ09ORklHX1JJTkdfQlVGRkVSX0JFTkNITUFSSyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JJTkdfQlVGRkVSX1NUQVJUVVBfVEVTVCBpcyBub3Qgc2V0CgojCiMgUnVudGltZSBU
ZXN0aW5nCiMKIyBDT05GSUdfTEtEVE0gaXMgbm90IHNldAojIENPTkZJR19URVNUX0xJU1RfU09S
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0tQUk9CRVNfU0FOSVRZX1RFU1QgaXMgbm90IHNldAojIENP
TkZJR19CQUNLVFJBQ0VfU0VMRl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkJUUkVFX1RFU1Qg
aXMgbm90IHNldAojIENPTkZJR19JTlRFUlZBTF9UUkVFX1RFU1QgaXMgbm90IHNldAojIENPTkZJ
R19BVE9NSUM2NF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfU1RSSU5HX0hFTFBF
UlMgaXMgbm90IHNldAojIENPTkZJR19URVNUX0tTVFJUT1ggaXMgbm90IHNldAojIENPTkZJR19E
TUFfQVBJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNUExFUyBpcyBub3Qgc2V0CkNPTkZJ
R19IQVZFX0FSQ0hfS0dEQj15CkNPTkZJR19LR0RCPXkKQ09ORklHX0tHREJfU0VSSUFMX0NPTlNP
TEU9eQojIENPTkZJR19LR0RCX1RFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfS0dEQl9LREIgaXMg
bm90IHNldAojIENPTkZJR19QUENfRElTQUJMRV9XRVJST1IgaXMgbm90IHNldApDT05GSUdfUFBD
X1dFUlJPUj15CkNPTkZJR19QUklOVF9TVEFDS19ERVBUSD02NAojIENPTkZJR19QUENfRU1VTEFU
RURfU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19DT0RFX1BBVENISU5HX1NFTEZURVNUIGlzIG5v
dCBzZXQKIyBDT05GSUdfRlRSX0ZJWFVQX1NFTEZURVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfTVNJ
X0JJVE1BUF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1hNT04gaXMgbm90IHNldApDT05G
SUdfREVCVUdHRVI9eQojIENPTkZJR19CRElfU1dJVENIIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBD
X0VBUkxZX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1NUUklDVF9ERVZNRU09eQoKIwojIFNlY3Vy
aXR5IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15CiMgQ09ORklHX0VOQ1JZUFRFRF9LRVlTIGlzIG5v
dCBzZXQKIyBDT05GSUdfS0VZU19ERUJVR19QUk9DX0tFWVMgaXMgbm90IHNldAojIENPTkZJR19T
RUNVUklUWV9ETUVTR19SRVNUUklDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VDVVJJVFlGUyBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX1NFQ1VS
SVRZX0RBQz15CkNPTkZJR19ERUZBVUxUX1NFQ1VSSVRZPSIiCkNPTkZJR19DUllQVE89eQoKIwoj
IENyeXB0byBjb3JlIG9yIGhlbHBlcgojCkNPTkZJR19DUllQVE9fQUxHQVBJPXkKQ09ORklHX0NS
WVBUT19BTEdBUEkyPXkKQ09ORklHX0NSWVBUT19BRUFEPXkKQ09ORklHX0NSWVBUT19BRUFEMj15
CkNPTkZJR19DUllQVE9fQkxLQ0lQSEVSPXkKQ09ORklHX0NSWVBUT19CTEtDSVBIRVIyPXkKQ09O
RklHX0NSWVBUT19IQVNIPXkKQ09ORklHX0NSWVBUT19IQVNIMj15CkNPTkZJR19DUllQVE9fUk5H
PW0KQ09ORklHX0NSWVBUT19STkcyPXkKQ09ORklHX0NSWVBUT19QQ09NUD1tCkNPTkZJR19DUllQ
VE9fUENPTVAyPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSPXkKQ09ORklHX0NSWVBUT19NQU5BR0VS
Mj15CkNPTkZJR19DUllQVE9fVVNFUj1tCkNPTkZJR19DUllQVE9fTUFOQUdFUl9ESVNBQkxFX1RF
U1RTPXkKQ09ORklHX0NSWVBUT19HRjEyOE1VTD1tCkNPTkZJR19DUllQVE9fTlVMTD1tCkNPTkZJ
R19DUllQVE9fUENSWVBUPW0KQ09ORklHX0NSWVBUT19XT1JLUVVFVUU9eQpDT05GSUdfQ1JZUFRP
X0NSWVBURD1tCkNPTkZJR19DUllQVE9fQVVUSEVOQz15CiMgQ09ORklHX0NSWVBUT19URVNUIGlz
IG5vdCBzZXQKCiMKIyBBdXRoZW50aWNhdGVkIEVuY3J5cHRpb24gd2l0aCBBc3NvY2lhdGVkIERh
dGEKIwpDT05GSUdfQ1JZUFRPX0NDTT1tCkNPTkZJR19DUllQVE9fR0NNPW0KQ09ORklHX0NSWVBU
T19TRVFJVj1tCgojCiMgQmxvY2sgbW9kZXMKIwpDT05GSUdfQ1JZUFRPX0NCQz15CkNPTkZJR19D
UllQVE9fQ1RSPW0KQ09ORklHX0NSWVBUT19DVFM9bQpDT05GSUdfQ1JZUFRPX0VDQj1tCkNPTkZJ
R19DUllQVE9fTFJXPW0KQ09ORklHX0NSWVBUT19QQ0JDPW0KQ09ORklHX0NSWVBUT19YVFM9bQoK
IwojIEhhc2ggbW9kZXMKIwpDT05GSUdfQ1JZUFRPX0NNQUM9bQpDT05GSUdfQ1JZUFRPX0hNQUM9
eQpDT05GSUdfQ1JZUFRPX1hDQkM9bQpDT05GSUdfQ1JZUFRPX1ZNQUM9bQoKIwojIERpZ2VzdAoj
CkNPTkZJR19DUllQVE9fQ1JDMzJDPXkKQ09ORklHX0NSWVBUT19DUkMzMj1tCkNPTkZJR19DUllQ
VE9fQ1JDVDEwRElGPXkKQ09ORklHX0NSWVBUT19HSEFTSD1tCkNPTkZJR19DUllQVE9fTUQ0PW0K
Q09ORklHX0NSWVBUT19NRDU9eQpDT05GSUdfQ1JZUFRPX01JQ0hBRUxfTUlDPW0KQ09ORklHX0NS
WVBUT19STUQxMjg9bQpDT05GSUdfQ1JZUFRPX1JNRDE2MD1tCkNPTkZJR19DUllQVE9fUk1EMjU2
PW0KQ09ORklHX0NSWVBUT19STUQzMjA9bQpDT05GSUdfQ1JZUFRPX1NIQTE9eQpDT05GSUdfQ1JZ
UFRPX1NIQTFfUFBDPW0KQ09ORklHX0NSWVBUT19TSEEyNTY9bQpDT05GSUdfQ1JZUFRPX1NIQTUx
Mj1tCkNPTkZJR19DUllQVE9fVEdSMTkyPW0KQ09ORklHX0NSWVBUT19XUDUxMj1tCgojCiMgQ2lw
aGVycwojCkNPTkZJR19DUllQVE9fQUVTPXkKQ09ORklHX0NSWVBUT19BTlVCSVM9bQpDT05GSUdf
Q1JZUFRPX0FSQzQ9bQpDT05GSUdfQ1JZUFRPX0JMT1dGSVNIPW0KQ09ORklHX0NSWVBUT19CTE9X
RklTSF9DT01NT049bQpDT05GSUdfQ1JZUFRPX0NBTUVMTElBPW0KQ09ORklHX0NSWVBUT19DQVNU
X0NPTU1PTj1tCkNPTkZJR19DUllQVE9fQ0FTVDU9bQpDT05GSUdfQ1JZUFRPX0NBU1Q2PW0KQ09O
RklHX0NSWVBUT19ERVM9eQpDT05GSUdfQ1JZUFRPX0ZDUllQVD1tCkNPTkZJR19DUllQVE9fS0hB
WkFEPW0KQ09ORklHX0NSWVBUT19TQUxTQTIwPW0KQ09ORklHX0NSWVBUT19TRUVEPW0KQ09ORklH
X0NSWVBUT19TRVJQRU5UPW0KQ09ORklHX0NSWVBUT19URUE9bQpDT05GSUdfQ1JZUFRPX1RXT0ZJ
U0g9bQpDT05GSUdfQ1JZUFRPX1RXT0ZJU0hfQ09NTU9OPW0KCiMKIyBDb21wcmVzc2lvbgojCkNP
TkZJR19DUllQVE9fREVGTEFURT15CkNPTkZJR19DUllQVE9fWkxJQj1tCkNPTkZJR19DUllQVE9f
TFpPPW0KIyBDT05GSUdfQ1JZUFRPX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWjRI
QyBpcyBub3Qgc2V0CgojCiMgUmFuZG9tIE51bWJlciBHZW5lcmF0aW9uCiMKQ09ORklHX0NSWVBU
T19BTlNJX0NQUk5HPW0KQ09ORklHX0NSWVBUT19VU0VSX0FQST1tCkNPTkZJR19DUllQVE9fVVNF
Ul9BUElfSEFTSD1tCkNPTkZJR19DUllQVE9fVVNFUl9BUElfU0tDSVBIRVI9bQpDT05GSUdfQ1JZ
UFRPX0hXPXkKIyBDT05GSUdfQ1JZUFRPX0RFVl9GU0xfQ0FBTSBpcyBub3Qgc2V0CkNPTkZJR19D
UllQVE9fREVWX1RBTElUT1M9bQpDT05GSUdfQVNZTU1FVFJJQ19LRVlfVFlQRT1tCkNPTkZJR19B
U1lNTUVUUklDX1BVQkxJQ19LRVlfU1VCVFlQRT1tCkNPTkZJR19QVUJMSUNfS0VZX0FMR09fUlNB
PW0KQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVfUEFSU0VSPW0KIyBDT05GSUdfUFBDX0NMT0NLIGlz
IG5vdCBzZXQKIyBDT05GSUdfVklSVFVBTElaQVRJT04gaXMgbm90IHNldAo=
--047d7b15ad4f7d7da804f074c770--
