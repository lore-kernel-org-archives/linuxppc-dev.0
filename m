Return-Path: <olson@cumulusnetworks.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5B441A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 09:14:24 +1100 (AEDT)
Received: by pdno5 with SMTP id o5so11982599pdn.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2015 14:14:22 -0800 (PST)
Date: Mon, 9 Feb 2015 14:14:21 -0800
From: Dave Olson <olson@cumulusnetworks.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
Message-ID: <20150209221421.GA22286@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Olson <olson@cumulusnetworks.com>

Fix missing L2 cache size in /sys/devices/system/cpu/cpu0/cache/index2/size
This bug appears to be introduced in 2.6.29 by 93197a36a9c16a85fb24cf5a8639f7bf9af838a3.
The missing entry caused lscpu to error out on e500v2 devices, and probably others
 error: cannot open /sys/devices/system/cpu/cpu0/cache/index2/size: No such file or directory
The DTS files we see use cache-size for the unified L2 cache size, not d-cache-size

Signed-off-by: Dave Olson <olson@cumulusnetworks.com>

---

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 40198d5..9ca1e9a 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -72,7 +72,7 @@ static const struct cache_type_info cache_type_info[] = {
 		 * must be equal on unified caches, so just use
 		 * d-cache properties. */
 		.name            = "Unified",
-		.size_prop       = "d-cache-size",
+		.size_prop       = "cache-size",
 		.line_size_props = { "d-cache-line-size",
 				     "d-cache-block-size", },
 		.nr_sets_prop    = "d-cache-sets",
