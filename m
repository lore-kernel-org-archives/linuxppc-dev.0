Date: Wed, 14 Jul 2004 16:15:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <piggin@cyberone.com.au>
Subject: Fw: 2.6.8-rc1-mm1 "Badness in schedule" on ppc32
Message-Id: <20040714161503.2b0ce4d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nick , Ingo: could you please appropriately berate the ppc developers
over this?  They're ignoring me ;)

Or, if we don't really think the risk is very high, maybe I should just drop
the debug patch?

Begin forwarded message:

Date: Thu, 15 Jul 2004 02:00:01 +0200 (MEST)
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Cc: jhf@rivenstone.net, linux-kernel@vger.kernel.org, trini@kernel.crashing.org
Subject: 2.6.8-rc1-mm1 "Badness in schedule" on ppc32


On 2004-07-14 22:01:50, Tom Rini wrote:
>On Fri, Jul 09, 2004 at 02:11:03PM -0700, Andrew Morton wrote:
>
>>
>> jhf@rivenstone.net (Joseph Fannin) wrote:
>> >
>> > On Thu, Jul 08, 2004 at 11:50:25PM -0700, Andrew Morton wrote:
>> > >
>> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
>> >
>> > > +detect-too-early-schedule-attempts.patch
>> > >
>> > > Catch attempts to call the scheduler before it is ready to go.
>> >
>> > With this patch, my Powermac (ppc32) spews 711 (I think)
>> > warning messages during bootup.
>>
>> hm, OK.  It could be that the debug patch is a bit too aggressive, or that
>> ppc got lucky and happens to always be in state TASK_RUNNING when these
>> calls to schedule() occur.
>>
>> Maybe this task incorrectly has _TIF_NEED_RESCHED set?
>>
>> Anyway, ppc guys: please take a look at the results from
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken \
>> -out/detect-too-early-schedule-attempts.patch and check that the kernel really \
>> should be calling schedule() at this time and place, let us know?
>
>Now that kallsyms data is OK, I took a quick look.. and all of this
>comes from generic code, at least on the machine I tried.  So if the
>code shouldn't be calling schedule() then, it's a more generic problem..
>
>... or I'm not following.

On my ppc32 (G3 PowerMac) 2.6.8-rc1-mm1 throws a large number of
"Badness in schedule" during boot. Below are the ones I managed
to capture: they contain both generic traces, and traces involving
Mac-only drivers.

Some of the traces involve the PDC202XX_NEW driver; I'll move that
card into an x86 PC tomorrow to see if the traces reappear or not;
if they don't then it does look like a PPC32-specific problem.

The kernel .config is SMP=n, PREEMPT=n, no debugging nonsense :-)

/Mikael

 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e0bc] wait_for_completion+0x7c/0x118
 [c00e10b0] adb_request+0x170/0x238
 [c00e1334] do_adb_reset_bus+0x1bc/0x530
 [c00e1778] adb_probe_task+0x54/0xb8
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbc8] do_probe+0x68/0x2c8
 [c00ec214] probe_hwif+0x3a0/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbb8] do_probe+0x58/0x2c8
 [c00ec4a0] probe_hwif+0x62c/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbc8] do_probe+0x68/0x2c8
 [c00ec4a0] probe_hwif+0x62c/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c0038ef8] pdflush+0xc4/0x1f4
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e0bc] wait_for_completion+0x7c/0x118
 [c00e10b0] adb_request+0x170/0x238
 [c00e1334] do_adb_reset_bus+0x1bc/0x530
 [c00e1778] adb_probe_task+0x54/0xb8
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbb8] do_probe+0x58/0x2c8
 [c00ec214] probe_hwif+0x3a0/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbc8] do_probe+0x68/0x2c8
 [c00ec214] probe_hwif+0x3a0/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebe20] do_probe+0x2c0/0x2c8
 [c00ec214] probe_hwif+0x3a0/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbb8] do_probe+0x58/0x2c8
 [c00ec4a0] probe_hwif+0x62c/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e0bc] wait_for_completion+0x7c/0x118
 [c00e10b0] adb_request+0x170/0x238
 [c00e1334] do_adb_reset_bus+0x1bc/0x530
 [c00e1778] adb_probe_task+0x54/0xb8
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebbc8] do_probe+0x68/0x2c8
 [c00ec4a0] probe_hwif+0x62c/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c0021400] msleep+0x38/0x54
 [c00ebe20] do_probe+0x2c0/0x2c8
 [c00ec4a0] probe_hwif+0x62c/0x6b8
 [c00ed030] probe_hwif_init+0x18/0x88
 [c00efd30] ide_setup_pci_device+0x70/0x88
 [c0206bd0] init_setup_pdcnew+0x10/0x20
 [c0206d40] pdc202new_init_one+0x30/0x44
 [c0207788] ide_scan_pcidev+0x80/0xc4
 [c02077f8] ide_scan_pcibus+0x2c/0x11c
 [c02076e0] ide_init+0x68/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c00f32b0] pmac_ide_setup_device+0x11c/0x664
 [c0207ac0] pmac_ide_macio_attach+0x11c/0x27c
 [c00ddd04] macio_device_probe+0x78/0xa4
 [c00cbd74] bus_match+0x50/0x9c
 [c00cbef4] driver_attach+0x74/0xdc
 [c00cc30c] bus_add_driver+0xac/0x160
 [c00cc928] driver_register+0x30/0x40
 [c00de730] macio_register_driver+0x4c/0x68
 [c0207e74] pmac_ide_probe+0x38/0x54
 [c02076e4] ide_init+0x6c/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e638] schedule_timeout+0x80/0xe0
 [c00f32e0] pmac_ide_setup_device+0x14c/0x664
 [c0207ac0] pmac_ide_macio_attach+0x11c/0x27c
 [c00ddd04] macio_device_probe+0x78/0xa4
 [c00cbd74] bus_match+0x50/0x9c
 [c00cbef4] driver_attach+0x74/0xdc
 [c00cc30c] bus_add_driver+0xac/0x160
 [c00cc928] driver_register+0x30/0x40
 [c00de730] macio_register_driver+0x4c/0x68
 [c0207e74] pmac_ide_probe+0x38/0x54
 [c02076e4] ide_init+0x6c/0x90
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c017e0bc] wait_for_completion+0x7c/0x118
 [c00e10b0] adb_request+0x170/0x238
 [c00e1334] do_adb_reset_bus+0x1bc/0x530
 [c00e1778] adb_probe_task+0x54/0xb8
 [c0008268] kernel_thread+0x44/0x60
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c0005d74] check_bug_trap+0x98/0xdc
 [c0005f0c] ProgramCheckException+0x154/0x220
 [c00055a0] ret_from_except_full+0x0/0x4c
 [c017da40] schedule+0x24/0x5fc
 [c00283a4] worker_thread+0x214/0x218
 [c002ca7c] kthread+0xec/0x128
 [c0008268] kernel_thread+0x44/0x60

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
