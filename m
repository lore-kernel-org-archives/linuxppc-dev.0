Return-Path: <anton@ozlabs.org>
Date: Thu, 23 Mar 2006 22:36:37 +1100
From: Anton Blanchard <anton@samba.org>
To: santil@us.ibm.com
Subject: ibmveth initialisation failure
Message-ID: <20060323113637.GJ30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

While testing kdump I hit the register_logical_lan issue already under
discussion. Unfortunately we end up oopsing shortly after this.

It turns out we call ibmveth_change_mtu early in ->open, before we have
set everything up. ibmveth_change_mtu calls ibmveth_interrupt and
shortly after we call ibmveth_poll regardless of whether the device came
up properly:

(/drivers/net/ibmveth.c:515 ua:30000002) ERROR: h_register_logical_lan failed with -4
(drivers/net/ibmveth.c:520 ua:30000002) ERROR: buffer TCE:0x0 filter TCE:0x1000 rxq desc:0x8000701000002000 MAC:0xdad230003002

Unable to handle kernel paging request for data at address 0x00000000
cpu 0x2: Vector: 300 (Data Access) at [c00000000778bab0]
    pc: c0000000022c44fc: .ibmveth_poll+0x94/0x77c
    lr: c0000000023997f4: .net_rx_action+0xe4/0x220
   dar: 0
[c00000000778be40] c0000000023997f4 .net_rx_action+0xe4/0x220
[c00000000778bef0] c0000000020538e8 .__do_softirq+0x98/0x164
[c00000000778bf90] c0000000020224d0 .call_do_softirq+0x14/0x24
[c0000000066e3790] c00000000200b73c .do_softirq+0x94/0xe0
[c0000000066e3820] c000000002053400 .local_bh_enable+0x58/0x8c
[c0000000066e38a0] c00000000242bb64 ._spin_unlock_bh+0x1c/0x30
[c0000000066e3920] c00000000238e3f4 .lock_sock+0xd4/0xf8
[c0000000066e39e0] c00000000238b87c .sock_fasync+0x9c/0x1b0
[c0000000066e3aa0] c00000000238c998 .sock_close+0x3c/0x60
[c0000000066e3b20] c0000000020b1904 .__fput+0xf8/0x238
[c0000000066e3bc0] c0000000020af054 .filp_close+0xac/0xd4
[c0000000066e3c50] c00000000204e7dc .put_files_struct+0xbc/0x148
[c0000000066e3cf0] c0000000020500e8 .do_exit+0x224/0x970
[c0000000066e3da0] c000000002050910 .sys_exit_group+0x0/0x8
[c0000000066e3e30] c00000000200871c syscall_exit+0x0/0x40

Shift ibmveth_change_mtu until after we have set everything up and
cannot fail.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/drivers/net/ibmveth.c
===================================================================
--- build.orig/drivers/net/ibmveth.c	2006-02-13 13:24:22.000000000 +1100
+++ build/drivers/net/ibmveth.c	2006-03-23 21:56:22.000000000 +1100
@@ -489,9 +489,6 @@ static int ibmveth_open(struct net_devic
 	adapter->rx_queue.num_slots = rxq_entries;
 	adapter->rx_queue.toggle = 1;
 
-	/* call change_mtu to init the buffer pools based in initial mtu */
-	ibmveth_change_mtu(netdev, netdev->mtu);
-
 	memcpy(&mac_address, netdev->dev_addr, netdev->addr_len);
 	mac_address = mac_address >> 16;
 
@@ -533,6 +530,9 @@ static int ibmveth_open(struct net_devic
 		return rc;
 	}
 
+	/* call change_mtu to init the buffer pools based in initial mtu */
+	ibmveth_change_mtu(netdev, netdev->mtu);
+
 	ibmveth_debug_printk("initial replenish cycle\n");
 	ibmveth_interrupt(netdev->irq, netdev, NULL);
 
