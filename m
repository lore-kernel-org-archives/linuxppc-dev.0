Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QwTH2TdGzF1sj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 18:36:51 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id w2-v6so1034983otj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 01:36:51 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <48cdb73c-f0c4-0c8a-19f5-8fce000e7050@c-s.fr>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
 <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
 <CA+7wUswJoGnb50y8jbPfsi9ztCO1jZ+O4cirHtXc7gp7MXRm5Q@mail.gmail.com>
 <48cdb73c-f0c4-0c8a-19f5-8fce000e7050@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 18 Apr 2018 10:36:28 +0200
Message-ID: <CA+7wUszJzG4CyfO2_Tvmc_u9oMPxLQMaiP+HnhpEex6KCRgSYw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe,

On Wed, Apr 18, 2018 at 8:34 AM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 17/04/2018 =C3=A0 19:10, Mathieu Malaterre a =C3=A9crit :
>>
>> On Tue, Apr 17, 2018 at 6:49 PM, Christophe LEROY
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>>
>>>
>>> Le 17/04/2018 =C3=A0 18:45, Mathieu Malaterre a =C3=A9crit :
>>>>
>>>>
>>>> On Tue, Apr 17, 2018 at 12:49 PM, Christophe Leroy
>>>> <christophe.leroy@c-s.fr> wrote:
>>>>>
>>>>>
>>>>> This option does dead code and data elimination with the linker by
>>>>> compiling with -ffunction-sections -fdata-sections and linking with
>>>>> --gc-sections.
>>>>>
>>>>> By selecting this option on mpc885_ads_defconfig,
>>>>> vmlinux LOAD segment size gets reduced by 10%
>>>>>
>>>>> Program Header before the patch:
>>>>>       LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align
>>>>> 2**16
>>>>>            filesz 0x0036eda4 memsz 0x0038de04 flags rwx
>>>>>
>>>>> Program Header after the patch:
>>>>>       LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align
>>>>> 2**16
>>>>>            filesz 0x00316da4 memsz 0x00334268 flags rwx
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> ---
>>>>>    arch/powerpc/Kconfig | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>>>> index 8fe4353be5e3..e1fac49cf465 100644
>>>>> --- a/arch/powerpc/Kconfig
>>>>> +++ b/arch/powerpc/Kconfig
>>>>> @@ -888,6 +888,14 @@ config PPC_MEM_KEYS
>>>>>
>>>>>             If unsure, say y.
>>>>>
>>>>> +config PPC_UNUSED_ELIMINATION
>>>>> +       bool "Eliminate unused functions and data from vmlinux"
>>>>> +       default n
>>>>> +       select LD_DEAD_CODE_DATA_ELIMINATION
>>>>> +       help
>>>>> +         Select this to do dead code and data elimination with the
>>>>> linker
>>>>> +         by compiling with -ffunction-sections -fdata-sections and
>>>>> linking
>>>>> +         with --gc-sections.
>>>>>    endmenu
>>>>>
>>>>
>>>> Just for reference, I cannot boot my Mac Mini G4 anymore (yaboot). The
>>>> messages I can see (prom_init) are:
>>>
>>>
>>>
>>> Which version of GCC do you use ?
>>
>>
>> $ powerpc-linux-gnu-gcc --version
>> powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
>> Copyright (C) 2016 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is =
NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
>> PURPOSE.
>>
>> this is simply coming from:
>>
>> $ apt-cache policy crossbuild-essential-powerpc
>> crossbuild-essential-powerpc:
>>    Installed: 12.3
>>    Candidate: 12.3
>>    Version table:
>>   *** 12.3 500
>>          500 http://ftp.fr.debian.org/debian stretch/main amd64 Packages
>>          500 http://ftp.fr.debian.org/debian stretch/main i386 Packages
>>          100 /var/lib/dpkg/status
>>
>>
>>> Can you provide the generated System.map with and without that option
>>> active
>>> ?
>>
>>
>> $ du -sh g4/System.map.*
>> 1.7M g4/System.map.with
>> 1.8M g4/System.map.without
>
>
> Here below is the list of objects removed with the option selected. I can=
't
> see anything suspect at first.

Does this help:

