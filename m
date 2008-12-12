Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 221D7DE06F
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 11:21:31 +1100 (EST)
Message-Id: <B30D7386-C6C7-4B16-A947-09EB08D1C514@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ron Madrid <ron_madrid@sbcglobal.net>
In-Reply-To: <683138.71397.qm@web83507.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Problem building kernel
Date: Thu, 11 Dec 2008 18:21:26 -0600
References: <683138.71397.qm@web83507.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2008, at 5:48 PM, Ron Madrid wrote:

> Hello all,
>
> I got the latest kernel from git://git.denx.de/linux-2.6-denx.git  
> and after
> configuring with menuconfig I am seeing these errors.  I feel like  
> this
> could be something simple that I am just unaware of, but I'm not sure
> and haven't been able to find anything useful when doing a web search.
>
> Any ideas?  What other information would be helpful?
>
>  BOOTCC  arch/powerpc/boot/redboot-83xx.o
>  BOOTCC  arch/powerpc/boot/cuboot-sam440ep.o
>  BOOTCC  arch/powerpc/boot/cuboot-acadia.o
> {standard input}: Assembler messages:
> {standard input}:278: Error: Unrecognized opcode: `mtdcr'
> {standard input}:282: Error: Unrecognized opcode: `mfdcr'
> {standard input}:289: Error: Unrecognized opcode: `mtdcr'
> {standard input}:293: Error: Unrecognized opcode: `mfdcr'
> {standard input}:312: Error: Unrecognized opcode: `mtdcr'
> {standard input}:316: Error: Unrecognized opcode: `mfdcr'
> make[2]: *** [arch/powerpc/boot/cuboot-acadia.o] Error 1
> make[1]: *** [zImage] Error 2
> make: *** [sub-make] Error 2
>
> Ron

Try the following patch:

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8fc6d72..483f78d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -39,6 +39,7 @@ DTS_FLAGS     ?= -p 1024

  $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
  $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
+$(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
  $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
  $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
  $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
