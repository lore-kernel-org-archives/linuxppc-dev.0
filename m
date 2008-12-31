Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CB749DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 14:14:53 +1100 (EST)
Date: Wed, 31 Dec 2008 14:14:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>
Subject: [PATCH] infiniband/ehca: use consistent type
Message-Id: <20081231141453.45d7f2c1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Heiko J Schick <schickhj@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ehca_plpar_hcall9() takes an unsigned long array, so pass that.

This change will avoid some warnings when we change u64 to unsigned
long long.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/hw/ehca/hcp_if.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 415d3a4..79d95d9 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -226,7 +226,7 @@ u64 hipz_h_alloc_resource_eq(const struct ipz_adapter_handle adapter_handle,
 			     u32 *eq_ist)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 	u64 allocate_controls;
 
 	/* resource type */
@@ -270,7 +270,7 @@ u64 hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
 			     struct ehca_alloc_cq_parms *param)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
 				adapter_handle.handle,   /* r4  */
@@ -297,7 +297,7 @@ u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle adapter_handle,
 {
 	u64 ret;
 	u64 allocate_controls, max_r10_reg, r11, r12;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	allocate_controls =
 		EHCA_BMASK_SET(H_ALL_RES_QP_ENHANCED_OPS, parms->ext_type)
@@ -525,7 +525,7 @@ u64 hipz_h_disable_and_get_wqe(const struct ipz_adapter_handle adapter_handle,
 			       int dis_and_get_function_code)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_DISABLE_AND_GETC, outs,
 				adapter_handle.handle,     /* r4 */
@@ -548,7 +548,7 @@ u64 hipz_h_modify_qp(const struct ipz_adapter_handle adapter_handle,
 		     struct h_galpa gal)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 	ret = ehca_plpar_hcall9(H_MODIFY_QP, outs,
 				adapter_handle.handle, /* r4 */
 				qp_handle.handle,      /* r5 */
@@ -579,7 +579,7 @@ u64 hipz_h_destroy_qp(const struct ipz_adapter_handle adapter_handle,
 		      struct ehca_qp *qp)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = hcp_galpas_dtor(&qp->galpas);
 	if (ret) {
@@ -625,7 +625,7 @@ u64 hipz_h_define_aqp1(const struct ipz_adapter_handle adapter_handle,
 		       u32 * bma_qp_nr)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_DEFINE_AQP1, outs,
 				adapter_handle.handle, /* r4 */
@@ -733,7 +733,7 @@ u64 hipz_h_alloc_resource_mr(const struct ipz_adapter_handle adapter_handle,
 			     struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
 				adapter_handle.handle,            /* r4 */
@@ -794,7 +794,7 @@ u64 hipz_h_query_mr(const struct ipz_adapter_handle adapter_handle,
 		    struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_QUERY_MR, outs,
 				adapter_handle.handle,     /* r4 */
@@ -828,7 +828,7 @@ u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
 			  struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_REREGISTER_PMR, outs,
 				adapter_handle.handle,    /* r4 */
@@ -855,7 +855,7 @@ u64 hipz_h_register_smr(const struct ipz_adapter_handle adapter_handle,
 			struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_REGISTER_SMR, outs,
 				adapter_handle.handle,            /* r4 */
@@ -877,7 +877,7 @@ u64 hipz_h_alloc_resource_mw(const struct ipz_adapter_handle adapter_handle,
 			     struct ehca_mw_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
 				adapter_handle.handle,      /* r4 */
@@ -895,7 +895,7 @@ u64 hipz_h_query_mw(const struct ipz_adapter_handle adapter_handle,
 		    struct ehca_mw_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = ehca_plpar_hcall9(H_QUERY_MW, outs,
 				adapter_handle.handle,    /* r4 */
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
