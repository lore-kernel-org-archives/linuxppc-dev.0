Message-ID: <000d01c35fa4$3ca46d70$7301a8c0@zhongqx>
From: "zhongqx-local" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Out of Memory problem with kernel 2.4.4 
Date: Mon, 11 Aug 2003 09:02:29 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone:

       I am developing a BRIDGE with in MPC860 and linux kernel
2.4.4(denx linux-2.4.4-2002-02-14).I make a bridge BR0 with eth1(100M
FEC) and eth0 (10M scc1),my total ram is 16M ,I used a 6M ramdisk.When
I boot the kernel I find the free memory is about 5M,But when I copy a
large files through the bridge,I find that the free memory become fewer
and fewer,at last the free memory is about 500K ,then the kernel killed
all process and restart itself like the following:

# | STATE_BRID_I1: retransmission; will wait 10s for response time 1
br0: port 2(eth1) entering learning state
br0: port 1(eth0) entering learning state
br0: received tcn bpdu on port 2(eth1)
br0: topology change detected, propagating
| STATE_BRID_I1: retransmission; will wait 10s for response time 2
br0: port 2(eth1) entering forwarding state
br0: topology change detected, propagating
br0: port 1(eth0) entering forwarding state
br0: topology change detected, propagating
| it seens Center ID is illegal
| STATE_BRID_I1: retransmission; will wait 10s for response time 3
| add center 192.168.1.242 public key sucessly
send work key to bridge c0a801f2
total drop skb 1 packet!
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
eth0: Memory squeeze, dropping packet.
eth1: Memory squeeze, dropping packet.
__alloc_pages: 0-order allocation failed.
eth1: Memory squeeze, dropping packet.
Out of Memory: Killed process 21 (sh).
Terminated
Out of Memory: Killed process 7 (linuxrc).

The system is going down NOW !!
Sending SIGTERM to all processes.
klips_debug:pfkey_remove_socket: succeeded.
klips_debug:pfkey_destroy_socket: destroyed.
klips_debug:pfkey_release: succeeded.
Sending SIGKILL to all processes.
Please stand by while rebooting the system.
Restarting syst

PPCBoot 1.1.5 (Mar 26 2003 - 10:24:01)

CPU:   XPC860xxZPnnD4 at 50.00 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
Board: Embedded Linux development kits for MPC8xx se
ries...
DRAM:  16 MB
In:    serial
Out:   serial
Err:   serial

'Type "run flash_nfs" to mount root filesystem over NFS'

Hit any key to stop autoboot:  0
BOOTP broadcast 1

    I can not understand why the free memory become fewer and fewer,I
look for the fec.c driver, when a packet come the program will
use dev_alloc_skb functions alloc a skb for it ,and at last in
net/bridge/br_forward.c it will be kfree_skb(skb),so I think the free
memory should be 5M allways.

    Can anyone help me? thanks a lot!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
