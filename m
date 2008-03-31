Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 4B335DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:48:49 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv3 1/4] cpm_uart: Allocate DPRAM memory for SMC ports on
	CPM2-based platforms.
Date: Mon, 31 Mar 2008 18:35:35 +0200
References: <200803311834.42327.laurentp@cse-semaphore.com>
In-Reply-To: <200803311834.42327.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1232634.JBgBdFo8Pl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803311835.35900.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1232634.JBgBdFo8Pl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch allocates parameter RAM for SMC serial ports without relying on
previous initialisation by a boot loader or a wrapper layer.

SMC parameter RAM on CPM2-based platforms can be allocated anywhere in the
general-purpose areas of the dual-port RAM. The current code relies on the
boot loader to allocate a section of general-purpose CPM RAM and gets the
section address from the device tree.

This patch modifies the device tree address usage to reference the SMC
parameter RAM base pointer instead of a pre-allocated RAM section and
allocates memory from the CPM dual-port RAM when initialising the SMC port.
CPM1-based platforms are not affected.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/serial/cpm_uart/cpm_uart.h      |    3 ++
 drivers/serial/cpm_uart/cpm_uart_core.c |   19 +++++------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |   12 +++++++
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |   52 +++++++++++++++++++++++++++=
++++
 4 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/c=
pm_uart.h
index 80a7d60..5334653 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -93,6 +93,9 @@ extern struct uart_cpm_port cpm_uart_ports[UART_NR];
=20
 /* these are located in their respective files */
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd);
+void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
+				struct device_node *np);
+void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram);
 int cpm_uart_init_portdesc(void);
 int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con);
 void cpm_uart_freebuf(struct uart_cpm_port *pinfo);
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_u=
art/cpm_uart_core.c
index 1ea123c..3a44a3f 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -997,24 +997,23 @@ static int cpm_uart_init_port(struct device_node *np,
 	if (!mem)
 		return -ENOMEM;
=20
=2D	pram =3D of_iomap(np, 1);
=2D	if (!pram) {
=2D		ret =3D -ENOMEM;
=2D		goto out_mem;
=2D	}
=2D
 	if (of_device_is_compatible(np, "fsl,cpm1-scc-uart") ||
 	    of_device_is_compatible(np, "fsl,cpm2-scc-uart")) {
 		pinfo->sccp =3D mem;
=2D		pinfo->sccup =3D pram;
+		pinfo->sccup =3D pram =3D cpm_uart_map_pram(pinfo, np);
 	} else if (of_device_is_compatible(np, "fsl,cpm1-smc-uart") ||
 	           of_device_is_compatible(np, "fsl,cpm2-smc-uart")) {
 		pinfo->flags |=3D FLAG_SMC;
 		pinfo->smcp =3D mem;
=2D		pinfo->smcup =3D pram;
+		pinfo->smcup =3D pram =3D cpm_uart_map_pram(pinfo, np);
 	} else {
 		ret =3D -ENODEV;
=2D		goto out_pram;
+		goto out_mem;
+	}
+
+	if (!pram) {
+		ret =3D -ENOMEM;
+		goto out_mem;
 	}
=20
 	pinfo->tx_nrfifos =3D TX_NUM_FIFO;
@@ -1038,7 +1037,7 @@ static int cpm_uart_init_port(struct device_node *np,
 	return cpm_uart_request_port(&pinfo->port);
=20
 out_pram:
=2D	iounmap(pram);
+	cpm_uart_unmap_pram(pinfo, pram);
 out_mem:
 	iounmap(mem);
 	return ret;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_u=
art/cpm_uart_cpm1.c
index 6ea0366..e692593 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -54,6 +54,18 @@ void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
 	cpm_command(port->command, cmd);
 }
+
+void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
+				struct device_node *np)
+{
+	return of_iomap(np, 1);
+}
+
+void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram)
+{
+	iounmap(pram);
+}
+
 #else
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_u=
art/cpm_uart_cpm2.c
index 6291094..a4cfb0b 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -41,6 +41,9 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/fs_pd.h>
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+#include <asm/prom.h>
+#endif
=20
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -54,6 +57,55 @@ void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
 	cpm_command(port->command, cmd);
 }
+
+void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
+				struct device_node *np)
+{
+	void __iomem *pram;
+	unsigned long offset;
+	struct resource res;
+	unsigned long len;
+
+	/* Don't remap parameter RAM if it has already been initialized
+	 * during console setup.
+	 */
+	if (IS_SMC(port) && port->smcup)
+		return port->smcup;
+	else if (!IS_SMC(port) && port->sccup)
+		return port->sccup;
+
+	if (of_address_to_resource(np, 1, &res))
+		return NULL;
+
+	len =3D 1 + res.end - res.start;
+	pram =3D ioremap(res.start, len);
+	if (!pram)
+		return NULL;
+
+	if (!IS_SMC(port))
+		return pram;
+
+	if (len !=3D 2) {
+		printk(KERN_WARNING "cpm_uart[%d]: device tree references "
+			"SMC pram, using boot loader/wrapper pram mapping. "
+			"Please fix your device tree to reference the pram "
+			"base register instead.\n",
+			port->port.line);
+		return pram;
+	}
+
+	offset =3D cpm_dpalloc(PROFF_SMC_SIZE, 64);
+	out_be16(pram, offset);
+	iounmap(pram);
+	return cpm_muram_addr(offset);
+}
+
+void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram)
+{
+	if (!IS_SMC(port))
+		iounmap(pram);
+}
+
 #else
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1232634.JBgBdFo8Pl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8RLX8y9gWxC9vpcRAupOAJwPKE15zF4HaTCGHOCnLBNjAdPSmgCfUgKw
6OR7kcU3Q+ZLCjUD8D2H76w=
=gPEs
-----END PGP SIGNATURE-----

--nextPart1232634.JBgBdFo8Pl--
