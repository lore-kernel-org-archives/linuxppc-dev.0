Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410Fm83nS7zF1dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 12:16:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: [PATCH v7 0/5] powerpc/64: memcmp() optimization
In-Reply-To: <1527672063-6953-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527672063-6953-1-git-send-email-wei.guo.simon@gmail.com>
Date: Tue, 05 Jun 2018 12:16:22 +1000
Message-ID: <877eneasg9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Simon,

wei.guo.simon@gmail.com writes:
> From: Simon Guo <wei.guo.simon@gmail.com>
>
> There is some room to optimize memcmp() in powerpc 64 bits version for
> following 2 cases:
> (1) Even src/dst addresses are not aligned with 8 bytes at the beginning,
> memcmp() can align them and go with .Llong comparision mode without
> fallback to .Lshort comparision mode do compare buffer byte by byte.
> (2) VMX instructions can be used to speed up for large size comparision,
> currently the threshold is set for 4K bytes. Notes the VMX instructions
> will lead to VMX regs save/load penalty. This patch set includes a
> patch to add a 32 bytes pre-checking to minimize the penalty.
>
> It did the similar with glibc commit dec4a7105e (powerpc: Improve memcmp 
> performance for POWER8). Thanks Cyril Bur's information.
> This patch set also updates memcmp selftest case to make it compiled and
> incorporate large size comparison case.

I'm seeing a few crashes with this applied, I haven't had time to look
into what is happening yet, sorry.

