Return-Path: <hamishm@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsyF2XrfzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:52:21 +1100 (AEDT)
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: chris.packham@alliedtelesis.co.nz, linuxppc-dev@lists.ozlabs.org,
 Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] Allow configurable stack size (especially 32k on PPC64)
Date: Fri, 24 Feb 2017 13:52:08 +1300
Message-Id: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds the ability to configure the THREAD_SHIFT value and
thereby alter the stack size on powerpc systems. We are particularly interested
in configuring for a 32k stack on PPC64.

Using an NXP T2081 (e6500 PPC64 cores) we are observing stack overflows as a
result of applying a DTS overlay containing some I2C devices. Our scenario is
an ethernet switch chassis with plug-in cards. The I2C is driven from the T2081
through a PCA9548 mux on the main board. When we detect insertion of the plugin
card we schedule work for a call to of_overlay_create() to install a DTS
overlay for the plugin board. This DTS overlay contains a further PCA9548 mux
with more devices hanging off it including a PCA9539 GPIO expander. The
ultimate installed I2C tree is:

T2081 --- PCA9548 MUX --- PCA9548 MUX --- PCA9539 GPIO Expander

When we install the overlay the devices described in the overlay are probed and
we see a large number of stack frames used as a result. If this is coupled with
an interrupt happening that requires moderate to high stack use we observe
stack corruption. Here is an example long stack (from a 4.10-rc8 kernel) that
does not show corruption but does demonstrate the length and frame sizes
involved.

        Depth    Size   Location    (72 entries)
        -----    ----   --------
  0)    13872     128   .__raise_softirq_irqoff+0x1c/0x130
  1)    13744     144   .raise_softirq+0x30/0x70
  2)    13600     112   .invoke_rcu_core+0x54/0x70
  3)    13488     336   .rcu_check_callbacks+0x294/0xde0
  4)    13152     128   .update_process_times+0x40/0x90
  5)    13024     144   .tick_sched_handle.isra.16+0x40/0xb0
  6)    12880     144   .tick_sched_timer+0x6c/0xe0
  7)    12736     272   .__hrtimer_run_queues+0x1a0/0x4b0
  8)    12464     208   .hrtimer_interrupt+0xe8/0x2a0
  9)    12256     160   .__timer_interrupt+0xdc/0x330
 10)    12096     160   .timer_interrupt+0x138/0x190
 11)    11936     752   exc_0x900_common+0xe0/0xe4
 12)    11184     128   .ftrace_ops_no_ops+0x11c/0x230
 13)    11056     176   .ftrace_ops_test.isra.12+0x30/0x50
 14)    10880     160   .ftrace_ops_no_ops+0xd4/0x230
 15)    10720     112   ftrace_call+0x4/0x8
 16)    10608     176   .lock_timer_base+0x3c/0xf0
 17)    10432     144   .try_to_del_timer_sync+0x2c/0x90
 18)    10288     128   .del_timer_sync+0x60/0x80
 19)    10160     256   .schedule_timeout+0x1fc/0x490
 20)     9904     208   .i2c_wait+0x238/0x290
 21)     9696     256   .mpc_xfer+0x4e4/0x570
 22)     9440     208   .__i2c_transfer+0x158/0x6d0
 23)     9232     192   .pca954x_reg_write+0x70/0x110
 24)     9040     160   .__i2c_mux_master_xfer+0xb4/0xf0
 25)     8880     208   .__i2c_transfer+0x158/0x6d0
 26)     8672     192   .pca954x_reg_write+0x70/0x110
 27)     8480     144   .pca954x_select_chan+0x68/0xa0
 28)     8336     160   .__i2c_mux_master_xfer+0x64/0xf0
 29)     8176     208   .__i2c_transfer+0x158/0x6d0
 30)     7968     144   .i2c_transfer+0x98/0x130
 31)     7824     320   .i2c_smbus_xfer_emulated+0x168/0x600
 32)     7504     208   .i2c_smbus_xfer+0x1c0/0x5d0
 33)     7296     192   .i2c_smbus_write_byte_data+0x50/0x70
 34)     7104     144   .pca953x_write_single+0x6c/0xe0
 35)     6960     192   .pca953x_gpio_direction_output+0xa4/0x160
 36)     6768     160   ._gpiod_direction_output_raw+0xec/0x460
 37)     6608     160   .gpiod_hog+0x98/0x250
 38)     6448     176   .of_gpiochip_add+0xdc/0x1c0
 39)     6272     256   .gpiochip_add_data+0x4f4/0x8c0
 40)     6016     144   .devm_gpiochip_add_data+0x64/0xf0
 41)     5872     208   .pca953x_probe+0x2b4/0x5f0
 42)     5664     144   .i2c_device_probe+0x224/0x2e0
 43)     5520     160   .really_probe+0x244/0x380
 44)     5360     160   .bus_for_each_drv+0x94/0x100
 45)     5200     160   .__device_attach+0x118/0x160
 46)     5040     144   .bus_probe_device+0xe8/0x100
 47)     4896     208   .device_add+0x500/0x6c0
 48)     4688     144   .i2c_new_device+0x1f8/0x240
 49)     4544     256   .of_i2c_register_device+0x160/0x280
 50)     4288     192   .i2c_register_adapter+0x238/0x630
 51)     4096     208   .i2c_mux_add_adapter+0x3f8/0x540
 52)     3888     192   .pca954x_probe+0x234/0x370
 53)     3696     144   .i2c_device_probe+0x224/0x2e0
 54)     3552     160   .really_probe+0x244/0x380
 55)     3392     160   .bus_for_each_drv+0x94/0x100
 56)     3232     160   .__device_attach+0x118/0x160
 57)     3072     144   .bus_probe_device+0xe8/0x100
 58)     2928     208   .device_add+0x500/0x6c0
 59)     2720     144   .i2c_new_device+0x1f8/0x240
 60)     2576     256   .of_i2c_register_device+0x160/0x280
 61)     2320     144   .of_i2c_notify+0x12c/0x1d0
 62)     2176     160   .notifier_call_chain+0x8c/0x100
 63)     2016     160   .__blocking_notifier_call_chain+0x6c/0xe0
 64)     1856     208   .__of_changeset_entry_notify+0xd8/0x140
 65)     1648     192   .__of_changeset_apply+0x7c/0x100
 66)     1456     272   .of_overlay_create+0x2e0/0x4b0
 67)     1184     128   .xem2_install_overlay+0x40/0x90
 68)     1056     176   .process_one_work+0x18c/0x540
 69)      880     240   .worker_thread+0x98/0x550
 70)      640     192   .kthread+0x150/0x190
 71)      448     448   .ret_from_kernel_thread+0x58/0x64
