Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id CE2E6B7D27
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 25 Apr 2010 00:26:23 +1000 (EST)
Message-ID: <4BD2FF8A.9080608@mlbassoc.com>
Date: Sat, 24 Apr 2010 08:26:18 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Initcall ordering
References: <4BD1C317.5000909@mlbassoc.com>
	<20100424012427.GA21255@pengutronix.de>
In-Reply-To: <20100424012427.GA21255@pengutronix.de>
Content-Type: multipart/mixed; boundary="------------060708010905050305060201"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060708010905050305060201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/23/2010 07:24 PM, Wolfram Sang wrote:
> Hi Gary,
>
> (adding linux-i2c)
>
> On Fri, Apr 23, 2010 at 09:56:07AM -0600, Gary Thomas wrote:
>> I'm having trouble with the I2C devices on my 8347 platform.
>> The problem is that I2C device probe() functions are only called
>> once, as the I2C bus is being initialized (in this case fsl_i2c_init())
>> I have 2 devices on this bus, one device gets it's initcall
>> before fsl_i2c_init, the second one does not :-(  This means
>> that the second device is never probed.
>
> Can you try this patch?

No improvement, I'm afraid.

Boot log with initcall_debug=1 attached.  I have 2 devices on I2C-1
   0x48 == tsc2007 touch screen controller
   0x60 == pca9551 LED controller
You can see that the tsc2007 driver gets initialized before the bus
starts, but the pca9551 driver comes too late and never gets probed :-(

Here's the snippet of my device tree:
		i2c@3100 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <1>;
			compatible = "fsl-i2c";
			reg = <0x3100 0x100>;
			interrupts = <15 0x8>;
			interrupt-parent = <&ipic>;
			dfsrr;

			ts@01 {
				compatible = "ti,tsc2007";
				reg = <0x48>;
			};

			leds@01 {
				compatible = "philips,leds-pca955x";
				reg = <0x60>;
			};
		};

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

--------------060708010905050305060201
Content-Type: text/plain;
 name="boot.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="boot.log"

RedBoot> e
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:07:d2:01:00:2e
ENET1: local-mac-address <- 00:07:d2:01:00:2f
CPU clock-frequency <- 0x27c19cc0 (667MHz)
CPU timebase-frequency <- 0x4f64b50 (83MHz)
CPU bus-frequency <- 0x13d92d40 (333MHz)

zImage starting: loaded at 0x00400000 (sp: 0x005d0034)
Allocating 0x3cedb8 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x005ce961)...done 0x3b3c14 bytes

Linux/PowerPC load: console=ttyS0,38400 root=/dev/mtdblock3 rootfstype=jffs2 rw initcall_debug=1
Finalizing device tree... flat tree at 0x5dc300
Using ASP8347E machine description
Linux version 2.6.28-svn5105 (gthomas@titan) (gcc version 4.3.2 (crosstool-NG-svn_unknown@20090118.021742) ) #19 Sat Apr 24 08:12:18 MDT 2010
console [udbg0] enabled
setup_arch: bootmem
asp834x_setup_arch()
DB FPGA at fdfee000
Found FSL PCI host bridge at 0x00000000ff008500. Firmware bus number: 0->0
PCI host bridge /pci@ff008500 (primary) ranges:
 MEM 0x00000000c0000000..0x00000000cfffffff -> 0x00000000c0000000 
  IO 0x00000000b8000000..0x00000000b80fffff -> 0x0000000000000000
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,38400 root=/dev/mtdblock3 rootfstype=jffs2 rw initcall_debug=1
IPIC (128 IRQ sources) at fdeeb700
PID hash table entries: 512 (order: 9, 2048 bytes)
clocksource: timebase mult[300c4ce] shift[22] registered
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 125864k/131072k available (3608k kernel code, 5052k reserved, 160k data, 107k bss, 176k init)
Calibrating delay loop... 166.40 BogoMIPS (lpj=332800)
Mount-cache hash table entries: 512
calling  spawn_ksoftirqd+0x0/0x58 @ 1
initcall spawn_ksoftirqd+0x0/0x58 returned 0 after 0 usecs
calling  net_ns_init+0x0/0x1a0 @ 1
net_namespace: 288 bytes
initcall net_ns_init+0x0/0x1a0 returned 0 after 3906 usecs
calling  sysctl_init+0x0/0x4c @ 1
initcall sysctl_init+0x0/0x4c returned 0 after 0 usecs
calling  ksysfs_init+0x0/0xd8 @ 1
initcall ksysfs_init+0x0/0xd8 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x28 @ 1
initcall init_jiffies_clocksource+0x0/0x28 returned 0 after 0 usecs
calling  filelock_init+0x0/0x48 @ 1
initcall filelock_init+0x0/0x48 returned 0 after 0 usecs
calling  init_misc_binfmt+0x0/0x5c @ 1
initcall init_misc_binfmt+0x0/0x5c returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x28 @ 1
initcall init_script_binfmt+0x0/0x28 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x28 @ 1
initcall init_elf_binfmt+0x0/0x28 returned 0 after 0 usecs
calling  random32_init+0x0/0xcc @ 1
initcall random32_init+0x0/0xcc returned 0 after 0 usecs
calling  sock_init+0x0/0x84 @ 1
initcall sock_init+0x0/0x84 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x170 @ 1
NET: Registered protocol family 16
initcall netlink_proto_init+0x0/0x170 returned 0 after 3906 usecs
calling  of_bus_driver_init+0x0/0x30 @ 1
initcall of_bus_driver_init+0x0/0x30 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x50 @ 1
initcall bdi_class_init+0x0/0x50 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0x64 @ 1
initcall kobject_uevent_init+0x0/0x64 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x30 @ 1
initcall pcibus_class_init+0x0/0x30 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x2c @ 1
initcall pci_driver_init+0x0/0x2c returned 0 after 0 usecs
calling  tty_class_init+0x0/0x58 @ 1
initcall tty_class_init+0x0/0x58 returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0xfc @ 1
initcall vtconsole_class_init+0x0/0xfc returned 0 after 0 usecs
calling  i2c_init+0x0/0x84 @ 1
************** i2c_register_driver.711
************** i2c_register_driver.716
************** i2c_register_driver.735
************** i2c_register_driver.742
************** i2c_register_driver.747
initcall i2c_init+0x0/0x84 returned 0 after 19531 usecs
calling  irq_late_init+0x0/0x10c @ 1
initcall irq_late_init+0x0/0x10c returned 0 after 0 usecs
calling  vdso_init+0x0/0x4a4 @ 1
initcall vdso_init+0x0/0x4a4 returned 0 after 0 usecs
calling  ppc_init+0x0/0x68 @ 1
             
