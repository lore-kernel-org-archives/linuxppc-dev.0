Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by ozlabs.org (Postfix) with ESMTP id C901FDDF15
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 10:53:16 +1100 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1492279rvb.0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 15:53:10 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/5200: Make internal 5200 PIC the default interrupt
	controller
To: linuxppc-dev@ozlabs.org
Date: Fri, 19 Dec 2008 16:53:07 -0700
Message-ID: <20081219235306.12989.48064.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The MPC5200 internal interrupt controller setup function needs to set
the default interrupt controller when it is called.  Without this
irq_create_of_mapping() cannot be called without first determining
the pointer to the irq controller (ie. call with controller = NULL).

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index c2fa60e..72865e8 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -547,6 +547,8 @@ void __init mpc52xx_init_irq(void)
 	if (!mpc52xx_irqhost)
 		panic(__FILE__ ": Cannot allocate the IRQ host\n");
 
+	irq_set_default_host(mpc52xx_irqhost);
+
 	pr_info("MPC52xx PIC is up and running!\n");
 }
 
