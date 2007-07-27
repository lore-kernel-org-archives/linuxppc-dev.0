Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0016FDDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 20:43:15 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6RAhBHn032926
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:43:11 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6RAhBEw913644
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 12:43:11 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6RAgtXV031460
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 12:42:55 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, general@lists.openfabrics.org
Subject: [PATCH 1/2] ehca: remove checkpatch.pl's warnings "externs should be
	avoided in .c files"
Date: Fri, 27 Jul 2007 12:54:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707271254.51055.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom b5d0336089b5ebe5b18acb94b2c94c2026cb95ee Mon Sep 17 00:00:00 2001
=46rom: Hoang-Nam Nguyen <hnguyen at de.ibm.com>
Date: Fri, 27 Jul 2007 10:24:49 +0200
Subject: [PATCH] remove checkpatch.pl's warnings "externs should be avoided=
 in .c files"

Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
=2D--
 drivers/infiniband/hw/ehca/ehca_classes.h |    1 +
 drivers/infiniband/hw/ehca/ehca_mrmw.c    |    2 --
 drivers/infiniband/hw/ehca/ehca_pd.c      |    1 -
 drivers/infiniband/hw/ehca/hcp_if.c       |    1 -
 drivers/infiniband/hw/ehca/ipz_pt_fn.h    |    2 ++
 5 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband=
/hw/ehca/ehca_classes.h
index 3725aa8..b5e9603 100644
=2D-- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -322,6 +322,7 @@ extern int ehca_static_rate;
 extern int ehca_port_act_time;
 extern int ehca_use_hp_mr;
 extern int ehca_scaling_code;
+extern int ehca_mr_largepage;
=20
 struct ipzu_queue_resp {
 	u32 qe_size;      /* queue entry size */
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw=
/ehca/ehca_mrmw.c
index c1b868b..773ac3f 100644
=2D-- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -64,8 +64,6 @@ enum ehca_mr_pgsize {
 	EHCA_MR_PGSIZE16M =3D 0x1000000L
 };
=20
=2Dextern int ehca_mr_largepage;
=2D
 static u32 ehca_encode_hwpage_size(u32 pgsize)
 {
 	u32 idx =3D 0;
diff --git a/drivers/infiniband/hw/ehca/ehca_pd.c b/drivers/infiniband/hw/e=
hca/ehca_pd.c
index 3dafd7f..43bcf08 100644
=2D-- a/drivers/infiniband/hw/ehca/ehca_pd.c
+++ b/drivers/infiniband/hw/ehca/ehca_pd.c
@@ -88,7 +88,6 @@ int ehca_dealloc_pd(struct ib_pd *pd)
 	u32 cur_pid =3D current->tgid;
 	struct ehca_pd *my_pd =3D container_of(pd, struct ehca_pd, ib_pd);
 	int i, leftovers =3D 0;
=2D	extern struct kmem_cache *small_qp_cache;
 	struct ipz_small_queue_page *page, *tmp;
=20
 	if (my_pd->ib_pd.uobject && my_pd->ib_pd.uobject->context &&
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/eh=
ca/hcp_if.c
index fdbfebe..24f4541 100644
=2D-- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -758,7 +758,6 @@ u64 hipz_h_register_rpage_mr(const struct ipz_adapter_h=
andle adapter_handle,
 			     const u64 logical_address_of_page,
 			     const u64 count)
 {
=2D	extern int ehca_debug_level;
 	u64 ret;
=20
 	if (unlikely(ehca_debug_level >=3D 2)) {
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.h b/drivers/infiniband/hw=
/ehca/ipz_pt_fn.h
index c6937a0..a801274 100644
=2D-- a/drivers/infiniband/hw/ehca/ipz_pt_fn.h
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
@@ -54,6 +54,8 @@
 struct ehca_pd;
 struct ipz_small_queue_page;
=20
+extern struct kmem_cache *small_qp_cache;
+
 /* struct generic ehca page */
 struct ipz_page {
 	u8 entries[EHCA_PAGESIZE];
=2D-=20
1.5.2
