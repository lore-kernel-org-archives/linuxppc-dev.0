Return-Path: <keescook@google.com>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7MgH30FBzDrCp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 06:06:03 +1100 (AEDT)
Received: by mail-io0-x233.google.com with SMTP id 21so14281379iof.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 12:06:03 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1507224106.3792.26.camel@abdul.in.ibm.com>
References: <1507224106.3792.26.camel@abdul.in.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Oct 2017 12:05:59 -0700
Message-ID: <CAGXu5j+ZyeZELcdCztetQdSkipH-tAke3FAhmCS-_=3gU-tikQ@mail.gmail.com>
Subject: Re: [linux-next][Oops] CPU toggle resulted in kernel crash
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, sachinp <sachinp@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 5, 2017 at 10:21 AM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> Hi,
>
> CPU off on in a loop for single cpu results in kernel panic for
> 4.14.0-rc2-next-20170929
>
> Machine: Power 8 PowerVM LPAR
> Kernel: 4.14.0-rc2-next-20170929
> gcc: 5.1.1
> config : attached
>
> Steps to recreate:
> -----------------
> The issue is not reproducible all the time.
>
> The trace occurred when CPU toggle operation for cpu14 in a loop for 10
> iterations.
>
> the Faulting instruction address: 0xc00000000035465c
> maps to:
>
> 0xc00000000035465c is in deactivate_slab (mm/slub.c:261).
> 256
> 257     /* Returns the freelist pointer recorded at location ptr_addr. */
> 258     static inline void *freelist_dereference(const struct kmem_cache =
*s,
> 259                                              void *ptr_addr)
> 260     {
> 261             return freelist_ptr(s, (void *)*(unsigned long *)(ptr_add=
r),
> 262                                 (unsigned long)ptr_addr);
> 263     }
> 264
> 265     static inline void *get_freepointer(struct kmem_cache *s, void *o=
bject)

This looks like slub cache corruption (a NULL pointer dereference for
the heap freelist).

-Kees

>
> dmesg logs:
> -----------
> Unable to handle kernel paging request for data at address 0x00000042
> Faulting instruction address: 0xc00000000035465c
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE SMP NR_CPUS=3D2048 NUMA pSeries
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in: rpadlpar_io(E) rpaphp(E) xt_addrtype(E) xt_conntrack(E=
) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E) iptable_nat(E) nf_conntrack_i=
pv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E) iptable_filter(E) ip_tables(E) x_ta=
bles(E) nf_nat(E) nf_conntrack(E) bridge(E) stp(E) llc(E) dm_thin_pool(E) d=
m_persistent_data(E) dm_bio_prison(E) dm_bufio(E) libcrc32c(E) vmx_crypto(E=
) rtc_generic(E) pseries_rng(E) autofs4(E)
> CPU: 15 PID: 2687 Comm: sh Tainted: G            E   4.14.0-rc2-next-2017=
0929-autotest #1
> task: c000000772342e00 task.stack: c000000772488000
> NIP:  c00000000035465c LR: c000000000354ef8 CTR: c000000000354e90
> REGS: c00000077ff6b8f0 TRAP: 0300   Tainted: G            E    (4.14.0-rc=
2-next-20170929-autotest)
> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28088822  XER: 2000000=
0
> CFAR: c000000000008718 DAR: 0000000000000042 DSISR: 40000000 SOFTE: 0
> GPR00: c000000000354ef8 c00000077ff6bb70 c00000000159c600 c00000077e01f30=
0
> GPR04: f000000001dcaec0 0000000000000010 000000000000006d 000000000000000=
1
> GPR08: 0000000001550000 0000000000000000 000000008155006d 00000000000000f=
f
> GPR12: 0000000088008828 c00000000e749d80 0000000000000000 000000000000000=
0
> GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
> GPR20: 0000000000000000 0000000000000000 0000000000000001 000000000000000=
2
> GPR24: c00000077e00fe40 0000000000000042 c000000772bb51c0 c00000077fee7d3=
0
> GPR28: c00000077fee7d20 c00000077e01f300 c000000772bb51a8 f000000001dcaec=
0
> NIP [c00000000035465c] deactivate_slab.isra.22+0x19c/0x610
> LR [c000000000354ef8] flush_cpu_slab+0x68/0xc0
> Call Trace:
> [c00000077ff6bb70] [c00000000035488c] deactivate_slab.isra.22+0x3cc/0x610=
 (unreliable)