13872

Obviously this could be avoided by constant whack-a-mole type activity of
restructuring code. We have in fact reworked our code from a two overlay
install to a one overlay install to avoid the worst cases. However, we believe
there is a more fundamental issue at the heart of the problem that ought to be
addressed.

In this thread from 2008 (https://lkml.org/lkml/2008/11/17/493) discussing
similar issues it is observed that the minimum stack frame size for PPC64 is
112 bytes compared with 16 bytes for PPC32. We consider that this fact means
the straight doubling of the 8k PPC32 stack to 16K for PPC64 does not lead to
an "equitable" situation with regard to stack headroom. The PPC64 system will
not have an equivalent amount of space to operate in.

For instance for a 70 frame stack, the architecture overhead just for the stack
frames is:
   70 * 16 bytes = 1120 bytes for PPC32, and
   70 * 112 bytes = 7840 bytes for PPC64.
So a simple doubling of the PPC32 stack size leaves us with a shortfall of 5600
bytes (7840 - (2 * 1120)). In the example the stack frame overhead for PPC32 is
1120/8192 = 13.5% of the stack space, whereas for PPC64 it is 7840/16384 =
47.8% of the space.

The aim of this series is to provide the ability for users to configure for
larger stacks without altering the defaults in a way that would impact existing
users. However, given the inequity between the PPC32 and PPC64 stacks when
taking into account the respective minimum stack frame sizes, we believe
consideration should be given to having a large default. We would appreciate
any input or opinions on this issue.

Changes:
v2:
* make THREAD_SHIFT dependent on EXPERT as suggested by Michael Ellerman.

Hamish Martin (2):
  powerpc: Move THREAD_SHIFT config to KConfig
  powerpc64: Allow for THREAD_SIZE > 16k

 arch/powerpc/Kconfig                   | 10 ++++++++++
 arch/powerpc/include/asm/thread_info.h | 10 +---------
 arch/powerpc/kernel/head_64.S          |  3 ++-
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.11.0
