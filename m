Date: Wed, 11 Feb 2004 17:15:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: stefano.gaiotto@tin.it, Andrew Morton <akpm@osdl.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Fix MPC82xx thinko (Was: Re: Linux 2.6.2 & MPC8260)
Message-ID: <20040212001558.GH19676@smtp.west.cox.net>
References: <401989520000FA56@ims4c.cp.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <401989520000FA56@ims4c.cp.tin.it>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Feb 11, 2004 at 03:16:12PM +0100, stefano.gaiotto@tin.it wrote:

> I'm trying to build Linux kernel 2.6.2 for some evaluation board with Motorola
> '8260, e.g. est8260.
> I'm using the following environment:
[snip]
> But after a few minutes the compiler stopps reporting the error:
>
>   AS      arch/ppc/kernel/head.o
> arch/ppc/kernel/head.S: Assembler messages:
> arch/ppc/kernel/head.S:1660: Error: unsupported relocation against MSR_
> make[1]: *** [arch/ppc/kernel/head.o] Error 1
> make: *** [arch/ppc/kernel] Error 2

Andrew, can you please apply the following patch?  Thanks.

--- 1.40/arch/ppc/kernel/head.S	Wed Feb  4 20:44:27 2004
+++ edited/arch/ppc/kernel/head.S	Wed Feb 11 17:14:53 2004
@@ -1657,7 +1657,7 @@
 	andc	r11, r11, r10
 	mtspr	HID0, r11
 	isync
-	li	r5, MSR_
+	li	r5, MSR_ME|MSR_RI
 	lis	r6,2f@h
 	addis	r6,r6,-KERNELBASE@h
 	ori	r6,r6,2f@l

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
