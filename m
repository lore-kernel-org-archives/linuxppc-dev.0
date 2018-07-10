Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Plx40DJhzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 12:08:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: corbet@lwn.net
Cc: keescook@chromium.org, tglx@linutronix.de, konrad.wilk@oracle.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH] Documentation: Add powerpc options for
 spec_store_bypass_disable
Date: Tue, 10 Jul 2018 12:08:36 +1000
Message-Id: <20180710020836.23571-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Document the support for spec_store_bypass_disable that was added for
powerpc in commit a048a07d7f45 ("powerpc/64s: Add support for a store
forwarding barrier at kernel entry/exit").

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

I tried documenting the differences between the PPC options and X86 ones in one
section, but it got quite messy, so I went with this instead. Happy to take
advice on how better to structure it if anyone has opinions.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..f320c7168b04 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4060,6 +4060,8 @@
 			This parameter controls whether the Speculative Store
 			Bypass optimization is used.
 
+			On x86 the options are:
+
 			on      - Unconditionally disable Speculative Store Bypass
 			off     - Unconditionally enable Speculative Store Bypass
 			auto    - Kernel detects whether the CPU model contains an
@@ -4075,12 +4077,20 @@
 			seccomp - Same as "prctl" above, but all seccomp threads
 				  will disable SSB unless they explicitly opt out.
 
-			Not specifying this option is equivalent to
-			spec_store_bypass_disable=auto.
-
 			Default mitigations:
 			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
 
+			On powerpc the options are:
+
+			on,auto - On Power8 and Power9 insert a store-forwarding
+				  barrier on kernel entry and exit. On Power7
+				  perform a software flush on kernel entry and
+				  exit.
+			off	- No action.
+
+			Not specifying this option is equivalent to
+			spec_store_bypass_disable=auto.
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
-- 
2.14.1
