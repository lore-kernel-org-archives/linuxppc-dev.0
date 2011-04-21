Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50EC21007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Apr 2011 06:50:58 +1000 (EST)
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.2.77] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1QD034-0004OI-Vl
	for linuxppc-dev@lists.ozlabs.org; Thu, 21 Apr 2011 16:00:23 -0400
Date: Thu, 21 Apr 2011 16:00:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] POWERPC: Remove redundant initialization of bsr dev_t
	declaration.
Message-ID: <alpine.DEB.2.00.1104211556240.6841@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Remove the unnecessary initialization of "dev_t bsr_dev" since it's
subsequently used in an "alloc_chrdev_region()" call which uses that
variable in an output-only fashion.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  *Not* compile tested since I don't have a PPC toolchain, but the
logic here should be fairly obvious.  The current code isn't wrong,
just misleading.

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index a4a6c2f..cf39bc0 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -295,7 +295,7 @@ static int bsr_create_devs(struct device_node *bn)
 static int __init bsr_init(void)
 {
 	struct device_node *np;
-	dev_t bsr_dev = MKDEV(bsr_major, 0);
+	dev_t bsr_dev;
 	int ret = -ENODEV;
 	int result;


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
