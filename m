Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybR3d0Bb1zDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 10:02:04 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vADN11XQ107134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 18:02:02 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e7mnv05xx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 18:02:02 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 16:02:01 -0700
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] ibmveth: Kernel crash LSO offload flag toggle
Date: Mon, 13 Nov 2017 17:01:55 -0600
Message-Id: <20171113230155.99682-1-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following script when run (along with some iperf traffic recreates the
crash within 5-10 mins or so).

while true
do
	ethtool -k ibmveth0 | grep tcp-segmentation-offload
	ethtool -K ibmveth0 tso off
	ethtool -k ibmveth0 | grep tcp-segmentation-offload
	ethtool -K ibmveth0 tso on
done

Note: This issue happens the very first time largsesend offload is
turned off too (but the above script recreates the issue all the times)

Stack trace output:
 [76563.914380] NIP [c000000000063940] memcpy_power7+0x40/0x800
[76563.914387] LR [d000000000d31788] ibmveth_start_xmit+0x1c8/0x8d0 [ibmveth]
[76563.914392] Call Trace:
[76563.914396] [c0000000feab3270] [c0000000feab32d0] 0xc0000000feab32d0 (unreliable)
[76563.914407] [c0000000feab3360] [c0000000009816f4] dev_hard_start_xmit+0x304/0x530
[76563.914415] [c0000000feab3440] [c0000000009b6564] sch_direct_xmit+0x124/0x330
[76563.914423] [c0000000feab34e0] [c000000000981ddc] __dev_queue_xmit+0x26c/0x770
[76563.914431] [c0000000feab3580] [c000000000a1efc0] arp_xmit+0x30/0xd0
[76563.914438] [c0000000feab35f0] [c000000000a1f0f4] arp_send_dst.part.0+0x94/0xb0
[76563.914445] [c0000000feab3660] [c000000000a1fcb4] arp_solicit+0x114/0x2b0
[76563.914452] [c0000000feab3730] [c00000000098d8f4] neigh_probe+0x84/0xd0
[76563.914460] [c0000000feab3760] [c0000000009937cc] neigh_timer_handler+0xbc/0x320
[76563.914468] [c0000000feab37a0] [c00000000014a3fc] call_timer_fn+0x5c/0x1c0
[76563.914474] [c0000000feab3830] [c00000000014a8bc] run_timer_softirq+0x31c/0x3f0
[76563.914483] [c0000000feab3900] [c0000000000bec58] __do_softirq+0x188/0x3e0
[76563.914490] [c0000000feab39f0] [c0000000000bf128] irq_exit+0xc8/0x100
[76563.914498] [c0000000feab3a10] [c00000000001f974] timer_interrupt+0xa4/0xe0
[76563.914505] [c0000000feab3a40] [c000000000002714] decrementer_common+0x114/0x180

Oops output:
 [76563.914173] Unable to handle kernel paging request for data at address 0x00000000
