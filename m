Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id B918967A45
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 22:22:13 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so208167wri
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 03:22:10 -0800 (PST)
Message-ID: <4240b916050121032230b9c5dc@mail.gmail.com>
Date: Fri, 21 Jan 2005 12:22:10 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050120231442.GE2626@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
	<4240b9160501101014317b8d85@mail.gmail.com>
	<20050110182940.GA3391@smtp.west.cox.net>
	<4240b91605011010593d2f3b3d@mail.gmail.com>
	<20050110191248.GB3391@smtp.west.cox.net>
	<4240b91605011011314bb06814@mail.gmail.com>
	<4240b91605011211101ed322a8@mail.gmail.com>
	<20050120231442.GE2626@smtp.west.cox.net>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Jan 2005 16:14:42 -0700, Tom Rini <trini@kernel.crashing.org> wrote:
> On Wed, Jan 12, 2005 at 08:10:58PM +0100, Jerome Glisse wrote:
> 
> > Wanted to know what is going on with CONFIG_6xx?  You will use
> > my patch or do you have another better way ? :)
> 
> Can you resend it please?
> 

Here is another version (the previous one used ifdef to comment
out function call but i read somewhere that this doesn't follow
codeguideline). Anyway i think that my patch is a ugly hack.

Signed-off-by: Jerome Glisse <j.glisse@gmail.com>

best,
Jerome Glisse



diff -Naur linux/arch/ppc/boot/simple/misc-prep.c
linux-2.6.10/arch/ppc/boot/simple/misc-prep.c
--- linux/arch/ppc/boot/simple/misc-prep.c	2004-12-24 22:33:51.000000000 +0100
+++ linux-2.6.10/arch/ppc/boot/simple/misc-prep.c	2005-01-21
12:09:50.976426672 +0100
@@ -34,7 +34,11 @@
 extern void serial_fixups(void);
 extern struct bi_record *decompress_kernel(unsigned long load_addr,
 		int num_words, unsigned long cksum);
+#ifdef CONFIG_6XX
 extern void disable_6xx_mmu(void);
+#elif
+void disable_6xx_mmu(void) {}
+#endif
 extern unsigned long mpc10x_get_mem_size(void);
 
 static void
