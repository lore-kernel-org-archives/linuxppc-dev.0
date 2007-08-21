Return-Path: <alfman@austin.rr.com>
Received: from ms-smtp-05.texas.rr.com (ms-smtp-05.texas.rr.com [24.93.47.44])
	by ozlabs.org (Postfix) with ESMTP id C0DF3DDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 11:34:20 +1000 (EST)
Received: from ms-mss-03 (ms-mss-03-b.texas.rr.com [10.93.46.54])
	by ms-smtp-05.texas.rr.com (8.13.6/8.13.6) with ESMTP id l7L1YHcN000918
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 20:34:18 -0500 (CDT)
Received: from texas.rr.com (localhost [127.0.0.1]) by ms-mss-03.texas.rr.com
	(iPlanet Messaging Server 5.2 HotFix 2.10 (built Dec 26 2005))
	with ESMTP id <0JN3004GKOD3TQ@ms-mss-03.texas.rr.com> for
	linuxppc-dev@ozlabs.org; Mon, 20 Aug 2007 20:34:16 -0500 (CDT)
Date: Mon, 20 Aug 2007 20:34:15 -0500
From: alfman@austin.rr.com
Subject: u-boot -> Linux prompt assistance
To: linuxppc-dev@ozlabs.org
Message-id: <fdfcd31b3d18.3d18fdfcd31b@texas.rr.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_nz/zzok4aOv+2MixsZ+QjQ)"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Boundary_(ID_nz/zzok4aOv+2MixsZ+QjQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

I have u-boot running and am currently working on the Linux prompt. I 
store uImage at ffd00000. u-boot is at fff00000. 

* The Freescale BSP for the MPC8360 was used for the base. u-boot 
1.1.6 and Linux 2.6.19 are the versions selected and reported.
* u-boot is running at the prompt and seems stable for u-boot 
functionality.
* Enabling the 64M of DDR2 memory was quite an endeavor but it appears 
stable today. Nothing shows up with the basic u-boot memory test, and 
there are no crashes using the normal u-boot functions. i-cache is 
enabled. Memory problems have not been fully ruled out. Any 
suggestions on how to validate the memory better?
* Linux (~2.6.19) is compiled with no changes at this point. 

Executing "bootm ffd00000" results in a transfer to Linux that (due to 
the CodeWarrior USB TAP?) I can follow the code up to the RFI in 
head_32.S. It looks like it is executing farther than that. I have 
attached a dump of the memory found at log_buf. Also attached is 
System.map. 

My interpretation of the stack dump suggests that start_here is 
successfully executing in high memory and the crash is within 
MMU_init. The crashes that follow would seem to be as much a result of 
this first problem.

Any suggestions or observations about this crash would be appreciated.

Alfman


--Boundary_(ID_nz/zzok4aOv+2MixsZ+QjQ)
Content-type: text/plain; NAME=System_map_trimmed.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=System_map_trimmed.txt

