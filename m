Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0086.outbound.protection.outlook.com [104.47.32.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGWB50KcrzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:08:44 +1000 (AEST)
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Brijesh Singh <brijesh.singh@amd.com>
Subject: [RFC Part1 PATCH v3 09/17] resource: Consolidate resource walking code
Date: Mon, 24 Jul 2017 14:07:49 -0500
Message-Id: <20170724190757.11278-10-brijesh.singh@amd.com>
In-Reply-To: <20170724190757.11278-1-brijesh.singh@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tom Lendacky <thomas.lendacky@amd.com>

The walk_iomem_res_desc(), walk_system_ram_res() and walk_system_ram_range()
functions each have much of the same code.  Create a new function that
consolidates the common code from these functions in one place to reduce
the amount of duplicated code.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 kernel/resource.c | 53 ++++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 9b5f044..7b20b3e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -397,9 +397,30 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 		res->start = p->start;
 	if (res->end > p->end)
 		res->end = p->end;
+	res->desc = p->desc;
 	return 0;
 }
 
+static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
+				 bool first_level_children_only,
+				 void *arg, int (*func)(u64, u64, void *))
+{
+	u64 orig_end = res->end;
+	int ret = -1;
+
+	while ((res->start < res->end) &&
+	       !find_next_iomem_res(res, desc, first_level_children_only)) {
+		ret = (*func)(res->start, res->end, arg);
+		if (ret)
+			break;
+
+		res->start = res->end + 1;
+		res->end = orig_end;
+	}
+
+	return ret;
+}
+
 /*
  * Walks through iomem resources and calls func() with matching resource
  * ranges. This walks through whole tree and not just first level children.
@@ -418,26 +439,12 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 		u64 end, void *arg, int (*func)(u64, u64, void *))
 {
 	struct resource res;
-	u64 orig_end;
-	int ret = -1;
 
 	res.start = start;
 	res.end = end;
 	res.flags = flags;
-	orig_end = res.end;
-
-	while ((res.start < res.end) &&
-		(!find_next_iomem_res(&res, desc, false))) {
-
-		ret = (*func)(res.start, res.end, arg);
-		if (ret)
-			break;
-
-		res.start = res.end + 1;
-		res.end = orig_end;
-	}
 
-	return ret;
+	return __walk_iomem_res_desc(&res, desc, false, arg, func);
 }
 
 /*
@@ -451,22 +458,13 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				int (*func)(u64, u64, void *))
 {
 	struct resource res;
-	u64 orig_end;
-	int ret = -1;
 
 	res.start = start;
 	res.end = end;
 	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-	orig_end = res.end;
-	while ((res.start < res.end) &&
-		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
-		ret = (*func)(res.start, res.end, arg);
-		if (ret)
-			break;
-		res.start = res.end + 1;
-		res.end = orig_end;
-	}
-	return ret;
+
+	return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
+				     arg, func);
 }
 
 #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
@@ -508,6 +506,7 @@ static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
 {
 	return 1;
 }
+
 /*
  * This generic page_is_ram() returns true if specified address is
  * registered as System RAM in iomem_resource list.
-- 
2.9.4
