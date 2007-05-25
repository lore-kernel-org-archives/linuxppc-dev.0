Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90472DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 22:24:34 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HrYqN-0003PS-DP
	for linuxppc-embedded@ozlabs.org; Fri, 25 May 2007 05:24:31 -0700
Message-ID: <10801964.post@talk.nabble.com>
Date: Fri, 25 May 2007 05:24:31 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <10681348.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com> <10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
	<4640F08E.5040608@nec.com.au>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
	<10409434.post@talk.nabble.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
	<10429898.post@talk.nabble.com> <10621564.post@talk.nabble.com>
	<4649A7AC.1050503@ru.mvista.com>
	<Pine.LNX.4.44.0705151430120.7758-100000@slslc02.psi.ch>
	<4649F6FF.7060003@ru.mvista.com>
	<Pine.LNX.4.44.0705152027280.16487-100000@slslc02.psi.ch>
	<10681348.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

          I have done more research on the problem with my ml403 board.
I use linux 2.6.21rc6 by Grant. I have configured the kernel to mount the
rootfile system via NFS.
The kernel boots properly up to the point to execute init.

My Last observation is as following.

I have written my own statically build init just to printf some strings to
the screen. The message is printed as expected. The size of my executable is
around 520 Kbytes.
When I have added more code to have a bigger executable I reached the point
when my init was sometimes executed and some times not (ie. the system
hanged and ping did not work) . This happens when the executable is around
647 Kbytes large.

I have aslo noticed that when the code is bigger than 700 Kbytes the system
hangs always.

To have more evidence I have compiled klibc rootfile system which is very
small but it uses dynamically linked library libc.so which is around 111
Kbytes. In such a case the init was executed fine so it seems to be the
problem of the file size the system is going to execute (load via NFS).

I suspect that it is the Temac which causes the problem. I do not however
know it is possible to adjust some temac parameters like the FIFOs size or
so. Maybe it is the Temac driver? 
It could be also that NFS client server communication which brakes due to
unknown reason. My eteral program which I used to monitor the network
traffic on the NFS server shows that NFS server works all the time and it
sends periodically the packets to the client even if the client hags. 
 
Would you have some idea what could be wrong?

Best Regards

Mirek


Mirek23 wrote:
> 
>> Anyway, you could try adding
>>    nfsroot=,rsize=1024,wsize=1024
>> to your cmdline just in case...
> 
> I have tried that but it did not help :(
> 
> Best Regards
> 
> Mirek
> 

-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10801964
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
