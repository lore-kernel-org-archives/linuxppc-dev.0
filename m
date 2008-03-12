Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id CD174DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:45:49 +1100 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 46E112B63
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:45:45 -0400 (EDT)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53]) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
	ESMTP id
	091A42B61 for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:45:43 -0400
	(EDT)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] maple: use platform name in define_machine()
Date: Wed, 12 Mar 2008 18:43:03 -0500
Message-Id: <1205365385-28315-2-git-send-email-ntl@pobox.com>
In-Reply-To: <1205365385-28315-1-git-send-email-ntl@pobox.com>
References: <1205365385-28315-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Prevailing practice for define_machine() in powerpc is to use the
platform name when the platform has only one define_machine()
statement, but maple uses "maple_md".  This caused me some
head-scratching when writing some new code that uses
machine_is(maple).

Use "maple" instead of "maple_md".  There should not be any behavioral
change -- fixup_maple_ide() calls machine_is(maple) but the body of
the function is ifdef'd out.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 3ce2d73..3b32e07 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -319,7 +319,7 @@ static int __init maple_probe(void)
 	return 1;
 }
 
-define_machine(maple_md) {
+define_machine(maple) {
 	.name			= "Maple",
 	.probe			= maple_probe,
 	.setup_arch		= maple_setup_arch,
-- 
1.5.4.4
