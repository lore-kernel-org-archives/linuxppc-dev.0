Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2C8B0DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 22:05:24 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 3618B133C0
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 14:05:22 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 1A38813375
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 14:05:22 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: [RFC] cpm_uart: Add generic clock API support to set baudrates
Date: Thu, 24 Jul 2008 14:05:18 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2533707.mdcF20rAr1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200807241405.21770.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2533707.mdcF20rAr1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch introduces baudrate setting support via the generic clock API.
When present the optional device tree clock property is used instead of
fsl-cpm-brg. Platforms can then define complex clock schemes, to output
the serial clock on an external pin for instance.

This is required to support RS485 ports on a platform I'm working on (TBox
CPU32 - see http://www.cse-semaphore.com/products/t-box/t-box-ms.php).

=2D--
 drivers/serial/cpm_uart/cpm_uart.h      |    1 +
 drivers/serial/cpm_uart/cpm_uart_core.c |   26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/c=
pm_uart.h
index d0c55e2..2e64c03 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -77,6 +77,7 @@ struct uart_cpm_port {
 	unsigned char		*rx_buf;
 	u32			flags;
 	void			(*set_lineif)(struct uart_cpm_port *);
+	struct clk		*clk;
 	u8			brg;
 	uint			 dp_addr;
 	void 			*mem_addr;
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_u=
art/cpm_uart_core.c
index d3c19e5..438e460 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -44,6 +44,7 @@
 #include <linux/fs_uart_pd.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/clk.h>
=20
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -641,7 +642,10 @@ static void cpm_uart_set_termios(struct uart_port *por=
t,
 		out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
 	}
=20
=2D	cpm_set_brg(pinfo->brg - 1, baud);
+	if (pinfo->clk)
+		clk_set_rate(pinfo->clk, baud);
+	else
+		cpm_set_brg(pinfo->brg - 1, baud);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
=20
@@ -991,13 +995,21 @@ static int cpm_uart_init_port(struct device_node *np,
 	int ret;
 	int i;
=20
=2D	data =3D of_get_property(np, "fsl,cpm-brg", &len);
=2D	if (!data || len !=3D 4) {
=2D		printk(KERN_ERR "CPM UART %s has no/invalid "
=2D		                "fsl,cpm-brg property.\n", np->name);
=2D		return -EINVAL;
+	data =3D of_get_property(np, "clock", NULL);
+	if (data) {
+		struct clk *clk =3D clk_get(NULL, (const char*)data);
+		if (!IS_ERR(clk))
+			pinfo->clk =3D clk;
+	}
+	if (!pinfo->clk) {
+		data =3D of_get_property(np, "fsl,cpm-brg", &len);
+		if (!data || len !=3D 4) {
+			printk(KERN_ERR "CPM UART %s has no/invalid "
+			                "fsl,cpm-brg property.\n", np->name);
+			return -EINVAL;
+		}
+		pinfo->brg =3D *data;
 	}
=2D	pinfo->brg =3D *data;
=20
 	data =3D of_get_property(np, "fsl,cpm-command", &len);
 	if (!data || len !=3D 4) {
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2533707.mdcF20rAr1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIcAEACgkQ8y9gWxC9vpfECwCfV8GRuemOxwT4l0GedVG4sL53
pE0An1b1xxdPgfi8GBOkjczQZEleiXZe
=ZXq2
-----END PGP SIGNATURE-----

--nextPart2533707.mdcF20rAr1--
