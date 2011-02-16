Return-Path: <jdboyer@media5corp.com>
Received: from MAIL1.mediatrix.com (mail1.mediatrix.com [207.134.65.15])
	by ozlabs.org (Postfix) with ESMTP id 95DE3B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Feb 2011 02:11:27 +1100 (EST)
From: Jean-Denis Boyer <jdboyer@media5corp.com>
To: 'Anton Vorontsov' <avorontsov@ru.mvista.com>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 16 Feb 2011 09:59:11 -0500
Subject: Bug in arch/powerpc/sysdev/fsl_gtm.c
Message-ID: <265ED5BA1B926340AF277A54E6A8341441FD6401F2@exchange.media5corp.com>
Content-Type: multipart/mixed;
	boundary="_002_265ED5BA1B926340AF277A54E6A8341441FD6401F2exchangemedia_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_002_265ED5BA1B926340AF277A54E6A8341441FD6401F2exchangemedia_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.
There is a bug in the function gtm_set_ref_timer16.
When called, it correctly sets the requested timer,
but the other timer that shares the register GTCFR is reset.

The parameter 'clear' passed to macro clrsetbits_8 should not be
a bitwise complement, since the macro already complements it.

Here is a patch that should fix this issue.

--- linux-2.6.35.11/arch/powerpc/sysdev/fsl_gtm.c
+++ linux/arch/powerpc/sysdev/fsl_gtm.c
@@ -203,13 +203,10 @@
 	spin_lock_irqsave(&gtm->lock, flags);
=20
 	/*
-	 * Properly reset timers: stop, reset, set up prescalers, reference
+	 * Properly set timers: stop, set up prescalers, reference
 	 * value and clear event register.
 	 */
-	clrsetbits_8(tmr->gtcfr, ~(GTCFR_STP(num) | GTCFR_RST(num)),
-				 GTCFR_STP(num) | GTCFR_RST(num));
-
-	setbits8(tmr->gtcfr, GTCFR_STP(num));
+	setbits8(tmr->gtcfr, GTCFR_STP(num) | GTCFR_RST(num));
=20
 	if (tmr->gtpsr)
 		out_be16(tmr->gtpsr, psr);

Regards,

Jean-Denis Boyer, Eng.
Media5 Corporation - Mediatrix, M5T, Media5Boss
4229 Garlock Street, Sherbrooke (Qu=E9bec), J1L 2C8, CANADA
(819)829-8749 x5241


--_002_265ED5BA1B926340AF277A54E6A8341441FD6401F2exchangemedia_
Content-Type: application/octet-stream; name="fsl_gtm.patch"
Content-Description: fsl_gtm.patch
Content-Disposition: attachment; filename="fsl_gtm.patch"; size=585;
	creation-date="Wed, 16 Feb 2011 09:02:28 GMT";
	modification-date="Tue, 15 Feb 2011 22:14:39 GMT"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4zNS4xMS9hcmNoL3Bvd2VycGMvc3lzZGV2L2ZzbF9ndG0uYworKysgbGlu
dXgvYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfZ3RtLmMKQEAgLTIwMywxMyArMjAzLDEwIEBACiAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmd0bS0+bG9jaywgZmxhZ3MpOwogCiAJLyoKLQkgKiBQcm9wZXJs
eSByZXNldCB0aW1lcnM6IHN0b3AsIHJlc2V0LCBzZXQgdXAgcHJlc2NhbGVycywgcmVmZXJlbmNl
CisJICogUHJvcGVybHkgc2V0IHRpbWVyczogc3RvcCwgc2V0IHVwIHByZXNjYWxlcnMsIHJlZmVy
ZW5jZQogCSAqIHZhbHVlIGFuZCBjbGVhciBldmVudCByZWdpc3Rlci4KIAkgKi8KLQljbHJzZXRi
aXRzXzgodG1yLT5ndGNmciwgfihHVENGUl9TVFAobnVtKSB8IEdUQ0ZSX1JTVChudW0pKSwKLQkJ
CQkgR1RDRlJfU1RQKG51bSkgfCBHVENGUl9SU1QobnVtKSk7Ci0KLQlzZXRiaXRzOCh0bXItPmd0
Y2ZyLCBHVENGUl9TVFAobnVtKSk7CisJc2V0Yml0czgodG1yLT5ndGNmciwgR1RDRlJfU1RQKG51
bSkgfCBHVENGUl9SU1QobnVtKSk7CiAKIAlpZiAodG1yLT5ndHBzcikKIAkJb3V0X2JlMTYodG1y
LT5ndHBzciwgcHNyKTsK

--_002_265ED5BA1B926340AF277A54E6A8341441FD6401F2exchangemedia_--