c0000000 T _start
c0000000 T _stext
c000000c T __start
c000002c t __after_mmu_off
c0000060 t turn_on_mmu
c00000c4 T __secondary_hold
c0000100 t Reset
c00001a0 t i0x100
c00002a0 t i0x200
c0000300 t DataAccess
c00003c4 t i0x300
c0000400 t InstructionAccess
c00004bc t i0x400
c0000500 t HardwareInterrupt
c00005a0 t i0x500
c0000600 t Alignment
c00006b4 t i0x600
c0000700 t ProgramCheck
c00007a0 t i0x700
c0000800 t FPUnavailable
c00008a8 t i0x800
c0000900 t Decrementer
c00009a0 t i0x900
c0000a00 t Trap_0a
c0000aa4 t i0xa00
c0000b00 t Trap_0b
c0000ba4 t i0xb00
c0000c00 t SystemCall
c0000ca0 t i0xc00
c0000d00 t SingleStep
c0000da0 t i0xd00
c0000e00 t Trap_0e
c0000ea4 t i0xe00
c0000f24 t Trap_0f
c0000fc8 t i0xf00
c0001000 t InstructionTLBMiss
c0001090 t InstructionAddressInvalid
c0001100 t DataLoadTLBMiss
c0001190 t DataAddressInvalid
c0001200 t DataStoreTLBMiss
c0001300 t Trap_13
c00013a4 t i0x1300
c0001400 t SMI
c00014a4 t i0x1400
c0001500 t Trap_15
c00015a4 t i0x1500
c0001600 t Trap_16
c00016a4 t i0x1600
c0001700 t Trap_17
c00017a0 t i0x1700
c0001800 t Trap_18
c00018a4 t i0x1800
c0001900 t Trap_19
c00019a4 t i0x1900
c0001a00 t Trap_1a
c0001aa4 t i0x1a00
c0001b00 t Trap_1b
c0001ba4 t i0x1b00
c0001c00 t Trap_1c
c0001ca4 t i0x1c00
c0001d00 t Trap_1d
c0001da4 t i0x1d00
c0001e00 t Trap_1e
c0001ea4 t i0x1e00
c0001f00 t Trap_1f
c0001fa4 t i0x1f00
c0002000 t RunMode
c00020a4 t i0x2000
c0002100 t Trap_21
c00021a4 t i0x2100
c0002200 t Trap_22
c00022a4 t i0x2200
c0002300 t Trap_23
c00023a4 t i0x2300
c0002400 t Trap_24
c00024a4 t i0x2400
c0002500 t Trap_25
c00025a4 t i0x2500
c0002600 t Trap_26
c00026a4 t i0x2600
c0002700 t Trap_27
c00027a4 t i0x2700
c0002800 t Trap_28
c00028a4 t i0x2800
c0002900 t Trap_29
c00029a4 t i0x2900
c0002a00 t Trap_2a
c0002aa4 t i0x2a00
c0002b00 t Trap_2b
c0002ba4 t i0x2b00
c0002c00 t Trap_2c
c0002ca4 t i0x2c00
c0002d00 t Trap_2d
c0002da4 t i0x2d00
c0002e00 t Trap_2e
c0002ea4 t i0x2e00
c0002f00 t MOLTrampoline
c0002fa4 t i0x2f00
c0002fa4 T mol_trampoline
c0003000 t AltiVecUnavailable
c00030a4 t i0xf20
c00030ac t relocate_kernel
c00030e0 t copy_and_flush
c0003128 t load_up_mmu
c0003258 t start_here
c00032d8 T set_context
c0003314 t clear_bats
c00033ac t flush_tlbs
c00033c4 t mmu_off
c00033e8 t initial_bats
c0003448 T load_up_fpu
c00035bc T giveup_fpu
c000368c T cvt_fd
c00036a8 T cvt_df
c00036c4 t rest_init
c00036fc t run_init_process
c0003730 t init
c00039fc t try_name
c0003be0 T name_to_dev_t
c0003ec0 T transfer_to_handler_full
c0003f0c T transfer_to_handler
c0003f64 T transfer_to_handler_cont
c0003f8c t stack_ovf
c0004010 T DoSyscall
c000403c t syscall_dotrace_cont
c0004060 T ret_from_syscall
c0004098 t syscall_exit_cont
c00040d0 T ret_from_fork
c0004128 t syscall_dotrace
c00041f0 t syscall_exit_work
c0004310 T ppc_fork
c000436c T ppc_vfork
c00043c8 T ppc_clone
c0004424 T ppc_swapcontext
c0004480 T handle_page_fault
c0004500 T _switch
c0004600 T fast_exception_return
c00046a8 T ret_from_except_full
c00046f4 T ret_from_except
c0004708 t user_exc_return
c0004718 t restore
c0004718 t restore_user
c0004718 t resume_kernel
c0004770 T exc_exit_restart
c0004794 T exc_exit_restart_end
c0004798 t do_work
c00047a0 t do_resched
c00047ac t recheck
c00047cc t do_user_signal
c0004890 t nonrecoverable
c0004938 T die
c00049b8 T _exception
c0004aac W platform_machine_check
c0004ab0 T machine_check_exception
c0004c20 T SMIException
c0004c3c T unknown_exception
c0004c94 T instruction_breakpoint_exception
c0004cac T RunModeException
c0004cc0 t emulate_single_step
c0004cf0 T find_bug
c0004d50 T check_bug_trap
c0004df8 T program_check_exception
c0005278 T single_step_exception
c000529c T alignment_exception
c0005350 T StackOverflow
c000538c T nonrecoverable_exception
c00053d8 T trace_syscall
c000544c T TAUException
c0005494 T kernel_fp_unavailable_exception
c00054d0 T altivec_unavailable_exception
c0005584 T wakeup_decrementer
c00055ac T timer_interrupt
c00057c0 T do_gettimeofday
c00058c4 T do_settimeofday
c00059d8 T to_tm
c0005b40 T mulhwu_scale_factor
c0005b84 T sched_clock
c0005c40 T __delay
c0005c54 T reloc_offset
c0005c74 T add_reloc_offset
c0005c98 T sub_reloc_offset
c0005cbc T reloc_got2
c0005d14 T call_setup_cpu
c0005d3c T _nmask_and_or_msr
c0005d54 T _tlbia
c0005d78 T _tlbie
c0005d84 T flush_instruction_cache
c0005da8 T __flush_icache_range
c0005df8 T clean_dcache_range
c0005e28 T flush_dcache_range
c0005e58 T invalidate_dcache_range
c0005e88 T __flush_dcache_icache
c0005ec8 T __flush_dcache_icache_phys
c0005f1c T clear_pages
c0005f38 T copy_page
c0005fc8 T atomic_clear_mask
c0005fdc T atomic_set_mask
c0005ff0 T _insb
c0006014 T _outsb
c0006038 T _insw_ns
c000605c T _outsw_ns
c0006080 T _insl_ns
c00060a4 T _outsl_ns
c00060c8 T __ashrdi3
c00060f4 T __ashldi3
c0006118 T __lshrdi3
c000613c T abs
c000614c T _get_SP
c0006154 T kernel_thread
c00061b4 T kernel_execve
c00061c8 T __main
c00061e0 T machine_restart
c000620c t ppc_generic_power_off
c0006238 T machine_halt
c0006264 T machine_power_off
c00062b4 T show_cpuinfo
c0006454 t c_start
c000646c t c_next
c000648c t c_stop
c0006490 T find_bootinfo
c00064cc T parse_bootinfo
c000658c T nvram_read_byte
c00065cc T nvram_write_byte
c000661c T nvram_sync
c0006660 t ppc_htab_open
c0006690 t ppc_htab_show
c000693c t ppc_htab_write
c0006c00 T proc_dol2crvec
c0007274 t set_bit
c00072a8 t clear_bit
c00072dc t change_bit
c0007310 t test_and_set_bit
c0007344 t test_and_clear_bit
c0007378 t test_and_change_bit
c00073ac t pci_alloc_consistent
c0007460 t pci_free_consistent
c0007494 t fixup_broken_pcnet32
c00074f0 t fixup_cpc710_pci64
c0007510 t pcibios_fixup_resources
c000761c T pcibios_resource_to_bus
c0007690 T pcibios_bus_to_resource
c0007708 T pcibios_align_resource
c0007794 T pcibios_enable_resources
c00078b8 T pcibios_make_OF_bus_map
c00078bc T pcibios_add_platform_entries
c00078c0 T resource_fixup
c00078c8 T pcibios_enable_device
c00079e0 T pci_bus_to_hose
c0007a24 T pci_bus_io_base
c0007a58 T pci_bus_io_base_phys
c0007a8c T pci_bus_mem_base_phys
c0007ac0 T pci_resource_to_bus
c0007af0 T pci_phys_mem_access_prot
c0007bd0 T pci_mmap_page_range
c0007d7c T phys_to_bus
c0007de0 T pci_phys_to_bus
c0007e24 T pci_bus_to_phys
c0007e68 T sys_pciconfig_iobase
c0007ef8 T pci_resource_to_user
c0007f80 T pci_iomap
c0008044 T pci_iounmap
c0008048 T pci_address_to_pio
c00080b4 t null_read_config
c00080bc t null_write_config
c00080c4 t fake_pci_bus
c0008180 T early_read_config_byte
c00081c4 T early_read_config_word
c0008208 T early_read_config_dword
c000824c T early_write_config_byte
c0008290 T early_write_config_word
c00082d4 T early_write_config_dword
c0008320 T __up
c000836c T identify_cpu
c000843c T do_feature_fixups
c00084f4 T ptrace_disable
c0008510 T arch_ptrace
c0008aa0 t do_syscall_trace
c0008b08 T do_syscall_trace_enter
c0008b78 T do_syscall_trace_leave
c0008ba4 T sys_ipc
c0008e30 T sys_pipe
c0008ed4 T sys_mmap2
c0008fb0 T sys_mmap
c000909c T ppc_select
c0009144 T ppc_newuname
c0009210 T sys_uname
c00092dc T sys_olduname
c00094f4 T ppc_fadvise64_64
c0009538 T do_show_syscall
c00095ac T do_show_syscall_exit
c00095e0 T show_interrupts
c00097ac T do_IRQ
c0009870 T do_softirq
c00098d0 T fix_alignment
c000a048 T sys_sigsuspend
c000a0dc T sys_sigaltstack
c000a100 T sys_sigaction
c000a244 t save_user_regs
c000a308 t restore_user_regs
c000a3f8 t restore_sigmask
c000a454 t do_setcontext
c000a54c T sys_swapcontext
c000a6b4 T sys_rt_sigreturn
c000a774 T sys_debug_setcontext
c000a934 T sys_sigreturn
c000aa34 T do_signal
c000b038 t dummy_perf
c000b048 T reserve_pmc_hardware
c000b0c8 T release_pmc_hardware
c000b0f8 t vdso_vma_close
c000b0fc t vdso_vma_nopage
c000b19c T arch_setup_additional_pages
c000b30c W arch_vma_name
c000b33c T in_gate_area_no_task
c000b344 T in_gate_area
c000b34c T get_gate_vma
c000b354 T flush_fp_to_thread
c000b3a0 T enable_kernel_fp
c000b3c8 T dump_task_fpu
c000b43c T discard_lazy_cpu_state
c000b458 T __switch_to
c000b498 T exit_thread
c000b49c T flush_thread
c000b4a0 T release_thread
c000b4a4 T prepare_to_copy
c000b4c8 T copy_thread
c000b5a8 T start_thread
c000b64c T set_fpexc_mode
c000b6a4 T get_fpexc_mode
c000b6e8 T set_endian
c000b764 T get_endian
c000b7b8 T set_unalign_ctl
c000b7c4 T get_unalign_ctl
c000b7f4 T sys_clone
c000b878 T sys_fork
c000b90c T sys_vfork
c000b9a0 T sys_execve
c000ba34 T validate_sp
c000ba64 T show_stack
c000bbc0 T dump_stack
c000bbcc T show_regs
c000be88 T get_wchan
c000bf50 T sys_call_table
c000c408 T cpu_idle
c000c4f8 T init_idle_6xx
c000c530 T ppc6xx_idle
c000c608 T power_save_6xx_restore
c000c644 T nap_save_msscr0
c000c648 T nap_save_hid1
c000c64c T powersave_lowspeed
c000c660 T _set_L2CR
c000c7c8 T _get_L2CR
c000c7d4 T _set_L3CR
c000c8c8 T _get_L3CR
c000c8d4 T __flush_disable_L1
c000c930 T __inval_enable_L1
c000c960 T __setup_cpu_603
c000c964 T __setup_cpu_604
c000c978 T __setup_cpu_750
c000c990 T __setup_cpu_750cx
c000c9ac T __setup_cpu_750fx
c000c9c8 T __setup_cpu_7400
c000c9e4 T __setup_cpu_7410
c000ca08 T __setup_cpu_745x
c000ca1c t setup_common_caches
c000ca50 t setup_604_hid0
c000ca78 t setup_7400_workarounds
c000ca8c t setup_7410_workarounds
c000cac8 t setup_750_7400_hid0
c000cb00 t setup_750cx
c000cb34 t setup_750fx
c000cb38 t setup_745x_specifics
c000cbbc T __init_fpu_registers
c000cc64 T __save_cpu_setup
c000cd1c T __restore_cpu_setup
c000ce5c T module_alloc
c000ce90 T module_free
c000ceb4 t get_plt_size
c000d010 T module_frob_arch_sections
c000d134 T apply_relocate
c000d164 T apply_relocate_add
c000d39c t find_section
c000d434 T module_finalize
c000d4f4 T module_arch_cleanup
c000d524 T module_find_bug
c000d594 t prep_ibm_cpuinfo
c000d670 t prep_gen_cpuinfo
c000d694 t prep_sandalfoot_cpuinfo
c000d768 t prep_thinkpad_cpuinfo
c000d9fc t prep_carolina_cpuinfo
c000dafc t prep_tiger1_cpuinfo
c000dc08 t prep_mot_cpuinfo
c000dd78 t prep_restart
c000de00 t prep_halt
c000de28 t prep_carrera_poweroff
c000de2c t prep_sig750_poweroff
c000ded0 t prep_show_percpuinfo
c000df18 t ibm_statusled_progress
c000dfb4 t ibm_statusled_panic
c000dfe0 T do_page_fault
c000e320 T bad_page_fault
c000e37c T clear_user_page
c000e3c0 T flush_dcache_page
c000e3d8 T copy_user_page
c000e418 T show_mem
c000e58c T free_initmem
c000e6a0 T free_initrd_mem
c000e748 T MMU_setup
c000e89c T flush_dcache_icache_page
c000e8cc T flush_icache_user_range
c000e910 T update_mmu_cache
c000ea04 T page_is_ram
c000ea1c T phys_mem_access_prot
c000ea8c T pgd_alloc
c000eab8 T pgd_free
c000eadc T pte_alloc_one_kernel
c000eb54 T pte_alloc_one
c000ebb8 T pte_free_kernel
c000ebdc T pte_free
c000ec00 T iounmap
c000ec60 T ioport_map
c000ec70 T ioport_unmap
c000ec74 T map_page
c000ed78 T __ioremap
c000eefc T ioremap
c000ef04 T get_pteptr
c000ef58 T iopa
c000efd4 T mm_ptov
c000efdc T hash_page
c000f024 t retry
c000f074 T add_hash_page
c000f0ec T create_hpte
c000f118 T hash_page_patch_A
c000f164 T hash_page_patch_B
c000f1b4 T hash_page_patch_C
c000f200 t found_empty
c000f204 t found_slot
c000f210 T flush_hash_pages
c000f284 T flush_hash_patch_A
c000f2b8 T flush_hash_patch_B
c000f320 T v_mapped_by_bats
c000f374 T p_mapped_by_bats
c000f3d4 T flush_hash_entry
c000f42c T flush_tlb_page_nohash
c000f470 T tlb_flush
c000f4b0 t flush_range
c000f57c T flush_tlb_kernel_range
c000f594 T flush_tlb_mm
c000f604 T flush_tlb_page
c000f690 T flush_tlb_range
c000f698 T ip_fast_csum
c000f6d4 T csum_tcpudp_magic
c000f6fc T csum_partial
c000f774 T csum_partial_copy_generic
c000f850 t src_error_4
c000f85c t src_error_1
c000f878 t src_error_2
c000f88c t src_error_3
c000f8a0 t src_error
c000f8b8 t dst_error
c000f8d0 T strcpy
c000f8ec T strncpy
c000f92c T strcat
c000f958 T strcmp
c000f97c T strlen
c000f994 T cacheable_memzero
c000fa38 T memset
c000fa94 T cacheable_memcpy
c000fb9c T memmove
c000fba4 T memcpy
c000fc40 T backwards_memcpy
c000fcc8 T memcmp
c000fcf8 T memchr
c000fd20 T __copy_tofrom_user
c000ff5c T __clear_user
c000ffd8 T __strncpy_from_user
c0010014 T __strnlen_user
c001005c T strcasecmp
c00100cc T strncasecmp
c0010144 T __div64_32
c00101e0 T prep_nvram_read_val
c001023c T prep_nvram_write_val
c001028c T prep_nvram_first_var
c00102b0 T prep_nvram_next_var
c0010374 T prep_nvram_get_var
c0010404 T openpic_read
c0010418 T openpic_writefield
c0010460 t openpic_safe_writefield
c00104d4 T openpic_set_priority
c0010584 t openpic_disable_irq
c0010654 t openpic_mapirq
c00106d4 T openpic_irq
c0010708 T openpic_eoi
c0010734 T openpic_get_priority
c0010768 T openpic_reset_processor_phys
c0010780 t openpic_enable_irq
c0010840 t openpic_ack_irq
c0010860 t openpic_end_irq
c0010880 t openpic_set_affinity
c00108c4 T openpic_get_irq
c0010954 T todc_direct_read_val
c0010978 T todc_direct_write_val
c0010990 T todc_m48txx_read_val
c0010a14 T todc_m48txx_write_val
c0010a8c T todc_mc146818_read_val
c0010ae4 T todc_mc146818_write_val
c0010b30 T todc_get_rtc_time
c00111f0 T todc_set_rtc_time
c0011a64 T i8259_irq
c0011b90 t i8259_mask_and_ack_irq
c0011ca8 t i8259_set_irq_mask
c0011cec t i8259_mask_irq
c0011d8c t i8259_unmask_irq
c0011e2c t indirect_read_config
c0011f50 t indirect_write_config
c0012058 T task_nice
c0012064 t static_prio_timeslice
c00120c4 t task_rq_lock
c00120e0 t dequeue_task
c0012164 t enqueue_task
c00121d0 t requeue_task
c001220c t set_load_weight
c001229c t effective_prio
c001232c t __activate_task
c0012390 t recalc_task_prio
c0012490 t deactivate_task
c00124e4 T task_curr
c00124fc T weighted_cpuload
c0012508 t try_to_wake_up
c0012640 T wake_up_process
c001264c T wake_up_state
c0012654 T wake_up_new_task
c0012814 T sched_exit
c00128b0 T schedule_tail
c0012988 T nr_running
c0012994 T nr_uninterruptible
c00129ac T nr_context_switches
c00129c0 T nr_iowait
c00129cc T nr_active
c00129f0 T current_sched_time
c0012a98 T scheduler_tick
c0012e04 T sched_fork
c0012eac T account_user_time
c0012f0c T account_system_time
c0012ff0 T account_steal_time
c0013080 T default_wake_function
c0013088 t __wake_up_common
c001311c T __wake_up
c001315c T __wake_up_locked
c001316c T __wake_up_sync
c00131b8 T complete
c0013214 T complete_all
c0013274 T rt_mutex_setprio
c001335c T set_user_nice
c00134d8 T can_nice
c0013544 T sys_nice
c00135f4 T task_prio
c0013600 T idle_cpu
c0013620 T idle_task
c001362c T sched_setscheduler
c0013904 t do_sched_setscheduler
c00139f0 T sys_sched_setscheduler
c0013a04 T sys_sched_setparam
c0013a10 T sys_sched_getscheduler
c0013a6c T sys_sched_getparam
c0013b50 T sched_setaffinity
c0013c34 T sys_sched_setaffinity
c0013d1c T sched_getaffinity
c0013d88 T sys_sched_getaffinity
c0013e60 T sys_sched_yield
c0013f04 t __cond_resched
c0013f54 T cond_resched_lock
c0013fac T sys_sched_get_priority_max
c0013ff0 T sys_sched_get_priority_min
c0014034 T sys_sched_rr_get_interval
c0014190 T show_state
c00143fc T in_sched_functions
c0014428 T nr_processes
c0014434 T free_task
c0014478 T __put_task_struct
c0014518 T __mmdrop
c00145bc t mm_init
c001466c T mm_alloc
c00146c4 T mmput
c0014798 T get_task_mm
c00147d4 T mm_release
c001486c T copy_fs_struct
c00149e0 t dup_fd
c0014c54 t copy_files
c0014ce8 T unshare_files
c0014d64 T __cleanup_sighand
c0014db8 T __cleanup_signal
c0014de4 T sys_set_tid_address
c0014df0 t copy_process
c0015d04 T do_fork
c0015edc t sighand_ctor
c0015ee8 T sys_unshare
c001647c T register_exec_domain
c00164d8 T unregister_exec_domain
c0016528 T __set_personality
c00166a0 t default_handler
c0016758 T get_exec_domain_list
c0016828 T sys_personality
c0016880 t no_blink
c0016888 T panic
c0016a04 T print_tainted
c0016b14 T add_taint
c0016b34 t spin_msec
c0016b88 t do_oops_enter_exit
c0016c50 T oops_may_print
c0016c64 T oops_enter
c0016c8c T oops_exit
c0016c90 T do_syslog
c0017110 T sys_syslog
c0017114 t __call_console_drivers
c00171b0 t _call_console_drivers
c0017258 t emit_log_char
c00172dc W printk_clock
c00172fc T acquire_console_sem
c00173b0 T try_acquire_console_sem
c00173f4 T is_console_locked
c0017400 T release_console_sem
c0017694 T resume_console
c00176a4 T vprintk
c00179d0 T printk
c0017a30 T suspend_console
c0017a68 T console_print
c0017a78 T console_unblank
c0017b48 T console_device
c0017bc8 T console_stop
c0017c00 T console_start
c0017c38 T unregister_console
c0017d18 T register_console
c0017f68 T tty_write_message
c0017fd8 T __printk_ratelimit
c00180a4 T printk_ratelimit
c00180b8 T printk_timed_ratelimit
c001811c t profile_event_register
c0018124 t profile_event_unregister
c001812c T profile_hit
c0018198 T profile_tick
c0018228 t prof_cpu_mask_read_proc
c0018284 t prof_cpu_mask_write_proc
c00182f4 T create_prof_cpu_mask
c0018358 t read_profile
c001850c t write_profile
c0018554 t delayed_put_task_struct
c00185a4 T release_task
c0018928 T session_of_pgrp
c00189dc t will_become_orphaned_pgrp
c0018a9c T is_orphaned_pgrp
c0018aa4 t has_stopped_jobs
c0018b2c T __set_special_pids
c0018bc4 T set_special_pids
c0018bfc T allow_signal
c0018c98 T disallow_signal
c0018d10 T get_files_struct
c0018d30 T put_files_struct
c0018e2c T reset_files_struct
c0018e3c T exit_files
c0018e58 T put_fs_struct
c0018f2c T exit_fs
c0019000 t exit_mm
c00190e0 T daemonize
c0019338 t reparent_thread
c00194e0 T do_exit
c0019cac T complete_and_exit
c0019cd4 T sys_exit
c0019ce8 T do_group_exit
c0019d74 T sys_exit_group
c0019d7c t eligible_child

