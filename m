Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srkBj5vwBzDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 22:07:57 +1100 (AEDT)
Date: Sat, 8 Oct 2016 22:07:33 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>, peterz@infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: CPU hotplug hits oops in select_idle_sibling()
Message-ID: <20161008220733.366e8c6b@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I updated to mainline as of today and tried CPU hotplug via the ppc64_cpu
tool:

# ppc64_cpu --smt=off
Segmentation fault

Looks like a NULL pointer in select_idle_sibling():

Unable to handle kernel paging request for data at address 0x00000078
Faulting instruction address: 0xc000000000101520
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in: kvm_hv kvm binfmt_misc vmx_crypto crc32c_vpmsum leds_powernv powernv_rng led_class powernv_op_panel rng_core ib_iser rdma_cm iw_cm ib_cm ib_core libiscsi scsi_transport_iscsi autofs4
CPU: 0 PID: 4232 Comm: ppc64_cpu Not tainted 4.8.0-11288-gb66484c #785
task: c0000007cc014d00 task.stack: c0000007cc0a8000
NIP: c000000000101520 LR: c000000000101720 CTR: c0000000001017c0
REGS: c0000007cc0ab4d0 TRAP: 0300   Not tainted  (4.8.0-11288-gb66484c)
MSR: 900000010280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 28002228  XER: 00000000
CFAR: c0000000000089dc DAR: 0000000000000078 DSISR: 40000000 SOFTE: 0 
GPR00: 0000000000000000 c0000007cc0ab750 c000000000dbc100 0000000000000800 
GPR04: 0000000000000800 0000000000000800 0000000000000000 c0000017f68ab630 
GPR08: 00000007fa360000 00000000000f4240 0000000000000000 c0000007fb00aa30 
GPR12: c0000007ed712c60 c00000000fe00000 0000000000000001 0000000000000800 
GPR16: c000000000caa8a0 0000000000000190 c000000000caa890 c0000007ed712800 
GPR20: 0000000000000000 0000000000000000 c0000017f68ab400 0000000000000032 
GPR24: 0000000000000001 c000000000dea960 0000000000000190 c000000000ca36a8 
GPR28: c000000000deef44 0000000000000000 0000000000000800 0000000000000000 
NIP [c000000000101520] select_idle_sibling+0x200/0x4a0
LR [c000000000101720] select_idle_sibling+0x400/0x4a0
Call Trace:
[c0000007cc0ab750] [c0000007cc0ab830] 0xc0000007cc0ab830 (unreliable)
[c0000007cc0ab800] [c0000000000f3dc8] try_to_wake_up+0x138/0x520
[c0000007cc0ab880] [c000000000113b94] __wake_up_common+0x84/0xf0
[c0000007cc0ab8e0] [c000000000308e14] ep_poll_callback+0xe4/0x2a0
[c0000007cc0ab930] [c000000000113b94] __wake_up_common+0x84/0xf0
[c0000007cc0ab990] [c0000000001140d8] __wake_up_sync_key+0x68/0xa0
[c0000007cc0ab9e0] [c0000000007f46cc] sock_def_readable+0x4c/0x90
[c0000007cc0aba10] [c00000000084d980] __netlink_sendskb+0x60/0xa0
[c0000007cc0aba50] [c00000000084dd44] netlink_broadcast_filtered+0x384/0x540
[c0000007cc0abb10] [c0000000004c1530] kobject_uevent_env+0x480/0x640
[c0000007cc0abbf0] [c0000000005a2e2c] device_offline+0x10c/0x130
[c0000007cc0abc30] [c0000000005a2f8c] online_store+0x5c/0xb0
[c0000007cc0abc70] [c00000000059f414] dev_attr_store+0x34/0x60
[c0000007cc0abc90] [c00000000034aeb4] sysfs_kf_write+0x64/0x80
[c0000007cc0abcb0] [c000000000349d0c] kernfs_fop_write+0x16c/0x230
[c0000007cc0abd00] [c0000000002a7020] __vfs_write+0x160/0x1a0
[c0000007cc0abd90] [c0000000002a81ac] vfs_write+0xcc/0x230
[c0000007cc0abde0] [c0000000002a9c60] SyS_write+0x60/0x110
[c0000007cc0abe30] [c00000000000bc04] system_call+0x38/0xe0
Instruction dump:
7f094836 419dff8c 2fbf0000 419eff34 2b9e07ff 409d0180 e90d0030 3d22fff0 
39296680 7fb2402a 7d294214 e9290960 <e95d0078> 7929ba42 7faa4840 419d00b4 
---[ end trace dab28cb0b01424b5 ]---

Anton
