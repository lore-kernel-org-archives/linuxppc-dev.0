Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8AEF467B94
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Sep 2006 05:22:43 +1000 (EST)
Message-ID: <44F9D8EF.6010101@s5r6.in-berlin.de>
Date: Sat, 02 Sep 2006 21:18:07 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost> <20060824192200.GA2715@localhost>
In-Reply-To: <20060824192200.GA2715@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, billfink@mindspring.com,
	linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer wrote on 2006-08-24:
> On Wed, Aug 23, 2006 at 02:28:01AM +0200, Wolfgang Pfeiffer wrote:
>> Some tests on the Alubook:
> 
> 
> .. but this time with "modprobe ieee1394 disable_irm=1". 2 logs were be
> created: 
> www.wolfgangpfeiffer.com/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
> www.wolfgangpfeiffer.com/disable-irm.kern.log.with.gscanbus.after.failed.fw.connection.txt

Thanks for all the logs, and sorry for the delay.

What happens is that the ieee1394 base driver or gscanbus via raw1394 
are able to read from the beginning of the ROM, but the disk's bridge 
does not send response packets anymore at some random point. In the 
first log, it happens at ROM offset ffff f000 0448, in the second at 
ffff f000 0414, in the third at ffff f000 042c, in the fourth at ffff 
f000 0494. The bridge still ack'ed the last attempted read requests with 
"ack_pending" like each previous successful read request, but suddenly 
it does not follow up with a response.

Unfortunately I cannot see how to cure the problem. There is no 
indication at all why the disk stops to respond at random points after 
the first chunks of the ROM were transferred OK. It is not extremely 
surprising; after all the Datafab's bridge is a pretty old one from 
before IEEE 1394a-2000. Nevertheless it should work OK with the 
1394b-2002 PowerBook since the enclosure even has a 1394a-2000 PHY. I 
think I already mentioned that I have a similar pre-1394a CD-RW which 
works well on a 1394b card.

Alas I am out of ideas. Perhaps you should purchase a new enclosure. 
Before you do that, you could test the AluBook running Linux and TiBook 
in target disk mode again to exclude the possibility of problems at the 
AluBook's side. Use "hdparm -tT /dev/sda" to try a few actual block read 
operations. This should show about 20 MByte/s. It is a read-only test 
and therefore safe.

BTW, I saw one thing in your logs which you are certainly not interested 
in at all. :-) We seem to have an endianess bug in 
ohci1394.c::dma_rcv_tasklet's DBGMSG. My attempt to fix the printout of 
tlabels last year didn't get it completely right. 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dfe547ab872951949a1a2fcc5cedbedad27a2fe5
I think the cond_le32_to_cpu has to be omitted there.
-- 
Stefan Richter
-=====-=-==- =--= ---=-
http://arcgraph.de/sr/