[76563.914197] Faulting instruction address: 0xc000000000063940
[76563.914205] Oops: Kernel access of bad area, sig: 11 [#1]
[76563.914210] SMP NR_CPUS=2048 NUMA pSeries
[76563.914217] Modules linked in: rpadlpar_io rpaphp dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag nls_utf8 isofs binfmt_misc pseries_rng rtc_generic autofs4 ibmvfc scsi_transport_fc ibmvscsi ibmveth
[76563.914251] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0-34-generic #53-Ubuntu
[76563.914258] task: c0000000fe9efcc0 ti: c0000000feab0000 task.ti: c0000000feab0000
[76563.914265] NIP: c000000000063940 LR: d000000000d31788 CTR: c000000000064100
[76563.914271] REGS: c0000000feab2ff0 TRAP: 0300   Not tainted  (4.4.0-34-generic)
[76563.914277] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 4800284e  XER: 0000001a
[76563.914294] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 42000000 SOFTE: 1
GPR00: 000000000000f240 c0000000feab3270 c0000000015b5d00 0000000000000000
GPR04: c00000000d9b0004 000000000000002a 0000000000000006 c0000000efc0ccac
GPR08: d000000000d3dd28 0000000000000080 0000000000000000 d000000000d34758
GPR12: c000000000064100 c00000000e7f1c80 c0000000ffdca938 0000000000000100
GPR16: c0000000ffdca738 c0000000ffdca538 c0000000feab34a0 c0000000015f4d00
GPR20: 0000000000000000 c0000000015f4cf0 c0000000f5945900 0000000000000000
GPR24: 0000000000000000 0000000080000000 c0000000feab32d0 c0000000efc0ccac
GPR28: c0000000f23ccb00 c0000000f5945000 c0000000f23ccb00 c0000000efc0cc00
[76563.914380] NIP [c000000000063940] memcpy_power7+0x40/0x800
[76563.914387] LR [d000000000d31788] ibmveth_start_xmit+0x1c8/0x8d0 [ibmveth]
[76563.914392] Call Trace:
[76563.914396] [c0000000feab3270] [c0000000feab32d0] 0xc0000000feab32d0 (unreliable)
[76563.914407] [c0000000feab3360] [c0000000009816f4] dev_hard_start_xmit+0x304/0x530
[76563.914415] [c0000000feab3440] [c0000000009b6564] sch_direct_xmit+0x124/0x330
[76563.914423] [c0000000feab34e0] [c000000000981ddc] __dev_queue_xmit+0x26c/0x770
[76563.914431] [c0000000feab3580] [c000000000a1efc0] arp_xmit+0x30/0xd0
[76563.914438] [c0000000feab35f0] [c000000000a1f0f4] arp_send_dst.part.0+0x94/0xb0
[76563.914445] [c0000000feab3660] [c000000000a1fcb4] arp_solicit+0x114/0x2b0
[76563.914452] [c0000000feab3730] [c00000000098d8f4] neigh_probe+0x84/0xd0
[76563.914460] [c0000000feab3760] [c0000000009937cc] neigh_timer_handler+0xbc/0x320
[76563.914468] [c0000000feab37a0] [c00000000014a3fc] call_timer_fn+0x5c/0x1c0
[76563.914474] [c0000000feab3830] [c00000000014a8bc] run_timer_softirq+0x31c/0x3f0
[76563.914483] [c0000000feab3900] [c0000000000bec58] __do_softirq+0x188/0x3e0
[76563.914490] [c0000000feab39f0] [c0000000000bf128] irq_exit+0xc8/0x100
[76563.914498] [c0000000feab3a10] [c00000000001f974] timer_interrupt+0xa4/0xe0
[76563.914505] [c0000000feab3a40] [c000000000002714] decrementer_common+0x114/0x180
[76563.914515] --- interrupt: 901 at plpar_hcall_norets+0x1c/0x28
[76563.914515]     LR = check_and_cede_processor+0x34/0x50
[76563.914525] [c0000000feab3d30] [c000000000916bf0] check_and_cede_processor+0x20/0x50 (unreliable)
[76563.914534] [c0000000feab3d90] [c000000000916e18] shared_cede_loop+0x68/0x170
[76563.914541] [c0000000feab3dd0] [c000000000913e20] cpuidle_enter_state+0x160/0x410
[76563.914549] [c0000000feab3e30] [c000000000119d48] call_cpuidle+0x78/0xd0
[76563.914556] [c0000000feab3e70] [c00000000011a11c] cpu_startup_entry+0x37c/0x480
[76563.914564] [c0000000feab3f30] [c00000000004563c] start_secondary+0x33c/0x360
[76563.914572] [c0000000feab3f90] [c000000000008b6c] start_secondary_prolog+0x10/0x14
[76563.914579] Instruction dump:
[76563.914584] 4185024c 7cc400d0 7cd01120 78c60760 409f0014 88040000 38840001 98030000
[76563.914596] 38630001 409e0014 a0040000 38840002 <b0030000> 38630002 409d0014 80040000
[76563.914613] ---[ end trace 5382b3d78671418e ]---
[76563.916817]
[76565.916870] Kernel panic - not syncing: Fatal exception in interrupt
[76565.919468] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> # 4.14+
---
 drivers/net/ethernet/ibm/ibmveth.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index f210398200ece..971ed54332d42 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1092,8 +1092,14 @@ static netdev_tx_t ibmveth_start_xmit(struct sk_buff *skb,
 	 */
 	if (force_bounce || (!skb_is_nonlinear(skb) &&
 				(skb->len < tx_copybreak))) {
-		skb_copy_from_linear_data(skb, adapter->bounce_buffer,
-					  skb->len);
+		if (adapter->bounce_buffer) {
+			skb_copy_from_linear_data(skb, adapter->bounce_buffer,
+						  skb->len);
+		} else {
+			adapter->tx_send_failed++;
+			netdev->stats.tx_dropped++;
+			goto out;
+		}
 
 		descs[0].fields.flags_len = desc_flags | skb->len;
 		descs[0].fields.address = adapter->bounce_buffer_dma;
@@ -1691,9 +1697,6 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		netdev->features |= NETIF_F_FRAGLIST;
 	}
 
-	netdev->min_mtu = IBMVETH_MIN_MTU;
-	netdev->max_mtu = ETH_MAX_MTU;
-
 	memcpy(netdev->dev_addr, mac_addr_p, ETH_ALEN);
 
 	if (firmware_has_feature(FW_FEATURE_CMO))
-- 
2.13.6 (Apple Git-96)
