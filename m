Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2D19DDE44
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 00:36:00 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HhRYC-00045d-Jc
	for linuxppc-embedded@ozlabs.org; Fri, 27 Apr 2007 07:35:56 -0700
Message-ID: <10220160.post@talk.nabble.com>
Date: Fri, 27 Apr 2007 07:35:56 -0700 (PDT)
From: tacitus <mark.mueller@haag-streit.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 ethernet communication stops unexpected
In-Reply-To: <462912AC.8090102@berghof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <462912AC.8090102@berghof.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hallo Eberhard, 

I've the same problem by running MPC5200B, but under MQX ...
But my first question, can we chat via german ?

ciao
  mark 


Eberhard Stoll wrote:
> 
> Hello,
> can someone help me?
> I have some problem with our MPC5200 board running denx linux kernel 
> 2.4.25 with ethernet communication.
> 
> My problem is that our board stops receiving and transmitting any 
> ethernet frames suddenly and unexpected. No pings - nothing is getting 
> thru the ethernet any more! The rest of the controller is running well.
> This situation is very rare - only a constellation with 6 Controllers 
> and a special ethernet communication load leads to this fault - in about 
> one day!
> 
> When i check how many tx and rx buffers are used in the BestComm buffer 
> descriptor ring (via TaskBDInUse() call) which hold pointers to transmit 
> and receive data, i see all tx and rx buffers are in use! When i look at 
> the FEC Tx Fifo Status Register i get the value 0x00030000. This means 
> FEC Tx Fifo empty!
> When i check fec Task Control register i see Tx and Rx Task are enabled, 
> current Pointer register points to 0xF000828C which belongs to FEC Tx 
> BestComm Microcode.
> When i now examine the status value of my currently active buffer 
> descriptor for Tx task, it shows that this buffer belongs to BestComm.
> In my opinion BestComm shold tranfer this buffer to the empty FEC Tx 
> Fifo - but it doesn't!
> Now the question for me is: WHY?
> 
> Do i oversee some bits in the registers/ram locations which lead to this 
> situation?
> I don't know much about BestComm/FEC, but my conclusion out of this is 
> BestComm is stuck somewhere out of some reason. Is this a hardware 
> issue? Does someone know? Has someone similar problems?
> 
> Can someone help me or check if i'm right with my conclusion (see 
> registers and ram locations down)? Or give me a hint where to look
> further.
> Any help is very welcome!
> 
> Many Thanks,
> Eberhard
> 
> PS: I saw this problem only on MPC5200B processors until now. And we use 
> BestComm Api 2.2 (the newest denx 2.4.x code for bestcomm)
> 
> Here are some registers and ram addresses i collected in this situation:
> 
> BTW: I saw BestComm Microcode changing in 16k SRAM after the first 
> Ethernet frames were sent. This seems very strange to me - but maybe is 
> correct behaviour - i don't know. Does someone of you?
> Its the address 0xf00082e8 (in FEC Tx BestComm microcode). After reset 
> (no frame sent) the ram at this address is 0x088AC398 after the first(?) 
> ethernet frame it's 0x0C8AC398!
> 
> === BestComm registers ===
> taskBar         0xF0008000
> currentPointer  0xF000828C
> endPointer      0x00000000
> variablePointer 0xF0008800
> IntVect1        0x0000000F
> IntVect2        0x0000000F
> PtdCntrl        0x00000001
> IntPend         0x00000000
> IntMask         0xFFFFFFF3
> tcr_0 0x0000
> tcr_1 0x0000
> tcr_2 0xE082
> tcr_3 0xC383
> tcr_4 0x0000
> tcr_5 0x0000
> tcr_6 0x0000
> tcr_7 0x0000
> tcr_8 0x0000
> tcr_9 0x0000
> tcr_a 0x0000
> tcr_b 0x0000
> tcr_c 0x0000
> tcr_d 0x0000
> tcr_e 0x0000
> tcr_f 0x0000
> IPR0  0x07
> IPR1  0x00
> IPR2  0x00
> IPR3  0x04
> IPR4  0x03
> IPR5  0x06
> IPR6  0x05
> IPR7  0x00
> IPR8  0x00
> IPR9  0x00
> IPR10 0x00
> IPR11 0x00
> IPR12 0x00
> IPR13 0x00
> IPR14 0x00
> IPR15 0x00
> IPR16 0x00
> IPR17 0x00
> IPR18 0x00
> IPR19 0x00
> IPR20 0x00
> IPR21 0x00
> IPR22 0x00
> IPR23 0x00
> IPR24 0x00
> IPR25 0x00
> IPR26 0x00
> IPR27 0x00
> IPR28 0x00
> IPR29 0x00
> IPR30 0x00
> IPR31 0x00
> task_size0 0x00000000
> task_size1 0x00000000
> MDEDebug   0x01000008
> ADSDebug   0x00000000
> Value1     0x00000000
> Value2     0x00000000
> Control    0x00000000
> Status     0x00000000
> EU00 0x04155519
> EU01 0x00000000
> EU02 0x00000000
> EU03 0x00000000
> EU04 0x00000000
> EU05 0x00000000
> EU06 0x00000000
> EU07 0x00000000
> EU10 0x00000000
> EU11 0x00000000
> EU12 0x00000000
> EU13 0x00000000
> EU14 0x00000000
> EU15 0x00000000
> EU16 0x00000000
> EU17 0x00000000
> EU20 0x00000000
> EU21 0x00000000
> EU22 0x00000000
> EU23 0x00000000
> EU24 0x00000000
> EU25 0x00000000
> EU26 0x00000000
> EU27 0x00000000
> EU30 0x00000000
> EU31 0x00000000
> EU32 0x00000000
> EU33 0x00000000
> EU34 0x00000000
> EU35 0x00000000
> EU36 0x00000000
> EU37 0x00000000
> 
> === Return values of BestComm Api Functions ===
> t_tasknum          = 2
> TaskBDInUse(tx)    = 256
> TaskStatus(tx)     = run (0x00008000)
> TaskIntPending(tx) = 0
> r_tasknum          = 3
> TaskBDInUse(rx)    = 256
> TaskStatus(rx)     = run (0x00008000)
> TaskIntPending(rx) = 0
> TasksGetSramOffset = 0x00002500
> task  0:  stop int: 0x00000000
> task  1:  stop int: 0x00000000
> task  2:  run  int: 0x00000000
> task  3:  run  int: 0x00000000
> task  4:  stop int: 0x00000000
> task  5:  stop int: 0x00000000
> task  6:  stop int: 0x00000000
> task  7:  stop int: 0x00000000
> task  8:  stop int: 0x00000000
> task  9:  stop int: 0x00000000
> task 10:  stop int: 0x00000000
> task 11:  stop int: 0x00000000
> task 12:  stop int: 0x00000000
> task 13:  stop int: 0x00000000
> task 14:  stop int: 0x00000000
> task 15:  stop int: 0x00000000
> 
> === FEC Registers ===
> fec base addr f0003000
> fec_id        0x00000000
> ievent        0x08000000
> imask         0xF0FE0000
> r_des_active  0x00000000
> x_des_active  0x00000000
> ecntrl        0xF0000002
> mii_data      0x5F821200
> mii_speed     0x0000001C
> mib_control   0x40000000
> r_cntrl       0x05EE0024
> r_hash        0x8A000000
> x_cntrl       0x00000004
> paddr1        0x00E0BA90
> paddr2        0x07DC8808
> op_pause      0x00010020
> iaddr1        0x00000000
> iaddr2        0x00000000
> gaddr1        0x00400000
> gaddr2        0x00000000
> x_wmrk        0x00000000
> rfifo_status  0x214E0000
> rfifo_cntrl   0x0F240000
> rfifo_lrf_ptr 0x0000005D
> rfifo_lwf_ptr 0x0000038D
> rfifo_alarm   0x0000030C
> rfifo_rdptr   0x0000005D
> rfifo_wrptr   0x0000005D
> tfifo_status  0x00030000
> tfifo_cntrl   0x0F200000
> tfifo_lrf_ptr 0x0000023C
> tfifo_lwf_ptr 0x0000023C
> tfifo_alarm   0x00000100
> tfifo_rdptr   0x0000023C
> tfifo_wrptr   0x0000023C
> reset_cntrl   0x01000000
> xmit_fsm      0x03000000
> 
> === FEC driver vars ===
> MBAR           0xF0000000
> MBAR SIZE      0x10000000
> queue_stopped  1
> mpc5xxx_bdi_tx 73 (x49)
> mpc5xxx_bdi_rx 97 (x61)
> adr(tx_fifo_skb)       c0233744
> adr(tx_fifo_skb[0])    c0233744
> adr(tx_fifo_skb[1])    c0233748
> tx_fifo_skb[0]         c2474f20
> tx_fifo_skb[1]         c24846e0
> sizeof(tx_fifo_skb)    1024
> sizeof(tx_fifo_skb[0]) 4
> MPC5xxx_FEC_TBD_NUM    256
> adr(rx_fifo_skb)       c0233b44
> sizeof(rx_fifo_skb)    1024
> sizeof(rx_fifo_skb[0]) 4
> MPC5xxx_FEC_RBD_NUM    256
> full_duplex    1
> tx_full        1
> r_tasknum      3
> t_tasknum      2
> r_irq          24
> t_irq          23
> last_transmit_time 0
> last_receive_time 0
> phy_id         0x0015F442
> phy_id_done    1
> phy_status     0x00000000
> phy_speed      28
> sequence_done  0
> link           0
> duplex_change  0
> link_up        0
> old_status     0x00000000
> 
> === BDHead Table ===
> TASK #0
> [0xC0232D74] = 0x00
> [0xC0232D75] = 0x00
> [0xC0232D76] = 0x00
> [0xC0232D77] = 0x00
> 
> TASK #1
> [0xC0232D78] = 0x00
> [0xC0232D79] = 0x00
> [0xC0232D7A] = 0x00
> [0xC0232D7B] = 0x00
> 
> TASK #2 - tx task
> [0xC0232D7C] = 0x00
> [0xC0232D7D] = 0x00
> [0xC0232D7E] = 0x00
> [0xC0232D7F] = 0x49
> --> actual tx index: 0x49->73
> 
> TASK #3 - rx task
> [0xC0232D80] = 0x00
> [0xC0232D81] = 0x00
> [0xC0232D82] = 0x00
> [0xC0232D83] = 0x61
> --> actual rx index: 0x61->97
> 
> [0xC0232D84] = 0x00
> [0xC0232D85] = 0x00
> [0xC0232D86] = 0x00
> ...
> 
> === TaskBDIdxTable ===
> TASK#0
> numBD      [0xC0232DF4] = 0x0000
> numPtr     [0xC0232DF6] = 0x00
> apiConfig  [0xC0232DF7] = 0x00
> BDTablePtr [0xC0232DF8] = 0x00000000
> BDStartPtr [0xC0232DFC] = 0x00000000
> currBDInUse[0xC0232E00] = 0x0000
> [0xC0232E02] = 0x00
> [0xC0232E03] = 0x00
> 
> TASK#1
> [0xC0232E04] = 0x00
> [0xC0232E05] = 0x00
> [0xC0232E06] = 0x00
> [0xC0232E07] = 0x00
> [0xC0232E08] = 0x00
> [0xC0232E09] = 0x00
> [0xC0232E0A] = 0x00
> [0xC0232E0B] = 0x00
> [0xC0232E0C] = 0x00
> [0xC0232E0D] = 0x00
> [0xC0232E0E] = 0x00
> [0xC0232E0F] = 0x00
> [0xC0232E10] = 0x00
> [0xC0232E11] = 0x00
> [0xC0232E12] = 0x00
> [0xC0232E13] = 0x00
> 
> TASK#2 - tx task
> numBD      [0xC0232E14] = 0x0100
> numPtr     [0xC0232E16] = 0x01
> apiConfig  [0xC0232E17] = 0x01
> BDTablePtr [0xC0232E18] = 0xF0009D00
> BDStartPtr [0xC0232E1C] = 0xF0008814
> currBDInUse[0xC0232E20] = 0x0100
> [0xC0232E22] = 0x00
> [0xC0232E23] = 0x00
> 
> TASK#3 - rx task
> numBD      [0xC0232E24] = 0x0100
> numPtr     [0xC0232E26] = 0x01
> apiConfig  [0xC0232E27] = 0x00
> BDTablePtr [0xC0232E28] = 0xF0009500
> BDStartPtr [0xC0232E2C] = 0xF0008890
> currBDInUse[0xC0232E30] = 0x0100
> [0xC0232E32] = 0x00
> [0xC0232E33] = 0x00
> 
> TASK#4
> [0xC0232E34] = 0x00
> [0xC0232E35] = 0x00
> ...
> 
> === Tx Descriptor Ring ===
> IDX 0x49-(73) is interesting, because active (see BDHeadTable).
> So our descriptor is as Addr 0xF0009D00 + (0x49 * 0x8) = 0xF0009F48
> 
> IDX 0
> [0xF0009D00] = 0x4C00003C
> [0xF0009D04] = 0x02475922
> 
> IDX 1
> [0xF0009D08] = 0x4C00003C
> [0xF0009D0C] = 0x02475CA2
> ...
> IDX 72
> [0xF0009F40] = 0x4C00003C
> [0xF0009F44] = 0x024665A2
> 
> IDX 73 - active descriptor
> [0xF0009F48] = 0x4C00004E  - owns BestComm, should transfer
> [0xF0009F4C] = 0x0243F05E
> 
> IDX 74
> [0xF0009F50] = 0x4C00004E
> [0xF0009F54] = 0x0243F85E
> 
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email 
> ______________________________________________________________________
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/MPC5200-ethernet-communication-stops-unexpected-tf3620140.html#a10220160
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
