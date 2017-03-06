Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x22a.google.com (mail-pg0-x22a.google.com
 [IPv6:2607:f8b0:400e:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWH56GKzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:39 +1100 (AEDT)
Received: by mail-pg0-x22a.google.com with SMTP id 77so26494481pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:39 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.kw@hitachi.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Geliang Tang <geliangtang@163.com>, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH 03/18] pstore: Avoid race in module unloading
Date: Mon,  6 Mar 2017 13:55:17 -0800
Message-Id: <1488837332-71582-4-git-send-email-keescook@chromium.org>
In-Reply-To: <1488837332-71582-1-git-send-email-keescook@chromium.org>
References: <1488837332-71582-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Technically, it might be possible for struct pstore_info to go out of
scope after the module_put(), so report the backend name first.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 074fe85a2078..d69ef8a840b9 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -722,10 +722,10 @@ int pstore_register(struct pstore_info *psi)
 	 */
 	backend = psi->name;
 
-	module_put(owner);
-
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
+	module_put(owner);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pstore_register);
-- 
2.7.4