> [c00000077ff6bca0] [c000000000354ef8] flush_cpu_slab+0x68/0xc0
> [c00000077ff6bcd0] [c0000000001c7470] flush_smp_call_function_queue+0x120=
/0x1e0
> [c00000077ff6bd50] [c000000000048fac] smp_ipi_demux_relaxed+0x9c/0x110
> [c00000077ff6bd90] [c000000000093fc4] icp_hv_ipi_action+0x64/0xb0
> [c00000077ff6be00] [c000000000185a60] __handle_irq_event_percpu+0x90/0x2d=
0
> [c00000077ff6bec0] [c000000000185cdc] handle_irq_event_percpu+0x3c/0x90
> [c00000077ff6bf00] [c00000000018c894] handle_percpu_irq+0x84/0xd0
> [c00000077ff6bf30] [c0000000001840f4] generic_handle_irq+0x54/0x80
> [c00000077ff6bf60] [c000000000016f00] __do_irq+0x80/0x1d0
> [c00000077ff6bf90] [c00000000002b120] call_do_irq+0x14/0x24
> [c00000077248bde0] [c0000000000170e8] do_IRQ+0x98/0x140
> [c00000077248be30] [c000000000008ac4] hardware_interrupt_common+0x114/0x1=
20
> Instruction dump:
> b0df0018 60420000 815f0018 55490bfe 5529f83e 7d294378 913f0018 7c2004ac
> e93f0000 792907a4 f93f0000 e93d0022 <7d59482a> 2faa0000 419e0054 7f3acb78
> ---[ end trace 1094995650f27c82 ]---
>
> Kernel panic - not syncing: Fatal exception in interrupt
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> ------------[ cut here ]------------
> WARNING: CPU: 15 PID: 2687 at kernel/sched/core.c:1178 set_task_cpu+0x200=
/0x260
> Modules linked in: rpadlpar_io(E) rpaphp(E) xt_addrtype(E) xt_conntrack(E=
) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E) iptable_nat(E) nf_conntrack_i=
pv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E) iptable_filter(E) ip_tables(E) x_ta=
bles(E) nf_nat(E) nf_conntrack(E) bridge(E) stp(E) llc(E) dm_thin_pool(E) d=
m_persistent_data(E) dm_bio_prison(E) dm_bufio(E) libcrc32c(E) vmx_crypto(E=
) rtc_generic(E) pseries_rng(E) autofs4(E)
> CPU: 15 PID: 2687 Comm: sh Tainted: G      D     E   4.14.0-rc2-next-2017=
0929-autotest #1
> task: c000000772342e00 task.stack: c000000772488000
> NIP:  c0000000001429c0 LR: c000000000143674 CTR: c00000000014fc00
> REGS: c00000077ff6ac60 TRAP: 0700   Tainted: G      D     E    (4.14.0-rc=
2-next-20170929-autotest)
> MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28088884  XER: 0000000=
2
> CFAR: c00000000014286c SOFTE: 0
> GPR00: c000000000143674 c00000077ff6aee0 c00000000159c600 c000000775159e0=
0
> GPR04: 0000000000000000 0000000000000000 0000000000000001 000000000000000=
1
> GPR08: 0000000000000000 0000000000008000 c0000000015d1ed0 000000000000000=
2
> GPR12: 0000000028088224 c00000000e749d80 0000000000000000 000000000000000=
0
> GPR16: 0000000000000000 0000000000000000 0000000000000000 000000077ee1000=
0
> GPR20: c00000077fed15c0 0000000000000000 0000000000000000 000000000000000=
0
> GPR24: c0000000015cdd78 c00000077515a238 c0000000010d6680 000000000000000=
0
> GPR28: 0000000000000000 0000000000000004 0000000000000000 c000000775159e0=
0
> NIP [c0000000001429c0] set_task_cpu+0x200/0x260
> LR [c000000000143674] try_to_wake_up+0x1d4/0x5d0
> Call Trace:
> [c00000077ff6aee0] [c0000000010d6680] runqueues+0x0/0xb00 (unreliable)
> [c00000077ff6af20] [c000000000143674] try_to_wake_up+0x1d4/0x5d0
> [c00000077ff6afa0] [c0000000001674d4] autoremove_wake_function+0x44/0x80
> [c00000077ff6aff0] [c000000000166824] __wake_up_common+0xe4/0x1e0
> [c00000077ff6b060] [c0000000001669dc] __wake_up_common_lock+0xbc/0x110
> [c00000077ff6b0f0] [c000000000182f90] wake_up_klogd_work_func+0x60/0xa0
> [c00000077ff6b120] [c00000000026c7d0] irq_work_run_list+0xb0/0x100
> [c00000077ff6b170] [c0000000001a8450] update_process_times+0x60/0x90
> [c00000077ff6b1a0] [c0000000001c080c] tick_sched_handle.isra.5+0x5c/0xa0
> [c00000077ff6b1d0] [c0000000001c08b0] tick_sched_timer+0x60/0xe0
> [c00000077ff6b210] [c0000000001a9058] __hrtimer_run_queues+0xf8/0x360
> [c00000077ff6b290] [c0000000001a9ffc] hrtimer_interrupt+0xfc/0x350
> [c00000077ff6b360] [c000000000025324] __timer_interrupt+0x94/0x270
> [c00000077ff6b3b0] [c000000000025764] timer_interrupt+0xa4/0x110
> [c00000077ff6b3f0] [c000000000008f74] decrementer_common+0x114/0x120
> --- interrupt: 901 at replay_interrupt_return+0x0/0x4
>     LR =3D arch_local_irq_restore+0x74/0x90
> [c00000077ff6b6e0] [c000000000e7fc00] num_spec.61222+0x178bbc/0x2287cc (u=
nreliable)
> [c00000077ff6b700] [c000000000100d44] panic+0x2b0/0x30c
> [c00000077ff6b790] [c000000000026428] oops_end+0x1b8/0x1e0
> [c00000077ff6b810] [c000000000067d30] bad_page_fault+0xe0/0x160
> [c00000077ff6b880] [c00000000000a4c0] handle_page_fault+0x34/0x38
> --- interrupt: 300 at deactivate_slab.isra.22+0x19c/0x610
>     LR =3D flush_cpu_slab+0x68/0xc0
> [c00000077ff6bb70] [c00000000035488c] deactivate_slab.isra.22+0x3cc/0x610=
 (unreliable)
