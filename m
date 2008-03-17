Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [128.224.252.2])
	by ozlabs.org (Postfix) with ESMTP id B6EBDDE0DD
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:18:49 +1100 (EST)
Date: Mon, 17 Mar 2008 16:07:55 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: powerpc: cuImage.* creation error
Message-ID: <20080317200754.GA7383@windriver.com>
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080317193652.GA9550@cs181133002.pp.htv.fi>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: powerpc: cuImage.* creation error
on 17/03/2008 Adrian Bunk wrote:

> When building all powerpc defconfigs in 2.6.25-rc6 exactly three of 
> them fail to build, and all with similar problems:
> 
> <--  snip  -->
> 
> 
> sbc8548_defconfig:
> 
> <--  snip  -->
> 
> ...
> Entry Point:  0x00000000
> make[2]: *** No rule to make target `arch/powerpc/boot/cuImage.tqm8548', needed by `arch/powerpc/boot/zImage'.  Stop.
> 

Untested, but I'll guess that this is at least part of the problem for
the sbc one...

Thanks,
Paul.

---

Author: Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon Mar 17 15:47:03 2008 -0400

    cuimage: fix board names in Makefile
    
    Fix the copy and paste error from 25431333813686654907ab987fb5de10c10a16db
    for the sbc8548 and sbc8560
    
    Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4974d9e..1aded8f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -253,8 +253,8 @@ image-$(CONFIG_TQM8540)			+= cuImage.tqm8540
 image-$(CONFIG_TQM8541)			+= cuImage.tqm8541
 image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
 image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
-image-$(CONFIG_SBC8548)			+= cuImage.tqm8548
-image-$(CONFIG_SBC8560)			+= cuImage.tqm8560
+image-$(CONFIG_SBC8548)			+= cuImage.sbc8548
+image-$(CONFIG_SBC8560)			+= cuImage.sbc8560
 
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
