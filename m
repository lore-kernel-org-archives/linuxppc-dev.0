Return-Path: <kentaro@triumf.ca>
Received: from trshare.triumf.ca (trshare.triumf.ca [142.90.100.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7EBBDDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 14:19:13 +1100 (EST)
Message-ID: <4732719A.20707@triumf.ca>
Date: Thu, 08 Nov 2007 11:16:58 +0900
From: kentaro <kentaro@triumf.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: ML405 gigabit ethernet with kernel 2.6.23
Content-Type: text/plain; charset=ISO-2022-JP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I have measured ethernet performance on ML405 with linux
kernel 2.6.23-rc2 which I obtained from the secreatlab.ca
git tree. I will post this e-mail because I would like to
share the data and besides I would like to ask something
about the performance.

In the past, similar e-mails are also posted to this mailing list;
http://ozlabs.org/pipermail/linuxppc-embedded/2007-June/027328.html
They are also helpful.

My hardware configuration :
-------------------------------------------------------------
ISE, EDK      : 9.1SP3(IP update-3) 9.1SP2
-------------------------------------------------------------
Board         : ML405
PPC frequency : 300 MHz
TEMAC         : SG-DMA, TX/RX checksum offload
                TX/RX FIFO depth = 131072
                MAC length and Status FIFO Depth = 64
                TX/RX DRE = 2
DDR Memory    : Support PLB Bursts and Cache = TRUE
-------------------------------------------------------------

Basically, this configuration is exactly same as XAPP1023
except for BRAM. (I used 64k BRAM.) And with this configuration,
Xilinx achieved 400 Mbps ~ 500Mbps throughput with MontaVista
Linux 4.0. However, my results were
~110 Mbps (TCP) and ~200 Mbps (UDP). I guess the differences
came from linux configuration. Here are my linux setup.

-------------------------------------------------------------
kernel     : 2.6.23-rc2 (from linux-2.6-virtex.git)
gcc, glibc : 4.0.2,  2.3.6
TX,RX threshold = 32, 8 and waitbound = 1, 1
-------------------------------------------------------------

Before compiling the kernel, I needed to modify a checksum
code in adapter.c because the checksum insert address was wrong.

Original (line 1076):
XTemac_mSgSendBdCsumSetup(bd_ptr, skb->transport_header
  - skb->data, (skb->transport_header - skb->data) + skb->csum);

Modified :
XTemac_mSgSendBdCsumSetup(bd_ptr, skb_transport_offset(skb),
            skb_transport_offset(skb) + skb->csum_offset);

I used "nerperf" to measure performance on the built kernel.
The results were
-------------------------------------------------------------
"netperf -H 192.168.1.1 -t TCP_STREAM"		110 Mbps
"netperf -H 192.168.1.1 -t UDP_STREAM"          210 Mbps
-------------------------------------------------------------
I have changed some netperf parameters but the results
didn't change so much. It seemed to me that the performance
was limited by CPU because "top" command told CPU usage was
99% (71% SYSTEM, 27% IRQ). If I lower the TX threshold down
to 16, the score becomes (~50% SYSTEM, ~40% IRQ).

Then, I changed MTU to 8000 (on both PC and ML405).
This made everything upset. Network became very unstable
and I couldn't run netperf successfully.

So, my question is
(1) Do I need to apply some optimization to the kernel sources
    in order to achieve ~400 Mbps ? It seems to me the difference
    comes from the kernel part.
(2) Does anyone have some MTU problem ? I'm very glad if I could
    have advices.

Any suggestion is welcome.

Best regards,
Kentaro.

--------------------------------------------------------------------
PS:
For your interest, here I attach my /proc/profile info
obtained while running netperf.

=============== Netperf Test (TCP STREAM) ====================
   394 __copy_tofrom_user                         0.6888
   208 invalidate_dcache_range                    4.3333
   196 clean_dcache_range                         4.0833
   173 XDmaV3_SgBdToHw                            0.5149
   152 tcp_sendmsg                                0.0485
   105 skb_clone                                  0.1862
    71 tcp_transmit_skb                           0.0380
    71 ip_queue_xmit                              0.0870
    67 cpu_idle                                   0.3102
    59 kfree                                      0.2588
    57 tcp_cwnd_validate                          0.4191
    49 tcp_push_one                               0.1551
    49 kmem_cache_alloc                           0.3063
    45 ip_output                                  0.0622
    44 tcp_ack                                    0.0067
    42 xenet_SgSend_internal                      0.0587
    38 __alloc_skb                                0.1418
    36 pfifo_fast_enqueue                         0.1579
    33 __kmalloc                                  0.1375
    30 memset                                     0.3261
    28 _xenet_SgSetupRecvBuffers                  0.0493
    27 XTemac_IntrSgEnable                        0.0938
    23 skb_release_data                           0.1150
    22 tcp_rcv_established                        0.0097

=============== Netperf Test (UDP STREAM) ====================
  1426 csum_partial_copy_generic                  6.4818
   961 cpu_idle                                   4.4491
   126 ip_fragment                                0.0754
    63 xenet_SgSend_internal                      0.0880
    58 memcpy                                     0.3718
    50 memset                                     0.5435
    48 XDmaV3_SgBdToHw                            0.1429
    48 __kmalloc                                  0.2000
    46 ip_push_pending_frames                     0.0451
    38 kfree                                      0.1667
    37 clean_dcache_range                         0.7708
    36 dev_queue_xmit                             0.0536
    33 __alloc_skb                                0.1231
    32 udp_push_pending_frames                    0.0452
    29 local_bh_enable                            0.2071
    29 ace_fsm_tasklet                            0.3295
    24 ip_append_data                             0.0100
    23 XTemac_SgCommit                            0.1027
    22 XDmaV3_SgBdAlloc                           0.1964
    21 skb_release_data                           0.1050
    21 kmem_cache_alloc                           0.1313
    20 ip_finish_output2                          0.0365
    19 XTemac_SgAlloc                             0.0679
    19 pfifo_fast_dequeue                         0.1532
