Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s21.bay0.hotmail.com (bay0-omc3-s21.bay0.hotmail.com
	[65.54.246.221]) by ozlabs.org (Postfix) with ESMTP id F26A3DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 20:03:33 +1000 (EST)
Message-ID: <BAY138-F307C2A2B96F64C7312A86AB2140@phx.gbl>
In-Reply-To: <BAY115-W543A1618F5BCC720DEFE8B2150@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: mamsadegh@hotmail.com
Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
Date: Mon, 25 Jun 2007 10:03:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
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

>The results are as follows:
>PC-->ML403
>TCP_SENDFILE : 38Mbps
>
>ML403--->PC
>TCP_SENDFILE: 155Mbps

This result is unreasonable. Because PC is more powerful than your board, 
so PC->board should be faster than board->PC.

>The transfer rate from ML403 to PC has improved by a factor of 2,
>I see on the posts here in the mailing list that you have reached a band 
width of 301Mbps.

Yes, with all features which could improve performance enabled, we can get 
around 300Mbps for TCP transfer. one more hint, did you enable caches on 
your system? perhaps it will help. Anyway, double check your hardware 
design to make sure all features are enabled.That's all I can suggest.

BR
Ming


>
>
>
>
>----------------------------------------
> > From: eemingliu@hotmail.com
> > To: mamsadegh@hotmail.com; akonovalov@ru.mvista.com; 
linuxppc-embedded@ozlabs.org; grant.likely@secretlab.ca
> > Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
> > Date: Sat, 23 Jun 2007 19:10:16 +0000
> >
> > Use the following command in Linux please:
> >
> > ifconfig eth0 mtu 8982
> >
> > As well you should do that on your PC in the measurement.
> >
> > Ming
> >
> >
> > >From: Mohammad Sadegh Sadri
> > >To: Ming Liu ,
> > ,,
> >
> > >Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
> > >Date: Sat, 23 Jun 2007 19:08:29 +0000
> > >
> > >
> > >Dear Ming,
> > >
> > >Really thanks for reply,
> > >
> > >about thresholds and waitbound OK! I'll adjust them in adapter.c ,
> > >
> > >but what about enabling jumbo frames? should I do any thing special to
> > enable Jumbo fram support?
> > >
> > >we were thinking that it is enabled by default. Is it?
> > >
> > >thanks
> > >
> > >
> > >
> > >
> > >----------------------------------------
> > > > From: eemingliu@hotmail.com
> > > > To: mamsadegh@hotmail.com; akonovalov@ru.mvista.com;
> > linuxppc-embedded@ozlabs.org; grant.likely@secretlab.ca
> > > > Subject: RE: ML403 gigabit ethernet bandwidth - 2.6 kernel
> > > > Date: Sat, 23 Jun 2007 18:48:19 +0000
> > > >
> > > > Dear Mohammad,
> > > > There are some parameters which could be adjusted to improve the
> > > > performance. They are: TX and RX_Threshold TX and RX_waitbound. In 
my
> > > > system, we use TX_Threshold=16 and Rx_Threshold=8 and both 
waitbound=1.
> > > >
> > > > Also Jumbo frame of 8982 could be enable.
> > > >
> > > > Try those hints and share your improvement with us.
> > > >
> > > > BR
> > > > Ming
> > > >
> > > > >From: Mohammad Sadegh Sadri
> > > > >To: Andrei Konovalov , Linux PPC Linux
> > > > PPC, Grant Likely
> > > > >Subject: ML403 gigabit ethernet bandwidth - 2.6 kernel
> > > > >Date: Sat, 23 Jun 2007 12:19:12 +0000
> > > > >
> > > > >
> > > > >Dear all,
> > > > >
> > > > >Recently we did a set of tests on performance of virtex 4FX hard 
TEMAC
> > > > module using ML403
> > > > >
> > > > >we studied all of the posts here carefully: these are the system
> > > > characteristics;
> > > > >
> > > > >Board : ML403
> > > > >EDK    : EDK9.1SP2
> > > > >Hard TEMAC version and PLTEMAC version are both 3.0.a
> > > > >PPC clock frequency :  300MHz
> > > > >Kernel : 2.6.21-rc7 , downloaded from grant's git tree some thing 
near
> > one
> > > > week ago
> > > > >DMA type: 3 (sg dma)
> > > > >DRE : enabled for TX and RX, (2)
> > > > >CSUM offload is enabled for both of TX and RX
> > > > >tx and rx fifo sizes : 131072 bits
> > > > >
> > > > >the board comes up over NFS root file system completely and 
without
> > any
> > > > problems.
> > > > >
> > > > >PC system used for these tests is : CPU P4 Dual Core, 3.4GHz ,
> > 2Gigabytes
> > > > memory, Dual gigabit ethernet port, running linux 2.6.21.3
> > > > >We have tested the PC system band width and it can easily reach
> > 966mbits/s
> > > > when connected to the same PC. ( using the same cross cable used 
for
> > ml403
> > > > test)
> > > > >
> > > > >Netperf is compiled with TCP SEND FILE enabled, ( -DHAVE_SENDFILE)
> > > > >
> > > > >(from board to PC)
> > > > >netperf -t TCP_SENDFILE -H 10.10.10.250 -F /boot/zImage.elf -- -m
> > 16384 -s
> > > > 87380 -S 87380
> > > > >
> > > > >the measured bandwidth for this test was just 40.66Mbits.
> > > > >It is also true for netperf from PC to board.
> > > > >
> > > > >we do not have any more idea about what we should do to improve 
the
> > > > bandwidth.
> > > > >any help or ideas is appreciated...
> > > > >
> > > > >_________________________________________________________________
> > > > >Connect to the next generation of MSN
> > > >
> > 
Messenger?>http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline

> >
> > > >
> > > > >_______________________________________________
> > > > >Linuxppc-embedded mailing list
> > > > >Linuxppc-embedded@ozlabs.org
> > > > >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > > >
> > > > _________________________________________________________________
> > > > 免费下载 MSN Explorer:   http://explorer.msn.com/lccn/
> > > >
> > >
> > >_________________________________________________________________
> > >News, entertainment and everything you care about at Live.com. Get it 
now!
> > >http://www.live.com/getstarted.aspx
> >
> > _________________________________________________________________
> > 免费下载 MSN Explorer:   http://explorer.msn.com/lccn/
> >
>
>_________________________________________________________________
>Discover the new Windows Vista
>http://search.msn.com/results.aspx?q=windows+vista&mkt=en-US&form=QBRE

_________________________________________________________________
免费下载 MSN Explorer:   http://explorer.msn.com/lccn/  
