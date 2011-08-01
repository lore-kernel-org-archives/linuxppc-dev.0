Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (cl-316.chi-02.us.sixxs.net
	[IPv6:2001:4978:f:13b::2])
	by ozlabs.org (Postfix) with ESMTP id 4B91BB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 21:36:30 +1000 (EST)
Message-ID: <4E368FB9.4010202@mlbassoc.com>
Date: Mon, 01 Aug 2011 05:36:25 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: naresh.kamboju@wipro.com
Subject: Re: HELP:PowerPc-Linux kernel
References: <35CC4C9595855B43903A67B297EFA8E3C544FD@HYD-MKD-MBX01.wipro.com>	<CAGn8Sby3Swk8zXxDXnXDBM+bDn=RV2cmvqvwXZM+05P=Z1FMAg@mail.gmail.com>
	<35CC4C9595855B43903A67B297EFA8E3C546BC@HYD-MKD-MBX01.wipro.com>
	<4E33F8F3.80002@mlbassoc.com>
	<35CC4C9595855B43903A67B297EFA8E3C54771@HYD-MKD-MBX01.wipro.com>
In-Reply-To: <35CC4C9595855B43903A67B297EFA8E3C54771@HYD-MKD-MBX01.wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: vijay.t.nikam@gmail.com, paulus@samba.org, scottwood@freescale.com,
	cort@fsmlabs.com, linuxppc-dev@lists.ozlabs.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-08-01 05:31, naresh.kamboju@wipro.com wrote:
>> Did you try passing 'console=ttyCPM0' to the bootargs?
>> I have tried ttyCPM0 no use.
> Do I need to modify something on boot loader or is there any boot loader
> can support CPM ?

What boot loader does your board use?

