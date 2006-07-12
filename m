Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 254FE67B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 17:10:55 +1000 (EST)
Date: Wed, 12 Jul 2006 17:10:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/3] Make the hvc_console output buffer size settable
Message-Id: <20060712171011.37b9ccf6.sfr@canb.auug.org.au>
In-Reply-To: <20060712170854.2a1ecf4f.sfr@canb.auug.org.au>
References: <20060712170655.459b8d71.sfr@canb.auug.org.au>
	<20060712170854.2a1ecf4f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

http://www.canb.auug.org.au/~sfr/
So the iSeries console will be faster since it can send up to 200 bytes at
a time to the Hypervisor.  This only affects the tty part of the console,
the console writes are still in 16 byte lots.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_console.c |   14 +++++++++-----
 drivers/char/hvc_console.h |    2 +-
 drivers/char/hvc_iseries.c |    3 ++-
 drivers/char/hvc_rtas.c    |    2 +-
 drivers/char/hvc_vio.c     |    3 ++-
 5 files changed, 15 insertions(+), 9 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index ca2f538..dbee8be 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -80,7 +80,8 @@ struct hvc_struct {
 	struct tty_struct *tty;
 	unsigned int count;
 	int do_wakeup;
-	char outbuf[N_OUTBUF] __ALIGNED__;
+	char *outbuf;
+	int outbuf_size;
 	int n_outbuf;
 	uint32_t vtermno;
 	struct hv_ops *ops;
@@ -505,7 +506,7 @@ static int hvc_write(struct tty_struct *
 	if (hp->n_outbuf > 0)
 		hvc_push(hp);
 
-	while (count > 0 && (rsize = N_OUTBUF - hp->n_outbuf) > 0) {
+	while (count > 0 && (rsize = hp->outbuf_size - hp->n_outbuf) > 0) {
 		if (rsize > count)
 			rsize = count;
 		memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
@@ -538,7 +539,7 @@ static int hvc_write_room(struct tty_str
 	if (!hp)
 		return -1;
 
-	return N_OUTBUF - hp->n_outbuf;
+	return hp->outbuf_size - hp->n_outbuf;
 }
 
 static int hvc_chars_in_buffer(struct tty_struct *tty)
@@ -728,12 +729,13 @@ static struct kobj_type hvc_kobj_type = 
 };
 
 struct hvc_struct __devinit *hvc_alloc(uint32_t vtermno, int irq,
-					struct hv_ops *ops)
+					struct hv_ops *ops, int outbuf_size)
 {
 	struct hvc_struct *hp;
 	int i;
 
-	hp = kmalloc(sizeof(*hp), GFP_KERNEL);
+	hp = kmalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
+			GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
 
@@ -742,6 +744,8 @@ struct hvc_struct __devinit *hvc_alloc(u
 	hp->vtermno = vtermno;
 	hp->irq = irq;
 	hp->ops = ops;
+	hp->outbuf_size = outbuf_size;
+	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
 
 	kobject_init(&hp->kobj);
 	hp->kobj.ktype = &hvc_kobj_type;
diff --git a/drivers/char/hvc_console.h b/drivers/char/hvc_console.h
index 96b7401..8c59818 100644
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -56,7 +56,7 @@ extern int hvc_instantiate(uint32_t vter
 
 /* register a vterm for hvc tty operation (module_init or hotplug add) */
 extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int irq,
-						 struct hv_ops *ops);
+				struct hv_ops *ops, int outbuf_size);
 /* remove a vterm from hvc tty operation (modele_exit or hotplug remove) */
 extern int __devexit hvc_remove(struct hvc_struct *hp);
 
diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index 256afc8..4747729 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -221,7 +221,8 @@ static int __devinit hvc_vio_probe(struc
 
 	pi = &port_info[vdev->unit_address];
 
-	hp = hvc_alloc(vdev->unit_address, vdev->irq, &hvc_get_put_ops);
+	hp = hvc_alloc(vdev->unit_address, vdev->irq, &hvc_get_put_ops,
+			VIOCHAR_MAX_DATA);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 	pi->hp = hp;
diff --git a/drivers/char/hvc_rtas.c b/drivers/char/hvc_rtas.c
index 57106e0..4b97eaf 100644
--- a/drivers/char/hvc_rtas.c
+++ b/drivers/char/hvc_rtas.c
@@ -94,7 +94,7 @@ static int hvc_rtas_init(void)
 
 	/* Allocate an hvc_struct for the console device we instantiated
 	 * earlier.  Save off hp so that we can return it on exit */
-	hp = hvc_alloc(hvc_rtas_cookie, NO_IRQ, &hvc_rtas_get_put_ops);
+	hp = hvc_alloc(hvc_rtas_cookie, NO_IRQ, &hvc_rtas_get_put_ops, 16);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 
diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index 9add81c..651e5d2 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -90,7 +90,8 @@ static int __devinit hvc_vio_probe(struc
 	if (!vdev || !id)
 		return -EPERM;
 
-	hp = hvc_alloc(vdev->unit_address, vdev->irq, &hvc_get_put_ops);
+	hp = hvc_alloc(vdev->unit_address, vdev->irq, &hvc_get_put_ops,
+			MAX_VIO_PUT_CHARS);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 	dev_set_drvdata(&vdev->dev, hp);
-- 
1.4.0
