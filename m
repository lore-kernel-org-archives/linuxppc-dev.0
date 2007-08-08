Return-Path: <mniyer@vnet.ibm.com>
Subject: Export DCR symbols - resubmitting
From: Murali Iyer <mniyer@vnet.ibm.com>
To: Linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-Bbn2/oGYJwtPjaB4CXL3"
Date: Wed, 08 Aug 2007 16:46:49 -0500
Message-Id: <1186609609.4053.19.camel@macg5-2.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Bbn2/oGYJwtPjaB4CXL3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

This patch is needed in order to compile kernel modules that uses some
of the DCR functions. For example, compiling powerpc emac driver as
module it is needed.

Arnd, Dennis Spathis pinged me about this today and I thought it was a
closed issue but still open. If you find it okay please upstream it or
let me know if any modifications needed. Thanks.

-- 
Bye,

Murali


--=-Bbn2/oGYJwtPjaB4CXL3
Content-Disposition: attachment; filename=export-dcr-symbols.diff
Content-Type: text/x-patch; name=export-dcr-symbols.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Subject: Export few DCR symbols for kernel modules

In order to compile drivers as modules that uses some of the
DCR functions, we need to export the symbols. Example, EMAC
driver and other drivers that are under development uses these
some of the functions.

This patch applies cleanly against 2.6.23-rc1 kernel and ready
for inclusion.

From: Murali Iyer

Signed-off-by: Murali Iyer <mniyer@us.ibm.com>
Index: linux-2.6.22/arch/powerpc/sysdev/dcr.c
===================================================================
--- linux-2.6.22.orig/arch/powerpc/sysdev/dcr.c
+++ linux-2.6.22/arch/powerpc/sysdev/dcr.c
@@ -33,6 +33,7 @@ unsigned int dcr_resource_start(struct d
 
 	return dr[index * 2];
 }
+EXPORT_SYMBOL_GPL(dcr_resource_start);
 
 unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
 {
@@ -44,6 +45,7 @@ unsigned int dcr_resource_len(struct dev
 
 	return dr[index * 2 + 1];
 }
+EXPORT_SYMBOL_GPL(dcr_resource_len);
 
 #ifndef CONFIG_PPC_DCR_NATIVE
 
@@ -122,6 +124,7 @@ dcr_host_t dcr_map(struct device_node *d
 	ret.token -= dcr_n * ret.stride;
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dcr_map);
 
 void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c)
 {
@@ -133,5 +136,6 @@ void dcr_unmap(dcr_host_t host, unsigned
 	iounmap(h.token);
 	h.token = NULL;
 }
+EXPORT_SYMBOL_GPL(dcr_unmap);
 
 #endif /* !defined(CONFIG_PPC_DCR_NATIVE) */

--=-Bbn2/oGYJwtPjaB4CXL3--