[...]

c0240000 A __nosave_begin
c0240000 A __nosave_end
c0240000 D irq_desc
c0240000 D tasklist_lock
c0240000 D vdso32_end
c0244000 D tcp_hashinfo
c02440c0 A _edata
c0244680 D _SDA_BASE_
c02448dc D _SDA2_BASE_
c0246000 D init_thread_union
c0248000 A __init_begin
c0248000 T _sinittext
c0248000 t nosmp
c0248014 t maxcpus
c0248048 t set_reset_devices
c024805c t debug_kernel
c0248080 t quiet_kernel
c02480a4 t loglevel
c02480d8 t unknown_bootoption
c024835c t init_setup
c0248394 t rdinit_setup
c02483cc t do_early_param
c024847c T parse_early_param
c0248504 W smp_setup_processor_id
c0248508 T start_kernel
c0248730 t initcall_debug_setup
c0248744 t load_ramdisk
c024877c t readonly
c02487a4 t readwrite
c02487cc t root_dev_setup
c0248800 t root_data_setup
c0248810 t fs_names_setup
c0248820 t root_delay_setup
c0248854 t do_mount_root
c0248918 T mount_block_root
c0248b64 T change_floppy
c0248ca0 T mount_root
c0248da4 T prepare_namespace
c0248f58 t prompt_ramdisk
c0248f90 t ramdisk_start_setup
c0248fc4 t huft_free
c024900c t huft_build
c0249534 t flush_window
c0249614 t error
c0249654 t fill_inbuf
c02496e0 t inflate_codes
c0249bc8 t inflate_fixed
c0249d38 t inflate_dynamic
c024a420 t gzip_release
c024a424 T rd_load_image
c024b3c8 T rd_load_disk
c024b47c t no_initrd
c024b490 t do_linuxrc
c024b528 T initrd_load
c024b834 t error
c024b84c t malloc
c024b870 t free
c024b890 t read_into
c024b93c t do_start
c024b970 t do_collect
c024ba40 t do_header
c024bcb0 t do_skip
c024bdbc t do_reset
c024be94 t maybe_link
c024bfcc t clean_path
c024c038 t do_name
c024c20c t do_copy
c024c338 t do_symlink
c024c3e8 t write_buffer
c024c450 t huft_free
c024c498 t huft_build
c024c9bc t flush_window
c024cae8 t inflate_codes
c024cf10 t inflate_fixed
c024d080 t inflate_dynamic
c024d690 t gzip_release
c024d694 t unpack_to_rootfs
c024e000 t free_initrd
c024e044 T populate_rootfs
c024e144 t lpj_setup
c024e178 T calibrate_delay
c024e330 T trap_init
c024e334 T time_init
c024e58c T early_init
c024e61c T platform_init
c024e674 T machine_init
c024e6e4 T ppc_setup_l2cr
c024e768 T ppc_init
c024e814 T setup_arch
c024e9cc t register_ppc_htab_sysctl
c024e9fc t pcibios_allocate_bus_resources
c024f004 t pcibios_allocate_resources
c024f1a0 T pcibios_alloc_controller
c024f218 t pcibios_init
c024f440 T common_swizzle
c024f4a8 T pcibios_fixup_bus
c024f690 T pcibios_setup
c024f694 T pcibios_update_irq
c024f6c4 T pci_init_resource
c024f6e8 T init_IRQ
c024f714 t find_section32
c024f7f4 t find_symbol32
c024f8c0 t find_function32
c024f914 T vdso_init
c024fccc t register_powersave_nap_sysctl
c024fcfc T raven_init
c024fedc T ibm_prep_init
c024fee0 t ibm43p_pci_map_non0
c024ff7c T prep_residual_setup_pci
c024ff80 T prep_sandalfoot_setup_pci
c024ffc4 T prep_thinkpad_setup_pci
c0250008 T prep_carolina_setup_pci
c025004c T prep_tiger1_setup_pci
c02500a0 T prep_route_pci_interrupts
c02503e4 T prep_pib_init
c02505b8 t Powerplus_Map_Non0
c025079c T prep_pcibios_fixup
c02508c8 t prep_pcibios_after_init
c02508cc t prep_init_resource
c02508f8 T prep_find_bridges
c02509cc t prep_gen_enable_l2
c0250a00 t prep_carolina_enable_l2
c0250a34 t prep_setup_arch
c0250d20 t prep_calibrate_decr
c0250d40 t prep_init_IRQ
c0250e04 t prep_map_io
c0250e48 t prep_request_io
c0250ed4 T prep_init
c0251240 T early_get_page
c025129c T set_phys_avail
c025135c T MMU_init
c0251560 T do_init_bootmem
c02516a0 T paging_init
c02516f8 T mem_init
c02518a0 T reserve_phys_mem
c02518d8 T mem_pieces_remove
c0251b20 T mem_pieces_find
c0251bcc T mem_pieces_sort
c0251c44 T mem_pieces_coalesce
c0251cfc T mmu_context_init
c0251d14 T mapin_ram
c0251da4 T io_block_mapping
c0251e80 T setbat
c0252044 T mmu_mapin_ram
c0252124 T MMU_init_hw
c02523e0 T init_prep_nvram
c02524b4 T openpic_set_sources
c0252524 T openpic_init
c0252980 T openpic_set_irq_priority
c0252a50 T openpic_init_nmi_irq
c0252af4 T openpic_hookup_cascade
c0252b6c t init_openpic_sysfs
c0252c28 T todc_time_init


