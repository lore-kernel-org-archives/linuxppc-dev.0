Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 92019B7BAC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 04:41:10 +1100 (EST)
Date: Mon, 05 Oct 2009 19:41:07 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH/v2] powerpc/5200: make BestComm gen_bd microcode exchangeable
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, grant.likely@secretlab.ca
Message-Id: <1254764467.5503.1@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a method for defining different microcodes than the pe-defi=
ned ones for the MPC52xx's BestComm General Buffer Descriptor (gen_db) task=
s.  The default microcode is still the one from bcom_gen_bd_[rt]x_task, but=
 it can be replaced by calling bcom_gen_bd_set_microcode() which is more ef=
ficient than explicitly loading it via bcom_load_image() after each bcom_ge=
n_bd_[rt]x_reset().

Except for a fixed tab vs. space formatting and the transfer format, there =
are no diffierences to the initial attempt.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>


---


diff -uprN -X linux-2.6.32-rc3/Documentation/dontdiff linux-2.6.32-rc3-orig=
/arch/powerpc/sysdev/bestcomm/gen_bd.c linux-2.6.32-rc3/arch/powerpc/sysdev=
/bestcomm/gen_bd.c
--- linux-2.6.32-rc3-orig/arch/powerpc/sysdev/bestcomm/gen_bd.c	2009-10-05 =
02:12:30.000000000 +0200
+++ linux-2.6.32-rc3/arch/powerpc/sysdev/bestcomm/gen_bd.c	2009-10-05 14:52=
:31.000000000 +0200
@@ -78,6 +78,7 @@ struct bcom_gen_bd_priv {
 	int		initiator;
 	int		ipr;
 	int		maxbufsize;
+	u32		*microcode;
 };
=20
=20
@@ -104,6 +105,7 @@ bcom_gen_bd_rx_init(int queue_len, phys_
 	priv->initiator	=3D initiator;
 	priv->ipr	=3D ipr;
 	priv->maxbufsize =3D maxbufsize;
+	priv->microcode =3D bcom_gen_bd_rx_task;
=20
 	if (bcom_gen_bd_rx_reset(tsk)) {
 		bcom_task_free(tsk);
@@ -128,7 +130,7 @@ bcom_gen_bd_rx_reset(struct bcom_task *t
 	var =3D (struct bcom_gen_bd_rx_var *) bcom_task_var(tsk->tasknum);
 	inc =3D (struct bcom_gen_bd_rx_inc *) bcom_task_inc(tsk->tasknum);
=20
-	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_rx_task))
+	if (bcom_load_image(tsk->tasknum, priv->microcode))
 		return -1;
=20
 	var->enable	=3D bcom_eng->regs_base +
@@ -188,6 +190,7 @@ bcom_gen_bd_tx_init(int queue_len, phys_
 	priv->fifo	=3D fifo;
 	priv->initiator	=3D initiator;
 	priv->ipr	=3D ipr;
+	priv->microcode =3D bcom_gen_bd_tx_task;
=20
 	if (bcom_gen_bd_tx_reset(tsk)) {
 		bcom_task_free(tsk);
@@ -212,7 +215,7 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
 	var =3D (struct bcom_gen_bd_tx_var *) bcom_task_var(tsk->tasknum);
 	inc =3D (struct bcom_gen_bd_tx_inc *) bcom_task_inc(tsk->tasknum);
=20
-	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_tx_task))
+	if (bcom_load_image(tsk->tasknum, priv->microcode))
 		return -1;
=20
 	var->enable	=3D bcom_eng->regs_base +
@@ -253,6 +256,15 @@ bcom_gen_bd_tx_release(struct bcom_task=20
 }
 EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
=20
+void
+bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode)
+{
+	struct bcom_gen_bd_priv *priv =3D tsk->priv;
+
+	priv->microcode =3D microcode;
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_set_microcode);
+
 /* ---------------------------------------------------------------------
  * PSC support code
  */
diff -uprN -X linux-2.6.32-rc3/Documentation/dontdiff linux-2.6.32-rc3-orig=
/arch/powerpc/sysdev/bestcomm/gen_bd.h linux-2.6.32-rc3/arch/powerpc/sysdev=
/bestcomm/gen_bd.h
--- linux-2.6.32-rc3-orig/arch/powerpc/sysdev/bestcomm/gen_bd.h	2009-10-05 =
02:12:30.000000000 +0200
+++ linux-2.6.32-rc3/arch/powerpc/sysdev/bestcomm/gen_bd.h	2009-10-05 14:52=
:31.000000000 +0200
@@ -43,6 +43,9 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
 extern void
 bcom_gen_bd_tx_release(struct bcom_task *tsk);
=20
+extern void
+bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode);
+
=20
 /* PSC support utility wrappers */
 struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int queue_len=
,
