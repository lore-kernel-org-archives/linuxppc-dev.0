Message-ID: <3E97EE11.6060705@tataelxsi.co.in>
Date: Sat, 12 Apr 2003 16:14:33 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: sk_buff doubt
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

A doubt in sk_buff. I am running the fcc_enet driver provided in the PPC
architecture tree for MPC8260 on ADS board. Kernel version is 2.4.1. The
driver has been modified to be loaded as a module. When IFNET provides
the sk_buff to transmit, the driver stores them up in an array and at
transmit complete the driver releases the sk_buff.

When the module is unloaded, the driver releases all the sk_buffs. When
I release the sk_buff I get the following output. Am I doing anything
wrong here ?
------------------------------------------------------------------------

# ifconfig eth1 10.1.70.56 netmask 255.255.0.0 up
eth1: config: auto-negotiation on, 10FDX, 10HDX.
# ping 10.1.1.1
Inside fcc_enet_start_xmit... skb: c01e5c60
Inside fcc_enet_start_xmit... skb: c01e5620
Inside fcc_enet_start_xmit... skb: c01e5080
No response from 10.1.1.1
# lsmod
Module                  Size  Used by
enet                   12512   0  (unused)
# rmmod enet
Warning: kfree_skb passed an skb still on a list (from c208360c).
kernel BUG at skbuff.c:277!
Oops: Exception in kernel mode, sig: 4

------------------------------------------------------------------------

Any suggestions or pointers could be very helpful.

Thank you.
Regards,
Sriram

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
