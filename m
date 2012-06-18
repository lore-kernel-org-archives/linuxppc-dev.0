Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02A1AB7088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 06:45:39 +1000 (EST)
Message-ID: <1340052331.2372.32.camel@pasglop>
Subject: Re: RCU stalls on 32-bit pmac SMP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: paulmck@linux.vnet.ibm.com
Date: Tue, 19 Jun 2012 06:45:31 +1000
In-Reply-To: <20120618170521.GD2400@linux.vnet.ibm.com>
References: <1339979746.2372.6.camel@pasglop>
 <20120618170521.GD2400@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul !

On Mon, 2012-06-18 at 10:05 -0700, Paul E. McKenney wrote:

> > sd 0:0:0:0: Attached scsi generic sg0 type 0
> >  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15
> > sd 0:0:0:0: [sda] Attached SCSI disk
> > scsi 0:0:1:0: Direct-Access     ATA      ST380021A        3.75 PQ: 0 ANSI: 5
> > sd 0:0:1:0: [sdb] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
> > sd 0:0:1:0: [sdb] Write Protect is off
> > sd 0:0:1:0: Attached scsi generic sg1 type 0
> > sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> > sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > INFO: rcu_sched self-detected stall on CPU { 0}  (t=16163 jiffies)
> > Call Trace:
> > INFO: rcu_sched self-detected stall on CPU { 1}  (t=16163 jiffies)
> > Call Trace:
> > [ef877d30] [c0008d04] show_stack+0x50/0x158 (unreliable)
> > [ef877d70] [c0097fe4] __rcu_pending+0x184/0x46c
> > [ef877da0] [c00991a0] rcu_check_callbacks+0x7c/0x168
> > [ef877dc0] [c0044a40] update_process_times+0x3c/0x70
> > [ef877de0] [c0083a3c] tick_sched_timer+0x88/0x100
> > [ef877e10] [c005b11c] __run_hrtimer.clone.29+0x54/0x104
> > [ef877e30] [c005bf44] hrtimer_interrupt+0x158/0x3f8
> > [ef877ea0] [c000b5c4] timer_interrupt+0x1cc/0x204
> > [ef877ed0] [c0011b88] ret_from_except+0x0/0x1c
> > --- Exception: 901 at cpu_idle+0xe4/0x188
> 
> Am I reading this correctly?  Did the system really take a scheduling-clock
> interrupt from within another scheduling-clock interrupt?

Not that I can see. I see only one interrupt on that CPU. It was idle,
took a timer interrupt -> hrtimer ... etc... RCU boom !

> If so, my first question is "Why did the scheduling-clock interrupt
> run for so long?"  ;-)

This is still that CPU:

>      LR = cpu_idle+0xc8/0x188
> > [ef877f90] [c00097e8] cpu_idle+0x60/0x188 (unreliable)
> > [ef877fc0] [c046531c] start_secondary+0x2c8/0x2cc
> > [ef877ff0] [00003278] 0x3278

And now we have the other one:

> > [ef873b60] [c0008d04] show_stack+0x50/0x158 (unreliable)
> > [ef873ba0] [c0097fe4] __rcu_pending+0x184/0x46c
> > [ef873bd0] [c0099240] rcu_check_callbacks+0x11c/0x168
> > [ef873bf0] [c0044a40] update_process_times+0x3c/0x70
> > [ef873c10] [c0083a3c] tick_sched_timer+0x88/0x100
> > [ef873c40] [c005b11c] __run_hrtimer.clone.29+0x54/0x104
> > [ef873c60] [c005bf44] hrtimer_interrupt+0x158/0x3f8
> > [ef873cd0] [c000b5c4] timer_interrupt+0x1cc/0x204
> > [ef873d00] [c0011b88] ret_from_except+0x0/0x1c
> > --- Exception: 901 at wake_up_new_task+0x134/0x16c
> >     LR = wake_up_new_task+0x134/0x16c
> > [ef873dc0] [c0065f08] wake_up_new_task+0xfc/0x16c (unreliable)
> > [ef873df0] [c0035530] do_fork+0xe8/0x2bc
> > [ef873e30] [c0008a4c] sys_clone+0x50/0x90
> > [ef873e50] [c00114b8] ret_from_syscall+0x0/0x40
> > --- Exception: c00 at kernel_thread+0x28/0x68
> >     LR = __call_usermodehelper+0x40/0xdc
> > [ef873f10] [c005f5c8] async_run_entry_fn+0x128/0x1e4 (unreliable)
> > [ef873f20] [ef878c00] 0xef878c00
> > [ef873f40] [c004e668] process_one_work+0x150/0x3f0
> > [ef873f70] [c00514f0] worker_thread+0x18c/0x37c
> > [ef873fb0] [c00567bc] kthread+0x84/0x88
> > [ef873ff0] [c000f514] kernel_thread+0x4c/0x68

Here what we have is a kernel thread trying to call_usermodehelper
(probably the hotplug stuff from discovering the disk) taking a timer
interrupt from wake_up_new_task.

