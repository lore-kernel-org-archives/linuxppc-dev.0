Return-Path: <kda@linux-powerpc.org>
Received: from mail-yh0-f51.google.com (mail-yh0-f51.google.com
 [209.85.213.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEAF31A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 01:45:51 +1000 (AEST)
Received: by yhpn97 with SMTP id n97so41681499yhp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2015 08:45:49 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 8 Jun 2015 18:45:49 +0300
Message-ID: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
Subject: [lockdep] cpufreq/ppc: possible circular locking dependency detected
From: Denis Kirjanov <kda@linux-powerpc.org>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I see the following lockdep splat on my RackMac machine on boot:

[    6.002593] Registering G5 CPU frequency driver
[    6.011288] Frequency method: i2c/pfunc, Voltage method: i2c/pfunc
[    6.023605] Low: 1800 Mhz, High: 2300 Mhz, Cur: 1800 MHz

[    6.038022] ======================================================
[    6.042080] windfarm: CPUs control loops started.
[    6.042084] wf_rm31: Backside control loop started.
[    6.042086] wf_rm31: Slots control loop started.
[    6.078644] [ INFO: possible circular locking dependency detected ]
[    6.091149] 4.1.0-rc6-01265-g908e80d-dirty #15 Not tainted
[    6.102083] -------------------------------------------------------
[    6.114586] swapper/0/1 is trying to acquire lock:
[    6.124136]  (&bus->mutex){+.+.+.}, at: [<c00000000004d450>]
.pmac_i2c_open+0x30/0x100
[    6.139933]
but task is already holding lock:
[    6.151569]  (&policy->rwsem){+.+.+.}, at: [<c000000000620bbc>]
.__cpufreq_add_dev.isra.29+0x34c/0xad0
[    6.170143]
which lock already depends on the new lock.

[    6.186464]
the existing dependency chain (in reverse order) is:
[    6.201401]
-> #4 (&policy->rwsem){+.+.+.}:
[    6.210077]        [<c0000000000d6380>] .lock_acquire+0x80/0x100
[    6.222061]        [<c0000000007a411c>] .down_write+0x6c/0x110
[    6.233690]        [<c000000000620bbc>]
.__cpufreq_add_dev.isra.29+0x34c/0xad0
[    6.248104]        [<c000000000489dd8>] .subsys_interface_register+0xc8/0x120
[    6.262336]        [<c0000000006215f8>] .cpufreq_register_driver+0x138/0x310
[    6.276404]        [<c000000000adeca8>] .g5_cpufreq_init+0x9cc/0xa28
[    6.289079]        [<c00000000000a714>] .do_one_initcall+0xd4/0x270
[    6.301577]        [<c000000000aaa778>] .kernel_init_freeable+0x190/0x270
[    6.315120]        [<c00000000000b17c>] .kernel_init+0x1c/0x120
[    6.326928]        [<c0000000000095b4>] .ret_from_kernel_thread+0x58/0xa4
[    6.340467]
-> #3 (subsys mutex#2){+.+.+.}:
[    6.349149]        [<c0000000000d6380>] .lock_acquire+0x80/0x100
[    6.361130]        [<c0000000007a0ccc>] .mutex_lock_nested+0xac/0x5a0
[    6.373980]        [<c00000000048aff4>] .bus_probe_device+0x44/0xf0
[    6.386477]        [<c000000000488318>] .device_add+0x508/0x730
[    6.398284]        [<c00000000048fb8c>] .register_cpu+0xfc/0x150
[    6.410266]        [<c000000000aaf27c>] .topology_init+0x108/0x1c0
[    6.422595]        [<c00000000000a714>] .do_one_initcall+0xd4/0x270
[    6.435092]        [<c000000000aaa778>] .kernel_init_freeable+0x190/0x270
[    6.448637]        [<c00000000000b17c>] .kernel_init+0x1c/0x120
[    6.460444]        [<c0000000000095b4>] .ret_from_kernel_thread+0x58/0xa4
[    6.473983]
-> #2 (cpu_add_remove_lock){+.+.+.}:
[    6.483536]        [<c0000000000d6380>] .lock_acquire+0x80/0x100
[    6.495517]        [<c0000000007a0ccc>] .mutex_lock_nested+0xac/0x5a0
[    6.508361]        [<c0000000000781ac>] .cpu_maps_update_begin+0x1c/0x30
[    6.521732]        [<c000000000070220>] .register_power_pmu+0xa0/0x128
[    6.534752]        [<c000000000abed50>] .init_ppc970_pmu+0x6c/0x8c
[    6.547081]        [<c00000000000a714>] .do_one_initcall+0xd4/0x270
[    6.559578]        [<c000000000aaa698>] .kernel_init_freeable+0xb0/0x270
[    6.572950]        [<c00000000000b17c>] .kernel_init+0x1c/0x120
[    6.584758]        [<c0000000000095b4>] .ret_from_kernel_thread+0x58/0xa4
[    6.598297]
-> #1 (&host->mutex){+.+.+.}:
[    6.606633]        [<c0000000000d6380>] .lock_acquire+0x80/0x100
[    6.618615]        [<c0000000007a0ccc>] .mutex_lock_nested+0xac/0x5a0
[    6.631458]        [<c00000000004d408>] .kw_i2c_open+0x18/0x30
[    6.643092]        [<c00000000004d4b4>] .pmac_i2c_open+0x94/0x100
[    6.655247]        [<c000000000abb174>] .smp_core99_probe+0x260/0x410
[    6.668097]        [<c000000000ab2f94>] .smp_prepare_cpus+0x1ec/0x220
[    6.680941]        [<c000000000aaa670>] .kernel_init_freeable+0x88/0x270
[    6.694313]        [<c00000000000b17c>] .kernel_init+0x1c/0x120
[    6.706121]        [<c0000000000095b4>] .ret_from_kernel_thread+0x58/0xa4
[    6.719660]
-> #0 (&bus->mutex){+.+.+.}:
[    6.727822]        [<c0000000000d5304>] .__lock_acquire+0x1194/0x1b70
[    6.740672]        [<c0000000000d6380>] .lock_acquire+0x80/0x100
[    6.752647]        [<c0000000007a0ccc>] .mutex_lock_nested+0xac/0x5a0
[    6.765497]        [<c00000000004d450>] .pmac_i2c_open+0x30/0x100
[    6.777652]        [<c00000000004da34>] .pmac_i2c_do_begin+0x34/0x120
[    6.790501]        [<c0000000000517e0>] .pmf_call_one+0x50/0xd0
[    6.802302]        [<c0000000006265ec>] .g5_pfunc_switch_volt+0x2c/0xc0
[    6.815501]        [<c00000000062659c>] .g5_pfunc_switch_freq+0x1cc/0x1f0
[    6.829040]        [<c0000000006262fc>] .g5_cpufreq_target+0x2c/0x40
[    6.841716]        [<c00000000061de40>] .__cpufreq_driver_target+0x230/0x400
[    6.855783]        [<c000000000622bec>]
.cpufreq_governor_performance+0x3c/0x60
[    6.870364]        [<c00000000061f0d0>] .__cpufreq_governor+0xc0/0x390
[    6.883389]        [<c00000000061f9fc>] .cpufreq_set_policy+0x25c/0x2c0
[    6.896581]        [<c0000000006206d4>] .cpufreq_init_policy+0x84/0xe0
[    6.909605]        [<c0000000006212ec>]
.__cpufreq_add_dev.isra.29+0xa7c/0xad0
[    6.924013]        [<c000000000489dd8>] .subsys_interface_register+0xc8/0x120
[    6.938253]        [<c0000000006215f8>] .cpufreq_register_driver+0x138/0x310
[    6.952314]        [<c000000000adeca8>] .g5_cpufreq_init+0x9cc/0xa28
[    6.964991]        [<c00000000000a714>] .do_one_initcall+0xd4/0x270
[    6.977488]        [<c000000000aaa778>] .kernel_init_freeable+0x190/0x270
[    6.991033]        [<c00000000000b17c>] .kernel_init+0x1c/0x120
[    7.002841]        [<c0000000000095b4>] .ret_from_kernel_thread+0x58/0xa4
[    7.016380]
other info that might help us debug this:

[    7.032354] Chain exists of:
  &bus->mutex --> subsys mutex#2 --> &policy->rwsem

[    7.047635]  Possible unsafe locking scenario:

[    7.059439]        CPU0                    CPU1
[    7.068467]        ----                    ----
[    7.077495]   lock(&policy->rwsem);
[    7.084440]                                lock(subsys mutex#2);
[    7.096422]                                lock(&policy->rwsem);
[    7.108400]   lock(&bus->mutex);
[    7.114829]
 *** DEADLOCK ***

[    7.126633] 3 locks held by swapper/0/1:
[    7.134445]  #0:  (subsys mutex#2){+.+.+.}, at:
[<c000000000489d60>] .subsys_interface_register+0x50/0x120
[    7.153719]  #1:  (cpufreq_rwsem){.+.+.+}, at: [<c00000000062093c>]
.__cpufreq_add_dev.isra.29+0xcc/0xad0
[    7.172817]  #2:  (&policy->rwsem){+.+.+.}, at:
[<c000000000620bbc>] .__cpufreq_add_dev.isra.29+0x34c/0xad0
[    7.192261]
stack backtrace:
[    7.200945] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.1.0-rc6-01265-g908e80d-dirty #15
[    7.217091] Call Trace:
[    7.221953] [c0000000790beab0] [c0000000007ad48c]
.dump_stack+0x98/0xd4 (unreliable)
[    7.237407] [c0000000790beb30] [c0000000007a9094]
.print_circular_bug+0x364/0x39c
[    7.252336] [c0000000790bebe0] [c0000000000d0e40] .check_prev_add+0x8d0/0x8e0
[    7.266575] [c0000000790becf0] [c0000000000d5304]
.__lock_acquire+0x1194/0x1b70
[    7.281156] [c0000000790bee20] [c0000000000d6380] .lock_acquire+0x80/0x100
[    7.294874] [c0000000790beef0] [c0000000007a0ccc]
.mutex_lock_nested+0xac/0x5a0
[    7.309456] [c0000000790bf010] [c00000000004d450] .pmac_i2c_open+0x30/0x100
[    7.323349] [c0000000790bf0a0] [c00000000004da34]
.pmac_i2c_do_begin+0x34/0x120
[    7.337931] [c0000000790bf130] [c0000000000517e0] .pmf_call_one+0x50/0xd0
[    7.351477] [c0000000790bf1c0] [c0000000006265ec]
.g5_pfunc_switch_volt+0x2c/0xc0
[    7.366405] [c0000000790bf230] [c00000000062659c]
.g5_pfunc_switch_freq+0x1cc/0x1f0
[    7.381688] [c0000000790bf300] [c0000000006262fc]
.g5_cpufreq_target+0x2c/0x40
[    7.396096] [c0000000790bf370] [c00000000061de40]
.__cpufreq_driver_target+0x230/0x400
[    7.411893] [c0000000790bf430] [c000000000622bec]
.cpufreq_governor_performance+0x3c/0x60
[    7.428219] [c0000000790bf4a0] [c00000000061f0d0]
.__cpufreq_governor+0xc0/0x390
[    7.442975] [c0000000790bf530] [c00000000061f9fc]
.cpufreq_set_policy+0x25c/0x2c0
[    7.457904] [c0000000790bf5c0] [c0000000006206d4]
.cpufreq_init_policy+0x84/0xe0
[    7.472666] [c0000000790bf920] [c0000000006212ec]
.__cpufreq_add_dev.isra.29+0xa7c/0xad0
[    7.488810] [c0000000790bfa10] [c000000000489dd8]
.subsys_interface_register+0xc8/0x120
[    7.504782] [c0000000790bfab0] [c0000000006215f8]
.cpufreq_register_driver+0x138/0x310
[    7.520586] [c0000000790bfb50] [c000000000adeca8]
.g5_cpufreq_init+0x9cc/0xa28
[    7.534993] [c0000000790bfc10] [c00000000000a714] .do_one_initcall+0xd4/0x270
[    7.549233] [c0000000790bfd00] [c000000000aaa778]
.kernel_init_freeable+0x190/0x270
[    7.564510] [c0000000790bfdb0] [c00000000000b17c] .kernel_init+0x1c/0x120
[    7.578056] [c0000000790bfe30] [c0000000000095b4]
.ret_from_kernel_thread+0x58/0xa4

Thanks.
