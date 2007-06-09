Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F8F2DDEEF
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 05:14:40 +1000 (EST)
Received: from [89.59.29.105] (helo=noname)
	by mail.g-house.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1Hx6OO-0004Gc-K5
	for linuxppc-dev@ozlabs.org; Sat, 09 Jun 2007 21:14:33 +0200
Date: Sat, 9 Jun 2007 21:14:29 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: zImage.miboot and vmlinux.lds
In-Reply-To: <Pine.LNX.4.64.0705282025250.6275@sheep.housecafe.de>
Message-ID: <alpine.DEB.0.99.0706092110060.8312@foobar-g4>
References: <Pine.LNX.4.64.0705282025250.6275@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii; format=flowed
Sender: "evil@g-house.de"@mail.g-house.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 May 2007, Christian Kujau wrote:
> when doing a "make mrproper" or even "make distclean" on a current 2.6-git 
> tree, I see 2 files being left over:
>
> arch/powerpc/boot/zImage.miboot
> arch/powerpc/kernel/vmlinux.lds

Hm, the files are still there. Is there any reason for "mrproper" not to 
remove these files? Otherwise, would the following be appropriate?

--- linux-2.6-dev/arch/powerpc/Makefile.orig	2007-05-28 21:24:39.000000000 +0200
+++ linux-2.6-dev/arch/powerpc/Makefile	2007-05-28 21:23:25.000000000 +0200
@@ -174,6 +174,7 @@ archclean:

  archmrproper:
  	$(Q)rm -rf arch/$(ARCH)/include
+	$(Q)rm  -f arch/$(ARCH)/boot/zImage.miboot arch/$(ARCH)/kernel/vmlinux.lds

  archprepare: checkbin


Thanks,
Christian.
-- 
make bzImage, not war