> [c00000077ff6bca0] [c000000000354ef8] flush_cpu_slab+0x68/0xc0
> [c00000077ff6bcd0] [c0000000001c7470] flush_smp_call_function_queue+0x120=
/0x1e0
> [c00000077ff6bd50] [c000000000048fac] smp_ipi_demux_relaxed+0x9c/0x110
> [c00000077ff6bd90] [c000000000093fc4] icp_hv_ipi_action+0x64/0xb0
> [c00000077ff6be00] [c000000000185a60] __handle_irq_event_percpu+0x90/0x2d=
0
> [c00000077ff6bec0] [c000000000185cdc] handle_irq_event_percpu+0x3c/0x90
> [c00000077ff6bf00] [c00000000018c894] handle_percpu_irq+0x84/0xd0
> [c00000077ff6bf30] [c0000000001840f4] generic_handle_irq+0x54/0x80
> [c00000077ff6bf60] [c000000000016f00] __do_irq+0x80/0x1d0
> [c00000077ff6bf90] [c00000000002b120] call_do_irq+0x14/0x24
> [c00000077248bde0] [c0000000000170e8] do_IRQ+0x98/0x140
> [c00000077248be30] [c000000000008ac4] hardware_interrupt_common+0x114/0x1=
20
> Instruction dump:
> e93d0019 2fa90000 409effd8 4bfffed8 893f0644 61290004 993f0644 4bffff10
> 0fe00000 4bfffe6c 60000000 60420000 <0fe00000> 4bfffeac 60000000 60420000
> ---[ end trace 1094995650f27c83 ]---
>
>
>
> --
> Regard's
>
> Abdul Haleem
> IBM Linux Technology Centre
>
>



--=20
Kees Cook
Pixel Security
