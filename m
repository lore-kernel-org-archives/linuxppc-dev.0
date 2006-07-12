Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 13/16] [powerpc,tmp_atmel] Constify & voidify get_property()
Message-ID: <1152678686.20160.13@pokey>
Date: Wed, 12 Jul 2006 15:41:30 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

tpm_atmel changes

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 tpm_atmel.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/char/tpm/tpm_atmel.h
===================================================================
--- linux-2.6.orig/drivers/char/tpm/tpm_atmel.h
+++ linux-2.6/drivers/char/tpm/tpm_atmel.h
@@ -37,7 +37,7 @@ static void __iomem * atmel_get_base_add
 {
 	struct device_node *dn;
 	unsigned long address, size;
-	unsigned int *reg;
+	const unsigned int *reg;
 	int reglen;
 	int naddrc;
 	int nsizec;
@@ -52,7 +52,7 @@ static void __iomem * atmel_get_base_add
 		return NULL;
 	}
 
-	reg = (unsigned int *) get_property(dn, "reg", &reglen);
+	reg = get_property(dn, "reg", &reglen);
 	naddrc = prom_n_addr_cells(dn);
 	nsizec = prom_n_size_cells(dn);
 
