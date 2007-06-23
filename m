Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s28.bay0.hotmail.com (bay0-omc1-s28.bay0.hotmail.com
	[65.54.246.100]) by ozlabs.org (Postfix) with ESMTP id A6085DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jun 2007 04:48:22 +1000 (EST)
Message-ID: <BAY138-F31999DB9BAF195D66870A2B2160@phx.gbl>
In-Reply-To: <BAY115-W1188529D49F71948165AF6B2160@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: mamsadegh@hotmail.com, akonovalov@ru.mvista.com,
	linuxppc-embedded@ozlabs.org, grant.likely@secretlab.ca
Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
Date: Sat, 23 Jun 2007 18:48:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Mohammad,
There are some parameters which could be adjusted to improve the 
performance. They are: TX and RX_Threshold TX and RX_waitbound. In my 
system, we use TX_Threshold=16 and Rx_Threshold=8 and both waitbound=1.

Also Jumbo frame of 8982 could be enable.

Try those hints and share your improvement with us.

BR
Ming

>From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
>To: Andrei Konovalov <akonovalov@ru.mvista.com>, Linux PPC Linux 
PPC<linuxppc-embedded@ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>
>Subject: ML403 gigabit ethernet bandwidth - 2.6 kernel 
>Date: Sat, 23 Jun 2007 12:19:12 +0000
>
>
>Dear all,
>
>Recently we did a set of tests on performance of virtex 4FX hard TEMAC 
module using ML403
>
>we studied all of the posts here carefully: these are the system 
characteristics;
>
>Board : ML403
>EDK    : EDK9.1SP2
>Hard TEMAC version and PLTEMAC version are both 3.0.a
>PPC clock frequency :  300MHz
>Kernel : 2.6.21-rc7 , downloaded from grant's git tree some thing near one 
week ago
>DMA type: 3 (sg dma)
>DRE : enabled for TX and RX, (2)
>CSUM offload is enabled for both of TX and RX
>tx and rx fifo sizes : 131072 bits
>
>the board comes up over NFS root file system completely and without any 
problems.
>
>PC system used for these tests is : CPU P4 Dual Core, 3.4GHz , 2Gigabytes 
memory, Dual gigabit ethernet port, running linux 2.6.21.3
>We have tested the PC system band width and it can easily reach 966mbits/s 
when connected to the same PC. ( using the same cross cable used for ml403 
test)
>
>Netperf is compiled with TCP SEND FILE enabled, ( -DHAVE_SENDFILE)
>
>(from board to PC)
>netperf -t TCP_SENDFILE -H 10.10.10.250 -F /boot/zImage.elf -- -m 16384 -s 
87380 -S 87380
>
>the measured bandwidth for this test was just 40.66Mbits.
>It is also true for netperf from PC to board.
>
>we do not have any more idea about what we should do to improve the 
bandwidth.
>any help or ideas is appreciated...
>
>_________________________________________________________________
>Connect to the next generation of MSN 
Messenger?>http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline

>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
