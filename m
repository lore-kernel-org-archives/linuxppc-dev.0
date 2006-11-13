Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 09FA367DDA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 19:22:46 +1100 (EST)
Date: Mon, 13 Nov 2006 11:22:30 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
Message-ID: <20061113112230.4c1af7b0@localhost.localdomain>
In-Reply-To: <17749.46096.241328.470093@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
	<17748.21645.621069.105453@cargo.ozlabs.ibm.com>
	<a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
	<Pine.LNX.4.64.0611101359200.25024@host32.eke.fi>
	<17749.46096.241328.470093@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_w7uat0aqqOUB_SBiASCfbyl;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_w7uat0aqqOUB_SBiASCfbyl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Paul,

patch with proper description inlined.

Thanks,
-Vitaly
---
[POWERPC] CPM_UART: Fixes inconsistency of function definition

From: Kalle Pokki <kalle.pokki@iki.fi>

The below hunk was missed from the recent patch, and now, there are somewha=
t=20
inconsistent definitions:

in cpm_uart.h:
int __init cpm_uart_init_portdesc(void);

in cpm_uart_cpm1.c:
int __init cpm_uart_init_portdesc(void)
{
}

in cpm_uart_cpm2.c:
int cpm_uart_init_portdesc(void)
{
}

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_u=
art/cpm_uart_cpm2.c
index b691d3e..787a8f1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -282,7 +282,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
 }
=20
 /* Setup any dynamic params in the uart desc */
-int cpm_uart_init_portdesc(void)
+int __init cpm_uart_init_portdesc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
 	u32 addr;

--Sig_w7uat0aqqOUB_SBiASCfbyl
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWCtHuOg9JvQhSEsRApa0AJsE/c1WWyJ8IlHTW7EFF6qDnPtjuACfQdJs
r8UXh/AjeCj8HwnhtOyS1hM=
=seqh
-----END PGP SIGNATURE-----

--Sig_w7uat0aqqOUB_SBiASCfbyl--