Looks like the hang has to be with some RCU stuff update_process_times
does vs. taking the interrupt in wake_up_new_task ? Hard to tell...

This happens more/less reliably once at boot on this machine, then no
more (after the long pause the machine moves on, apparently fine).

Cheers,
Ben.

> > pata-macio 0.00020000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 0
> > scsi1 : pata_macio
> > ata2: PATA max MWDMA2 irq 20
> >  sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 sdb13
> > sd 0:0:1:0: [sdb] Attached SCSI disk
> > ata2.00: ATAPI: PIONEER DVD-RW  DVR-104, A227, max UDMA/33
> > ata2.00: configured for MWDMA2
> > scsi 1:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-104  A227 PQ: 0 ANSI: 5
> > pata-macio 0.00021000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 1
> > scsi2 : pata_macio
> > ata3: PATA max MWDMA2 irq 21
> > sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> > cdrom: Uniform CD-ROM driver Revision: 3.20
> > sr 1:0:0:0: Attached scsi CD-ROM sr0
> > pcnet32: pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.franken.de
> > sr 1:0:0:0: Attached scsi generic sg2 type 5
> > sungem.c:v1.0 David S. Miller <davem@redhat.com>
> > gem 0002:20:0f.0: eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:6f:04:b2
> > PPP generic driver version 2.4.2
> > PPP Deflate Compression module registered
> > ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > ohci_hcd 0001:10:18.0: OHCI Host Controller
> > ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
> > ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 2 ports detected
> > ohci_hcd 0001:10:19.0: OHCI Host Controller
> > ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
> > ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
> > hub 2-0:1.0: USB hub found
> > hub 2-0:1.0: 2 ports detected
> > mousedev: PS/2 mouse device common for all mice
> > usbcore: registered new interface driver appletouch
> > PowerMac i2c bus pmu 2 registered
> > i2c i2c-0: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/via-pmu@16000/rtc
> > i2c i2c-0: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/via-pmu@16000/power-mgt
> > PowerMac i2c bus pmu 1 registered
> > i2c i2c-1: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/via-pmu@16000/rtc
> > i2c i2c-1: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/via-pmu@16000/power-mgt
> > PowerMac i2c bus mac-io 0 registered
> > i2c i2c-2: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/i2c@18000/cereal
> > i2c i2c-2: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/i2c@18000/deq
> > i2c i2c-2: i2c-powermac: invalid reg on /pci@f2000000/mac-io@17/i2c@18000/i2c-modem
> > PowerMac i2c bus uni-n 1 registered
> > i2c i2c-3: i2c-powermac: invalid reg on /uni-n@f8000000/i2c@f8001000/cereal
> > PowerMac i2c bus uni-n 0 registered
> > i2c i2c-4: i2c-powermac: invalid reg on /uni-n@f8000000/i2c@f8001000/cereal
> > APM Battery Driver
> > usbcore: registered new interface driver usbhid
> > usbhid: USB HID core driver
> > oprofile: using ppc/7450 performance monitoring.
> > TCP: cubic registered
> > Initializing XFRM netlink socket
> > NET: Registered protocol family 17
> > NET: Registered protocol family 15
> > Key type dns_resolver registered
> > PM: Hibernation image not present or could not be loaded.
> > input: PMU as /devices/virtual/input/input0
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs (sda15): mounted filesystem with writeback data mode
> > VFS: Mounted root (ext3 filesystem) readonly on device 8:15.
> > usb 1-1: new full-speed USB device number 2 using ohci_hcd
> > devtmpfs: mounted
> > Freeing unused kernel memory: 240k freed
> > hub 1-1:1.0: USB hub found
> > hub 1-1:1.0: 3 ports detected
> > usb 1-2: new full-speed USB device number 3 using ohci_hcd
> > hub 1-2:1.0: USB hub found
> > hub 1-2:1.0: 3 ports detected
> > usb 1-1.3: new full-speed USB device number 4 using ohci_hcd
> > input: Mitsumi Electric Apple Extended USB Keyboard as /devices/pci0001:10/0001:10:18.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input1
> > hid-generic 0003:05AC:020B.0001: input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:18.0-1.3/input0
> > input: Mitsumi Electric Apple Extended USB Keyboard as /devices/pci0001:10/0001:10:18.0/usb1/1-1/1-1.3/1-1.3:1.1/input/input2
> > hid-generic 0003:05AC:020B.0002: input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:18.0-1.3/input1
> > usb 1-2.3: new low-speed USB device number 5 using ohci_hcd
> > hid-generic 0003:05AC:9219.0003: claimed by neither input, hiddev nor hidraw
> > udevd[1209]: starting version 175
> > EXT3-fs (sda15): using internal journal
> > sungem_phy: PHY ID: 2060e1, addr: 0
> > gem 0002:20:0f.0: eth0: Found BCM5421 PHY
> > gem 0002:20:0f.0: eth0: Link is up at 100 Mbps, full-duplex
> > gem 0002:20:0f.0: eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
> > sshd (2042): /proc/2042/oom_adj is deprecated, please use /proc/2042/oom_score_adj instead.
> > 
> > 
