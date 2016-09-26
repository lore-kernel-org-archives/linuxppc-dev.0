Return-Path: <kda@linux-powerpc.org>
Received: from mail-yb0-x233.google.com (mail-yb0-x233.google.com
 [IPv6:2607:f8b0:4002:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjLb81MWKzDrPt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 21:00:04 +1000 (AEST)
Received: by mail-yb0-x233.google.com with SMTP id 2so83664694ybv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 04:00:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1474457698-3855-1-git-send-email-kda@linux-powerpc.org>
References: <1474457698-3855-1-git-send-email-kda@linux-powerpc.org>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Mon, 26 Sep 2016 14:00:00 +0300
Message-ID: <CAOJe8K07TUCAOiHu3OkEHCmC1jhvwGo9Pd6SaxRX2h32RTGdQg@mail.gmail.com>
Subject: Re: [PATCH] i2c_powermac: shut up lockdep warning
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: multipart/alternative; boundary=001a1140b62494b1c8053d6707c9
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1140b62494b1c8053d6707c9
Content-Type: text/plain; charset=UTF-8

On Wednesday, September 21, 2016, Denis Kirjanov <kda@linux-powerpc.org>
wrote:

> That's unclear why lockdep shows the following warning but adding a
> lockdep class to struct pmac_i2c_bus solves it


HI Ben,

could you give any comments on this?

Thanks!

>
> [   20.507795] ======================================================
> [   20.507796] [ INFO: possible circular locking dependency detected ]
> [   20.507800] 4.8.0-rc7-00037-gd2ffb01 #21 Not tainted
> [   20.507801] -------------------------------------------------------
> [   20.507803] swapper/0/1 is trying to acquire lock:
> [   20.507818]  (&bus->mutex){+.+.+.}, at: [<c000000000052830>]
> .pmac_i2c_open+0x30/0x100
> [   20.507819]
> [   20.507819] but task is already holding lock:
> [   20.507829]  (&policy->rwsem){+.+.+.}, at: [<c00000000068adcc>]
> .cpufreq_online+0x1ac/0x9d0
> [   20.507830]
> [   20.507830] which lock already depends on the new lock.
> [   20.507830]
> [   20.507832]
> [   20.507832] the existing dependency chain (in reverse order) is:
> [   20.507837]
> [   20.507837] -> #4 (&policy->rwsem){+.+.+.}:
> [   20.507844]        [<c00000000082385c>] .down_write+0x6c/0x110
> [   20.507849]        [<c00000000068adcc>] .cpufreq_online+0x1ac/0x9d0
> [   20.507855]        [<c0000000004d76d8>] .subsys_interface_register+
> 0xb8/0x110
> [   20.507860]        [<c000000000689bb0>] .cpufreq_register_driver+
> 0x1d0/0x250
> [   20.507866]        [<c000000000b4f8f4>] .g5_cpufreq_init+0x9cc/0xa28
> [   20.507872]        [<c00000000000a98c>] .do_one_initcall+0x5c/0x1d0
> [   20.507878]        [<c000000000b0f86c>] .kernel_init_freeable+0x1ac/
> 0x28c
> [   20.507883]        [<c00000000000b3bc>] .kernel_init+0x1c/0x140
> [   20.507887]        [<c0000000000098f4>] .ret_from_kernel_thread+0x58/
> 0x64
> [   20.507894]
> [   20.507894] -> #3 (subsys mutex#2){+.+.+.}:
> [   20.507899]        [<c000000000820448>] .mutex_lock_nested+0xa8/0x590
> [   20.507903]        [<c0000000004d7f24>] .bus_probe_device+0x44/0xe0
> [   20.507907]        [<c0000000004d5208>] .device_add+0x508/0x730
> [   20.507911]        [<c0000000004dd528>] .register_cpu+0x118/0x190
> [   20.507916]        [<c000000000b14450>] .topology_init+0x148/0x248
> [   20.507921]        [<c00000000000a98c>] .do_one_initcall+0x5c/0x1d0
> [   20.507925]        [<c000000000b0f86c>] .kernel_init_freeable+0x1ac/
> 0x28c
> [   20.507929]        [<c00000000000b3bc>] .kernel_init+0x1c/0x140
> [   20.507934]        [<c0000000000098f4>] .ret_from_kernel_thread+0x58/
> 0x64
> [   20.507939]
> [   20.507939] -> #2 (cpu_add_remove_lock){+.+.+.}:
> [   20.507944]        [<c000000000820448>] .mutex_lock_nested+0xa8/0x590
> [   20.507950]        [<c000000000087a9c>] .register_cpu_notifier+0x2c/
> 0x70
> [   20.507955]        [<c000000000b267e0>] .spawn_ksoftirqd+0x18/0x4c
> [   20.507959]        [<c00000000000a98c>] .do_one_initcall+0x5c/0x1d0
> [   20.507964]        [<c000000000b0f770>] .kernel_init_freeable+0xb0/
> 0x28c
> [   20.507968]        [<c00000000000b3bc>] .kernel_init+0x1c/0x140
> [   20.507972]        [<c0000000000098f4>] .ret_from_kernel_thread+0x58/
> 0x64
> [   20.507978]
> [   20.507978] -> #1 (&host->mutex){+.+.+.}:
> [   20.507982]        [<c000000000820448>] .mutex_lock_nested+0xa8/0x590
> [   20.507987]        [<c0000000000527e8>] .kw_i2c_open+0x18/0x30
> [   20.507991]        [<c000000000052894>] .pmac_i2c_open+0x94/0x100
> [   20.507995]        [<c000000000b220a0>] .smp_core99_probe+0x260/0x410
> [   20.507999]        [<c000000000b185bc>] .smp_prepare_cpus+0x280/0x2ac
> [   20.508003]        [<c000000000b0f748>] .kernel_init_freeable+0x88/
> 0x28c
> [   20.508008]        [<c00000000000b3bc>] .kernel_init+0x1c/0x140
> [   20.508012]        [<c0000000000098f4>] .ret_from_kernel_thread+0x58/
> 0x64
> [   20.508018]
> [   20.508018] -> #0 (&bus->mutex){+.+.+.}:
> [   20.508023]        [<c0000000000ed5b4>] .lock_acquire+0x84/0x100
> [   20.508027]        [<c000000000820448>] .mutex_lock_nested+0xa8/0x590
> [   20.508032]        [<c000000000052830>] .pmac_i2c_open+0x30/0x100
> [   20.508037]        [<c000000000052e14>] .pmac_i2c_do_begin+0x34/0x120
> [   20.508040]        [<c000000000056bc0>] .pmf_call_one+0x50/0xd0
> [   20.508045]        [<c00000000068ff1c>] .g5_pfunc_switch_volt+0x2c/0xc0
> [   20.508050]        [<c00000000068fecc>] .g5_pfunc_switch_freq+0x1cc/
> 0x1f0
> [   20.508054]        [<c00000000068fc2c>] .g5_cpufreq_target+0x2c/0x40
> [   20.508058]        [<c0000000006873ec>] .__cpufreq_driver_target+
> 0x23c/0x840
> [   20.508062]        [<c00000000068c798>] .cpufreq_gov_performance_
> limits+0x18/0x30
> [   20.508067]        [<c00000000068915c>] .cpufreq_start_governor+0xac/
> 0x100
> [   20.508071]        [<c00000000068a788>] .cpufreq_set_policy+0x208/0x260
> [   20.508076]        [<c00000000068abdc>] .cpufreq_init_policy+0x6c/0xb0
> [   20.508081]        [<c00000000068ae70>] .cpufreq_online+0x250/0x9d0
> [   20.508085]        [<c0000000004d76d8>] .subsys_interface_register+
> 0xb8/0x110
> [   20.508090]        [<c000000000689bb0>] .cpufreq_register_driver+
> 0x1d0/0x250
> [   20.508094]        [<c000000000b4f8f4>] .g5_cpufreq_init+0x9cc/0xa28
> [   20.508099]        [<c00000000000a98c>] .do_one_initcall+0x5c/0x1d0
> [   20.508103]        [<c000000000b0f86c>] .kernel_init_freeable+0x1ac/
> 0x28c
> [   20.508107]        [<c00000000000b3bc>] .kernel_init+0x1c/0x140
> [   20.508112]        [<c0000000000098f4>] .ret_from_kernel_thread+0x58/
> 0x64
> [   20.508113]
> [   20.508113] other info that might help us debug this:
> [   20.508113]
> [   20.508121] Chain exists of:
> [   20.508121]   &bus->mutex --> subsys mutex#2 --> &policy->rwsem
> [   20.508121]
> [   20.508123]  Possible unsafe locking scenario:
> [   20.508123]
> [   20.508124]        CPU0                    CPU1
> [   20.508125]        ----                    ----
> [   20.508128]   lock(&policy->rwsem);
> [   20.508132]                                lock(subsys mutex#2);
> [   20.508135]                                lock(&policy->rwsem);
> [   20.508138]   lock(&bus->mutex);
> [   20.508139]
> [   20.508139]  *** DEADLOCK ***
> [   20.508139]
> [   20.508141] 3 locks held by swapper/0/1:
> [   20.508150]  #0:  (cpu_hotplug.lock){++++++}, at: [<c000000000087838>]
> .get_online_cpus+0x48/0xc0
> [   20.508159]  #1:  (subsys mutex#2){+.+.+.}, at: [<c0000000004d7670>]
> .subsys_interface_register+0x50/0x110
> [   20.508168]  #2:  (&policy->rwsem){+.+.+.}, at: [<c00000000068adcc>]
> .cpufreq_online+0x1ac/0x9d0
> [   20.508169]
> [   20.508169] stack backtrace:
> [   20.508173] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.8.0-rc7-00037-gd2ffb01 #21
> [   20.508175] Call Trace:
> [   20.508180] [c0000000790c2b90] [c00000000082cc70]
> .dump_stack+0xe0/0x14c (unreliable)
> [   20.508184] [c0000000790c2c20] [c000000000828c88]
> .print_circular_bug+0x350/0x388
> [   20.508188] [c0000000790c2cd0] [c0000000000ecb0c]
> .__lock_acquire+0x196c/0x1d30
> [   20.508192] [c0000000790c2e50] [c0000000000ed5b4]
> .lock_acquire+0x84/0x100
> [   20.508196] [c0000000790c2f20] [c000000000820448]
> .mutex_lock_nested+0xa8/0x590
> [   20.508201] [c0000000790c3030] [c000000000052830]
> .pmac_i2c_open+0x30/0x100
> [   20.508206] [c0000000790c30c0] [c000000000052e14]
> .pmac_i2c_do_begin+0x34/0x120
> [   20.508209] [c0000000790c3150] [c000000000056bc0]
> .pmf_call_one+0x50/0xd0
> [   20.508213] [c0000000790c31e0] [c00000000068ff1c]
> .g5_pfunc_switch_volt+0x2c/0xc0
> [   20.508217] [c0000000790c3250] [c00000000068fecc]
> .g5_pfunc_switch_freq+0x1cc/0x1f0
> [   20.508221] [c0000000790c3320] [c00000000068fc2c]
> .g5_cpufreq_target+0x2c/0x40
> [   20.508226] [c0000000790c3390] [c0000000006873ec]
> .__cpufreq_driver_target+0x23c/0x840
> [   20.508230] [c0000000790c3440] [c00000000068c798]
> .cpufreq_gov_performance_limits+0x18/0x30
> [   20.508235] [c0000000790c34b0] [c00000000068915c]
> .cpufreq_start_governor+0xac/0x100
> [   20.508239] [c0000000790c3530] [c00000000068a788]
> .cpufreq_set_policy+0x208/0x260
> [   20.508244] [c0000000790c35d0] [c00000000068abdc]
> .cpufreq_init_policy+0x6c/0xb0
> [   20.508249] [c0000000790c3940] [c00000000068ae70]
> .cpufreq_online+0x250/0x9d0
> [   20.508253] [c0000000790c3a30] [c0000000004d76d8]
> .subsys_interface_register+0xb8/0x110
> [   20.508258] [c0000000790c3ad0] [c000000000689bb0]
> .cpufreq_register_driver+0x1d0/0x250
> [   20.508262] [c0000000790c3b60] [c000000000b4f8f4]
> .g5_cpufreq_init+0x9cc/0xa28
> [   20.508267] [c0000000790c3c20] [c00000000000a98c]
> .do_one_initcall+0x5c/0x1d0
> [   20.508271] [c0000000790c3d00] [c000000000b0f86c]
> .kernel_init_freeable+0x1ac/0x28c
> [   20.508276] [c0000000790c3db0] [c00000000000b3bc]
> .kernel_init+0x1c/0x140
> [   20.508280] [c0000000790c3e30] [c0000000000098f4]
> .ret_from_kernel_thread+0x58/0x64
>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org <javascript:;>>
> ---
>  arch/powerpc/platforms/powermac/low_i2c.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c
> b/arch/powerpc/platforms/powermac/low_i2c.c
> index 6d6f277..0159363 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -90,6 +90,7 @@ struct pmac_i2c_bus
>         int                     opened;
>         int                     polled;         /* open mode */
>         struct platform_device  *platform_dev;
> +       struct lock_class_key   lock_key;
>
>         /* ops */
>         int (*open)(struct pmac_i2c_bus *bus);
> @@ -587,6 +588,7 @@ static void __init kw_i2c_add(struct pmac_i2c_host_kw
> *host,
>         bus->close = kw_i2c_close;
>         bus->xfer = kw_i2c_xfer;
>         mutex_init(&bus->mutex);
> +       lockdep_set_class(&bus->mutex, &bus->lock_key);
>         if (controller == busnode)
>                 bus->flags = pmac_i2c_multibus;
>         list_add(&bus->link, &pmac_i2c_busses);
> @@ -815,6 +817,7 @@ static void __init pmu_i2c_probe(void)
>                 bus->hostdata = bus + 1;
>                 bus->xfer = pmu_i2c_xfer;
>                 mutex_init(&bus->mutex);
> +               lockdep_set_class(&bus->mutex, &bus->lock_key);
>                 bus->flags = pmac_i2c_multibus;
>                 list_add(&bus->link, &pmac_i2c_busses);
>
> @@ -938,6 +941,7 @@ static void __init smu_i2c_probe(void)
>                 bus->hostdata = bus + 1;
>                 bus->xfer = smu_i2c_xfer;
>                 mutex_init(&bus->mutex);
> +               lockdep_set_class(&bus->mutex, &bus->lock_key);
>                 bus->flags = 0;
>                 list_add(&bus->link, &pmac_i2c_busses);
>
> --
> 2.4.0
>
>

--001a1140b62494b1c8053d6707c9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, September 21, 2016, Denis Kirjanov &lt;<a href=3D"mai=
lto:kda@linux-powerpc.org">kda@linux-powerpc.org</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">That&#39;s unclear why lockdep shows the following w=
arning but adding a<br>
lockdep class to struct pmac_i2c_bus solves it</blockquote><div><br></div><=
div>HI Ben,=C2=A0</div><div><br></div><div>could you give any comments=C2=
=A0on this?=C2=A0</div><div><br></div><div>Thanks!</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
[=C2=A0 =C2=A020.507795] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
[=C2=A0 =C2=A020.507796] [ INFO: possible circular locking dependency detec=
ted ]<br>
[=C2=A0 =C2=A020.507800] 4.8.0-rc7-00037-gd2ffb01 #21 Not tainted<br>
[=C2=A0 =C2=A020.507801] ------------------------------<wbr>---------------=
----------<br>
[=C2=A0 =C2=A020.507803] swapper/0/1 is trying to acquire lock:<br>
[=C2=A0 =C2=A020.507818]=C2=A0 (&amp;bus-&gt;mutex){+.+.+.}, at: [&lt;c0000=
00000052830&gt;] .pmac_i2c_open+0x30/0x100<br>
[=C2=A0 =C2=A020.507819]<br>
[=C2=A0 =C2=A020.507819] but task is already holding lock:<br>
[=C2=A0 =C2=A020.507829]=C2=A0 (&amp;policy-&gt;rwsem){+.+.+.}, at: [&lt;c0=
0000000068adcc&gt;] .cpufreq_online+0x1ac/0x9d0<br>
[=C2=A0 =C2=A020.507830]<br>
[=C2=A0 =C2=A020.507830] which lock already depends on the new lock.<br>
[=C2=A0 =C2=A020.507830]<br>
[=C2=A0 =C2=A020.507832]<br>
[=C2=A0 =C2=A020.507832] the existing dependency chain (in reverse order) i=
s:<br>
[=C2=A0 =C2=A020.507837]<br>
[=C2=A0 =C2=A020.507837] -&gt; #4 (&amp;policy-&gt;rwsem){+.+.+.}:<br>
[=C2=A0 =C2=A020.507844]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000082385c&g=
t;] .down_write+0x6c/0x110<br>
[=C2=A0 =C2=A020.507849]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068adcc&g=
t;] .cpufreq_online+0x1ac/0x9d0<br>
[=C2=A0 =C2=A020.507855]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000004d76d8&g=
t;] .subsys_interface_register+<wbr>0xb8/0x110<br>
[=C2=A0 =C2=A020.507860]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000689bb0&g=
t;] .cpufreq_register_driver+<wbr>0x1d0/0x250<br>
[=C2=A0 =C2=A020.507866]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b4f8f4&g=
t;] .g5_cpufreq_init+0x9cc/0xa28<br>
[=C2=A0 =C2=A020.507872]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000a98c&g=
t;] .do_one_initcall+0x5c/0x1d0<br>
[=C2=A0 =C2=A020.507878]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b0f86c&g=
t;] .kernel_init_freeable+0x1ac/<wbr>0x28c<br>
[=C2=A0 =C2=A020.507883]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000b3bc&g=
t;] .kernel_init+0x1c/0x140<br>
[=C2=A0 =C2=A020.507887]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000098f4&g=
t;] .ret_from_kernel_thread+0x58/<wbr>0x64<br>
[=C2=A0 =C2=A020.507894]<br>
[=C2=A0 =C2=A020.507894] -&gt; #3 (subsys mutex#2){+.+.+.}:<br>
[=C2=A0 =C2=A020.507899]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000820448&g=
t;] .mutex_lock_nested+0xa8/0x590<br>
[=C2=A0 =C2=A020.507903]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000004d7f24&g=
t;] .bus_probe_device+0x44/0xe0<br>
[=C2=A0 =C2=A020.507907]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000004d5208&g=
t;] .device_add+0x508/0x730<br>
[=C2=A0 =C2=A020.507911]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000004dd528&g=
t;] .register_cpu+0x118/0x190<br>
[=C2=A0 =C2=A020.507916]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b14450&g=
t;] .topology_init+0x148/0x248<br>
[=C2=A0 =C2=A020.507921]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000a98c&g=
t;] .do_one_initcall+0x5c/0x1d0<br>
[=C2=A0 =C2=A020.507925]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b0f86c&g=
t;] .kernel_init_freeable+0x1ac/<wbr>0x28c<br>
[=C2=A0 =C2=A020.507929]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000b3bc&g=
t;] .kernel_init+0x1c/0x140<br>
[=C2=A0 =C2=A020.507934]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000098f4&g=
t;] .ret_from_kernel_thread+0x58/<wbr>0x64<br>
[=C2=A0 =C2=A020.507939]<br>
[=C2=A0 =C2=A020.507939] -&gt; #2 (cpu_add_remove_lock){+.+.+.}:<br>
[=C2=A0 =C2=A020.507944]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000820448&g=
t;] .mutex_lock_nested+0xa8/0x590<br>
[=C2=A0 =C2=A020.507950]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000087a9c&g=
t;] .register_cpu_notifier+0x2c/<wbr>0x70<br>
[=C2=A0 =C2=A020.507955]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b267e0&g=
t;] .spawn_ksoftirqd+0x18/0x4c<br>
[=C2=A0 =C2=A020.507959]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000a98c&g=
t;] .do_one_initcall+0x5c/0x1d0<br>
[=C2=A0 =C2=A020.507964]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b0f770&g=
t;] .kernel_init_freeable+0xb0/<wbr>0x28c<br>
[=C2=A0 =C2=A020.507968]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000b3bc&g=
t;] .kernel_init+0x1c/0x140<br>
[=C2=A0 =C2=A020.507972]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000098f4&g=
t;] .ret_from_kernel_thread+0x58/<wbr>0x64<br>
[=C2=A0 =C2=A020.507978]<br>
[=C2=A0 =C2=A020.507978] -&gt; #1 (&amp;host-&gt;mutex){+.+.+.}:<br>
[=C2=A0 =C2=A020.507982]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000820448&g=
t;] .mutex_lock_nested+0xa8/0x590<br>
[=C2=A0 =C2=A020.507987]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000527e8&g=
t;] .kw_i2c_open+0x18/0x30<br>
[=C2=A0 =C2=A020.507991]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000052894&g=
t;] .pmac_i2c_open+0x94/0x100<br>
[=C2=A0 =C2=A020.507995]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b220a0&g=
t;] .smp_core99_probe+0x260/0x410<br>
[=C2=A0 =C2=A020.507999]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b185bc&g=
t;] .smp_prepare_cpus+0x280/0x2ac<br>
[=C2=A0 =C2=A020.508003]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b0f748&g=
t;] .kernel_init_freeable+0x88/<wbr>0x28c<br>
[=C2=A0 =C2=A020.508008]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000b3bc&g=
t;] .kernel_init+0x1c/0x140<br>
[=C2=A0 =C2=A020.508012]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000098f4&g=
t;] .ret_from_kernel_thread+0x58/<wbr>0x64<br>
[=C2=A0 =C2=A020.508018]<br>
[=C2=A0 =C2=A020.508018] -&gt; #0 (&amp;bus-&gt;mutex){+.+.+.}:<br>
[=C2=A0 =C2=A020.508023]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000ed5b4&g=
t;] .lock_acquire+0x84/0x100<br>
[=C2=A0 =C2=A020.508027]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000820448&g=
t;] .mutex_lock_nested+0xa8/0x590<br>
[=C2=A0 =C2=A020.508032]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000052830&g=
t;] .pmac_i2c_open+0x30/0x100<br>
[=C2=A0 =C2=A020.508037]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000052e14&g=
t;] .pmac_i2c_do_begin+0x34/0x120<br>
[=C2=A0 =C2=A020.508040]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000056bc0&g=
t;] .pmf_call_one+0x50/0xd0<br>
[=C2=A0 =C2=A020.508045]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068ff1c&g=
t;] .g5_pfunc_switch_volt+0x2c/<wbr>0xc0<br>
[=C2=A0 =C2=A020.508050]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068fecc&g=
t;] .g5_pfunc_switch_freq+0x1cc/<wbr>0x1f0<br>
[=C2=A0 =C2=A020.508054]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068fc2c&g=
t;] .g5_cpufreq_target+0x2c/0x40<br>
[=C2=A0 =C2=A020.508058]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000006873ec&g=
t;] .__cpufreq_driver_target+<wbr>0x23c/0x840<br>
[=C2=A0 =C2=A020.508062]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068c798&g=
t;] .cpufreq_gov_performance_<wbr>limits+0x18/0x30<br>
[=C2=A0 =C2=A020.508067]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068915c&g=
t;] .cpufreq_start_governor+0xac/<wbr>0x100<br>
[=C2=A0 =C2=A020.508071]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068a788&g=
t;] .cpufreq_set_policy+0x208/<wbr>0x260<br>
[=C2=A0 =C2=A020.508076]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068abdc&g=
t;] .cpufreq_init_policy+0x6c/0xb0<br>
[=C2=A0 =C2=A020.508081]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000068ae70&g=
t;] .cpufreq_online+0x250/0x9d0<br>
[=C2=A0 =C2=A020.508085]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000004d76d8&g=
t;] .subsys_interface_register+<wbr>0xb8/0x110<br>
[=C2=A0 =C2=A020.508090]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000689bb0&g=
t;] .cpufreq_register_driver+<wbr>0x1d0/0x250<br>
[=C2=A0 =C2=A020.508094]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b4f8f4&g=
t;] .g5_cpufreq_init+0x9cc/0xa28<br>
[=C2=A0 =C2=A020.508099]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000a98c&g=
t;] .do_one_initcall+0x5c/0x1d0<br>
[=C2=A0 =C2=A020.508103]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c000000000b0f86c&g=
t;] .kernel_init_freeable+0x1ac/<wbr>0x28c<br>
[=C2=A0 =C2=A020.508107]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c00000000000b3bc&g=
t;] .kernel_init+0x1c/0x140<br>
[=C2=A0 =C2=A020.508112]=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&lt;c0000000000098f4&g=
t;] .ret_from_kernel_thread+0x58/<wbr>0x64<br>
[=C2=A0 =C2=A020.508113]<br>
[=C2=A0 =C2=A020.508113] other info that might help us debug this:<br>
[=C2=A0 =C2=A020.508113]<br>
[=C2=A0 =C2=A020.508121] Chain exists of:<br>
[=C2=A0 =C2=A020.508121]=C2=A0 =C2=A0&amp;bus-&gt;mutex --&gt; subsys mutex=
#2 --&gt; &amp;policy-&gt;rwsem<br>
[=C2=A0 =C2=A020.508121]<br>
[=C2=A0 =C2=A020.508123]=C2=A0 Possible unsafe locking scenario:<br>
[=C2=A0 =C2=A020.508123]<br>
[=C2=A0 =C2=A020.508124]=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU1<br>
[=C2=A0 =C2=A020.508125]=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ----<br>
[=C2=A0 =C2=A020.508128]=C2=A0 =C2=A0lock(&amp;policy-&gt;rwsem);<br>
[=C2=A0 =C2=A020.508132]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock(subsys =
mutex#2);<br>
[=C2=A0 =C2=A020.508135]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock(&amp;po=
licy-&gt;rwsem);<br>
[=C2=A0 =C2=A020.508138]=C2=A0 =C2=A0lock(&amp;bus-&gt;mutex);<br>
[=C2=A0 =C2=A020.508139]<br>
[=C2=A0 =C2=A020.508139]=C2=A0 *** DEADLOCK ***<br>
[=C2=A0 =C2=A020.508139]<br>
[=C2=A0 =C2=A020.508141] 3 locks held by swapper/0/1:<br>
[=C2=A0 =C2=A020.508150]=C2=A0 #0:=C2=A0 (cpu_hotplug.lock){++++++}, at: [&=
lt;c000000000087838&gt;] .get_online_cpus+0x48/0xc0<br>
[=C2=A0 =C2=A020.508159]=C2=A0 #1:=C2=A0 (subsys mutex#2){+.+.+.}, at: [&lt=
;c0000000004d7670&gt;] .subsys_interface_register+<wbr>0x50/0x110<br>
[=C2=A0 =C2=A020.508168]=C2=A0 #2:=C2=A0 (&amp;policy-&gt;rwsem){+.+.+.}, a=
t: [&lt;c00000000068adcc&gt;] .cpufreq_online+0x1ac/0x9d0<br>
[=C2=A0 =C2=A020.508169]<br>
[=C2=A0 =C2=A020.508169] stack backtrace:<br>
[=C2=A0 =C2=A020.508173] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc=
7-00037-gd2ffb01 #21<br>
[=C2=A0 =C2=A020.508175] Call Trace:<br>
[=C2=A0 =C2=A020.508180] [c0000000790c2b90] [c00000000082cc70] .dump_stack+=
0xe0/0x14c (unreliable)<br>
[=C2=A0 =C2=A020.508184] [c0000000790c2c20] [c000000000828c88] .print_circu=
lar_bug+0x350/<wbr>0x388<br>
[=C2=A0 =C2=A020.508188] [c0000000790c2cd0] [c0000000000ecb0c] .__lock_acqu=
ire+0x196c/0x1d30<br>
[=C2=A0 =C2=A020.508192] [c0000000790c2e50] [c0000000000ed5b4] .lock_acquir=
e+0x84/0x100<br>
[=C2=A0 =C2=A020.508196] [c0000000790c2f20] [c000000000820448] .mutex_lock_=
nested+0xa8/0x590<br>
[=C2=A0 =C2=A020.508201] [c0000000790c3030] [c000000000052830] .pmac_i2c_op=
en+0x30/0x100<br>
[=C2=A0 =C2=A020.508206] [c0000000790c30c0] [c000000000052e14] .pmac_i2c_do=
_begin+0x34/0x120<br>
[=C2=A0 =C2=A020.508209] [c0000000790c3150] [c000000000056bc0] .pmf_call_on=
e+0x50/0xd0<br>
[=C2=A0 =C2=A020.508213] [c0000000790c31e0] [c00000000068ff1c] .g5_pfunc_sw=
itch_volt+0x2c/<wbr>0xc0<br>
[=C2=A0 =C2=A020.508217] [c0000000790c3250] [c00000000068fecc] .g5_pfunc_sw=
itch_freq+0x1cc/<wbr>0x1f0<br>
[=C2=A0 =C2=A020.508221] [c0000000790c3320] [c00000000068fc2c] .g5_cpufreq_=
target+0x2c/0x40<br>
[=C2=A0 =C2=A020.508226] [c0000000790c3390] [c0000000006873ec] .__cpufreq_d=
river_target+<wbr>0x23c/0x840<br>
[=C2=A0 =C2=A020.508230] [c0000000790c3440] [c00000000068c798] .cpufreq_gov=
_performance_<wbr>limits+0x18/0x30<br>
[=C2=A0 =C2=A020.508235] [c0000000790c34b0] [c00000000068915c] .cpufreq_sta=
rt_governor+0xac/<wbr>0x100<br>
[=C2=A0 =C2=A020.508239] [c0000000790c3530] [c00000000068a788] .cpufreq_set=
_policy+0x208/<wbr>0x260<br>
[=C2=A0 =C2=A020.508244] [c0000000790c35d0] [c00000000068abdc] .cpufreq_ini=
t_policy+0x6c/0xb0<br>
[=C2=A0 =C2=A020.508249] [c0000000790c3940] [c00000000068ae70] .cpufreq_onl=
ine+0x250/0x9d0<br>
[=C2=A0 =C2=A020.508253] [c0000000790c3a30] [c0000000004d76d8] .subsys_inte=
rface_register+<wbr>0xb8/0x110<br>
[=C2=A0 =C2=A020.508258] [c0000000790c3ad0] [c000000000689bb0] .cpufreq_reg=
ister_driver+<wbr>0x1d0/0x250<br>
[=C2=A0 =C2=A020.508262] [c0000000790c3b60] [c000000000b4f8f4] .g5_cpufreq_=
init+0x9cc/0xa28<br>
[=C2=A0 =C2=A020.508267] [c0000000790c3c20] [c00000000000a98c] .do_one_init=
call+0x5c/0x1d0<br>
[=C2=A0 =C2=A020.508271] [c0000000790c3d00] [c000000000b0f86c] .kernel_init=
_freeable+0x1ac/<wbr>0x28c<br>
[=C2=A0 =C2=A020.508276] [c0000000790c3db0] [c00000000000b3bc] .kernel_init=
+0x1c/0x140<br>
[=C2=A0 =C2=A020.508280] [c0000000790c3e30] [c0000000000098f4] .ret_from_ke=
rnel_thread+0x58/<wbr>0x64<br>
<br>
Signed-off-by: Denis Kirjanov &lt;<a href=3D"javascript:;" onclick=3D"_e(ev=
ent, &#39;cvml&#39;, &#39;kda@linux-powerpc.org&#39;)">kda@linux-powerpc.or=
g</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/platforms/<wbr>powermac/low_i2c.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/arch/powerpc/platforms/<wbr>powermac/low_i2c.c b/arch/powerpc/=
platforms/<wbr>powermac/low_i2c.c<br>
index 6d6f277..0159363 100644<br>
--- a/arch/powerpc/platforms/<wbr>powermac/low_i2c.c<br>
+++ b/arch/powerpc/platforms/<wbr>powermac/low_i2c.c<br>
@@ -90,6 +90,7 @@ struct pmac_i2c_bus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opened;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0polled;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* open mode */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct platform_device=C2=A0 *platform_dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct lock_class_key=C2=A0 =C2=A0lock_key;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ops */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*open)(struct pmac_i2c_bus *bus);<br>
@@ -587,6 +588,7 @@ static void __init kw_i2c_add(struct pmac_i2c_host_kw *=
host,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;close =3D kw_i2c_close;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;xfer =3D kw_i2c_xfer;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&amp;bus-&gt;mutex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0lockdep_set_class(&amp;bus-&gt;mutex, &amp;bus-=
&gt;lock_key);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (controller =3D=3D busnode)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;flags =3D p=
mac_i2c_multibus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add(&amp;bus-&gt;link, &amp;pmac_i2c_busse=
s);<br>
@@ -815,6 +817,7 @@ static void __init pmu_i2c_probe(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;hostdata =
=3D bus + 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;xfer =3D pm=
u_i2c_xfer;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&amp;bus=
-&gt;mutex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lockdep_set_class(&=
amp;bus-&gt;mutex, &amp;bus-&gt;lock_key);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;flags =3D p=
mac_i2c_multibus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add(&amp;bus-&=
gt;link, &amp;pmac_i2c_busses);<br>
<br>
@@ -938,6 +941,7 @@ static void __init smu_i2c_probe(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;hostdata =
=3D bus + 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;xfer =3D sm=
u_i2c_xfer;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&amp;bus=
-&gt;mutex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lockdep_set_class(&=
amp;bus-&gt;mutex, &amp;bus-&gt;lock_key);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus-&gt;flags =3D 0=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add(&amp;bus-&=
gt;link, &amp;pmac_i2c_busses);<br>
<br>
--<br>
2.4.0<br>
<br>
</blockquote>

--001a1140b62494b1c8053d6707c9--
