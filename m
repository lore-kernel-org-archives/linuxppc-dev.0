Return-Path: <muvarov@gmail.com>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by ozlabs.org (Postfix) with ESMTP id 2B0ACB7D8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 01:41:40 +1000 (EST)
Received: by wwb24 with SMTP id 24so2993953wwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 08:41:38 -0700 (PDT)
From: Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH] [POWEPC] crashdump: do not fail on null pointer dereferencing
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	uvarov@dev.rtsoft.ru
Date: Tue, 11 May 2010 19:41:08 +0400
Message-ID: <20100511154108.11546.12066.stgit@muvarov>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Best regards,
Maxim Uvarov.

From: Maxim Uvarov <muvarov@gmail.com>

Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 arch/powerpc/kernel/crash.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 6f4613d..341d8af 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -375,6 +375,9 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	for_each_irq(i) {
 		struct irq_desc *desc = irq_to_desc(i);
 
+		if (!desc || !desc->chip || !desc->chip->eoi)
+			continue;
+
 		if (desc->status & IRQ_INPROGRESS)
 			desc->chip->eoi(i);
 
