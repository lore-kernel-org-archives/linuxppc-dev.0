Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1fJ16r2CzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 15:44:01 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 79so24406596pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Apr 2017 22:44:01 -0700 (PDT)
Date: Mon, 10 Apr 2017 15:43:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
Message-ID: <20170410154348.051e7a34@roar.ozlabs.ibm.com>
In-Reply-To: <CAL_JsqKuomE41grhAvjFxkFbS4A3-M_TK8gP8FU=HdDpQ3TTkg@mail.gmail.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
 <20170405123706.6081-3-npiggin@gmail.com>
 <CAL_JsqK4zbACwWVb-rsrvBb4hjBCexrqKRKrzSiZrZH5w=bKqQ@mail.gmail.com>
 <20170406003251.533e2845@roar.ozlabs.ibm.com>
 <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
 <1491425881.4166.90.camel@kernel.crashing.org>
 <20170406103829.67d462e1@roar.ozlabs.ibm.com>
 <CAL_JsqKuomE41grhAvjFxkFbS4A3-M_TK8gP8FU=HdDpQ3TTkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Apr 2017 09:09:41 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Apr 5, 2017 at 7:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > Given that it's quite a small addition to of/fdt code, hopefully
> > that gives you a reasonable justification to accept it.
> >
> > If you prefer not to, that's okay, but I think we would have to carry
> > it in arch/powerpc at least for a time, because of the schedule we're
> > working to for POWER9 enablement. As a longer term item I agree with you
> > and Ben, it would be worth considering unflattening earlier.  
> 
> As I mentioned, keeping it in arch/powerpc I like even less. So this is fine.

Here is the patch with the change you suggested. Can I add your
ack and send it via the powerpc tree with the change that uses
these interfaces?

Thanks,
Nick

---
 drivers/of/fdt.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e5ce4b59e162..961ca97072a9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -754,6 +754,36 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 }
 
 /**
+ * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
+ * @it: callback function
+ * @data: context data pointer
+ *
+ * This function is used to scan sub-nodes of a node.
+ */
+int __init of_scan_flat_dt_subnodes(unsigned long parent,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data)
+{
+	const void *blob = initial_boot_params;
+	int node;
+
+	fdt_for_each_subnode(node, blob, parent) {
+		const char *pathp;
+		int rc;
+
+		pathp = fdt_get_name(blob, node, NULL);
+		if (*pathp == '/')
+			pathp = kbasename(pathp);
+		rc = it(node, pathp, data);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+/**
  * of_get_flat_dt_subnode_by_name - get the subnode by given name
  *
  * @node: the parent node
@@ -812,6 +842,14 @@ int __init of_flat_dt_match(unsigned long node, const char *const *compat)
 	return of_fdt_match(initial_boot_params, node, compat);
 }
 
+/**
+ * of_get_flat_dt_prop - Given a node in the flat blob, return the phandle
+ */
+uint32_t __init of_get_flat_dt_phandle(unsigned long node)
+{
+	return fdt_get_phandle(initial_boot_params, node);
+}
+
 struct fdt_scan_status {
 	const char *name;
 	int namelen;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 271b3fdf0070..1dfbfd0d8040 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -54,6 +54,11 @@ extern char __dtb_end[];
 extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
 				     int depth, void *data),
 			   void *data);
+extern int of_scan_flat_dt_subnodes(unsigned long node,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data);
 extern int of_get_flat_dt_subnode_by_name(unsigned long node,
 					  const char *uname);
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
@@ -62,6 +67,7 @@ extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern int of_flat_dt_match(unsigned long node, const char *const *matches);
 extern unsigned long of_get_flat_dt_root(void);
 extern int of_get_flat_dt_size(void);
+extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
-- 
2.11.0
