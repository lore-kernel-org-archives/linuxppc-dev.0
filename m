Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 3B76BB7BD5
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 05:55:40 +1000 (EST)
Date: Thu, 01 Oct 2009 21:55:38 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH] powerpc/5200: make BestComm gen_bd microcode exchangeable
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Message-Id: <1254426938.3252.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-XWelNosOMeK8XhYuNugS"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-XWelNosOMeK8XhYuNugS
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds a method for defining different microcodes than the =20
pe-defined ones for the MPC52xx processor's BestComm General Buffer =20
Descriptor (gen_db) tasks.  The default microcode is still the one from =20
bcom_gen_bd_[rt]x_task, but it can be replaced by calling =20
bcom_gen_bd_set_microcode() which is more efficient than explicitly =20
loading it via bcom_load_image() after each bcom_gen_bd_[rt]x_reset().

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>


---


diff -uprN -X linux-2.6.30.3/Documentation/dontdiff =20
linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.c =20
linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.c
--- linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.c	=20
2009-07-24 23:47:51.000000000 +0200
+++ linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.c	=20
2009-10-01 14:26:33.000000000 +0200
@@ -78,6 +78,7 @@ struct bcom_gen_bd_priv {
  	int		initiator;
  	int		ipr;
  	int		maxbufsize;
+	u32    *microcode;
  };


@@ -104,6 +105,7 @@ bcom_gen_bd_rx_init(int queue_len, phys_
  	priv->initiator	=3D initiator;
  	priv->ipr	=3D ipr;
  	priv->maxbufsize =3D maxbufsize;
+	priv->microcode =3D bcom_gen_bd_rx_task;

  	if (bcom_gen_bd_rx_reset(tsk)) {
  		bcom_task_free(tsk);
@@ -128,7 +130,7 @@ bcom_gen_bd_rx_reset(struct bcom_task *t
  	var =3D (struct bcom_gen_bd_rx_var *) bcom_task_var(tsk->tasknum);
  	inc =3D (struct bcom_gen_bd_rx_inc *) bcom_task_inc(tsk->tasknum);

-	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_rx_task))
+	if (bcom_load_image(tsk->tasknum, priv->microcode))
  		return -1;

  	var->enable	=3D bcom_eng->regs_base +
@@ -188,6 +190,7 @@ bcom_gen_bd_tx_init(int queue_len, phys_
  	priv->fifo	=3D fifo;
  	priv->initiator	=3D initiator;
  	priv->ipr	=3D ipr;
+	priv->microcode =3D bcom_gen_bd_tx_task;

  	if (bcom_gen_bd_tx_reset(tsk)) {
  		bcom_task_free(tsk);
@@ -212,7 +215,7 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
  	var =3D (struct bcom_gen_bd_tx_var *) bcom_task_var(tsk->tasknum);
  	inc =3D (struct bcom_gen_bd_tx_inc *) bcom_task_inc(tsk->tasknum);

-	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_tx_task))
+	if (bcom_load_image(tsk->tasknum, priv->microcode))
  		return -1;

  	var->enable	=3D bcom_eng->regs_base +
@@ -253,6 +256,16 @@ bcom_gen_bd_tx_release(struct bcom_task
  }
  EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);

+void
+bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode)
+{
+	struct bcom_gen_bd_priv *priv =3D tsk->priv;
+
+	priv->microcode =3D microcode;
+}
+EXPORT_SYMBOL_GPL(bcom_gen_bd_set_microcode);
+
+
  /* =20
---------------------------------------------------------------------
   * PSC support code
   */
diff -uprN -X linux-2.6.30.3/Documentation/dontdiff =20
linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.h =20
linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.h
--- linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.h	=20
2009-07-24 23:47:51.000000000 +0200
+++ linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.h	=20
2009-10-01 14:26:50.000000000 +0200
@@ -43,6 +43,9 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
  extern void
  bcom_gen_bd_tx_release(struct bcom_task *tsk);

+extern void
+bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode);
+

  /* PSC support utility wrappers */
  struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int =20
queue_len,


--=-XWelNosOMeK8XhYuNugS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKxQk6n/9unNAn/9ERAsliAJ9EB0wuoI5JiYALQ/RRjH2LvaEdrgCeIA/g
4AhZZ0E31anCfUkhJ7JBYgU=
=TU2a
-----END PGP SIGNATURE-----

--=-XWelNosOMeK8XhYuNugS--
