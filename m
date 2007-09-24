Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05D32DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 02:56:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8OFm5ov010399
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 11:48:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8OGuBJm490898
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 10:56:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8OGuAlC011812
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 10:56:10 -0600
Date: Mon, 24 Sep 2007 11:56:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Manil Gaouar" <mgaouar@solacom.com>
Subject: Re: Problems compiling Linux for MPC8272ADS
Message-ID: <20070924115608.1625e5ec@weaponx.rchland.ibm.com>
In-Reply-To: <9A1468054ED2FD40907CC3B2C1871D400106CC90@hermes.versatel.com>
References: <9A1468054ED2FD40907CC3B2C1871D400106CC90@hermes.versatel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Sep 2007 12:26:24 -0400
"Manil Gaouar" <mgaouar@solacom.com> wrote:

> Hi there,
> 
> I am trying to compile the latest Linux from the git repos: git clone
> git://www.denx.de/git/linux-2.6-denx.git linux-2.6-denx, I checked out
> the code a few weeks ago and was able to build my uImage no problems. I
> did a git pull this morning and I can not compile anymore, here is the
> error message I have:
> 
>   BOOTCC  arch/powerpc/boot/ps3.o
>   BOOTCC  arch/powerpc/boot/treeboot-bamboo.o
>   BOOTCC  arch/powerpc/boot/cuboot-sequoia.o
>   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> {standard input}: Assembler messages:
> {standard input}:184: Error: Unrecognized opcode: `mfdcr'
> {standard input}:185: Error: Unrecognized opcode: `mfdcr'
> {standard input}:186: Error: Unrecognized opcode: `mfdcr'
> {standard input}:217: Error: Unrecognized opcode: `mtdcr'
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
> make: *** [uImage] Error 2
> 
> here are the commands I am using:
> 
> make mrproper
> make ARCH=powerpc CROSS_COMPILE=ppc_6xx- mpc8272_ads_defconfig
> make ARCH=powerpc CROSS_COMPILE=ppc_6xx- uImage
> 
> Do you have any ideas, or I should check out the 2.6.22 stable release
> instead and try again???

Apply this:


    [POWERPC] 4xx: Fix Walnut wrapper compile errors
    
    Pass the appropriate -mcpu flag to the treeboot-walnut.o object to prevent
    some toolchains from erroring out with unknown opcodes
    
    Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c1582b6..ac516a1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -33,6 +33,7 @@ BOOTCFLAGS    += -I$(obj) -I$(srctree)/$(obj)
 
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
+$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
