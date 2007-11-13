Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DBADBDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 05:29:11 +1100 (EST)
Message-ID: <4739ECDA.4010200@scram.de>
Date: Tue, 13 Nov 2007 19:28:42 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] powerpc: Add support for PORTA and PORTB odr registers
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

PORTA and PORTB have odr registers, as well. However, the PORTB odr
register is only 16bit.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/commproc.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index d5a0dcf..3694a69 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -441,6 +441,13 @@ static void cpm1_set_pin32(int port, int pin, int flags)
 	else
 		clrbits32(&iop->par, pin);
 
+	if (port == CPM_PORTB) {
+		if (flags & CPM_PIN_OPENDRAIN)
+			setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
+		else
+			clrbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
+	}
+
 	if (port == CPM_PORTE) {
 		if (flags & CPM_PIN_SECONDARY)
 			setbits32(&iop->sor, pin);
@@ -474,6 +481,12 @@ static void cpm1_set_pin16(int port, int pin, int flags)
 	else
 		clrbits16(&iop->par, pin);
 
+	if (port == CPM_PORTA) {
+		if (flags & CPM_PIN_OPENDRAIN)
+			setbits16(&iop->odr, pin);
+		else
+			clrbits16(&iop->odr, pin);
+	}
 	if (port == CPM_PORTC) {
 		if (flags & CPM_PIN_SECONDARY)
 			setbits16(&iop->sor, pin);
-- 
1.5.3.5
