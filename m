From: marvin24@gmx.de
To: linuxppc-dev@lists.linuxppc.org
Subject: latency at bmac initialisation
Date: Wed, 25 Aug 2004 22:28:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408252228.11963.marvin24@gmx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've compiled a kernel with Ingo Molar's voluntary-preempt patch. My B/W G3
runs stable with it. I have no sputters anymore when playing a mp3 file with
heavy disk load. Very fine! But I was very astonished about the latency
during the bmac initialisation which produced a 100 ms latency on my system
(400 Mhz). I know that this doesn't has an effect during normal operation and
this shouldn't be an endless thread of "Hey! I still have some > 10 ms
latency in foo_bar_function", but maybe this can be fixed easily (though I
don't know how).... Here's the dump:

(pppd/2061): 100035 us critical section violates 10000 us threshold.
 => started at: <bmac_reset_and_enable+0x4c/0x174 [bmac]>
 => ended at:   <bmac_reset_and_enable+0x134/0x174 [bmac]>
Call trace:
 [c000bdc8] dump_stack+0x2c/0x3c
 [c004106c] check_preempt_timing+0x19c/0x230
 [c0041298] sub_preempt_count+0x70/0x80
 [ce2a1c34] bmac_reset_and_enable+0x134/0x174 [bmac]
 [ce2a2214] bmac_open+0x34/0x60 [bmac]
 [c01bd704] dev_open+0x128/0x168
 [c01bf800] dev_change_flags+0x80/0x164
 [c02053b0] devinet_ioctl+0x32c/0x6a0
 [c0207f54] inet_ioctl+0x94/0xe0
 [c01b2858] sock_ioctl+0x140/0x378
 [c007fbd4] sys_ioctl+0x148/0x36c
 [c0008000] ret_from_syscall+0x0/0x44

and here is the trace

preemption latency trace v1.0.2
-------------------------------
 latency: 100031 us, entries: 2943 (2943)
    -----------------
    | task: pppd/2003, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: bmac_reset_and_enable+0x4c/0x174
 => ended at:   bmac_reset_and_enable+0x134/0x174
=======>
00000001 0.000ms (+0.000ms): bmac_reset_and_enable (bmac_open)
00000001 0.000ms (+0.000ms): bmac_enable_and_reset_chip
(bmac_reset_and_enable)
00000001 0.001ms (+0.000ms): dbdma_reset (bmac_enable_and_reset_chip)
00000001 0.003ms (+0.002ms): dbdma_reset (bmac_enable_and_reset_chip)
00000001 0.006ms (+0.002ms): <c031091c> (bmac_enable_and_reset_chip)
00000001 0.009ms (+0.002ms): <c030d014> (<c0310a2c>)
00000001 0.010ms (+0.000ms): <c030bd64> (<c030d030>)
00000001 19.930ms (+19.919ms): bmac_init_tx_ring (bmac_reset_and_enable)
00000001 19.934ms (+0.003ms): dbdma_setcmd (bmac_init_tx_ring)
00000001 19.934ms (+0.000ms): dbdma_reset (bmac_init_tx_ring)
00000001 19.936ms (+0.001ms): bmac_init_rx_ring (bmac_reset_and_enable)
00000001 19.942ms (+0.006ms): alloc_skb (bmac_init_rx_ring)

Greetings

Marc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
