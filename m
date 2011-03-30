Return-Path: <richardcochran@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09E77B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 00:25:19 +1100 (EST)
Received: by bwz10 with SMTP id 10so956309bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 06:25:14 -0700 (PDT)
Date: Wed, 30 Mar 2011 15:25:04 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: rename get_irq_desc_data and get_irq_desc_chip
Message-ID: <20110330132504.GA31832@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lennert Buytenhek <buytenh@secretlab.ca>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two functions disappeared in commit

    0c6f8a8b917ad361319c8ace3e9f28e69bfdb4c1
    "genirq: Remove compat code"

but they still exist in qe_ic.h.
This patch renames the function to their new names.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 arch/powerpc/include/asm/qe_ic.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe_ic.h
index 9e2cb20..f706164 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -81,7 +81,7 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = get_irq_desc_data(desc);
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
 	if (cascade_irq != NO_IRQ)
@@ -91,7 +91,7 @@ static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 					   struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = get_irq_desc_data(desc);
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
 	if (cascade_irq != NO_IRQ)
@@ -101,9 +101,9 @@ static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 static inline void qe_ic_cascade_low_mpic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = get_irq_desc_data(desc);
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
@@ -114,9 +114,9 @@ static inline void qe_ic_cascade_low_mpic(unsigned int irq,
 static inline void qe_ic_cascade_high_mpic(unsigned int irq,
 					   struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = get_irq_desc_data(desc);
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
@@ -127,9 +127,9 @@ static inline void qe_ic_cascade_high_mpic(unsigned int irq,
 static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
 					    struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = get_irq_desc_data(desc);
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq;
-	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	cascade_irq = qe_ic_get_high_irq(qe_ic);
 	if (cascade_irq == NO_IRQ)
-- 
1.7.0.4
