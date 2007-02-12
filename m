Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s27.bay0.hotmail.com (unknown [65.54.246.99])
	by ozlabs.org (Postfix) with ESMTP id AC2BADDE36
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 07:39:49 +1100 (EST)
Message-ID: <BAY110-F12D0418ECF77BF45266984B2910@phx.gbl>
In-Reply-To: <20070212194619.03083EA0097@mail91-dub.bigfish.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Rick.Moleres@xilinx.com
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Mon, 12 Feb 2007 20:39:47 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Rick,
Thanks for your kindly telling once more. :)

>GSRD is a reference design intended to exhibit high-performance gigabit
>rates.  It offloads the data path of the Ethernet traffic from the PLB
>bus, under the assumption that the arbitrated bus is best used for other
>things (control, other data, etc...).  With Linux, however, GSRD still
>only achieves slightly more than 500Mbps TCP.  We see similar numbers
>with PLB TEMAC, and with other stacks we see similar numbers as GSRD as
>well (e.g., Treck).  The decision points for using GSRD would be a) what
>else needs to happen on the PLB in your system, and b) Xilinx support.
>GSRD is a reference design, so it's not officially supported through the
>Xilinx support chain.  However, many of its architectural concepts are
>being considered for future EDK IP (sorry, no timeframe).  For now, I
>recommend PLB TEMAC because it's part of the EDK, supported, and gets as
>good performance in most use cases.

Well. This time I am totally clear on the concept of GSRD. That's, if I 
have other tasks which use PLB Bus a lot, it will release the network 
traffic from the PLB and then improve the network performance, right? So I 
would like to agree with you: in my system, I choose PLB_TEMAC. 


>Note that Linux only supports zero-copy on the transmit side (i.e.,
>sendfile), not on the receive side.  I'm not going to recommend one RTOS
>or network stack over another.  Treck is a general purpose TCP/IP stack
>that can be used in a standalone environment or in various RTOS
>environments (I think).  We've found that Treck, in the case where it is
>used without an RTOS, is a higher performing stack than the Linux stack.
>The VxWorks stack is also good, and Linux (of the three I've mentioned)
>seems to be the slowest.  Again, it's possible that the Linux stack
>could be tuned better, but we haven't taken the time to try this.

I just read some documents on sendfile() and have understanded some. So I 
tried to use TCP_SENDFILE in netperf at this time. With TCP_SENDFILE 
option, I can achieve a higher TX performance of 301.4Mbps for TCP. 
(without TCP_SENDFILE, it's 213.8Mbps. improved by almost 50%) For RX there 
is no difference with or without TCP_SENDFILE (278Mbps), which shows that 
Linux only supports zero-copy on the TX side as you mentioned. 

Then till now, my best performance for TCP is TX(301Mbps) and RX(278Mbps). 
There is still a long distance from your result (TX of 550Mbps). In my 
system, everything is the same as yours (PLB_TEMAC v3.00, SGDMA, TX/RX DRE 
and CSUM offload, 16k TX/RX FIFO, 300Mhz CPU) except that I am using the 
opensource linux other than MontaVista linux 4.0. Will Montavista Linux 
lead to such a much higher performance? Or what's the real reason why my 
performance is yet not so high as yours? I will appreciate a lot if you can 
give me more hints.

BTW, for your result of TX 550Mbps, did you just use the Linux stack or 
include the Treck one? 

Thanks again for your time and kindly help.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