[...]

--Boundary_(ID_nz/zzok4aOv+2MixsZ+QjQ)
Content-type: application/octet-stream; NAME=oops.log
Content-transfer-encoding: base64
Content-disposition: attachment; filename=oops.log

U2Vzc2lvbiBsb2cgZmlsZSBpbml0aWF0ZWQ6IHBhbmljLmxvZw0KJT5kaXNwbGF5IDI3NzI2
NCAxMDI0IDhiaXQNCiAgICAyNzcyNjQgIDNDIDM0IDNFIDRGIDZGIDcwIDczIDNBIDIwIDZC
IDY1IDcyIDZFIDY1IDZDIDIwICAgPCA0ID4gTyBvIHAgcyA6ICAgayBlIHIgbiBlIGwgICAN
CiAgICAyNzcyNzQgIDYxIDYzIDYzIDY1IDczIDczIDIwIDZGIDY2IDIwIDYyIDYxIDY0IDIw
IDYxIDcyICAgYSBjIGMgZSBzIHMgICBvIGYgICBiIGEgZCAgIGEgciANCiAgICAyNzcyODQg
IDY1IDYxIDJDIDIwIDczIDY5IDY3IDNBIDIwIDMxIDMxIDIwIDVCIDIzIDMxIDVEICAgZSBh
ICwgICBzIGkgZyA6ICAgMSAxICAgWyAjIDEgXSANCiAgICAyNzcyOTQgIDBBIDNDIDM0IDNF
IDRFIDQ5IDUwIDNBIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwICAgLiA8IDQgPiBOIEkgUCA6
ICAgMCAwIDAgMCAwIDAgMCANCiAgICAyNzcyYTQgIDMwIDIwIDRDIDUyIDNBIDIwIDQzIDMw
IDMyIDM1IDMxIDM1IDMzIDQzIDIwIDQzICAgMCAgIEwgUiA6ICAgQyAwIDIgNSAxIDUgMyBD
ICAgQyANCiAgICAyNzcyYjQgIDU0IDUyIDNBIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDMw
IDBBIDNDIDM0IDNFICAgVCBSIDogICAwIDAgMCAwIDAgMCAwIDAgLiA8IDQgPiANCiAgICAy
NzcyYzQgIDUyIDQ1IDQ3IDUzIDNBIDIwIDYzIDMwIDMyIDM0IDM3IDY2IDMzIDMwIDIwIDU0
ICAgUiBFIEcgUyA6ICAgYyAwIDIgNCA3IGYgMyAwICAgVCANCiAgICAyNzcyZDQgIDUyIDQx
IDUwIDNBIDIwIDMwIDM0IDMwIDMwIDIwIDIwIDIwIDRFIDZGIDc0IDIwICAgUiBBIFAgOiAg
IDAgNCAwIDAgICAgICAgTiBvIHQgICANCiAgICAyNzcyZTQgIDc0IDYxIDY5IDZFIDc0IDY1
IDY0IDIwIDIwIDI4IDMyIDJFIDM2IDJFIDMxIDM5ICAgdCBhIGkgbiB0IGUgZCAgICAgKCAy
IC4gNiAuIDEgOSANCiAgICAyNzcyZjQgIDI5IDBBIDNDIDM0IDNFIDREIDUzIDUyIDNBIDIw
IDMxIDMwIDMwIDMwIDMzIDMwICAgKSAuIDwgNCA+IE0gUyBSIDogICAxIDAgMCAwIDMgMCAN
CiAgICAyNzczMDQgIDMzIDMyIDIwIDNDIDQ2IDUwIDJDIDREIDQ1IDJDIDQ5IDUyIDJDIDQ0
IDUyIDNFICAgMyAyICAgPCBGIFAgLCBNIEUgLCBJIFIgLCBEIFIgPiANCiAgICAyNzczMTQg
IDIwIDIwIDQzIDUyIDNBIDIwIDMyIDM4IDMwIDMyIDM4IDMwIDM0IDMyIDIwIDIwICAgICAg
IEMgUiA6ICAgMiA4IDAgMiA4IDAgNCAyICAgICANCiAgICAyNzczMjQgIDU4IDQ1IDUyIDNB
IDIwIDMyIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDBBIDNDIDM0ICAgWCBFIFIgOiAgIDIgMCAw
IDAgMCAwIDAgMCAuIDwgNCANCiAgICAyNzczMzQgIDNFIDU0IDQxIDUzIDRCIDIwIDNEIDIw
IDYzIDMwIDMyIDMyIDM4IDMxIDM4IDMwICAgPiBUIEEgUyBLICAgPSAgIGMgMCAyIDIgOCAx
IDggMCANCiAgICAyNzczNDQgIDVCIDMwIDVEIDIwIDI3IDczIDc3IDYxIDcwIDcwIDY1IDcy
IDI3IDIwIDU0IDQ4ICAgWyAwIF0gICAnIHMgdyBhIHAgcCBlIHIgJyAgIFQgSCANCiAgICAy
NzczNTQgIDUyIDQ1IDQxIDQ0IDNBIDIwIDYzIDMwIDMyIDM0IDM2IDMwIDMwIDMwIDBBIDND
ICAgUiBFIEEgRCA6ICAgYyAwIDIgNCA2IDAgMCAwIC4gPCANCiAgICAyNzczNjQgIDM2IDNF
IDQ3IDUwIDUyIDMwIDMwIDNBIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwICAgNiA+IEcgUCBS
IDAgMCA6ICAgMCAwIDAgMCAwIDAgMCANCiAgICAyNzczNzQgIDMwIDIwIDQzIDMwIDMyIDM0
IDM3IDQ2IDQ1IDMwIDIwIDQzIDMwIDMyIDMyIDM4ICAgMCAgIEMgMCAyIDQgNyBGIEUgMCAg
IEMgMCAyIDIgOCANCiAgICAyNzczODQgIDMxIDM4IDMwIDIwIDMwIDMwIDMwIDMwIDMwIDMw
IDMwIDMwIDIwIDQzIDMwIDMyICAgMSA4IDAgICAwIDAgMCAwIDAgMCAwIDAgICBDIDAgMiAN
CiAgICAyNzczOTQgIDMyIDM3IDMwIDMwIDMwIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDMw
IDIwIDMwICAgMiA3IDAgMCAwICAgMCAwIDAgMCAwIDAgMCAwICAgMCANCiAgICAyNzczYTQg
IDMwIDMwIDMwIDMxIDQ2IDQ2IDM5IDIwIDMwIDMwIDMwIDMwIDMxIDQ2IDQ2IDQ2ICAgMCAw
IDAgMSBGIEYgOSAgIDAgMCAwIDAgMSBGIEYgRiANCiAgICAyNzczYjQgIDIwIDBBIDNDIDM2
IDNFIDQ3IDUwIDUyIDMwIDM4IDNBIDIwIDQzIDMwIDMyIDM2ICAgICAuIDwgNiA+IEcgUCBS
IDAgOCA6ICAgQyAwIDIgNiANCiAgICAyNzczYzQgIDQzIDM2IDM1IDMwIDIwIDQzIDMwIDMy
IDM3IDMwIDMwIDMwIDMwIDIwIDQzIDMwICAgQyA2IDUgMCAgIEMgMCAyIDcgMCAwIDAgMCAg
IEMgMCANCiAgICAyNzczZDQgIDMyIDM2IDQzIDM0IDMyIDM0IDIwIDQzIDMwIDMwIDMxIDMw
IDQyIDMzIDMwIDIwICAgMiA2IEMgNCAyIDQgICBDIDAgMCAxIDAgQiAzIDAgICANCiAgICAy
NzczZTQgIDMwIDMwIDMwIDMwIDMwIDMwIDMxIDQ1IDIwIDMwIDM5IDM3IDM4IDMwIDMwIDMw
ICAgMCAwIDAgMCAwIDAgMSBFICAgMCA5IDcgOCAwIDAgMCANCiAgICAyNzczZjQgIDMwIDIw
IDMwIDM0IDMwIDMwIDMwIDMwIDMwIDMwIDIwIDMwIDMwIDM3IDQ2IDQ2ICAgMCAgIDAgNCAw
IDAgMCAwIDAgMCAgIDAgMCA3IEYgRiANCiAgICAyNzc0MDQgIDQ2IDMwIDMwIDIwIDBBIDND
IDM2IDNFIDQ3IDUwIDUyIDMxIDM2IDNBIDIwIDMwICAgRiAwIDAgICAuIDwgNiA+IEcgUCBS
IDEgNiA6ICAgMCANCiAgICAyNzc0MTQgIDMzIDQ2IDQ2IDQxIDM0IDM4IDMwIDIwIDMwIDMw
IDMwIDMwIDMwIDMwIDMwIDMwICAgMyBGIEYgQSA0IDggMCAgIDAgMCAwIDAgMCAwIDAgMCAN
CiAgICAyNzc0MjQgIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDMyIDIwIDMwIDMwIDM3IDQ2
IDQ2IDQ1ICAgICAwIDAgMCAwIDAgMCAwIDIgICAwIDAgNyBGIEYgRSANCiAgICAyNzc0MzQg
IDQyIDMwIDIwIDMwIDMzIDQ2IDQ2IDQ2IDQ1IDQxIDM0IDIwIDMwIDMwIDM4IDMwICAgQiAw
ICAgMCAzIEYgRiBGIEUgQSA0ICAgMCAwIDggMCANCiAgICAyNzc0NDQgIDMwIDMwIDMwIDMw
IDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDIwIDMwIDMwICAgMCAwIDAgMCAgIDAgMCAw
IDAgMCAwIDAgMCAgIDAgMCANCiAgICAyNzc0NTQgIDMwIDMwIDMwIDMwIDMwIDMwIDIwIDBB
IDNDIDM2IDNFIDQ3IDUwIDUyIDMyIDM0ICAgMCAwIDAgMCAwIDAgICAuIDwgNiA+IEcgUCBS
IDIgNCANCiAgICAyNzc0NjQgIDNBIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDIwIDMw
IDMwIDMwIDMwIDMwICAgOiAgIDAgMCAwIDAgMCAwIDAgMCAgIDAgMCAwIDAgMCANCiAgICAy
Nzc0NzQgIDMwIDMwIDMwIDIwIDM0IDMwIDMwIDMwIDMwIDMwIDMwIDMwIDIwIDMwIDMwIDM3
ICAgMCAwIDAgICA0IDAgMCAwIDAgMCAwIDAgICAwIDAgNyANCiAgICAyNzc0ODQgIDQ2IDQ2
IDQ2IDMzIDM0IDIwIDMwIDMwIDM3IDQ2IDQ2IDQ2IDMwIDMwIDIwIDMwICAgRiBGIEYgMyA0
ICAgMCAwIDcgRiBGIEYgMCAwICAgMCANCiAgICAyNzc0OTQgIDMwIDMwIDMwIDMwIDMwIDMw
IDMwIDIwIDQzIDMwIDMyIDM3IDMwIDMwIDMwIDMwICAgMCAwIDAgMCAwIDAgMCAgIEMgMCAy
IDcgMCAwIDAgMCANCiAgICAyNzc0YTQgIDIwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDMwIDIw
IDBBIDNDIDM0IDNFIDQzIDYxICAgICAwIDAgMCAwIDAgMCAwIDAgICAuIDwgNCA+IEMgYSAN
CiAgICAyNzc0YjQgIDZDIDZDIDIwIDU0IDcyIDYxIDYzIDY1IDNBIDBBIDNDIDM0IDNFIDVC
IDQzIDMwICAgbCBsICAgVCByIGEgYyBlIDogLiA8IDQgPiBbIEMgMCANCiAgICAyNzc0YzQg
IDMyIDM0IDM3IDQ2IDQ1IDMwIDVEIDIwIDVCIDQzIDMwIDMyIDM1IDMxIDMzIDM4ICAgMiA0
IDcgRiBFIDAgXSAgIFsgQyAwIDIgNSAxIDMgOCANCiAgICAyNzc0ZDQgIDM0IDVEIDIwIDIw
IDI4IDc1IDZFIDcyIDY1IDZDIDY5IDYxIDYyIDZDIDY1IDI5ICAgNCBdICAgICAoIHUgbiBy
IGUgbCBpIGEgYiBsIGUgKSANCiAgICAyNzc0ZTQgIDBBIDNDIDM0IDNFIDVCIDQzIDMwIDMy
IDM0IDM3IDQ2IDQ2IDMwIDVEIDIwIDVCICAgLiA8IDQgPiBbIEMgMCAyIDQgNyBGIEYgMCBd
ICAgWyANCiAgICAyNzc0ZjQgIDQzIDMwIDMwIDMwIDMzIDMyIDQxIDMwIDVEIDIwIDBBIDND
IDM0IDNFIDQ5IDZFICAgQyAwIDAgMCAzIDIgQSAwIF0gICAuIDwgNCA+IEkgbiANCiAgICAy
Nzc1MDQgIDczIDc0IDcyIDc1IDYzIDc0IDY5IDZGIDZFIDIwIDY0IDc1IDZEIDcwIDNBIDBB
ICAgcyB0IHIgdSBjIHQgaSBvIG4gICBkIHUgbSBwIDogLiANCiAgICAyNzc1MTQgIDNDIDM0
IDNFIDU4IDU4IDU4IDU4IDU4IDU4IDU4IDU4IDIwIDU4IDU4IDU4IDU4ICAgPCA0ID4gWCBY
IFggWCBYIFggWCBYICAgWCBYIFggWCANCiAgICAyNzc1MjQgIDU4IDU4IDU4IDU4IDIwIDU4
IDU4IDU4IDU4IDU4IDU4IDU4IDU4IDIwIDU4IDU4ICAgWCBYIFggWCAgIFggWCBYIFggWCBY
IFggWCAgIFggWCANCiAgICAyNzc1MzQgIDU4IDU4IDU4IDU4IDU4IDU4IDIwIDU4IDU4IDU4
IDU4IDU4IDU4IDU4IDU4IDIwICAgWCBYIFggWCBYIFggICBYIFggWCBYIFggWCBYIFggICAN
CiAgICAyNzc1NDQgIDU4IDU4IDU4IDU4IDU4IDU4IDU4IDU4IDIwIDU4IDU4IDU4IDU4IDU4
IDU4IDU4ICAgWCBYIFggWCBYIFggWCBYICAgWCBYIFggWCBYIFggWCANCiAgICAyNzc1NTQg
IDU4IDIwIDU4IDU4IDU4IDU4IDU4IDU4IDU4IDU4IDIwIDBBIDNDIDM0IDNFIDU4ICAgWCAg
IFggWCBYIFggWCBYIFggWCAgIC4gPCA0ID4gWCANCiAgICAyNzc1NjQgIDU4IDU4IDU4IDU4
IDU4IDU4IDU4IDIwIDU4IDU4IDU4IDU4IDU4IDU4IDU4IDU4ICAgWCBYIFggWCBYIFggWCAg
IFggWCBYIFggWCBYIFggWCANCiAgICAyNzc1NzQgIDIwIDU4IDU4IDU4IDU4IDU4IDU4IDU4
IDU4IDIwIDU4IDU4IDU4IDU4IDU4IDU4ICAgICBYIFggWCBYIFggWCBYIFggICBYIFggWCBY
IFggWCANCiAgICAyNzc1ODQgIDU4IDU4IDIwIDU4IDU4IDU4IDU4IDU4IDU4IDU4IDU4IDIw
IDU4IDU4IDU4IDU4ICAgWCBYICAgWCBYIFggWCBYIFggWCBYICAgWCBYIFggWCANCiAgICAy
Nzc1OTQgIDU4IDU4IDU4IDU4IDIwIDU4IDU4IDU4IDU4IDU4IDU4IDU4IDU4IDIwIDU4IDU4
ICAgWCBYIFggWCAgIFggWCBYIFggWCBYIFggWCAgIFggWCANCiAgICAyNzc1YTQgIDU4IDU4
IDU4IDU4IDU4IDU4IDIwIDBBIDNDIDM0IDNFIDRGIDZGIDcwIDczIDNBICAgWCBYIFggWCBY
IFggICAuIDwgNCA+IE8gbyBwIHMgOiANCiAgICAyNzc1YjQgIDIwIDZCIDY1IDcyIDZFIDY1
IDZDIDIwIDYxIDYzIDYzIDY1IDczIDczIDIwIDZGICAgICBrIGUgciBuIGUgbCAgIGEgYyBj
IGUgcyBzICAgbyANCiAgICAyNzc1YzQgIDY2IDIwIDYyIDYxIDY0IDIwIDYxIDcyIDY1IDYx
IDJDIDIwIDczIDY5IDY3IDNBICAgZiAgIGIgYSBkICAgYSByIGUgYSAsICAgcyBpIGcgOiAN
CiAgICAyNzc1ZDQgIDIwIDMxIDMxIDIwIDVCIDIzIDMyIDVEIDBBIDNDIDM0IDNFIDRFIDQ5
IDUwIDNBICAgICAxIDEgICBbICMgMiBdIC4gPCA0ID4gTiBJIFAgOiANCiAgICAyNzc1ZTQg
IDIwIDQzIDMwIDMwIDMyIDMxIDM3IDM5IDM4IDIwIDRDIDUyIDNBIDIwIDQzIDMwICAgICBD
IDAgMCAyIDEgNyA5IDggICBMIFIgOiAgIEMgMCANCiAgICAyNzc1ZjQgIDMwIDMwIDM1IDM2
IDM1IDQzIDIwIDQzIDU0IDUyIDNBIDIwIDQzIDMwIDMxIDMwICAgMCAwIDUgNiA1IEMgICBD
IFQgUiA6ICAgQyAwIDEgMCANCiAgICAyNzc2MDQgIDQ0IDQyIDQ2IDM0IDBBIDNDIDM0IDNF
IDUyIDQ1IDQ3IDUzIDNBIDIwIDYzIDMwICAgRCBCIEYgNCAuIDwgNCA+IFIgRSBHIFMgOiAg
IGMgMCANCiAgICAyNzc2MTQgIDMyIDM0IDM3IDYzIDY1IDMwIDIwIDU0IDUyIDQxIDUwIDNB
IDIwIDMwIDMzIDMwICAgMiA0IDcgYyBlIDAgICBUIFIgQSBQIDogICAwIDMgMCANCiAgICAy
Nzc2MjQgIDMwIDIwIDIwIDIwIDRFIDZGIDc0IDIwIDc0IDYxIDY5IDZFIDc0IDY1IDY0IDIw
ICAgMCAgICAgICBOIG8gdCAgIHQgYSBpIG4gdCBlIGQgICANCiAgICAyNzc2MzQgIDIwIDI4
IDMyIDJFIDM2IDJFIDMxIDM5IDI5IDBBIDNDIDM0IDNFIDREIDUzIDUyICAgICAoIDIgLiA2
IC4gMSA5ICkgLiA8IDQgPiBNIFMgUiANCiAgICAyNzc2NDQgIDNBIDIwIDMwIDMwIDMwIDMw
IDMxIDMwIDMzIDMyIDIwIDNDIDREIDQ1IDJDIDQ5ICAgOiAgIDAgMCAwIDAgMSAwIDMgMiAg
IDwgTSBFICwgSSANCiAgICAyNzc2NTQgIDUyIDJDIDQ0IDUyIDNFIDIwIDIwIDQzIDUyIDNB
IDIwIDMyIDM0IDMwIDMyIDM4ICAgUiAsIEQgUiA+ICAgICBDIFIgOiAgIDIgNCAwIDIgOCAN
CiU+bG9nIG9mZg0K

--Boundary_(ID_nz/zzok4aOv+2MixsZ+QjQ)--
