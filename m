Return-Path: <jstancek@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssz3h2n2czDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 22:51:12 +1100 (AEDT)
Date: Mon, 10 Oct 2016 13:51:05 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: ehea crash on boot
Message-ID: <20161010115102.GA501@dustball.brq.redhat.com>
References: <CAOJe8K0p60fmubbhSHCm0096CTjYjnnfoo_JLuwDcg6fo-=pBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K0p60fmubbhSHCm0096CTjYjnnfoo_JLuwDcg6fo-=pBg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Denis / all,

Do you know if there is a patch or lead for this problem? I seem
to be hitting same Oops with P730 lpar when running 4.8 (see below),
but 4.7.7 looks OK.

Regards,
Jan

[    8.698424] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready 
[    8.713373] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready 
[    8.713940] mm: Hashing failure ! EA=0xd000080080004040 access=0x800000000000000e current=NetworkManager 
[    8.713949]     trap=0x300 vsid=0x13d349c ssize=1 base psize=2 psize 2 pte=0xc0003cc033e701ae 
[    8.713958] mm: Hashing failure ! EA=0xd000080080004040 access=0x800000000000000e current=NetworkManager 
[    8.713966]     trap=0x300 vsid=0x13d349c ssize=1 base psize=2 psize 2 pte=0xc0003cc033e701ae 
[    8.713979] Unable to handle kernel paging request for data at address 0xd000080080004040 
[    8.713985] Faulting instruction address: 0xd0000000011cc250 
[    8.713992] Oops: Kernel access of bad area, sig: 7 [#1] 
[    8.713996] SMP NR_CPUS=2048 NUMA pSeries 
[    8.714008] Modules linked in: sg uio_pdrv_genirq uio nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmvscsi scsi_transport_srp ibmveth ehea dm_mirror dm_region_hash dm_log dm_mod 
[    8.714063] CPU: 2 PID: 1148 Comm: NetworkManager Not tainted 4.8.0-1.el7.test.ppc64.debug #1 
[    8.714072] task: c0000000065e2080 task.stack: c000000006668000 
[    8.714078] NIP: d0000000011cc250 LR: d0000000011cc118 CTR: 000000000042c120 
[    8.714086] REGS: c00000000666ab00 TRAP: 0300   Not tainted  (4.8.0-1.el7.test.ppc64.debug) 
[    8.714092] MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24288442  XER: 00000020 
[    8.714120] CFAR: c0000000000087d0 DAR: d000080080004040 DSISR: 42000000 SOFTE: 1  
GPR00: d0000000011cc118 c00000000666ad80 d0000000011dbdd8 c000000006327f80  
GPR04: 0000000000000000 c0000000b0800000 0000000000029000 0000000000028000  
GPR08: c0000000b0800000 0000000000000000 d000080080004000 00000000ffffd953  
GPR12: 0000000080000001 c00000000ea61200 0000000000000000 0000000000000000  
GPR16: 00000000000007fe 0000000000000000 0000000000000001 0000000000000000  
GPR20: c0000000b53ecbd0 c0000000b53ecb00 c0000000b53ec1e8 c0000000b53ec1d0  
GPR24: c0000000b53ec1b8 c0000000b53ec200 0000000000000000 0000000000000015  
GPR28: 00000000000009fd c0000000bbb59418 0000000000000028 c000000006327f80  
[    8.714254] NIP [d0000000011cc250] .ehea_create_cq+0x280/0x340 [ehea] 
[    8.714263] LR [d0000000011cc118] .ehea_create_cq+0x148/0x340 [ehea] 
[    8.714270] Call Trace: 
[    8.714278] [c00000000666ad80] [d0000000011cc118] .ehea_create_cq+0x148/0x340 [ehea] (unreliable) 
[    8.714292] [c00000000666ae30] [d0000000011c5e28] .ehea_up+0x258/0x1200 [ehea] 
[    8.714304] [c00000000666afa0] [d0000000011c6e14] .ehea_open+0x44/0x1a0 [ehea] 
[    8.714316] [c00000000666b030] [c0000000009bc4c4] .__dev_open+0x164/0x310 
[    8.714328] [c00000000666b0d0] [c0000000009c6998] .__dev_change_flags+0x158/0x4f0 
[    8.714339] [c00000000666b180] [c0000000009c6d5c] .dev_change_flags+0x2c/0x220 
[    8.714349] [c00000000666b220] [c0000000009e2d3c] .do_setlink+0x38c/0xef0 
[    8.714359] [c00000000666b3a0] [c0000000009e65cc] .rtnl_newlink+0x97c/0xb10 
[    8.714369] [c00000000666b6b0] [c0000000009e4ae4] .rtnetlink_rcv_msg+0xc4/0x380 
[    8.714379] [c00000000666b7a0] [c000000000a1c05c] .netlink_rcv_skb+0x12c/0x150 
[    8.714388] [c00000000666b830] [c0000000009e1b68] .rtnetlink_rcv+0x38/0x60 
[    8.714396] [c00000000666b8b0] [c000000000a1bb74] .netlink_unicast+0x554/0x6b0 
[    8.714405] [c00000000666b990] [c000000000a1cbcc] .netlink_sendmsg+0x41c/0x490 
[    8.714415] [c00000000666ba70] [c000000000986e18] .___sys_sendmsg+0x278/0x370 
[    8.714425] [c00000000666bc50] [c0000000009892d4] .SyS_sendmsg+0xc4/0x130 
[    8.714436] [c00000000666bd50] [c00000000098a180] .SyS_socketcall+0x3d0/0x4e0 
[    8.714448] [c00000000666be30] [c000000000009590] system_call+0x38/0xec 
[    8.714455] Instruction dump: 
[    8.714462] 38a00001 4bffe7fd 60000000 7fe3fb78 48003081 e8410028 38600000 48000030  
[    8.714484] e95f0038 39200000 7fe3fb78 f93f0010 <f92a0040> 3920ffff 79290004 e95f0038  
[    8.714506] ---[ end trace fe4fbc224578dd0c ]--- 
