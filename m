Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yfyj2193jzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 03:58:07 +1100 (AEDT)
Received: from [192.168.1.139] (ppp-188-174-95-145.dynamic.mnet-online.de
 [188.174.95.145]) by smtp.strato.de (RZmta 42.9 DYNA|AUTH)
 with ESMTPSA id m08e38tAJGvxQgv
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 19 Nov 2017 17:57:59 +0100 (CET)
Subject: Qoriq P5020 PowerPC board doesn't boot with the latest git version
 anymore
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
References: <ce2c842f-df48-6763-4626-adead5606acc@xenosoft.de>
 <3e4805a4-6114-205d-653b-ea6cd7fdc057@xenosoft.de>
Message-ID: <8ed2edc7-a14b-35b3-86c1-a9995f41df84@xenosoft.de>
Date: Sun, 19 Nov 2017 17:57:58 +0100
MIME-Version: 1.0
In-Reply-To: <3e4805a4-6114-205d-653b-ea6cd7fdc057@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

A little success. :-) I reverted the following files from the bad commit 
a8a217c22116eff6c120d753c9934089fb229af0 [1]:

arch/powerpc/include/asm/spinlock.h
kernel/locking/spinlock.c
include/linux/spinlock_up.h
include/linux/spinlock.h
include/linux/rwlock.h

After that I compiled the latest git kernel again. Then I was able to 
boot the latest git kernel on my Varisys Cyrus Plus board [2][3]. :-)

That means the bug is in one of these files.

Please help me to find the bug in these files above.

Thanks,
Christian


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8a217c22116eff6c120d753c9934089fb229af0
[2] http://www.amigaos.net/hardware/133/amigaone-x5000
[3] http://wiki.amiga.org/index.php?title=AmigaONE_X5000
