Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0A22DDF2D
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 07:39:29 +1000 (EST)
Date: Sat, 9 Jun 2007 23:39:20 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: zImage.miboot and vmlinux.lds
In-Reply-To: <981f558c34d946fcb2683a9731f8d5ad@kernel.crashing.org>
Message-ID: <alpine.DEB.0.99.0706092327300.8312@foobar-g4>
References: <Pine.LNX.4.64.0705282025250.6275@sheep.housecafe.de>
	<alpine.DEB.0.99.0706092110060.8312@foobar-g4>
	<981f558c34d946fcb2683a9731f8d5ad@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Sender: "evil@g-house.de"@mail.g-house.de
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 9 Jun 2007, Segher Boessenkool wrote:
> vmlinux.lds should be cleaned from the main (non-arch)
> Makefile; I could swear I've sent a patch for that some
> time ago.

Well, Stephen Rothwell did (too?) and you replied to his post:
http://article.gmane.org/gmane.linux.ports.ppc.devel/5881
http://article.gmane.org/gmane.linux.ports.ppc.devel/5897

> Maybe it should be added to $(image-) unconditionally?
> Or get rid of the ifeq, preferably.

What about just adding it to clean-files, since $(image-) does not seem 
to catch it?

--- linux-2.6.22-rc3.orig/arch/powerpc/boot/Makefile	2007-05-26 04:55:14.000000000 +0200
+++ linux-2.6.22-rc3/arch/powerpc/boot/Makefile	2007-06-09 23:38:07.000000000 +0200
@@ -81,7 +81,7 @@ $(obj)/zImage.lds $(obj)/zImage.coff.lds
  	@cp $< $@

  clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
-		empty.c zImage.coff.lds zImage.lds
+		empty.c zImage.coff.lds zImage.lds zImage.miboot

  quiet_cmd_bootcc = BOOTCC  $@
        cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<


-- 
make bzImage, not war
