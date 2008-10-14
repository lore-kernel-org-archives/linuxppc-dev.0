Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 154D8DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:32:46 +1100 (EST)
Date: Tue, 14 Oct 2008 11:32:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Aaron Tokhy <atokhy@gmail.com>
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
In-Reply-To: <Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
Message-ID: <Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-722226620-1223976762=:16020"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-722226620-1223976762=:16020
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Oct 2008, Geert Uytterhoeven wrote:
> On Sun, 12 Oct 2008, Aaron Tokhy wrote:
> > I recently built 2.6.27 with these patches on my PS3.
> > 
> > http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-patches/ps3-wip/ps3vram-driver.patch
> > http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-linux-patches/ps3-wip/ps3vram-proc-fs.patch
> > 
> > These patches enable the 'ps3vram' module, which creates a MTD node
> 
> > Now I am not sure if the patch is the issue.  None of the functions in
> 
> No, we've seen similar things happen without ps3vram, too.
> 
> > BUG: soft lockup - CPU#0 stuck for 61s! [top:22788]
> > Modules linked in: evdev hci_usb usbhid bluetooth usb_storage snd_ps3
> > ehci_hcd snd_pcm ohci_hcd snd_page_alloc snd_timer usbcore snd sg
> > ps3_lpm soundcore
> > irq event stamp: 5018780
> > hardirqs last  enabled at (5018779): [<c000000000007c1c>] restore+0x1c/0xe4
> > hardirqs last disabled at (5018780): [<c000000000003600>] decrementer_common+0x100/0x180
> > softirqs last  enabled at (5018778): [<c000000000020928>] .call_do_softirq+0x14/0x24
> > softirqs last disabled at (5018773): [<c000000000020928>] .call_do_softirq+0x14/0x24
> > NIP: c000000000084110 LR: c000000000084468 CTR: c0000000003181d0
> > REGS: c000000006f37280 TRAP: 0901   Not tainted  (2.6.27)
> > MSR: 8000000000008032 <EE,IR,DR>  CR: 42004424  XER: 00000000
> > TASK = c000000007980000[22788] 'top' THREAD: c000000006f34000 CPU: 0
> > GPR00: 0000000000000001 c000000006f37500 c0000000005543d0 c000000006f37570
> > GPR04: 0000000000000000 c00000000008427c 0000000000000001 0000000000000000
> > GPR08: 0000000000000830 0000000000000001 0000000000000000 c000000000b96874
> > GPR12: 8000000000008032 c000000000586300
> > NIP [c000000000084110] .csd_flag_wait+0x14/0x1c
> > LR [c000000000084468] .smp_call_function_single+0x13c/0x164
> > Call Trace:
> > [c000000006f37500] [c000000000084468] .smp_call_function_single+0x13c/0x164 (unreliable)
> 
> smp_call_function_single() causes an IPI to be sent to the other CPU thread.
> However, the IPI never seems to arrive at the other CPU thread, causing the
> soft lockup message to be printed on the console.
> 
> If this happens when the BKL is held before sending the IPI, the system will
> deadlock when the other CPU thread tries to acquire the BKL. In that
> unfortunate case, you won't see any message on the console of a retail PS3,
> though.
> 
> So far we do not know what's the exact cause of the IPI not arriving, hence
> suggestions are welcome.

I've enabled the recently introduced CONFIG_RCU_CPU_STALL_DETECTOR option and
got:

| <3>RCU detected CPU 1 stall (t=4295279718/750 jiffies)
| Call Trace:
| [c000000013e5a940] [c00000000000f314] .show_stack+0x70/0x184 (unreliable)
| [c000000013e5a9f0] [c00000000009029c] .__rcu_pending+0x9c/0x2b4
| [c000000013e5aa90] [c0000000000904ec] .rcu_pending+0x38/0x84
| [c000000013e5ab10] [c00000000005d9f0] .update_process_times+0x40/0x8c
| [c000000013e5aba0] [c000000000076d4c] .tick_sched_timer+0x154/0x1bc
| [c000000013e5ac60] [c00000000006e630] .__run_hrtimer+0x8c/0x128
| [c000000013e5ad00] [c00000000006f60c] .hrtimer_interrupt+0x10c/0x1c8
| [c000000013e5add0] [c00000000001d2d0] .timer_interrupt+0xcc/0x124
| [c000000013e5ae80] [c000000000003614] decrementer_common+0x114/0x180
| --- Exception: 901 at .csd_flag_wait+0x4/0x1c
|     LR = .smp_call_function_single+0x13c/0x164
| [c000000013e5b230] [c000000000082774] .smp_call_function_mask+0xe4/0x240
| [c000000013e5b390] [c0000000000566dc] .on_each_cpu+0x24/0x94
| [c000000013e5b430] [c0000000000998bc] .drain_all_pages+0x24/0x3c
| [c000000013e5b4b0] [c000000000099ba4] .__alloc_pages_internal+0x2d0/0x464
| [c000000013e5b5b0] [c0000000000bb158] .cache_alloc_refill+0x340/0x678
| [c000000013e5b680] [c0000000000bb574] .__kmalloc+0xe4/0x170
| [c000000013e5b720] [c000000000297e18] .__alloc_skb+0x7c/0x154
| [c000000013e5b7c0] [c0000000002923a8] .sock_alloc_send_skb+0xc4/0x2a4
| [c000000013e5b8a0] [c00000000030a464] .unix_stream_sendmsg+0x178/0x384
| [c000000013e5b990] [c00000000028e234] .sock_aio_write+0xec/0x114
| [c000000013e5baa0] [c0000000000bf2dc] .do_sync_readv_writev+0xc8/0x130
| [c000000013e5bc30] [c0000000000fefa0] .compat_do_readv_writev+0x1e0/0x33c
| [c000000013e5bd90] [c0000000000ff184] .compat_sys_writev+0x88/0xbc
| [c000000013e5be30] [c0000000000074dc] syscall_exit+0x0/0x40

which points again to smp_call_function_single...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-722226620-1223976762=:16020--
