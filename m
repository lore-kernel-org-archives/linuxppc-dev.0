Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8C303DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 23:48:15 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KHfSO-0003oL-QB
	for linuxppc-embedded@ozlabs.org; Sat, 12 Jul 2008 06:48:12 -0700
Message-ID: <18419614.post@talk.nabble.com>
Date: Sat, 12 Jul 2008 06:48:12 -0700 (PDT)
From: Alex_SYS <schmid-grafenau@t-online.de>
To: linuxppc-embedded@ozlabs.org
Subject: LIME on MPC5200B ioremap problem
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,
I have an MPC5200B with Linux and an Grafic Chip Lime on the LPB !
The Lime is configured under U-Boot und works very fine in 800x480x16 bit
colors.
In Linux I adapted the Virtual Framebuffer driver! There are only three
things necessary:
   1: check_mem (0xE0000000, 750kB)      ->thats OK
   2: io__mem_request(0xE0000000, 750kB)    ->thats OK , too
   3_ioremap(0xE0000000, 750kB)    ->thats OK , too
   3: write Io request to framebuffers screen_base
The Kernel with Grafics output works fine with 800x350 resolution or 580x480
and so on.
But when I use 800x480, the screen output is OK, But the kernel crashes with
custom trace stop.
I have found out that it must be a ioremap failure, because it has to do
with the space i request!
It works fine if the mem_remap is under 546kB! Exactly it is not the space,
but the upper adress!
Because ioremap(0xE00000860, 500kB) crashes also the Kernel!
It seems like ioremap can`t give me the adresses upper
(0xE00000000+546kB)=0xE00088B80 ?
What can be the problem?
Kernel 2.6.23-rt5 with 16MB Flash and 64MB RAM

Thanks very much!


-- 
View this message in context: http://www.nabble.com/LIME-on-MPC5200B-ioremap-problem-tp18419614p18419614.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
