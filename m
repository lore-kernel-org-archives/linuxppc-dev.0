Return-Path: <aweissma_ppc@yahoo.com>
Received: from web35210.mail.mud.yahoo.com (web35210.mail.mud.yahoo.com
	[66.163.179.89]) by ozlabs.org (Postfix) with SMTP id AB121682A0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 00:18:58 +1000 (EST)
Message-ID: <20050914141856.72600.qmail@web35210.mail.mud.yahoo.com>
Date: Wed, 14 Sep 2005 07:18:56 -0700 (PDT)
From: "Adrian B. Weissman" <aweissma_ppc@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: A question regarding the Marvel 64360 and a MPC7447A
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello:
     I am having some issues with the Marvell 64360
Driver, mv643xx_eth.c on an MPC7447A.  I am writing 
this email in the hopes that someone has seen the 
type of behavior that I am seeing with this
combination.
     My company has taken an existing board that had
an MPC7447 with 64360, and dropped down a MPC7447A.
On the original board that had the MPC7447, the 
Marvell Driver works just fine.  The MPC7447A was 
supposed to be a pin-for-pin compatible replacement,
with some minor resistor bootstrapping changes to 
set the processor speed.
  
Here are my problems:

1.  Rx Resource Error with Priority Queue 0

    eth_int_cause 0x00000c00 Port-0
eth_int_cause_ext 0x00000000 Port-0
     rx queue cmd 0x0000fe00 Port-0
        rx status 0x0000042e Port-0
     tx queue cmd 0x0000ff00 Port-0
       rx dropped 0x00000003 Port-0
         sdma Cfg 0x00800004 Port-0
 SDMA Cause Reg = 0x00000000 

     Using the configuration that worked just fine
on the MPC7447, I try and bring up the interface.
When I do, I immediately get an Rx Resource Error 
with priority queue 0.
     After thinking about what could cause an
Rx Resource error, I decided to increase the number
of Rx Buffer Descriptors to 2000, from 400.  When I 
did this, the Rx Resource error disappeared.
     However, when thinking about this problem,
I realize that the MPX bus speed, and DDR speed has
not changed from the MPC7447 to the MPC7447A.  
Given this point, why does increasing the number of
Rx Buffer Descriptors have any affect.
     Thus, I think this first problem is on the 
perifery of what the real problem is.  This leads me
to my next problem, which I think is also on the
perifery.

2.  Transmit Buffer descriptor does not relinquish 
ownership of the descriptor to the processor.

     eth_int_cause 0x00000005 Port-0 
 eth_int_cause_ext 0x00000000 Port-0
      rx queue cmd 0x0003fe01 Port-0  <-----\
         rx status 0x0000042e Port-0         |
      tx queue cmd 0x0000fe00 Port-0  <------|
        rx dropped 0x00000000 Port-0         |
          sdma Cfg 0x00800004 Port-0         |
  SDMA Cause Reg = 0x00000000                |
                                             |
     Here we can see that the Rx Queue and Tx Queue
is enabled.

------mv643xx_private:  ----------
             port num:  0
          port_config:  0x00000000
   port_config_extend:  0x00000000
     port_sdma_config:  0x00800004
  port_serial_control:  0x0164260f
port_tx_queue_command:  0x00000001
port_rx_queue_command:  0x00000001
         rx_sram_addr:  0x00000000
         rx_sram_size:  0x00000000
         tx_sram_addr:  0x00000000
         tx_sram_size:  0x00000000
      rx_resource_err:  0x0
      tx_resource_err:  0x0

-Rx-Buffer-Descriptor:  ----------
             byte_cnt:  0x0068
             buf_size:  0x05f8
   Command and Status:  0x2fc7555e
  Next Descriptor Ptr:  0x00aa8020
           Buffer Ptr:  0x00a81010

mv643xx_eth.c  eth_port_send()  Enableing Tx Queue
-Tx-Buffer-Descriptor:  ----------
             byte_cnt:  0x002a
              l4i_chk:  0x0000
   Command and Status:  0x80f82800
  Next Descriptor Ptr:  0x00aa0030
           Buffer Ptr:  0x1fdba2e2

     Here, the "Command and Status" element in the
Transmit descriptor indicates that the DMA engine 
still owns the descriptor.  I don't see this problem,
running the same software on the MPC7447.
     So, in both error conditions, there is something
screwed up with the DMA engine.  In the first issue,
I was thinking that maybe the increase of descriptors
slowed down the interface enough to make it work, and
on the transmit side, the DMA error still exists.   
     From here, I tryed changing the SDMA config to
0 thus changing the burst size to 1, and I have tried
changing the burst size up to 16.  
     I also tried enabling the Tx Interrupts and only
saw them on the MPC7447, not on the MPC7447A.  Thus,
the DMA engine does not think it has completed a 
transaction.
     I was also curious if anyone has tried using the
internal SRAM in the MV64360?
     In addition, another data point I saw was that 
the tx_packets is incremented when I send out an 
ethernet frame, but the good_frames_sent is not 
incremented.

ethtool -S eth0
NIC statistics:
     rx_packets: 3
     tx_packets: 3
     rx_bytes: 342
     tx_bytes: 126
     rx_errors: 0
     tx_errors: 0
     rx_dropped: 0
     tx_dropped: 0
     good_octets_received: 342
     bad_octets_received: 0
     internal_mac_transmit_err: 0
     good_frames_received: 3
     bad_frames_received: 0
     broadcast_frames_received: 1
     multicast_frames_received: 0
     frames_64_octets: 0
     frames_65_to_127_octets: 2
     frames_128_to_255_octets: 1
     frames_256_to_511_octets: 0
     frames_512_to_1023_octets: 0
     frames_1024_to_max_octets: 0
     good_octets_sent: 0
     good_frames_sent: 0
     excessive_collision: 0
     multicast_frames_sent: 0
     broadcast_frames_sent: 0
     unrec_mac_control_received: 0
     fc_sent: 0
     good_fc_received: 0
     bad_fc_received: 0
     undersize_received: 0
     fragments_received: 0
     oversize_received: 0
     jabber_received: 0
     mac_receive_error: 0
     bad_crc_event: 0
     collision: 0
     late_collision: 0

     Any comments, help, questions or advice would
be greatly appreciated!!

Regards,

Adrian









		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
