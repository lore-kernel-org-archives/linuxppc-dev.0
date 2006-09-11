Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 9387867B62
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 19:30:31 +1000 (EST)
Received: from ibook.aepfle.de (p5493E152.dip.t-dialin.net [84.147.225.82])
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k8B9UREi020085
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Sep 2006 11:30:28 +0200 (MEST)
Date: Mon, 11 Sep 2006 11:30:28 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: missing release_region in i8042_exit
Message-ID: <20060911093028.GA23112@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Does anyone know why 64bit kernels do not call release_region in
i8042_platform_exit? Why is it allowed on 32bit kernels?

drivers/input/serio/i8042-io.h

     83 static inline void i8042_platform_exit(void)
     84 {
     85 #if !defined(__sh__) && !defined(__alpha__) && !defined(CONFIG_PPC64)
     86         release_region(I8042_DATA_REG, 16);
     87 #endif
     88 }
