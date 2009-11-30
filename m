Return-Path: <blofeldus@yahoo.com>
Received: from web53502.mail.re2.yahoo.com (web53502.mail.re2.yahoo.com
	[206.190.37.63]) by ozlabs.org (Postfix) with SMTP id A91811007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 15:23:20 +1100 (EST)
Message-ID: <187031.59622.qm@web53502.mail.re2.yahoo.com>
Date: Sun, 29 Nov 2009 20:23:18 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
Subject: [PATCH] powerpc: Restore dma ops for powermac cardbus drivers
To: benh@kernel.crashing.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-850056063-1259554998=:59622"
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-850056063-1259554998=:59622
Content-Type: text/plain; charset=us-ascii

Commit 4ae0ff606e848fa4957ebf8f97e5db5fdeec27be broke dma setup for cardbus
devices such as sata_sil, rt2500 and ath5k. This patch restores the default
dma ops for cardbus devices. Tested with sata_sil on a powerbook G4.

bz#537176

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>

---
The inline patch is whitespace damaged by this mailer. The attachment should be ok,
and passes checkpatch.pl


diff -up linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c.orig linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c
--- linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c.orig    2009-06-09 22:05:27.000000000 -0500
+++ linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c    2009-11-29 21:47:15.000000000 -0600
@@ -514,6 +514,44 @@ static void __init pmac_init_early(void)
 #endif
 }
 
