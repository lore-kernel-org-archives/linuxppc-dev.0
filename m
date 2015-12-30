Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC6701A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 21:40:46 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/hvc: constify hv_ops structures
Date: Wed, 30 Dec 2015 11:28:02 +0100
Message-Id: <1451471282-5548-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These hv_ops structures are never modified, so declare them as const.  Most
were const already.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/hvc/hvc_xen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index fa816b7..1505056 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -162,7 +162,7 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 	return recv;
 }
 
-static struct hv_ops domU_hvc_ops = {
+static const struct hv_ops domU_hvc_ops = {
 	.get_chars = domU_read_console,
 	.put_chars = domU_write_console,
 	.notifier_add = notifier_add_irq,
@@ -188,7 +188,7 @@ static int dom0_write_console(uint32_t vtermno, const char *str, int len)
 	return len;
 }
 
-static struct hv_ops dom0_hvc_ops = {
+static const struct hv_ops dom0_hvc_ops = {
 	.get_chars = dom0_read_console,
 	.put_chars = dom0_write_console,
 	.notifier_add = notifier_add_irq,