[ 2471.300595] kselftest: Running tests in user
[ 2471.302785] calling  test_user_copy_init+0x0/0xd14 [test_user_copy] @ 44883
[ 2471.302892] Unable to handle kernel paging request for data at address 0xc008000018553005
[ 2471.303014] Faulting instruction address: 0xc00000000001f29c
[ 2471.303119] Oops: Kernel access of bad area, sig: 11 [#1]
[ 2471.303193] LE SMP NR_CPUS=2048 NUMA PowerNV
[ 2471.303256] Modules linked in: test_user_copy(+) vxlan ip6_udp_tunnel udp_tunnel 8021q bridge stp llc dummy test_printf test_firmware vmx_crypto crct10dif_vpmsum crct10dif_common crc32c_vpmsum veth [last unloaded: test_static_key_base]
[ 2471.303532] CPU: 4 PID: 44883 Comm: modprobe Tainted: G        W         4.17.0-rc3-gcc7x-g7204012 #1
[ 2471.303644] NIP:  c00000000001f29c LR: c00000000001f6e4 CTR: 0000000000000000
[ 2471.303754] REGS: c000001fddc2b560 TRAP: 0300   Tainted: G        W          (4.17.0-rc3-gcc7x-g7204012)
[ 2471.303873] MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 24222844  XER: 00000000
[ 2471.303996] CFAR: c00000000001f6e0 DAR: c008000018553005 DSISR: 40000000 IRQMASK: 0 
[ 2471.303996] GPR00: c00000000001f6e4 c000001fddc2b7e0 c008000018529900 0000000002000000 
[ 2471.303996] GPR04: c000001fe4b90020 000000000000ffe0 0000000000000000 03fffffe01b48000 
[ 2471.303996] GPR08: 0000000080000000 c008000018553005 c000001fddc28000 c008000018520df0 
[ 2471.303996] GPR12: c00000000009c430 c000001fffffbc00 0000000020000000 0000000000000000 
[ 2471.303996] GPR16: c000001fddc2bc20 0000000000000030 c0000000001f7ba0 0000000000000001 
[ 2471.303996] GPR20: 0000000000000000 c000000000c772b0 c0000000010b4018 0000000000000000 
[ 2471.303996] GPR24: 0000000000000000 c008000018521c98 0000000000000000 c000001fe4b90000 
[ 2471.303996] GPR28: fffffffffffffff4 0000000002000000 9000000002009033 9000000002009033 
[ 2471.304930] NIP [c00000000001f29c] msr_check_and_set+0x3c/0xc0
[ 2471.305008] LR [c00000000001f6e4] enable_kernel_altivec+0x44/0x100
[ 2471.305084] Call Trace:
[ 2471.305122] [c000001fddc2b7e0] [c00000000009baa8] __copy_tofrom_user_base+0x9c/0x574 (unreliable)
[ 2471.305240] [c000001fddc2b860] [c00000000001f6e4] enable_kernel_altivec+0x44/0x100
[ 2471.305336] [c000001fddc2b890] [c00000000009ce40] enter_vmx_ops+0x50/0x70
[ 2471.305418] [c000001fddc2b8b0] [c00000000009c768] memcmp+0x338/0x680
[ 2471.305501] [c000001fddc2b9b0] [c008000018520190] test_user_copy_init+0x188/0xd14 [test_user_copy]
[ 2471.305617] [c000001fddc2ba60] [c00000000000de20] do_one_initcall+0x90/0x560
[ 2471.305710] [c000001fddc2bb30] [c000000000200630] do_init_module+0x90/0x260
[ 2471.305795] [c000001fddc2bbc0] [c0000000001fec88] load_module+0x1a28/0x1ce0
[ 2471.305875] [c000001fddc2bd70] [c0000000001ff1e8] sys_finit_module+0xc8/0x110
[ 2471.305983] [c000001fddc2be30] [c00000000000b528] system_call+0x58/0x6c
[ 2471.306066] Instruction dump:
[ 2471.306112] fba1ffe8 fbc1fff0 fbe1fff8 f8010010 f821ff81 7c7d1b78 60000000 60000000 
[ 2471.306216] 7fe000a6 3d220003 39299705 7ffeeb78 <89290000> 2f890000 419e0044 60000000 
[ 2471.306326] ---[ end trace daf8d409e65b9841 ]---

And:

[   19.096709] test_bpf: test_skb_segment: success in skb_segment!
[   19.096799] initcall test_bpf_init+0x0/0xae0 [test_bpf] returned 0 after 591217 usecs
[   19.115869] calling  test_user_copy_init+0x0/0xd14 [test_user_copy] @ 3159
[   19.116165] Unable to handle kernel paging request for data at address 0xd000000003852805
[   19.116352] Faulting instruction address: 0xc00000000001f44c
[   19.116483] Oops: Kernel access of bad area, sig: 11 [#1]
[   19.116583] LE SMP NR_CPUS=2048 NUMA pSeries
[   19.116684] Modules linked in: test_user_copy(+) lzo_compress crc_itu_t zstd_compress zstd_decompress test_bpf test_static_keys test_static_key_base xxhash test_firmware af_key cls_bpf act_bpf bridge nf_nat_irc xt_NFLOG nfnetlink_log xt_policy nf_conntrack_netlink nfnetlink xt_nat nf_conntrack_irc xt_mark xt_tcpudp nf_nat_sip xt_TCPMSS xt_LOG nf_nat_ftp nf_conntrack_ftp xt_conntrack nf_conntrack_sip xt_addrtype xt_state 8021q iptable_filter ipt_MASQUERADE nf_log_ipv4 iptable_mangle nf_nat_masquerade_ipv4 ipt_REJECT nf_reject_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack ip_tables x_tables nf_log_arp nf_log_common ah4 ipcomp xfrm4_tunnel esp4 rpcrdma stp p8022 psnap llc xfrm_ipcomp xfrm_user xfrm_algo platform_lcd lcd ocxl virtio_balloon virtio_crypto crypto_engine
[   19.118040]  vmx_crypto nbd zram zsmalloc virtio_blk st be2iscsi cxgb3i cxgb4i libcxgbi bnx2i ibmvfc sym53c8xx scsi_transport_spi scsi_dh_alua scsi_dh_rdac qla4xxx mpt3sas scsi_transport_sas cxlflash cxl libiscsi_tcp lpfc crc_t10dif crct10dif_generic crct10dif_common qla2xxx iscsi_boot_sysfs raid_class parport_pc parport powernv_op_panel powernv_rng pseries_rng rng_core virtio_console pcspkr input_leds evdev dm_round_robin dm_mirror dm_region_hash dm_log raid10 dm_service_time multipath dm_queue_length dm_multipath dm_thin_pool faulty dm_persistent_data dm_zero dm_crypt dm_bio_prison dm_snapshot dm_bufio raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq rpadlpar_io rpaphp jsm icom hvcs ib_ipoib ib_srp ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_ucm ib_ucm ib_uverbs
[   19.119505]  rdma_cm iw_cm ib_cm mlx4_ib iw_cxgb3 iw_cxgb4 ib_mthca ib_core leds_powernv led_class vhost_net vhost macvtap macvlan dummy bsd_comp ppp_async crc_ccitt pppoe ppp_synctty pppox ppp_deflate ppp_generic 3c59x s2io bnx2 cnic uio bnx2x libcrc32c i40e ixgbe ixgb cxgb3 libcxgb cxgb cxgb4 pcnet32 netxen_nic qlge be2net acenic mlx4_en mlx4_core myri10ge bonding slhc tap mdio veth vxlan udp_tunnel tun usb_storage usbmon oprofile sha1_powerpc md5_ppc crc32c_vpmsum kvm hvcserver
[   19.120358] CPU: 4 PID: 3159 Comm: modprobe Not tainted 4.17.0-rc3-gcc7x-g7204012 #1
[   19.120508] NIP:  c00000000001f44c LR: c00000000001f894 CTR: 0000000000000000
[   19.120666] REGS: c0000000f8d9f570 TRAP: 0300   Not tainted  (4.17.0-rc3-gcc7x-g7204012)
[   19.120817] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24222844  XER: 00000000
[   19.120984] CFAR: c00000000000c03c DAR: d000000003852805 DSISR: 40000000 IRQMASK: 0 
               GPR00: c00000000001f894 c0000000f8d9f7f0 d000000003829900 0000000002000000 
               GPR04: c0000000f9a30048 000000000000ffe0 0000000000000000 03fffffff065dffd 
               GPR08: 0000000080000000 d000000003852805 c0000000f8d9c000 d000000003820df0 
               GPR12: c00000000009ebb0 c00000003fffb300 c0000000f8d9fd90 d000000003840000 
               GPR16: d000000003840000 0000000000000000 c0000000011d6900 d000000003821ad0 
               GPR20: c000000000bd7860 0000000000000000 c000000000ff9060 00000000014000c0 
               GPR24: 0000000000000000 0000000000000000 0000000000000100 c0000000f9a30028 
               GPR28: fffffffffffffff4 0000000002000000 8000000002009033 8000000000009033 
[   19.122454] NIP [c00000000001f44c] msr_check_and_set+0x3c/0xc0
[   19.122580] LR [c00000000001f894] enable_kernel_altivec+0x44/0x100
[   19.122707] Call Trace:
[   19.122789] [c0000000f8d9f7f0] [c00000000009e228] __copy_tofrom_user_base+0x9c/0x574 (unreliable)
[   19.122962] [c0000000f8d9f870] [c00000000001f894] enable_kernel_altivec+0x44/0x100
[   19.123344] [c0000000f8d9f8a0] [c00000000009f740] enter_vmx_ops+0x50/0x70
[   19.123583] [c0000000f8d9f8c0] [c00000000009eee8] memcmp+0x338/0x680
[   19.123728] [c0000000f8d9f9c0] [d000000003820190] test_user_copy_init+0x188/0xd14 [test_user_copy]
[   19.123909] [c0000000f8d9fa70] [c00000000000e37c] do_one_initcall+0x5c/0x2d0
[   19.124094] [c0000000f8d9fb30] [c00000000020066c] do_init_module+0x90/0x264
[   19.124234] [c0000000f8d9fbc0] [c0000000001ff084] load_module+0x2f64/0x3600
[   19.124371] [c0000000f8d9fd70] [c0000000001ff9c8] sys_finit_module+0xc8/0x110
[   19.124530] [c0000000f8d9fe30] [c00000000000b868] system_call+0x58/0x6c
[   19.124648] Instruction dump:
[   19.124721] fba1ffe8 fbc1fff0 fbe1fff8 f8010010 f821ff81 7c7d1b78 60000000 60000000 
[   19.124869] 7fe000a6 3d220003 39298f05 7ffeeb78 <89290000> 2f890000 419e0044 60000000 
[   19.125034] ---[ end trace 7c08acedd4b4e6aa ]---


cheers
