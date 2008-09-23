Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FA87DE578
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 06:39:06 +1000 (EST)
Received: from www.tglx.de (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id
	m8NKcvdE020936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 22:38:57 +0200
Received: (from bigeasy@localhost)
	by www.tglx.de (8.13.8/8.13.8/Submit) id m8NKcvaq020935
	for linuxppc-dev@ozlabs.org; Tue, 23 Sep 2008 22:38:57 +0200
Date: Tue, 23 Sep 2008 22:38:57 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
Message-ID: <20080923203857.GB10935@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My mylinux binary incl. bss is ~5 MiB without bss less than 4 MiB.
Therefore I though that I could replace ei.memsize with ei.loadsize. It
didn't work. I'm not sure why it did not work but I guess that the
memset() of bss in the initial kernel code overwrote the cuimage code
which is required for some reason. Maybe some device-tree callbacks.

My current (working) solution is to move cuImage from 4 MiB to 8 MiB.
Something similar has been done for pSeries in 9b09c6d "powerpc: Change
the default link address for pSeries zImage kernels". Would it be
appropriate to move initial address to 64 MiB as the default loading
address or do we have here some boards which have only 64 MiB of memory?
Does someone have another idea?

--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -56,7 +56,7 @@ static struct addr_range prep_kernel(void)
 	if (platform_ops.vmlinux_alloc) {
 		addr = platform_ops.vmlinux_alloc(ei.memsize);
 	} else {
-		if ((unsigned long)_start < ei.memsize)
+		if ((unsigned long)_start < ei.loadsize)
 			fatal("Insufficient memory for kernel at address 0!"
 			       " (_start=%p)\n\r", _start);
 	}
-- 

--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -138,7 +138,7 @@ objflags=-S
 tmp=$tmpdir/zImage.$$.o
 ksection=.kernel:vmlinux.strip
 isection=.kernel:initrd
-link_address='0x400000'
+link_address='0x800000'
 
 case "$platform" in
 pseries)
-- 
1.5.6.5
