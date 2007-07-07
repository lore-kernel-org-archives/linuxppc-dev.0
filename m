Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:52 -0500 (CDT)
Subject: [PATCH 08/11] dtc: store labels in asscending order
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-08.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When adding a label, walk to the end of the list since the
label reflects the end of the data.

Since merging data buffers already preserved the order, this
will cause the labels to be emitted in order when writing
assembly output.

It should also aid emiting labels when writing dts output
should that be added in the future (data formatting would
need to break at each label).

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Currently cosmetic as the labels will be on the correct
data either way.

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-06-14 21:39:34.000000000 -0500
+++ dtc/data.c	2007-06-14 21:50:52.000000000 -0500
@@ -301,16 +301,22 @@ struct data data_add_fixup(struct data d
 
 struct data data_add_label(struct data d, char *label)
 {
-	struct fixup *f;
+	struct fixup *f, **p;
 	struct data nd;
 
 	f = xmalloc(sizeof(*f));
 	f->offset = d.len;
 	f->ref = label;
-	f->next = d.labels;
 
 	nd = d;
-	nd.labels = f;
+	p = &nd.labels;
+
+	/* adding to end keeps them sorted */
+	while (*p)
+		p = &((*p)->next);
+
+	f->next = *p;
+	*p = f;
 
 	return nd;
 }