+#ifdef CONFIG_CARDBUS
+static int pmac_cardbus_notify(struct notifier_block *nb, unsigned long action,
+             void *data)
+{
+    struct device *dev = data;
+    struct device *parent;
+    struct pci_dev *pdev = to_pci_dev(dev);
+
+    /* We are only interested in device addition */
+    if (action != BUS_NOTIFY_ADD_DEVICE)
+        return 0;
+
+    parent = pdev->dev.parent;
+
+    if (!parent->archdata.of_node)
+        return 0;
+
+    if (!of_device_is_compatible(parent->archdata.of_node,
+            "cardbus-bridge"))
+        return 0;
+
+    /* We use the direct ops for cardbus */
+    dev->archdata.dma_ops = &dma_direct_ops;
+
+    return 0;
+}
+
+static struct notifier_block cardbus_notifier = {
+    .notifier_call = pmac_cardbus_notify,
+};
+
+static int __init pmac_cardbus_init(void)
+{
+    return bus_register_notifier(&pci_bus_type, &cardbus_notifier);
+}
+machine_device_initcall(powermac, pmac_cardbus_init);
+#endif
+
 static int __init pmac_declare_of_platform_devices(void)
 {
     struct device_node *np;


      
--0-850056063-1259554998=:59622
Content-Type: application/octet-stream; name="powermac-cardbus-dma-notifier.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="powermac-cardbus-dma-notifier.patch"

W1BBVENIXSBwb3dlcnBjOiBSZXN0b3JlIGRtYSBvcHMgZm9yIHBvd2VybWFj
IGNhcmRidXMgZHJpdmVycwoKQ29tbWl0IDRhZTBmZjYwNmU4NDhmYTQ5NTdl
YmY4Zjk3ZTVkYjVmZGVlYzI3YmUgYnJva2UgZG1hIHNldHVwIGZvciBjYXJk
YnVzCmRldmljZXMgc3VjaCBhcyBzYXRhX3NpbCwgcnQyNTAwIGFuZCBhdGg1
ay4gVGhpcyBwYXRjaCByZXN0b3JlcyB0aGUgZGVmYXVsdApkbWEgb3BzIGZv
ciBjYXJkYnVzIGRldmljZXMuIFRlc3RlZCB3aXRoIHNhdGFfc2lsIG9uIGEg
cG93ZXJib29rIEc0LgoKYnojNTM3MTc2CgpTaWduZWQtb2ZmLWJ5OiBSb2dl
ciBCbG9mZWxkIDxibG9mZWxkdXNAeWFob28uY29tPgoKCmRpZmYgLXVwIGxp
bnV4LTIuNi4zMC5wcGMvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm1h
Yy9zZXR1cC5jLm9yaWcgbGludXgtMi42LjMwLnBwYy9hcmNoL3Bvd2VycGMv
cGxhdGZvcm1zL3Bvd2VybWFjL3NldHVwLmMKLS0tIGxpbnV4LTIuNi4zMC5w
cGMvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm1hYy9zZXR1cC5jLm9y
aWcJMjAwOS0wNi0wOSAyMjowNToyNy4wMDAwMDAwMDAgLTA1MDAKKysrIGxp
bnV4LTIuNi4zMC5wcGMvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm1h
Yy9zZXR1cC5jCTIwMDktMTEtMjkgMjE6NDc6MTUuMDAwMDAwMDAwIC0wNjAw
CkBAIC01MTQsNiArNTE0LDQ0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBwbWFj
X2luaXRfZWFybHkodm9pZCkKICNlbmRpZgogfQogCisjaWZkZWYgQ09ORklH
X0NBUkRCVVMKK3N0YXRpYyBpbnQgcG1hY19jYXJkYnVzX25vdGlmeShzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLCB1bnNpZ25lZCBsb25nIGFjdGlvbiwK
KwkJCSB2b2lkICpkYXRhKQoreworCXN0cnVjdCBkZXZpY2UgKmRldiA9IGRh
dGE7CisJc3RydWN0IGRldmljZSAqcGFyZW50OworCXN0cnVjdCBwY2lfZGV2
ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOworCisJLyogV2UgYXJlIG9ubHkg
aW50ZXJlc3RlZCBpbiBkZXZpY2UgYWRkaXRpb24gKi8KKwlpZiAoYWN0aW9u
ICE9IEJVU19OT1RJRllfQUREX0RFVklDRSkKKwkJcmV0dXJuIDA7CisKKwlw
YXJlbnQgPSBwZGV2LT5kZXYucGFyZW50OworCisJaWYgKCFwYXJlbnQtPmFy
Y2hkYXRhLm9mX25vZGUpCisJCXJldHVybiAwOworCisJaWYgKCFvZl9kZXZp
Y2VfaXNfY29tcGF0aWJsZShwYXJlbnQtPmFyY2hkYXRhLm9mX25vZGUsCisJ
CQkiY2FyZGJ1cy1icmlkZ2UiKSkKKwkJcmV0dXJuIDA7CisKKwkvKiBXZSB1
c2UgdGhlIGRpcmVjdCBvcHMgZm9yIGNhcmRidXMgKi8KKwlkZXYtPmFyY2hk
YXRhLmRtYV9vcHMgPSAmZG1hX2RpcmVjdF9vcHM7CisKKwlyZXR1cm4gMDsK
K30KKworc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayBjYXJkYnVzX25v
dGlmaWVyID0geworCS5ub3RpZmllcl9jYWxsID0gcG1hY19jYXJkYnVzX25v
dGlmeSwKK307CisKK3N0YXRpYyBpbnQgX19pbml0IHBtYWNfY2FyZGJ1c19p
bml0KHZvaWQpCit7CisJcmV0dXJuIGJ1c19yZWdpc3Rlcl9ub3RpZmllcigm
cGNpX2J1c190eXBlLCAmY2FyZGJ1c19ub3RpZmllcik7Cit9CittYWNoaW5l
X2RldmljZV9pbml0Y2FsbChwb3dlcm1hYywgcG1hY19jYXJkYnVzX2luaXQp
OworI2VuZGlmCisKIHN0YXRpYyBpbnQgX19pbml0IHBtYWNfZGVjbGFyZV9v
Zl9wbGF0Zm9ybV9kZXZpY2VzKHZvaWQpCiB7CiAJc3RydWN0IGRldmljZV9u
b2RlICpucDsK

--0-850056063-1259554998=:59622--