$ grep orphan /tmp/g4.log|grep prom_init
powerpc-linux-gnu-ld: warning: orphan section `.sbss.of_workarounds'
from `arch/powerpc/kernel/prom_init.o' being placed in section
`.sbss.of_workarounds'.
powerpc-linux-gnu-ld: warning: orphan section `.sbss.of_workarounds'
from `arch/powerpc/kernel/prom_init.o' being placed in section
`.sbss.of_workarounds'.
powerpc-linux-gnu-ld: warning: orphan section `.sbss.of_workarounds'
from `arch/powerpc/kernel/prom_init.o' being placed in section
`.sbss.of_workarounds'.


> Do you use one of the defconfigs of the kernel ? Otherwise, can you provi=
de
> your .config ?

This is a custom (ugly) one:

https://raw.githubusercontent.com/malaterre/linux/g4/arch/powerpc/configs/g=
4_defconfig

> Can you also provide a copy of the messages you can see (prom_init ...) w=
hen
> boot is ok ?

Hum. I've always been interested in seeing it also myself. Is there a
way to setup env to see those message (netconsole, delayed boot
messages ...) ? I never found a clear documentation on how to do that
on (closed) Apple hardware.

> Maybe you can also send me the two vmlinux objects.

Well if that can help. I'll send them by private emails.

> Thanks
> Christophe
>
> account_steal_time
> adbhid_exit
> adb_reset_bus
> add_range
> add_range_with_merge
> aes_fini
> af_unix_exit
> agp_exit
> agp_find_client_by_pid
> agp_find_mem_by_key
> agp_find_private
> agp_free_memory_wrap
> agpioc_protect_wrap
> agpioc_release_wrap
> agp_uninorth_cleanup
> __alloc_reserved_percpu
> all_stat_sessions
> all_stat_sessions_mutex
> apple_driver_exit
> arch_cpu_idle_dead
> arch_setup_msi_irq
> arch_teardown_msi_irq
> arch_tlb_gather_mmu
> asymmetric_key_cleanup
> asymmetric_key_hex_to_key_id
> ata_exit
> ata_tf_to_lba
> ata_tf_to_lba48
> attribute_container_add_class_device_adapter
> attribute_container_trigger
> backlight_class_exit
> bdi_lock
> bhrb_table
> biovec_create_pool
> blk_stat_enable_accounting
> boot_mapsize
> bpf_map_meta_equal
> bvec_free
> bvec_nr_vecs
> calc_load_fold_active
> can_request_irq
> capacity_margin
> cap_inode_getsecurity
> cap_mmap_file
> cfq_exit
> cgroup_is_threaded
> cgroup_is_thread_root
> cgroup_migrate_add_src
> cgroup_migrate_vet_dst
> cgroup_on_dfl
> cgroup_sk_update_lock
> cgroupstats_build
> cgroup_task_count
> cgroup_transfer_tasks
> change_protection
> clean_sort_range
> clear_ftrace_function
> clear_zone_contiguous
> __clockevents_update_freq
> clockevents_update_freq
> clocksource_mark_unstable
> clocksource_touch_watchdog
> clone_property.isra.2
> cmp_range
> cn_fini
> cn_queue_free_dev
> collect_mounts
> compaction_restarting
> copy_fpr_from_user
> copy_fpr_to_user
> copy_mount_string
> copy_msg
> cpu_check_up_prepare
> cpufreq_boost_trigger_state
> cpufreq_gov_performance_exit
> cpu_hotplug_state
> cpu_in_idle
> cpu_report_state
> cpu_set_state_online
> cpu_temp
> crashk_low_res
> crash_wake_offline
> create_prof_cpu_mask
> crypto_algapi_exit
> crypto_exit_proc
> crypto_null_mod_fini
> crypto_wq_exit
> css_rightmost_descendant
> css_set_lock
> cubictcp_unregister
> __current_kernel_time
> d_absolute_path
> dbg_release_bp_slot
> dbg_reserve_bp_slot
> deadline_exit
> deadline_exit
> debug_guardpage_ops
> default_restore_msi_irqs
> default_teardown_msi_irqs
> del_named_trigger
> dereference_module_function_descriptor
> __dev_pm_qos_flags
> dev_pm_qos_read_value
> devtree_lock
> die_will_crash
> disable_cpufreq
> dma_buf_deinit
> dma_common_contiguous_remap
> dma_common_pages_remap
> __dma_get_required_mask
> dma_pfn_limit_to_zone
> do_execveat
> do_fork
> __domain_nr
> do_msg_redirect_map
> do_pipe_flags
> do_sk_redirect_map
> drmem_lmb_memory_max
> drmem_update_dt
> dst_discard
> dummy_cmp
> dump_cpu_task
> dump_stack_set_arch_desc
> earlycon_acpi_spcr_enable
> early_find_capability
> early_printk
> early_read_config_byte
> early_write_config_byte
> exar_pci_driver_exit
> exit_elf_binfmt
> exit_misc_binfmt
> exit_pmz
> exit_script_binfmt
> exit_scsi
> fdt_add_mem_rsv
> fdt_add_property_
> fdt_add_subnode
> fdt_add_subnode_namelen
> fdt_appendprop
> fdt_del_mem_rsv
> fdt_del_node
> fdt_delprop
> fdt_find_string_
> fdt_get_alias
> fdt_get_max_phandle
> fdt_get_path
> fdt_get_property
> fdt_get_property_by_offset
> fdt_get_property_namelen
> fdt_move
> fdt_node_depth
> fdt_node_end_offset_
> fdt_node_offset_by_compatible
> fdt_node_offset_by_phandle
> fdt_node_offset_by_prop_value
> fdt_nop_node
> fdt_nop_property
> fdt_num_mem_rsv
> fdt_offset_ptr
> fdt_open_into
> fdt_pack
> fdt_packblocks_
> fdt_rw_check_header_
> fdt_set_name
> fdt_setprop
> fdt_setprop_inplace
> fdt_setprop_inplace_namelen_partial
> fdt_setprop_placeholder
> fdt_splice_
> fdt_string
> fdt_stringlist_count
> fdt_stringlist_get
> fdt_stringlist_search
> fdt_subnode_offset
> feature_lock
> fib_table_flush_external
> fib_trie_unmerge
> fib_unmerge
> find_named_trigger
> __finish_swait
> firmware_class_exit
> fixup_red_left
> force_printk_to_btext
> force_sig_bnderr
> force_sig_fault
> force_sig_pkuerr
> force_sig_ptrace_errno_trap
> fork_idle
> fprop_fraction_single
> __fprop_inc_percpu
> __fprop_inc_single
> fprop_local_destroy_single
> fprop_local_init_single
> free_page_and_swap_cache
> free_workqueue_attrs
> fsl_mpic_primary_get_version
> fsnotify_add_mark
> fsnotify_finish_user_wait
> fsnotify_get_mark_safe
> fsnotify_prepare_user_wait
> fsnotify_put_mark_wake
> ftrace_exports
> ftrace_get_addr_curr
> ftrace_get_addr_new
> ftrace_graph_ret_addr
> ftrace_graph_stop
> ftrace_nr_registered_ops
> ftrace_ops_assist_func
> ftrace_ops_get_func
> ftrace_ops_trampoline
> ftrace_run_stop_machine
> ftrace_test_record
> ftrace_text_reserved
> __func__.3126
> __func__.53147
> func_ptr_is_kernel_text
> generic_ptrace_pokedata
> generic_rtc_driver_exit
> __get_cached_msi_msg
> get_cpu_cacheinfo
> get_iowait_load
> get_named_trigger_data
> get_safe_page
> get_syscall_name
> get_vm_area
> __get_vm_area_caller
> grub_reclaim
> gup_fast_permitted
> gup_hugepte
> handle_hmi_exception
> handle_percpu_devid_irq
> handle_percpu_irq
> has_unmovable_pages
> has_unmovable_pages.part.31
> hdec_interrupt
> hid_debug_exit
> hid_exit
> hid_generic_exit
> hidraw_exit
> hrtimers_prepare_cpu
> hwmon_exit
> i2c_register_board_info
> igmp_mcf_get_next.isra.4
> igmp_mcf_seq_fops
> igmp_mcf_seq_next
> igmp_mcf_seq_open
> igmp_mcf_seq_ops
> igmp_mcf_seq_show
> igmp_mcf_seq_start
> igmp_mcf_seq_stop
> igmp_mc_init
> igmp_mc_seq_fops
> igmp_mc_seq_next
> igmp_mc_seq_open
> igmp_mc_seq_ops
> igmp_mc_seq_show
> igmp_mc_seq_start
> igmp_mc_seq_stop
> igmp_netdev_event
> igmp_net_exit
> igmp_net_init
> igmp_net_ops
> igmp_notifier
> init_cpu_online
> init_cpu_possible
> init_cpu_present
> init_kernel_text
> init_thread_info
> input_exit
> input_leds_exit
> insert_resource_conflict
> insert_resource_expand_to_fit
> insert_stat
> instr_is_branch_to_addr
> instr_is_relative_link_branch
> iomem_map_sanity_check
> io_range_mutex
> ip6_ra_lock
> ipv4_blackhole_route
> ipv6_renew_options_kern
> ipv6_sysctl_unregister
> irq_chip_compose_msi_msg
> irqchip_init
> irq_cpu_offline
> irq_cpu_online
> irq_domain_set_info
> irq_domain_update_bus_token
> irq_get_next_irq
> irq_set_percpu_devid
> irq_set_percpu_devid_partition
> isa_io_special
> is_file_shm_hugepages
> is_hardlockup
> __is_kernel_percpu_address
> is_kernel_percpu_address
> is_module_address
> __is_module_percpu_address
> is_module_percpu_address
> is_named_trigger
> is_offset_in_branch_range
> isolate_freepages_range
> isolate_migratepages_range
> is_pageblock_removable_nolock
> __is_ram
> is_tracing_stopped
> is_vmalloc_or_module_addr
> is_vma_temporary_stack
> iterate_mounts
> k2_skiplist
> kcompactd_stop
> __key.36706
> keyctl_negate_key
> key_serial_lock
> kimage_is_destination_range
> kmap_flush_unused
> __kmem_cache_alloc_bulk
> __kmem_cache_empty
> kobj_child_ns_ops
> kobj_ns_initial
> kobj_ns_netlink
> kobj_ns_type_registered
> kretprobe_blacklist
> kstat_incr_irq_this_cpu
> kswapd_stop
> ldsem_down_write_trylock
> leds_exit
> libata_transport_exit
> lockup_detector_cleanup
> lockup_detector_soft_poweroff
> log_buf_addr_get
> log_buf_len_get
> logbuf_lock
> logic_pio_register_range
> logic_pio_to_hwaddr
> logic_pio_trans_cpuaddr
> lookup_module_symbol_attrs
> lookup_page_ext
> lookup_resource
> lookup_symbol_attrs
> mac_var_to_vmode
> map_kernel_range_noflush
> max_cfs_quota_period
> max_possible_pfn
> memblock_add_node
> memblock_clear_nomap
> memblock_get_current_limit
> memblock_is_map_memory
> memblock_is_region_memory
> memblock_is_region_reserved
> memblock_mark_mirror
> memblock_mark_nomap
> memblock_overlaps_region
> memblock_reserved_size
> memblock_start_of_DRAM
> memblock_trim_memory
> metadata_dst_free
> migrate_huge_page_move_mapping
> migrate_prep
> migrate_reason_names
> migration_entry_wait_huge
> min_cfs_quota_period
> mmc_blk_exit
> mmc_exit
> mmc_pwrseq_emmc_driver_exit
> mmc_pwrseq_simple_driver_exit
> mm_find_pmd
> mmlist_lock
> mmput_async
> mmput_async_fn
> mnt_clone_internal
> mousedev_exit
> mpc6xx_enter_standby
> mpic_get_one_irq
> mpic_setup_this_cpu
> named_triggers
> n_null_exit
> noop_exit
> nr_free_pagecache_pages
> nsecs_to_usecs
> num_powerpc_operands
> nvmem_exit
> nvram_cleanup
> of_device_compatible_match
> of_fdt_is_big_endian
> of_fdt_limit_memory
> __of_find_all_nodes
> of_find_last_cache_level
> of_find_matching_node_by_address
> of_get_flat_dt_subnode_by_name
> __of_get_property
> of_msi_map_get_device_domain
> __of_msi_map_rid
> of_msi_map_rid
> of_node_is_attached
> of_parse_dma_window
> of_pci_map_rid
> of_print_phandle_args
> __of_remove_property
> __of_sysfs_remove_bin_file
> oops_may_print
> our_mnt
> p4d_clear_bad
> packet_exit
> page_counter_cancel
> page_mapped_in_vma
> page_mapping_file
> page_unlock_anon_vma_read
> panic_flush_kmsg_end
> panic_flush_kmsg_start
> pata_macio_exit
> patch_branch
> pause_named_trigger
> __pause_named_trigger.isra.4
> pci_acs_enabled
> pci_acs_flags_enabled
> pci_acs_path_enabled
> pci_add_cap_save_buffer
> pcibios_max_latency
> pcibios_penalize_isa_irq
> pcibios_resource_survey_bus
> pci_bridge_group
> pci_bridge_groups
> pci_bus_set_current_state
> pci_dev_acs_enabled
> pci_devs_are_dma_aliases
> pci_dev_specific_acs_enabled
> pcie_cap_has_lnkctl
> pcie_dev_group
> pcie_dev_groups
> pci_ext_cfg_avail
> pci_for_each_dma_alias
> pci_get_interrupt_pin
> pci_get_new_domain_nr
> pci_lock
> __pci_msix_desc_mask_irq
> pci_parse_request_of_pci_ranges
> pci_pio_to_address
> pci_pme_wakeup
> pci_pme_wakeup_bus
> pci_quirk_amd_sb_acs
> pci_quirk_cavium_acs
> pci_quirk_intel_pch_acs
> pci_quirk_intel_spt_pch_acs
> pci_quirk_mf_endpoint_acs
> pci_quirk_qcom_rp_acs
> pci_quirk_xgene_acs
> pci_request_acs
> pci_set_platform_pm
> pci_setup_bridge
> pci_wakeup_bus
> pcpu_lock
> perf_duration_warn
> perf_duration_work
> perf_event_account_interrupt
> perf_event_attrs
> perf_event_exit_cpu
> perf_event_itrace_started
> perf_log_lost_samples
> perf_pmu_name
> perf_sample_event_took
> perf_sched_cb_dec
> perf_sched_cb_inc
> pgd_clear_bad
> phy_core_exit
> pin_insert
> pmac_get_uninorth_variant
> pm_generic_prepare
> pm_labels
> pm_system_cancel_wakeup
> power_events_sysfs_show
> powerpc_macros
> powerpc_num_macros
> power_supply_class_exit
> prandom_reseed_late
> pr_cont_kernfs_name
> prep_compound_page
> __print_once.21255
> print_vma_addr
> prof_cpu_mask_proc_fops
> prof_cpu_mask_proc_open
> prof_cpu_mask_proc_show
> prof_cpu_mask_proc_write
> ptrace_get_reg
> ptrace_writedata
> pud_clear_bad
> randomize_page
> rcu_test_sync_prims
> read_bhrb
> reclaim_clean_pages_from_list
> refined_jiffies
> register_refined_jiffies
> register_stat_tracer
> regs_query_register_name
> relay_prepare_cpu
> remove_percpu_irq
> __report_allowed
> __report_avg
> reset_node_managed_pages
> __reset_stat_session
> restore_math
> ret_from_standby
> ring_buffer_event_time_stamp
> ring_buffer_nest_end
> ring_buffer_nest_start
> ring_buffer_page_len
> _rs.53145
> rsa_exit
> rtc_dev_exit
> s2idle_set_ops
> save_named_trigger
> sched_idle_set_state
> sched_setattr_nocheck
> scsi_sysfs_unregister
> sdio_unregister_bus
> secondary_cpu_time_init
> send_sig_fault
> serial8250_exit
> serial_pci_driver_exit
> __se_sys_fadvise64_64
> __se_sys_gethostname
> __se_sys_mmap_pgoff
> __se_sys_msgctl
> __se_sys_msgget
> __se_sys_msgrcv
> __se_sys_msgsnd
> __se_sys_semctl
> __se_sys_semget
> __se_sys_semop
> __se_sys_semtimedop
> __se_sys_shmat
> __se_sys_shmctl
> __se_sys_shmdt
> __se_sys_shmget
> __se_sys_sync_file_range
> set_breakpoint
> set_graph_array
> set_iounmap_nonlazy
> set_named_trigger_data
> set_pci_dma_ops
> set_thread_uses_vas
> setup_percpu_irq
> setup_per_zone_wmarks
> sg_pool_exit
> shmem_charge
> shmem_getpage
> shmem_uncharge
> shm_file_operations_huge
> simple_xattr_list_add
> skb_crc32c_csum_help
> skb_do_redirect
> smpboot_create_threads
> smpboot_park_threads
> smpboot_unpark_threads
> smu_init
> snapshot_additional_pages
> sort_range
> spi_register_board_info
> stack_trace_max_lock
> stat_dir
> stat_seq_next
> stat_seq_show
> stat_seq_start
> stat_seq_stop
> subtract_range
> swap_buf_le16
> swap_lock
> sysctl_schedstats
> sys_fadvise64_64
> sysfs_symlink_target_lock
> sys_gethostname
> sys_mmap_pgoff
> sys_msgctl
> sys_msgget
> sys_msgrcv
> sys_msgsnd
> __sysrq_get_key_op
> sys_semctl
> sys_semget
> sys_semop
> sys_semtimedop
> sys_shmat
> sys_shmctl
> sys_shmdt
> sys_shmget
> sys_switch_endian
> sys_sync_file_range
> tasklist_lock
> task_rcu_dereference
> __task_rq_lock
> tau_interrupts
> tcp_fastopen_active_should_disable
> tcp_set_ulp_id
> tcpudp_mt_exit
> tg_set_cfs_period
> tg_set_cfs_quota
> tick_broadcast_ipi_handler
> tick_cancel_sched_timer
> tick_freeze
> tick_freeze_depth
> tick_nohz_get_idle_calls
> tick_nohz_get_idle_calls_cpu
> tick_nohz_idle_got_tick
> tick_nohz_idle_retain_tick
> tick_nohz_tick_stopped_cpu
> tick_suspend_local
> tick_unfreeze
> timer_migration_handler
> __tlb_remove_page_size
> tnum_sbin
> tnum_xor
> touch_softlockup_watchdog_sync
> trace_array_printk
> trace_array_printk_buf
> trace_array_vprintk
> trace_clock_in_ns
> trace_find_filtered_pid
> tracefs_remove
> trace_graph_function
> trace_keep_overwrite
> trace_latency_header
> tracer_init
> trace_stat_seq_ops
> tracing_is_enabled
> tracing_record_tgid
> tracing_start
> tracing_stat_fops
> tracing_stat_open
> tracing_stat_release
> uart_get_console
> udbg_printf
> unix_get_socket
> unpause_named_trigger
> unregister_stat_tracer
> uprobe_get_trap_addr
> using_ftrace_ops_list_func
> vfs_getxattr_alloc
> vfs_ioctl
> vle_num_opcodes
> vle_opcodes
> vma_is_special_mapping
> vma_is_stack_for_current
> vm_numa_stat_key
> vsx_unavailable_exception
> vwrite
> walk_iomem_res_desc
> walk_mem_res
> walk_system_ram_res
> watchdog_dev_exit
> watchdog_exit
> workqueue_prepare_cpu
> wq_update_unbound_numa
> x509_key_exit
> xt_fini
> xtime_update
> zone_pcp_reset
>
>
>
>>
>> Will send them by private emails.
>>
>>> Thanks
>>> Christophe
>>>
>>>
>>>>
>>>> ---
>>>> done
>>>> copying OF device tree...
>>>> Building dt strings...
>>>> Building dt structure...
>>>> Device tree strings 0x01100000 -> 0x01100e02
>>>> Device tree struct   0x01101000 -> 0x01109000
>>>> Quiescing Open Firmware ...
>>>> Booting Linux via __start() @ 0x00140000 ...
>>>> _
>>>> ---
>>>>
>>>>
>>>>
>>>>>    config ISA_DMA_API
>>>>> --
>>>>> 2.13.3
>>>>>
>>>
>
