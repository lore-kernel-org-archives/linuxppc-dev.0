Return-Path: <srs0=ccls=lk=nefkom.net=whitebox@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zds23fnbzDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 03:18:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41zds232s6z8tPx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 03:18:46 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41zds04k65z9s47
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 03:18:44 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: netdev@vger.kernel.org
Subject: Oops running iptables -F OUTPUT
CC: linuxppc-dev@ozlabs.org
Date: Mon, 27 Aug 2018 19:11:01 +0200
Message-ID: <87bm9n68gq.fsf@igel.home>
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

I'm getting this Oops when running iptables -F OUTPUT:

[   91.139409] Unable to handle kernel paging request for data at address 0xd0000001fff12f34
[   91.139414] Faulting instruction address: 0xd0000000016a5718
[   91.139419] Oops: Kernel access of bad area, sig: 11 [#1]
[   91.139426] BE SMP NR_CPUS=2 PowerMac
[   91.139434] Modules linked in: iptable_filter ip_tables x_tables bpfilter nfsd auth_rpcgss lockd grace nfs_acl sunrpc tun af_packet snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm_oss snd_pcm snd_seq snd_timer snd_seq_device snd_mixer_oss snd sungem sr_mod firewire_ohci cdrom sungem_phy soundcore firewire_core pata_macio crc_itu_t sg hid_generic usbhid linear md_mod ohci_pci ohci_hcd ehci_pci ehci_hcd usbcore usb_common dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_mod sata_svw
[   91.139522] CPU: 1 PID: 3620 Comm: iptables Not tainted 4.19.0-rc1 #1
[   91.139526] NIP:  d0000000016a5718 LR: d0000000016a569c CTR: c0000000006f560c
[   91.139531] REGS: c0000001fa577670 TRAP: 0300   Not tainted  (4.19.0-rc1)
[   91.139534] MSR:  900000000200b032 <SF,HV,VEC,EE,FP,ME,IR,DR,RI>  CR: 84002484  XER: 20000000
[   91.139553] DAR: d0000001fff12f34 DSISR: 40000000 IRQMASK: 0 
GPR00: d0000000016a569c c0000001fa5778f0 d0000000016b0400 0000000000000000 
GPR04: 0000000000000002 0000000000000000 80000001fa46418e c0000001fa0d05c8 
GPR08: d0000000016b0400 d00037fffff13000 00000001ff3e7000 d0000000016a6fb8 
GPR12: c0000000006f560c c00000000ffff780 0000000000000000 0000000000000000 
GPR16: 0000000011635010 00003fffa1b7aa68 0000000000000000 0000000000000000 
GPR20: 0000000000000003 0000000010013918 00000000116350c0 c000000000b88990 
GPR24: c000000000b88ba4 0000000000000000 d0000001fff12f34 0000000000000000 
GPR28: d0000000016b8000 c0000001fa20f400 c0000001fa20f440 0000000000000000 
[   91.139627] NIP [d0000000016a5718] .alloc_counters.isra.10+0xbc/0x140 [ip_tables]
[   91.139634] LR [d0000000016a569c] .alloc_counters.isra.10+0x40/0x140 [ip_tables]
[   91.139638] Call Trace:
[   91.139645] [c0000001fa5778f0] [d0000000016a569c] .alloc_counters.isra.10+0x40/0x140 [ip_tables] (unreliable)
[   91.139655] [c0000001fa5779b0] [d0000000016a5b54] .do_ipt_get_ctl+0x110/0x2ec [ip_tables]
[   91.139666] [c0000001fa577aa0] [c0000000006233e0] .nf_getsockopt+0x68/0x88
[   91.139674] [c0000001fa577b40] [c000000000631608] .ip_getsockopt+0xbc/0x128
[   91.139682] [c0000001fa577bf0] [c00000000065adf4] .raw_getsockopt+0x18/0x5c
[   91.139690] [c0000001fa577c60] [c0000000005b5f60] .sock_common_getsockopt+0x2c/0x40
[   91.139697] [c0000001fa577cd0] [c0000000005b3394] .__sys_getsockopt+0xa4/0xd0
[   91.139704] [c0000001fa577d80] [c0000000005b5ab0] .__se_sys_socketcall+0x238/0x2b4
[   91.139712] [c0000001fa577e30] [c00000000000a31c] system_call+0x5c/0x70
[   91.139716] Instruction dump:
[   91.139721] 39290040 7d3d4a14 7fbe4840 409cff98 81380000 2b890001 419d000c 393e0060 
[   91.139736] 48000010 7d57c82a e93e0060 7d295214 <815a0000> 794807e1 41e20010 7c210b78 
[   91.139752] ---[ end trace f5d1d5431651845d ]---


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
