Return-Path: <SRS0+e5d05c376b37d7088a49+801+infradead.org+dwmw2@baythorne.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17256.17408.247708.622755@cargo.ozlabs.ibm.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
	<1130861207.21212.66.camel@hades.cambridge.redhat.com>
	<17256.17408.247708.622755@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 07:35:12 +0000
Message-Id: <1130916912.10031.143.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-11-02 at 15:43 +1100, Paul Mackerras wrote:
> I also pulled in Linus' tree, and now drivers/char/tlclk.c fails to
> build for some reason.  I claim that's not my fault, however. :)

It just needs <linux/platform_device.h> included. That reminds me -- I
needed that in platforms/chrp/pegasos_eth.c too.

diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/powerpc/platforms/chrp/pegasos_eth.c
--- a/arch/powerpc/platforms/chrp/pegasos_eth.c
+++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
@@ -15,6 +15,7 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/mv643xx.h>
+#include <linux/platform_device.h>
 #include <linux/pci.h>
 
 #define PEGASOS2_MARVELL_REGBASE 		(0xf1000000)
diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -43,6 +43,7 @@
 #include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>		/* inb/outb */
 #include <asm/uaccess.h>
 


-- 
dwmw2
