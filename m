Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWH4MXSzDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:39 +1100 (AEDT)
Received: by mail-pf0-x233.google.com with SMTP id j5so65710533pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:39 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
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
Subject: [PATCH 02/18] pstore: Shut down worker when unregistering
Date: Mon,  6 Mar 2017 13:55:16 -0800
Message-Id: <1488837332-71582-3-git-send-email-keescook@chromium.org>
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

When built as a module and running with update_ms >= 0, pstore will Oops
during module unload since the work timer is still running. This makes sure
the worker is stopped before unloading.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
---
 fs/pstore/platform.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cfc1abd264d9..074fe85a2078 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -709,6 +709,7 @@ int pstore_register(struct pstore_info *psi)
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_register_pmsg();
 
+	/* Start watching for new records, if desired. */
 	if (pstore_update_ms >= 0) {
 		pstore_timer.expires = jiffies +
 			msecs_to_jiffies(pstore_update_ms);
@@ -731,6 +732,11 @@ EXPORT_SYMBOL_GPL(pstore_register);
 
 void pstore_unregister(struct pstore_info *psi)
 {
+	/* Stop timer and make sure all work has finished. */
+	pstore_update_ms = -1;
+	del_timer_sync(&pstore_timer);
+	flush_work(&pstore_work);
+
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_unregister_pmsg();
 	if (psi->flags & PSTORE_FLAGS_FTRACE)
@@ -830,7 +836,9 @@ static void pstore_timefunc(unsigned long dummy)
 		schedule_work(&pstore_work);
 	}
 
-	mod_timer(&pstore_timer, jiffies + msecs_to_jiffies(pstore_update_ms));
+	if (pstore_update_ms >= 0)
+		mod_timer(&pstore_timer,
+			  jiffies + msecs_to_jiffies(pstore_update_ms));
 }
 
 module_param(backend, charp, 0444);
-- 
2.7.4
