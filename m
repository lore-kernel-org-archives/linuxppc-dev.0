Return-Path: <Peter.Ryser@xilinx.com>
Received: from mail40-R-kan.bigfish.com (mail-kan.bigfish.com [63.161.60.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F0D0E2BD46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Oct 2004 16:01:08 +1000 (EST)
Date: Mon, 25 Oct 2004 22:39:30 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
In-reply-to: <35fb2e59041025140776cfe174@mail.gmail.com>
To: jonathan@jonmasters.org
Message-id: <417DE312.6070405@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <1098701468l.31592l.0l@ipnnarval> <417D2B5E.8050200@xilinx.com>
	<35fb2e59041025140776cfe174@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: uboot and ppc405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>This appnote assumes that he's using the ML300, has the Montavista
>tree, and a few other general assumptions that might well not be true
>here, but is otherwise interesting if they decide to heed our
>suggestions of using the SystemACE in the design.
>
The app note concentrates on one example, however, it is generic enough 
and applies to different setups. The MontaVista Linux preview kit for 
the ML300 is free but you can use other distributions if you wish to do 
so. The only thing you need for u-boot is the PowerPC cross-compiler. 
You can use the cross-compiler that ships with EDK, however, I do not 
recommend it as it is set up for a different environment than for Linux 
and/or U-Boot and it will expect files like boot.o and libxil.a...

Other boards than the ML300 can be used, too. If you look at the 
repository layout in U-Boot there is space for other boards than the 
ML300. I'm sure Wolfgang will appreciate contributions and ports to 
different boards.

>btw Peter, I've been moaning about the weird interrupt behaviour of
>the SysACE on e.g. the Memec board for some time (see archives for
>various other people's experiences too) - and I've spoken to several
>folks at Xilinx without getting very far. If there's a fundamental
>problem then it probably makes sense for us to help get it fixed.
>
Hmm, I'm not aware of any interrupt problems with System ACE CF. For 
Linux it works for a long time unchanged as published in the 
linuxppc_2_4_devel and linuxppc-2.4 repositories. I'm operating my own 
web and mail server on a V2P based board using a 1GB MicroDrive through 
System ACE CF as the root and swap filesystems. The system is up and 
running for months now. No special tricks or hacks just a 
straight-forward EDK FPGA design with a MVL kernel.

There is now a MVL preview kit for the Memec board. You might want to 
try it out and see whether the problems you observe persist.

Looking at the postings back in April I can only say that I never saw 
any similar problems. Please let me know if you have a specific test 
case where you see problems and I'll be glad to look at it.

The implementation of System ACE CF functionality in U-Boot is written 
for polled operation. In that case Stephen Williams wrote the actual 
driver and we decided not to publish our own driver but reuse his.

- Peter