>
> Scott,
> Is cpm_console_init() must be initialized to fix this issue?
>
>
>> Also, 2.6.21 is truly ancient.  Why not try a more recent kernel,
> especially if
>> you are just getting srarted?
> I think this is the time, for me to use latest kernel to work on.
>
> BR Naresh Kamboju
>
> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Saturday, July 30, 2011 5:59 PM
> To: Naresh Kamboju (WT01 - GMT-Telecom Equipment)
> Cc: linuxppc-dev@lists.ozlabs.org; scottwood@freescale.com;
> vijay.t.nikam@gmail.com; cort@fsmlabs.com
> Subject: Re: HELP:PowerPc-Linux kernel
>
> On 2011-07-30 06:21, naresh.kamboju@wipro.com wrote:
>> Hi All,
>>
>> I have started working on powerpc board bring up. I have prepared dtb
> file and booted linux kernel with my debug statement.
>> Problem:
>> I could not see anything on the serial console. By using the emulator
> I can read __log_buf and found below info.
>>
>> How can I initialize the serial console?
>> Here "ttyCPM0 at MMIO map 0xc504aa00 mem 0x0 (irq = 40) is a CPM UART"
> is detected by kernel and where we generally pass boot args as ttyS0.
>> May I the relation between ttyCPM0 and ttyS0.
>> How can I see kernel boot console on the serial port? It would be
> helpful if you share any workarounds.
>
> Did you try passing 'console=ttyCPM0' to the bootargs?
>
> Also, 2.6.21 is truly ancient.  Why not try a more recent kernel,
> especially if
> you are just getting srarted?
>
>>
>> Below print out is from emulator by reading __log_buf and parsed as
> readable log.
>>
>> <6>Using MPC82xx ADS machine description
>> .<3>Initializing container subsys cpu.
>> <5>Linux version 2.6.21.7-hrt1-cfs-v22-grsec-WR2.0bl_cgl (vanga@linux)
> (gcc version 4.1.2 (Wind River Linux Sourcery G++ 4.1-91)) #18 Sat Jul
> 30 14:39:06 IST 2011
>> .<7>Entering add_active_range(0, 0, 16384) 0 entries of 256 used
>> .<6>No memory reg property [1] in devicetree
>> .<7>Top of RAM: 0x4000000, Total RAM: 0x4000000
>> .<7>Memory hole size: 0MB
>> .<4>Zone PFN ranges:
>> .<4>    DMA             0 ->      16384
>> .<4>    Normal      16384 ->      16384
>> .<     4>early_node_map[1] active PFN ranges
>> .<4>      0:        0 ->      16384
>> .<7>On node 0 totalpages: 16384
>> .<7>    DMA zone: 128 pages used for memmap
>> .<7>    DMA zone: 0 pages reserved
>> .<7>    DMA zone: 16256 pages, LIFO batch:3
>> .<7>    Normal zone: 0 pages used for memmap.<4>Built 1 zonelists.
> Total pages: 16256.
>> <5>Kernel command line: mem=64M console=ttyS0,9600n8 root=/dev/nfs rw
> nfsroot=172.16.50.152:/home/export,nolock,rsize=1024,wsize=1024.
>> <5>---after parse_early_param------- .
>> <5>---after parse_args------- .
>> <5>entered    sort_main_extable
>> <5>exit sort_main_extable
>> <5>---after sort_main_extable()------- .
>> <5>---after trap_init()------- .
>> <5>---after rcu_init()-------
>> .<6>No pci node on device tree.
>> <5>---after init_IRQ()-------
>> .<4>PID hash table entries: 256 (order: 8, 1024    bytes).
>> <5>---after pidhash_init------- .
>> <5>---after init_timers------- .
>> <5>---after hrtimers_init------- .
>> <5>---after softirq_init------- .
>> <5>---after timekeeping_init-------
>> .<7>time_init: decrementer frequency = 16.675000 MHz
>> .<7>time_init: processor fre   quency   = 166.750000 MHz.
>> <5>---after time_init------- .
>> <5>---after profile_init------- .
>> <5>---after early_boot_irqs_on------- .
>> <5>---after local_irq_enable-------
>> .<6>---entered in cpm_uart_console_init -- .
>> <5>---after console_init------- .
>> <5>---after pan   ic check------- .
>> <5>---after lockdep_info------- .
>> <5>---after locking_selftest-------
>> .<4>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
>> .<4>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes).
>> <5>---after vfs_caches_init_early-------    .
>> <5>---cpuset_init_early-------
>> .<6>Memory: 61612k/65536k available (2848k kernel code, 3860k
> reserved, 84k data, 276k bss, 152k init).
>> <5>---after kmem_cache_init------- .
>> <5>---after locking_selftest------- .
>> <5>---after radix_tree_init------- .
>> <5>---after                       memleak_init------- .
>> <5>---after setup_per_cpu_pageset------- .
>> <5>---after numa_policy_init------- .
>> <5>---after late_time_init------
>> .<7>Calibrating delay loop... 33.28 BogoMIPS (lpj=66560).
>> <5>---after calibrate_delay------- .
>> <5>---after pidmap_init------   - .
>> <5>---after pgtable_cache_init------- .
>> <5>---after prio_tree_init------- .
>> <5>---after anon_vma_init------- .
>> <5>---after fork_init------- .
>> <5>---after proc_caches_init------- .
>> <5>---after buffer_init------- .
>> <5>---after unnamed_dev_init------- .
>> <5>---aft   er key_init------- .
>> <5>---after security_init-------
>> .<4>Mount-cache hash table entries: 512.
>> <5>---after vfs_caches_init------- .
>> <5>---after signals_init------- .
>> <5>---after page_writeback_init-------
>> .<3>Initializing container subsys cpuacct
>> .<3>Initializi   ng container subsys debug.
>> <5>---after container_init------- .
>> <5>---after cpuset_init------- .
>> <5>---after taskstats_init_early------ .
>> <5>---after delayacct_init------- .
>> <5>---after check_bugs------- .
>> <5>---after acpi_early_init-------
>> .<6>-------entry rest_   init--------
>> .<6>-------kernel_thread --------
>> .<6>----------after numa_default_policy---------
>> .<6>-----unlock_kernel--------
>> .<6>------------init_idle_bootup_task---------
>> .<6>--------preempt_enable_no_resched------
>> .<6>NET: Registered protocol family 16
>> .<6>PC   I: Probing PCI hardware
>> .<6>Generic PHY: Registered new driver
>> .<6>NET: Registered protocol family 2
>> .<6>------------after schedule---------
>> .<6>----------preempt_disable-------.
>> <5>-----entered cpu_idle -------
>> <5>-----entered cpu_idle  set_thread_flag -------I   P route cache
> hash table entries: 1024 (order: 0, 4096 bytes)
>> .<4>TCP established hash table entries: 2048 (order: 2, 16384 bytes)
>> .<4>TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
>> .<6>TCP: Hash tables configured (established 2048 bind 2048)
>> .<6>TCP    reno registered
>> .<6>JFS: nTxBlock = 481, nTxLock = 3854
>> .<6>Time: timebase clocksource has been installed.
>> .<6>Switched to high resolution mode on CPU 0
>> .<6>Registering unionfs 2.1.6 (for 2.6.21.7)
>> .<6>io scheduler noop registered
>> .<6>Generic RTC Driver v1.07
>> .<     3>i8042.c: No controller found.
>> .<6>Serial: CPM driver $Revision: 0.02 $
>> .<6>--cpm_uart_init()---dev = C07E6C08
>> .<6>--uart_register_driver() ---ret = 0--
>> .<6>cpm_uart_drv_probe: Adding CPM UART 0
>> .<6>CPM uart[0]:config_port
>> .<6>:CPM uart[0]:request port
>> .<6>pinfo->sccp->scc_sccm
>> .<6>CPM uart[0]:allocbuf
>> .<6>CPM uart[0]:init_scc
>> .<6>ttyCPM0 at MMIO map 0xc504aa00 mem 0x0 (irq = 40) is a CPM UART
>> .<4>RAMDISK driver initialized: 16 RAM disks of 32768K size 1024
> blocksize
>> .<4>Default I/O scheduler not found, using no-   op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<4>Default I/O scheduler not found, using no-op
>> .<6>nbd: registered device at major 43
>> .<6>Broa   dcom BCM5411: Registered new driver
>> .<6>Broadcom BCM5421: Registered new driver
>> .<6>Broadcom BCM5461: Registered new driver
>> .<6>fs_enet.c:v1.0 (Aug 8, 2005)
>> .<3>BB MII Bus: Cannot register as MDIO bus
>> .<4>fsl-bb-mdio: probe of fsl-bb-mdio.0 failed with error -1
>> .<3>BB MII Bus: Cannot register as MDIO bus
>> .<4>fsl-bb-mdio: probe of fsl-bb-mdio.1 failed with error -1
>> .<6>No memory reg property [1] in devicetree
>> .<6>No memory reg property [1] in devicetree
>> .<6>i2c /dev entries driver.
>> <5>physmap platform flash device: 020   00000 at fe000000
>> .<6>physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank.
>> <5>Support for command set 0002 not present
>> .<4>gen_probe: No supported Vendor Command Set found
>> .<3>physmap-flash physmap-flash.0: map_probe failed
>> .<6>TCP cubic registered
>> .<6>Initializing XFRM netlink socket
>> .<6>NET: Registered protocol family 1
>> .<6>NET: Registered protocol family 17
>> .<6>NET: Registered protocol family 15
>> .<6>802.1Q VLAN Support v1.8 Ben Greear<greearb@candelatech.com>
>> .<6>All bugs added by David S. Miller<davem@red   hat.com>.
>> <5>Looking up port of RPC 100003/2 on 172.16.50.152....
>>
>>
>> Best regards
>> Naresh Kamboju
>> -----Original Message-----
>> From: Vijay Nikam [mailto:vijay.t.nikam@gmail.com]
>> Sent: Thursday, July 28, 2011 10:16 AM
>> To: Naresh Kamboju (WT01 - GMT-Telecom Equipment)
>> Cc: linuxppc-dev@lists.ozlabs.org; cort@fsmlabs.com;
> linas@austin.ibm.com; hollis@austin.ibm.com
>> Subject: Re: HELP:PowerPc-Linux kernel
>>
>> Hello,
>>
>> Start with looking at the configuration of the board done which is
>> similar to yours
>> or based on the same CPU as yours. It is important to know role of
>> device tree so
>> read the documentation and understand the syntax and concept of device
>> tree. Once
>> the complete concept is understood then you should start the
>> configuration and achieve
>> successful creation of kernel image.
>>
>> Take a step forward and do some hands on. If any problem occurs then
>> post for specific help,
>> as porting itself is a big task and dosent have really straight
> forward steps.
>> Good Luck
>>
>> Kind Regards,
>> Vijay Nikam
>>
>> On Wed, Jul 27, 2011 at 8:33 PM,<naresh.kamboju@wipro.com>   wrote:
>>>
>>> Hi,
>>>
>>>
>>>
>>> I have take up the new assignment  Board bring up activity with Linux
> kernel on PowerPC MPC8272.
>>>
>>> I have been searching Linux bring up on PowerPC processor in Google
> and IBM wiki and not found good stuff.
>>>
>>> It would be more helpful for me if you could share related documents.
>>>
>>>
>>>
>>> Best regards
>>>
>>> Naresh Kamboju
>>>
>>>
>>>
>>> Please do not print this email unless it is absolutely necessary.
>>>
>>> The information contained in this electronic message and any
> attachments to this message are intended for the exclusive use of the
> addressee(s) and may contain proprietary, confidential or privileged
> information. If you are not the intended recipient, you should not
> disseminate, distribute or copy this e-mail. Please notify the sender
> immediately and destroy all copies of this message and any attachments.
>>>
>>> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
>>>
>>> www.wipro.com
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>> Please do not print this email unless it is absolutely necessary.
>>
>> The information contained in this electronic message and any
> attachments to this message are intended for the exclusive use of the
> addressee(s) and may contain proprietary, confidential or privileged
> information. If you are not the intended recipient, you should not
> disseminate, distribute or copy this e-mail. Please notify the sender
> immediately and destroy all copies of this message and any attachments.
>>
>> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of viruses.
> The company accepts no liability for any damage caused by any virus
> transmitted by this email.
>>
>> www.wipro.com
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
