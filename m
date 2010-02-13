Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187]) by ozlabs.org (Postfix) with ESMTP id 974F4B7DD7
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 03:02:42 +1100 (EST)
Received: by pxi17 with SMTP id 17so834000pxi.11
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 08:02:41 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/9] proc_devtree: fix THIS_MODULE without module.h
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org,
	jeremy.kerr@canonical.com, davem@davemloft.net,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Date: Sat, 13 Feb 2010 09:02:37 -0700
Message-ID: <20100213160236.4767.48310.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
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

From: Jeremy Kerr <jeremy.kerr@canonical.com>

Commit e22f628395432b967f2f505858c64450f7835365 introduced a build
breakage for ARM devtree work: the THIS_MODULE macro was added, but we
don't have module.h

This change adds the necessary #include to get THIS_MODULE defined.
While we could just replace it with NULL (PROC_FS is a bool, not a
tristate), using THIS_MODULE will prevent unexpected breakage if we
ever do compile this as a module.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 fs/proc/proc_devtree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index 0ec4511..f8650dc 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -11,6 +11,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/of.h>
+#include <linux/module.h>
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include "internal.h"
