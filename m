From: "challaharikumar" <challaharikumar@tataelxsi.co.in>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: A doubt in sk_buff
Date: Sat, 13 Mar 2004 14:59:06 +0530
Message-ID: <000501c408dd$a2133960$3401080a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!
all,

A doubt in sk_buff. I am running the fcc_enet driver provided in the PPC
architecture tree for MPC8260 on ADS board.
Kernel version is 2.4.1. The driver has been modified to be loaded as a
module.
When IFNET provides the sk_buff to transmit I store them up in an array
and at transmit complete I release the sk_buff.

When the module is unloaded, I release all the sk_buffs.
When I release the sk_buff I get the following output. Am I doing
anything wrong here ?
----------------------------------------------------------------------------
-------------

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

----------------------------------------------------------------------------
------------------
Any help will be greatly appreciated,
Thanks in advance ,


regards
hari


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
