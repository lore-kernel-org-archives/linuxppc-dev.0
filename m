Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A70F1B7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 00:11:35 +1000 (EST)
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 12CEADDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 00:11:34 +1000 (EST)
Date: Thu, 30 Jul 2009 16:11:24 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: johannes@sipsolutions.net, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
Message-ID: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
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

From: Julia Lawall <julia@diku.dk>

Check that the result of kzalloc is not NULL before a dereference.

The semantic match that finds this problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression *x;
identifier f;
constant char *C;
@@

x = \(kmalloc\|kcalloc\|kzalloc\)(...);
... when != x == NULL
    when != x != NULL
    when != (x || ...)
(
kfree(x)
|
f(...,C,...,x,...)
|
*f(...,x,...)
|
*x->f
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/aoa/core/gpio-pmf.c           |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/aoa/core/gpio-pmf.c b/sound/aoa/core/gpio-pmf.c
index 5ca2220..b4439ce 100644
--- a/sound/aoa/core/gpio-pmf.c
+++ b/sound/aoa/core/gpio-pmf.c
@@ -182,6 +182,12 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		irq_client = kzalloc(sizeof(struct pmf_irq_client),
 				     GFP_KERNEL);
+		if (!irq_client) {
+			err = -ENOMEM;
+			printk(KERN_ERR "snd-aoa: gpio layer failed to"
+				" register %s irq (%d)\n", name, err);
+			goto out_unlock;
+		}
 		irq_client->data = notif;
 		irq_client->handler = pmf_handle_notify_irq;
 		irq_client->owner = THIS_MODULE;