initcall ppc_init+0x0/0x68 returned 0 after 0 usecs
calling  fsl_usb_of_init+0x0/0x454 @ 1
initcall fsl_usb_of_init+0x0/0x454 returned 0 after 0 usecs
calling  gfar_of_init+0x0/0x3f4 @ 1
initcall gfar_of_init+0x0/0x3f4 returned 0 after 0 usecs
calling  gfar_mdio_of_init+0x0/0x90 @ 1
initcall gfar_mdio_of_init+0x0/0x90 returned 0 after 0 usecs
calling  mpc83xx_restart_init+0x0/0x38 @ 1
initcall mpc83xx_restart_init+0x0/0x38 returned 0 after 0 usecs
calling  topology_init+0x0/0x7c @ 1
initcall topology_init+0x0/0x7c returned 0 after 0 usecs
calling  pcibios_init+0x0/0x154 @ 1
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 5 of device 0000:00:0b.0, will remap
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0, will remap
bus: 00 index 0 io port: [0x00-0xfffff]
bus: 00 index 1 mmio: [0xc0000000-0xcfffffff]
initcall pcibios_init+0x0/0x154 returned 0 after 19531 usecs
calling  init_ipic_sysfs+0x0/0xa4 @ 1
initcall init_ipic_sysfs+0x0/0xa4 returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0x218 @ 1
initcall param_sysfs_init+0x0/0x218 returned 0 after 7812 usecs
calling  readahead_init+0x0/0x54 @ 1
initcall readahead_init+0x0/0x54 returned 0 after 0 usecs
calling  init_bio+0x0/0xf4 @ 1
initcall init_bio+0x0/0xf4 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x50 @ 1
initcall cryptomgr_init+0x0/0x50 returned 0 after 0 usecs
calling  blk_settings_init+0x0/0x30 @ 1
initcall blk_settings_init+0x0/0x30 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x44 @ 1
initcall blk_ioc_init+0x0/0x44 returned 0 after 0 usecs
calling  blk_softirq_init+0x0/0x40 @ 1
initcall blk_softirq_init+0x0/0x40 returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x98 @ 1
initcall genhd_device_init+0x0/0x98 returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x64 @ 1
initcall pci_slot_init+0x0/0x64 returned 0 after 0 usecs
calling  fbmem_init+0x0/0xc4 @ 1
initcall fbmem_init+0x0/0xc4 returned 0 after 0 usecs
calling  misc_init+0x0/0xc0 @ 1
initcall misc_init+0x0/0xc0 returned 0 after 0 usecs
calling  phy_init+0x0/0x50 @ 1
initcall phy_init+0x0/0x50 returned 0 after 0 usecs
calling  init_scsi+0x0/0xa8 @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0xa8 returned 0 after 3906 usecs
calling  ata_init+0x0/0x3cc @ 1
initcall ata_init+0x0/0x3cc returned 0 after 0 usecs
calling  usb_init+0x0/0x100 @ 1
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x100 returned 0 after 11718 usecs
calling  input_init+0x0/0x134 @ 1
initcall input_init+0x0/0x134 returned 0 after 0 usecs
calling  leds_init+0x0/0x5c @ 1
initcall leds_init+0x0/0x5c returned 0 after 0 usecs
calling  proto_init+0x0/0x4c @ 1
initcall proto_init+0x0/0x4c returned 0 after 0 usecs
calling  net_dev_init+0x0/0x11c @ 1
initcall net_dev_init+0x0/0x11c returned 0 after 0 usecs
calling  neigh_init+0x0/0x98 @ 1
initcall neigh_init+0x0/0x98 returned 0 after 0 usecs
calling  genl_init+0x0/0xec @ 1
initcall genl_init+0x0/0xec returned 0 after 15625 usecs
calling  sysctl_init+0x0/0x64 @ 1
initcall sysctl_init+0x0/0x64 returned 0 after 0 usecs
calling  clocksource_done_booting+0x0/0x14 @ 1
initcall clocksource_done_booting+0x0/0x14 returned 0 after 0 usecs
calling  init_pipe_fs+0x0/0x74 @ 1
initcall init_pipe_fs+0x0/0x74 returned 0 after 26 usecs
calling  init_mnt_writers+0x0/0x14 @ 1
initcall init_mnt_writers+0x0/0x14 returned 0 after 0 usecs
calling  anon_inode_init+0x0/0x120 @ 1
initcall anon_inode_init+0x0/0x120 returned 0 after 16 usecs
calling  chr_dev_init+0x0/0xc8 @ 1
initcall chr_dev_init+0x0/0xc8 returned 0 after 1985 usecs
calling  loopback_init+0x0/0x28 @ 1
initcall loopback_init+0x0/0x28 returned 0 after 353 usecs
calling  inet_init+0x0/0x224 @ 1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
initcall inet_init+0x0/0x224 returned 0 after 123457 usecs
calling  af_unix_init+0x0/0x6c @ 1
NET: Registered protocol family 1
initcall af_unix_init+0x0/0x6c returned 0 after 8916 usecs
calling  populate_rootfs+0x0/0x130 @ 1
initcall populate_rootfs+0x0/0x130 returned 0 after 333 usecs
calling  register_powersave_nap_sysctl+0x0/0x2c @ 1
initcall register_powersave_nap_sysctl+0x0/0x2c returned 0 after 26 usecs
calling  serial_dev_init+0x0/0x148 @ 1
initcall serial_dev_init+0x0/0x148 returned 0 after 372 usecs
calling  setup_kcore+0x0/0xf4 @ 1
initcall setup_kcore+0x0/0xf4 returned 0 after 2 usecs
calling  __machine_initcall_asp834x_asp8347_declare_of_platform_devices+0x0/0x50 @ 1
initcall __machine_initcall_asp834x_asp8347_declare_of_platform_devices+0x0/0x50 returned 0 after 4417 usecs
calling  proc_execdomains_init+0x0/0x40 @ 1
initcall proc_execdomains_init+0x0/0x40 returned 0 after 18 usecs
calling  ioresources_init+0x0/0x68 @ 1
initcall ioresources_init+0x0/0x68 returned 0 after 6 usecs
calling  uid_cache_init+0x0/0xac @ 1
initcall uid_cache_init+0x0/0xac returned 0 after 38 usecs
calling  init_posix_timers+0x0/0x100 @ 1
initcall init_posix_timers+0x0/0x100 returned 0 after 12 usecs
calling  init_posix_cpu_timers+0x0/0xf0 @ 1
initcall init_posix_cpu_timers+0x0/0xf0 returned 0 after 1 usecs
calling  nsproxy_cache_init+0x0/0x44 @ 1
initcall nsproxy_cache_init+0x0/0x44 returned 0 after 9 usecs
calling  timekeeping_init_device+0x0/0x44 @ 1
initcall timekeeping_init_device+0x0/0x44 returned 0 after 347 usecs
calling  init_clocksource_sysfs+0x0/0x74 @ 1
initcall init_clocksource_sysfs+0x0/0x74 returned 0 after 347 usecs
calling  init_timer_list_procfs+0x0/0x4c @ 1
initcall init_timer_list_procfs+0x0/0x4c returned 0 after 16 usecs
calling  futex_init+0x0/0xa4 @ 1
initcall futex_init+0x0/0xa4 returned 0 after 22 usecs
calling  proc_dma_init+0x0/0x40 @ 1
initcall proc_dma_init+0x0/0x40 returned 0 after 4 usecs
calling  proc_modules_init+0x0/0x44 @ 1
initcall proc_modules_init+0x0/0x44 returned 0 after 3 usecs
calling  kallsyms_init+0x0/0x44 @ 1
initcall kallsyms_init+0x0/0x44 returned 0 after 3 usecs
calling  utsname_sysctl_init+0x0/0x2c @ 1
initcall utsname_sysctl_init+0x0/0x2c returned 0 after 51 usecs
calling  init_per_zone_pages_min+0x0/0x64 @ 1
initcall init_per_zone_pages_min+0x0/0x64 returned 0 after 16 usecs
calling  pdflush_init+0x0/0x28 @ 1
initcall pdflush_init+0x0/0x28 returned 0 after 140 usecs
calling  kswapd_init+0x0/0x2c @ 1
initcall kswapd_init+0x0/0x2c returned 0 after 69 usecs
calling  setup_vmstat+0x0/0xa0 @ 1
initcall setup_vmstat+0x0/0xa0 returned 0 after 24 usecs
calling  mm_sysfs_init+0x0/0x48 @ 1
initcall mm_sysfs_init+0x0/0x48 returned 0 after 19 usecs
calling  proc_vmalloc_init+0x0/0x44 @ 1
initcall proc_vmalloc_init+0x0/0x44 returned 0 after 6 usecs
calling  procswaps_init+0x0/0x44 @ 1
initcall procswaps_init+0x0/0x44 returned 0 after 3 usecs
calling  init_tmpfs+0x0/0x100 @ 1
initcall init_tmpfs+0x0/0x100 returned 0 after 89 usecs
calling  slab_proc_init+0x0/0x44 @ 1
initcall slab_proc_init+0x0/0x44 returned 0 after 9 usecs
calling  cpucache_init+0x0/0x28 @ 1
initcall cpucache_init+0x0/0x28 returned 0 after 4 usecs
calling  fasync_init+0x0/0x44 @ 1
initcall fasync_init+0x0/0x44 returned 0 after 16 usecs
calling  proc_filesystems_init+0x0/0x40 @ 1
initcall proc_filesystems_init+0x0/0x40 returned 0 after 6 usecs
calling  inotify_setup+0x0/0x14 @ 1
initcall inotify_setup+0x0/0x14 returned 0 after 0 usecs
calling  inotify_user_setup+0x0/0xd8 @ 1
initcall inotify_user_setup+0x0/0xd8 returned 0 after 48 usecs
calling  aio_setup+0x0/0x9c @ 1
initcall aio_setup+0x0/0x9c returned 0 after 124 usecs
calling  proc_locks_init+0x0/0x44 @ 1
initcall proc_locks_init+0x0/0x44 returned 0 after 15 usecs
calling  init_mbcache+0x0/0x2c @ 1
initcall init_mbcache+0x0/0x2c returned 0 after 1 usecs
calling  dnotify_init+0x0/0x44 @ 1
initcall dnotify_init+0x0/0x44 returned 0 after 19 usecs
calling  proc_cmdline_init+0x0/0x40 @ 1
initcall proc_cmdline_init+0x0/0x40 returned 0 after 6 usecs
calling  proc_cpuinfo_init+0x0/0x40 @ 1
initcall proc_cpuinfo_init+0x0/0x40 returned 0 after 3 usecs
calling  proc_devices_init+0x0/0x44 @ 1
initcall proc_devices_init+0x0/0x44 returned 0 after 4 usecs
calling  proc_interrupts_init+0x0/0x44 @ 1
initcall proc_interrupts_init+0x0/0x44 returned 0 after 4 usecs
calling  proc_loadavg_init+0x0/0x40 @ 1
initcall proc_loadavg_init+0x0/0x40 returned 0 after 4 usecs
calling  proc_meminfo_init+0x0/0x40 @ 1
initcall proc_meminfo_init+0x0/0x40 returned 0 after 4 usecs
calling  proc_stat_init+0x0/0x40 @ 1
initcall proc_stat_init+0x0/0x40 returned 0 after 4 usecs
calling  proc_uptime_init+0x0/0x50 @ 1
initcall proc_uptime_init+0x0/0x50 returned 0 after 4 usecs
calling  proc_version_init+0x0/0x40 @ 1
initcall proc_version_init+0x0/0x40 returned 0 after 4 usecs
calling  proc_kcore_init+0x0/0x6c @ 1
initcall proc_kcore_init+0x0/0x6c returned 0 after 4 usecs
calling  proc_kmsg_init+0x0/0x40 @ 1
initcall proc_kmsg_init+0x0/0x40 returned 0 after 4 usecs
calling  proc_page_init+0x0/0x68 @ 1
initcall proc_page_init+0x0/0x68 returned 0 after 25 usecs
calling  init_devpts_fs+0x0/0x68 @ 1
initcall init_devpts_fs+0x0/0x68 returned 0 after 33 usecs
calling  init_ext3_fs+0x0/0x8c @ 1
initcall init_ext3_fs+0x0/0x8c returned 0 after 40 usecs
calling  journal_init+0x0/0xd8 @ 1
initcall journal_init+0x0/0xd8 returned 0 after 45 usecs
calling  init_ext2_fs+0x0/0x7c @ 1
initcall init_ext2_fs+0x0/0x7c returned 0 after 13 usecs
calling  init_ramfs_fs+0x0/0x28 @ 1
initcall init_ramfs_fs+0x0/0x28 returned 0 after 1 usecs
calling  init_nfs_fs+0x0/0x158 @ 1
initcall init_nfs_fs+0x0/0x158 returned 0 after 294 usecs
calling  init_nlm+0x0/0x4c @ 1
initcall init_nlm+0x0/0x4c returned 0 after 42 usecs
calling  init_jffs2_fs+0x0/0xe8 @ 1
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
initcall init_jffs2_fs+0x0/0xe8 returned 0 after 13935 usecs
calling  ipc_init+0x0/0x38 @ 1
msgmni has been set to 246
initcall ipc_init+0x0/0x38 returned 0 after 7116 usecs
calling  ipc_sysctl_init+0x0/0x2c @ 1
initcall ipc_sysctl_init+0x0/0x2c returned 0 after 81 usecs
calling  crypto_algapi_init+0x0/0x24 @ 1
initcall crypto_algapi_init+0x0/0x24 returned 0 after 10 usecs
calling  chainiv_module_init+0x0/0x28 @ 1
initcall chainiv_module_init+0x0/0x28 returned 0 after 3 usecs
calling  eseqiv_module_init+0x0/0x28 @ 1
initcall eseqiv_module_init+0x0/0x28 returned 0 after 1 usecs
calling  md5_mod_init+0x0/0x28 @ 1
initcall md5_mod_init+0x0/0x28 returned 0 after 200 usecs
calling  crypto_cbc_module_init+0x0/0x28 @ 1
initcall crypto_cbc_module_init+0x0/0x28 returned 0 after 3 usecs
calling  des_generic_mod_init+0x0/0x5c @ 1
initcall des_generic_mod_init+0x0/0x5c returned 0 after 365 usecs
calling  krng_mod_init+0x0/0x28 @ 1
alg: No test for stdrng (krng)
initcall krng_mod_init+0x0/0x28 returned 0 after 8163 usecs
calling  proc_genhd_init+0x0/0x68 @ 1
initcall proc_genhd_init+0x0/0x68 returned 0 after 27 usecs
calling  noop_init+0x0/0x2c @ 1
io scheduler noop registered
initcall noop_init+0x0/0x2c returned 0 after 7615 usecs
calling  as_init+0x0/0x2c @ 1
io scheduler anticipatory registered (default)
initcall as_init+0x0/0x2c returned 0 after 12187 usecs
calling  deadline_init+0x0/0x2c @ 1
io scheduler deadline registered
initcall deadline_init+0x0/0x2c returned 0 after 8630 usecs
calling  cfq_init+0x0/0xc4 @ 1
io scheduler cfq registered
initcall cfq_init+0x0/0xc4 returned 0 after 7361 usecs
calling  pci_init+0x0/0x50 @ 1
initcall pci_init+0x0/0x50 returned 0 after 17 usecs
calling  pci_proc_init+0x0/0x94 @ 1
initcall pci_proc_init+0x0/0x94 returned 0 after 31 usecs
calling  am_CoralP_fb_init+0x0/0x34 @ 1
******** driver_probe_device.191 - called from c019b038
bus: 'pci': driver_probe_device: checking device 0000:00:0c.0 with driver CoralP_fb
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
AM Coral-P FB [1024x768x24] at 0xc0000000..0xc3ffffff [0xc9080000]
fb0: Coral-P frame buffer device at 0xc0000000
initcall am_CoralP_fb_init+0x0/0x34 returned 0 after 110331 usecs
calling  rand_initialize+0x0/0x48 @ 1
initcall rand_initialize+0x0/0x48 returned 0 after 66 usecs
calling  tty_init+0x0/0x128 @ 1
initcall tty_init+0x0/0x128 returned 0 after 16036 usecs
calling  pty_init+0x0/0x4c4 @ 1
initcall pty_init+0x0/0x4c4 returned 0 after 333414 usecs
calling  serial8250_init+0x0/0x140 @ 1
Serial: 8250/16550 driver 4 ports, IRQ sharing disabled
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device serial8250.0 with driver serial8250
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
serial8250.0: ttyS0 at MMIO 0xff004500 (irq = 16) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xff004600 (irq = 20) is a 16550A
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device serial8250 with driver serial8250
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
initcall serial8250_init+0x0/0x140 returned 0 after 226222 usecs
calling  serial8250_pci_init+0x0/0x34 @ 1
initcall serial8250_pci_init+0x0/0x34 returned 0 after 260 usecs
calling  brd_init+0x0/0x1e0 @ 1
brd: module loaded
initcall brd_init+0x0/0x1e0 returned 0 after 12623 usecs
calling  loop_init+0x0/0x1c0 @ 1
loop: module loaded
initcall loop_init+0x0/0x1c0 returned 0 after 9509 usecs
calling  gfar_init+0x0/0x50 @ 1
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device fsl-gianfar_mdio.14 with driver fsl-gianfar_mdio
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
******** driver_probe_device.191 - called from c019a250
bus: 'mdio_bus': driver_probe_device: checking device 24520:00 with driver Generic PHY
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'mdio_bus': driver_probe_device: checking device 24520:01 with driver Generic PHY
******** driver_probe_device.196 - called from c019a250
Gianfar MII Bus: probed
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device fsl-gianfar.0 with driver fsl-gianfar
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
eth0: Gianfar Ethernet Controller Version 1.2, 00:07:d2:01:00:2e
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device fsl-gianfar.1 with driver fsl-gianfar
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
eth1: Gianfar Ethernet Controller Version 1.2, 00:07:d2:01:00:2f
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
initcall gfar_init+0x0/0x50 returned 0 after 437415 usecs
calling  smsc_init+0x0/0x78 @ 1
initcall smsc_init+0x0/0x78 returned 0 after 549 usecs
calling  net_olddevs_init+0x0/0xe8 @ 1
initcall net_olddevs_init+0x0/0xe8 returned 0 after 16 usecs
calling  init_sd+0x0/0x148 @ 1
Driver 'sd' needs updating - please use bus_type methods
initcall init_sd+0x0/0x148 returned 0 after 15238 usecs
calling  init_sg+0x0/0x178 @ 1
initcall init_sg+0x0/0x178 returned 0 after 235 usecs
calling  sil_init+0x0/0x34 @ 1
******** driver_probe_device.191 - called from c019b038
bus: 'pci': driver_probe_device: checking device 0000:00:0b.0 with driver sata_sil
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
sata_sil 0000:00:0b.0: cache line size not set.  Driver may not function
sata_sil 0000:00:0b.0: Applying R_ERR on DMA activate FIS errata fix
scsi0 : sata_sil
******** driver_probe_device.191 - called from c019a250
bus: 'scsi': driver_probe_device: checking device host0 with driver sd
******** driver_probe_device.196 - called from c019a250
scsi1 : sata_sil
******** driver_probe_device.191 - called from c019a250
bus: 'scsi': driver_probe_device: checking device host1 with driver sd
******** driver_probe_device.196 - called from c019a250
ata1: SATA max UDMA/100 mmio m512@0xc4080000 tf 0xc4080080 irq 22
ata2: SATA max UDMA/100 mmio m512@0xc4080000 tf 0xc40800c0 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-4: TS8GSSD25S-S, 20080128, max UDMA/66
ata1.00: 15924384 sectors, multi 0: LBA 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/66
ata2: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      TS8GSSD25S-S     2008 PQ: 0 ANSI: 5
******** driver_probe_device.191 - called from c019a250
bus: 'scsi': driver_probe_device: checking device target0:0:0 with driver sd
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'scsi': driver_probe_device: checking device 0:0:0:0 with driver sd
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.200 - called from c019a250
******** driver_probe_device.204 - called from c019a250
sd 0:0:0:0: [sda] 15924384 512-byte hardware sectors: (8.15 GB/7.59 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 15924384 512-byte hardware sectors: (8.15 GB/7.59 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
initcall sil_init+0x0/0x34 returned 0 after 4628091 usecs
calling  sil24_init+0x0/0x34 @ 1
initcall sil24_init+0x0/0x34 returned 0 after 229 usecs
calling  init_mtd+0x0/0x50 @ 1
initcall init_mtd+0x0/0x50 returned 0 after 27 usecs
calling  redboot_parser_init+0x0/0x28 @ 1
initcall redboot_parser_init+0x0/0x28 returned 0 after 0 usecs
calling  init_mtdchar+0x0/0xb0 @ 1
initcall init_mtdchar+0x0/0xb0 returned 0 after 206 usecs
calling  init_mtdblock+0x0/0x28 @ 1
initcall init_mtdblock+0x0/0x28 returned 0 after 112 usecs
calling  cfi_probe_init+0x0/0x2c @ 1
initcall cfi_probe_init+0x0/0x2c returned 0 after 1 usecs
calling  of_flash_init+0x0/0x34 @ 1
******** driver_probe_device.191 - called from c019b038
bus: 'of_platform': driver_probe_device: checking device f0000000.flash with driver of-flash
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
do_map_probe('cfi_probe')
f0000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
f0000000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
Searching for RedBoot partition table in f0000000.flash at offset 0x1fe0000
8 RedBoot partitions found on MTD device f0000000.flash
Creating 8 MTD partitions on "f0000000.flash":
0x00000000-0x00020000 : "(reserved)"
0x00020000-0x00080000 : "RedBoot"
0x00080000-0x000c0000 : "ASP8347DB.FPGA"
0x000c0000-0x008c0000 : "JFFS2"
0x008c0000-0x00aa0000 : "linux"
0x00aa0000-0x01fe0000 : "unallocated"
0x01fe0000-0x01fff000 : "FIS directory"
mtd: partition "FIS directory" doesn't end on an erase block -- force read-only
0x01fff000-0x02000000 : "RedBoot config"
mtd: partition "RedBoot config" doesn't start on an erase block boundary -- force read-only
initcall of_flash_init+0x0/0x34 returned 0 after 392933 usecs
calling  mon_init+0x0/0x114 @ 1
usbmon: debugfs is not available
initcall mon_init+0x0/0x114 returned -19 after 8662 usecs
calling  ehci_hcd_init+0x0/0x148 @ 1
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device fsl-ehci.0 with driver fsl-ehci
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 39, io base 0xff022000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device usb1 with driver usbfs
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device usb1 with driver hub
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device usb1 with driver usb
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.200 - called from c019a250
******** driver_probe_device.204 - called from c019a250
usb usb1: configuration #1 chosen from 1 choice
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device 1-0:1.0 with driver usbfs
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device 1-0:1.0 with driver hub
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.200 - called from c019a250
******** driver_probe_device.204 - called from c019a250
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.28-svn5105 ehci_hcd
usb usb1: SerialNumber: fsl-ehci.0
******** driver_probe_device.191 - called from c019b038
bus: 'platform': driver_probe_device: checking device fsl-ehci.1 with driver fsl-ehci
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
fsl-ehci fsl-ehci.1: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.1: new USB bus registered, assigned bus number 2
fsl-ehci fsl-ehci.1: irq 38, io base 0xff023000
fsl-ehci fsl-ehci.1: USB 2.0 started, EHCI 1.00
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device usb2 with driver usbfs
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device usb2 with driver hub
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device usb2 with driver usb
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.200 - called from c019a250
******** driver_probe_device.204 - called from c019a250
usb usb2: configuration #1 chosen from 1 choice
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device 2-0:1.0 with driver usbfs
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'usb': driver_probe_device: checking device 2-0:1.0 with driver hub
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.200 - called from c019a250
******** driver_probe_device.204 - called from c019a250
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Freescale On-Chip EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.28-svn5105 ehci_hcd
usb usb2: SerialNumber: fsl-ehci.1
initcall ehci_hcd_init+0x0/0x148 returned 0 after 4374071 usecs
calling  evdev_init+0x0/0x28 @ 1
initcall evdev_init+0x0/0x28 returned 0 after 2 usecs
calling  tsc2007_init+0x0/0x4c @ 1
******** tsc2007_init.394 - called from c0003874
************** i2c_register_driver.711
************** i2c_register_driver.716
************** i2c_register_driver.735
************** i2c_register_driver.742
************** i2c_register_driver.747
initcall tsc2007_init+0x0/0x4c returned 0 after 64006 usecs
calling  i2c_dev_init+0x0/0xcc @ 1
i2c /dev entries driver
************** i2c_register_driver.711
************** i2c_register_driver.716
************** i2c_register_driver.735
************** i2c_register_driver.742
************** i2c_register_driver.747
initcall i2c_dev_init+0x0/0xcc returned 0 after 57860 usecs
calling  fsl_i2c_init+0x0/0x58 @ 1
******** driver_probe_device.191 - called from c019b038
bus: 'of_platform': driver_probe_device: checking device ff003000.i2c with driver mpc-i2c
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
********* i2c_detect.1352
********* i2c_detect.1352
********* i2c_detect.1352
******** driver_probe_device.191 - called from c019b038
bus: 'of_platform': driver_probe_device: checking device ff003100.i2c with driver mpc-i2c
******** driver_probe_device.196 - called from c019b038
******** driver_probe_device.200 - called from c019b038
******** driver_probe_device.204 - called from c019b038
********* i2c_detect.1352
********* i2c_detect.1352
********* i2c_detect.1352
++++++++ OF I2C 'tsc2007'
******** driver_probe_device.191 - called from c019a250
bus: 'i2c': driver_probe_device: checking device 1-0048 with driver dummy
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'i2c': driver_probe_device: checking device 1-0048 with driver tsc2007
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.200 - called from c019a250
******** driver_probe_device.204 - called from c019a250
******** i2c_device_probe.108 - driver: c03a5fc0, probe: c0205158, id_table: c03a6030, called from: c019aeb8
******** tsc2007_probe.273 - called from c0205bb8
tsc2007 1-0048: i2c io error: -5
tsc2007 1-0048: i2c io error: -5
tsc2007 1-0048: i2c io error: -5
tsc2007 1-0048: i2c io error: -5
tsc2007 1-0048: i2c io error: -5
input: TSC2007 Touchscreen as /devices/virtual/input/input0
tsc2007 1-0048: registered with irq (24)
++++++++ OF I2C 'leds-pca955x'
******** driver_probe_device.191 - called from c019a250
bus: 'i2c': driver_probe_device: checking device 1-0060 with driver dummy
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'i2c': driver_probe_device: checking device 1-0060 with driver tsc2007
******** driver_probe_device.196 - called from c019a250
******** driver_probe_device.191 - called from c019a250
bus: 'i2c': driver_probe_device: checking device 1-0060 with driver dev_driver
******** driver_probe_device.196 - called from c019a250
initcall fsl_i2c_init+0x0/0x58 returned 0 after 621569 usecs
calling  pca955x_leds_init+0x0/0x50 @ 1
******** pca955x_leds_init.388 - called from c0003874
************** i2c_register_driver.711
************** i2c_register_driver.716
************** i2c_register_driver.735
************** i2c_register_driver.742
************** i2c_register_driver.747
************** __attach_adapter.685
********* i2c_detect.1352
************** __attach_adapter.689
************** __attach_adapter.693
************** __attach_adapter.685
********* i2c_detect.1352
************** __attach_adapter.689
************** __attach_adapter.693
initcall pca955x_leds_init+0x0/0x50 returned 0 after 135556 usecs
calling  hid_init+0x0/0x88 @ 1
initcall hid_init+0x0/0x88 returned 0 after 300 usecs
calling  a4_init+0x0/0x34 @ 1
initcall a4_init+0x0/0x34 returned 0 after 339 usecs
calling  apple_init+0x0/0x5c @ 1
initcall apple_init+0x0/0x5c returned 0 after 404 usecs
calling  belkin_init+0x0/0x34 @ 1
initcall belkin_init+0x0/0x34 returned 0 after 229 usecs
calling  bright_init+0x0/0x34 @ 1
initcall bright_init+0x0/0x34 returned 0 after 201 usecs
calling  ch_init+0x0/0x34 @ 1
initcall ch_init+0x0/0x34 returned 0 after 197 usecs
calling  ch_init+0x0/0x34 @ 1
initcall ch_init+0x0/0x34 returned 0 after 197 usecs
calling  cp_init+0x0/0x34 @ 1
initcall cp_init+0x0/0x34 returned 0 after 198 usecs
calling  dell_init+0x0/0x34 @ 1
initcall dell_init+0x0/0x34 returned 0 after 197 usecs
calling  ez_init+0x0/0x34 @ 1
initcall ez_init+0x0/0x34 returned 0 after 214 usecs
calling  gyration_init+0x0/0x34 @ 1
initcall gyration_init+0x0/0x34 returned 0 after 201 usecs
calling  lg_init+0x0/0x34 @ 1
initcall lg_init+0x0/0x34 returned 0 after 203 usecs
calling  ms_init+0x0/0x34 @ 1
initcall ms_init+0x0/0x34 returned 0 after 208 usecs
calling  mr_init+0x0/0x34 @ 1
initcall mr_init+0x0/0x34 returned 0 after 206 usecs
calling  pl_init+0x0/0x34 @ 1
initcall pl_init+0x0/0x34 returned 0 after 201 usecs
calling  pl_init+0x0/0x34 @ 1
initcall pl_init+0x0/0x34 returned 0 after 205 usecs
calling  samsung_init+0x0/0x34 @ 1
initcall samsung_init+0x0/0x34 returned 0 after 202 usecs
calling  sony_init+0x0/0x34 @ 1
initcall sony_init+0x0/0x34 returned 0 after 205 usecs
calling  sp_init+0x0/0x34 @ 1
initcall sp_init+0x0/0x34 returned 0 after 221 usecs
calling  hid_init+0x0/0xa0 @ 1
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
initcall hid_init+0x0/0xa0 returned 0 after 21640 usecs
calling  sysctl_core_init+0x0/0x44 @ 1
initcall sysctl_core_init+0x0/0x44 returned 0 after 173 usecs
calling  flow_cache_init+0x0/0x13c @ 1
initcall flow_cache_init+0x0/0x13c returned 0 after 57 usecs
calling  sysctl_ipv4_init+0x0/0x68 @ 1
initcall sysctl_ipv4_init+0x0/0x68 returned 0 after 889 usecs
calling  init_syncookies+0x0/0x30 @ 1
initcall init_syncookies+0x0/0x30 returned 0 after 142 usecs
calling  xfrm4_beet_init+0x0/0x2c @ 1
initcall xfrm4_beet_init+0x0/0x2c returned 0 after 2 usecs
calling  xfrm4_transport_init+0x0/0x2c @ 1
initcall xfrm4_transport_init+0x0/0x2c returned 0 after 0 usecs
calling  xfrm4_mode_tunnel_init+0x0/0x2c @ 1
initcall xfrm4_mode_tunnel_init+0x0/0x2c returned 0 after 0 usecs
calling  inet_diag_init+0x0/0x94 @ 1
initcall inet_diag_init+0x0/0x94 returned 0 after 22 usecs
calling  tcp_diag_init+0x0/0x28 @ 1
initcall tcp_diag_init+0x0/0x28 returned 0 after 1 usecs
calling  cubictcp_register+0x0/0x8c @ 1
TCP cubic registered
initcall cubictcp_register+0x0/0x8c returned 0 after 5609 usecs
calling  packet_init+0x0/0x5c @ 1
NET: Registered protocol family 17
initcall packet_init+0x0/0x5c returned 0 after 9199 usecs
calling  init_sunrpc+0x0/0x78 @ 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
initcall init_sunrpc+0x0/0x78 returned 0 after 20254 usecs
calling  init_rpcsec_gss+0x0/0x58 @ 1
initcall init_rpcsec_gss+0x0/0x58 returned 0 after 20 usecs
calling  init_kerberos_module+0x0/0x4c @ 1
initcall init_kerberos_module+0x0/0x4c returned 0 after 8 usecs
calling  init_oops_id+0x0/0x44 @ 1
initcall init_oops_id+0x0/0x44 returned 0 after 18 usecs
calling  disable_boot_consoles+0x0/0x6c @ 1
initcall disable_boot_consoles+0x0/0x6c returned 0 after 0 usecs
calling  pm_qos_power_init+0x0/0xd0 @ 1
initcall pm_qos_power_init+0x0/0xd0 returned 0 after 1553 usecs
calling  random32_reseed+0x0/0x78 @ 1
initcall random32_reseed+0x0/0x78 returned 0 after 29 usecs
calling  pci_sysfs_init+0x0/0x6c @ 1
initcall pci_sysfs_init+0x0/0x6c returned 0 after 81 usecs
calling  seqgen_init+0x0/0x28 @ 1
initcall seqgen_init+0x0/0x28 returned 0 after 55 usecs
calling  scsi_complete_async_scans+0x0/0x104 @ 1
initcall scsi_complete_async_scans+0x0/0x104 returned 0 after 0 usecs
calling  tcp_congestion_default+0x0/0xc @ 1
initcall tcp_congestion_default+0x0/0xc returned 0 after 1 usecs
calling  ip_auto_config+0x0/0xe60 @ 1
initcall ip_auto_config+0x0/0xe60 returned 0 after 18 usecs
VFS: Mounted root (jffs2 filesystem).
Mounting /dev & creating initial devices
Freeing unused kernel memory: 176k init
init started: BusyBox v1.10.4 (2009-05-29 06:37:47 MDT)
starting pid 926, tty '/dev/console': '/etc/init.d/rcS'
mounting filesystems...done.
running rc.d services...
starting udev
mounting tmpfs at /dev
creating static nodes
starting udevd...done
waiting for devices...done
starting network interfaces...

OSELAS(R)-amltd_ppc-1 (PTXdist-1.99.svn/2009-08-05T09:01:53-0600)

                     _                       _   
 _ __  _ __   ___   | |_ __ _ _ __ __ _  ___| |_ 
| '_ \| '_ \ / __|  | __/ _` | '__/ _` |/ _ \ __|
| |_) | |_) | (__   | || (_| | | | (_| |  __/ |_ 
| .__/| .__/ \___|___\__\__,_|_|  \__, |\___|\__|
|_|   |_|       |_____|           |___/          


Starting Dropbear SSH server: modprobe: FATAL: Could not load /lib/modules/2.6.28-svn5105/modu
ppc_target login: PHY: 24520:01 - Link is Up - 100/Full
PHY: 24520:00 - Link is Up - 100/Full

--------------060708010905050305060201--
