Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.5.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E539167B17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Jun 2006 20:16:30 +1000 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5NAGJtl028514
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Jun 2006 12:16:19 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: entry point of kernel in RAM at 0x0c--linux tree file name
Date: Fri, 23 Jun 2006 12:18:14 +0200
References: <edd12c050606220146i57282781o2052679c8f6108ef@mail.gmail.com>
	<200606221735.15761.laurent.pinchart@tbox.biz>
	<edd12c050606230253u5842ea5bvd78d06f0354cb4bd@mail.gmail.com>
In-Reply-To: <edd12c050606230253u5842ea5bvd78d06f0354cb4bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
Message-Id: <200606231218.14788.laurent.pinchart@tbox.biz>
Cc: Arun Kumar <arunkat@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Arun,

please keep the list posted when you reply.

> Thanks for the response .I would also like to ask another query hoever
> naive it might sound .I am using a Linux 2.4.1

That's very old. Can't you upgrade to 2.6 ?

> wherein my entry point 
> code at 0x0c expects at R3 ,R4,R5,R6 some parameters which I strongly
> suspect to be residual record bi_rec *,start of initrd and end of initrd
> sections as my kernel is crashing immediately after  MMU_init and I
> suspect that machine _init that is done prior to  MMU_init expects __res
> in R3 as a input parameter .Please confirm .

Depending on your platform and boot loader, r3 to r7 are initialized with 
different values. If you're using ppcboot, the kernel expects r3 to be 
initialized with the residual record, right.

> I am using ppcboot2..0.0 as my bootloader .

That' very old too. You should upgrade to U-Boot.

> Also I would like to know how can i enable serial console in these early
> kernel initialsaiotns process. I am using a CONFIG_SANDPOINT(8260) on a
> MPC 8245 platform and trying to port the code on MPC8245 platform .the
> board has a very similar config as a SANDPOINT board .

If I'm not mistaken, you can't enable a serial console that early. Do you have 
a hardware debugger (BDI2000) ? If not, you could try LED debugging.

Best regards,

Laurent Pinchart
