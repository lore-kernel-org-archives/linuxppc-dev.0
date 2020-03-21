Return-Path: <SRS0=LfBu=5G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33192C4332D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2020 11:59:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C6820754
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2020 11:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C6820754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kzhG1chbzF0dm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2020 22:59:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kz886pPzzDr8m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2020 22:34:48 +1100 (AEDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jFcOR-0001zL-1n; Sat, 21 Mar 2020 12:34:19 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
 by nanos.tec.linutronix.de (Postfix) with ESMTP id 36749104084;
 Sat, 21 Mar 2020 12:34:18 +0100 (CET)
Message-Id: <20200321113241.150783464@linutronix.de>
User-Agent: quilt/0.65
Date: Sat, 21 Mar 2020 12:25:48 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 04/20] orinoco_usb: Use the regular completion interfaces
References: <20200321112544.878032781@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-ia64@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Sebastian Siewior <bigeasy@linutronix.de>, platform-driver-x86@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Vincent Chen <deanbo422@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>,
 kbuild test robot <lkp@intel.com>, Brian Cain <bcain@codeaurora.org>,
 linux-acpi@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 linux-hexagon@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-csky@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Greentime Hu <green.hu@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Nick Hu <nickhu@andestech.com>, Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Davidlohr Bueso <dbueso@suse.de>, netdev@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, "David S. Miller" <davem@davemloft.net>,
 Andy Shevchenko <andy@infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Thomas Gleixner <tglx@linutronix.de>

The completion usage in this driver is interesting:

  - it uses a magic complete function which according to the comment was
    implemented by invoking complete() four times in a row because
    complete_all() was not exported at that time.

  - it uses an open coded wait/poll which checks completion:done. Only one wait
    side (device removal) uses the regular wait_for_completion() interface.

The rationale behind this is to prevent that wait_for_completion() consumes
completion::done which would prevent that all waiters are woken. This is not
necessary with complete_all() as that sets completion::done to UINT_MAX which
is left unmodified by the woken waiters.

Replace the magic complete function with complete_all() and convert the
open coded wait/poll to regular completion interfaces.

This changes the wait to exclusive wait mode. But that does not make any
difference because the wakers use complete_all() which ignores the
exclusive mode.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
V2: New patch to avoid conversion to swait functions later.
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c |   21 ++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -365,17 +365,6 @@ static struct request_context *ezusb_all
 	return ctx;
 }
 
-
-/* Hopefully the real complete_all will soon be exported, in the mean
- * while this should work. */
-static inline void ezusb_complete_all(struct completion *comp)
-{
-	complete(comp);
-	complete(comp);
-	complete(comp);
-	complete(comp);
-}
-
 static void ezusb_ctx_complete(struct request_context *ctx)
 {
 	struct ezusb_priv *upriv = ctx->upriv;
@@ -409,7 +398,7 @@ static void ezusb_ctx_complete(struct re
 
 			netif_wake_queue(dev);
 		}
-		ezusb_complete_all(&ctx->done);
+		complete_all(&ctx->done);
 		ezusb_request_context_put(ctx);
 		break;
 
@@ -419,7 +408,7 @@ static void ezusb_ctx_complete(struct re
 			/* This is normal, as all request contexts get flushed
 			 * when the device is disconnected */
 			err("Called, CTX not terminating, but device gone");
-			ezusb_complete_all(&ctx->done);
+			complete_all(&ctx->done);
 			ezusb_request_context_put(ctx);
 			break;
 		}
@@ -690,11 +679,11 @@ static void ezusb_req_ctx_wait(struct ez
 			 * get the chance to run themselves. So we make sure
 			 * that we don't sleep for ever */
 			int msecs = DEF_TIMEOUT * (1000 / HZ);
-			while (!ctx->done.done && msecs--)
+
+			while (!try_wait_for_completion(&ctx->done) && msecs--)
 				udelay(1000);
 		} else {
-			wait_event_interruptible(ctx->done.wait,
-						 ctx->done.done);
+			wait_for_completion(&ctx->done);
 		}
 		break;
 	default:


