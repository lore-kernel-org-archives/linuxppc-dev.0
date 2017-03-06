Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWG71c1zDqXf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:38 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id b129so70802330pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:38 -0800 (PST)
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
Subject: [PATCH 04/18] pstore: Improve register_pstore() error reporting
Date: Mon,  6 Mar 2017 13:55:18 -0800
Message-Id: <1488837332-71582-5-git-send-email-keescook@chromium.org>
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

Uncommon errors are better to get reported to dmesg so developers can
more easily figure out why pstore is unhappy with a backend attempting
to register.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d69ef8a840b9..320a673ecb5b 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -673,11 +673,15 @@ int pstore_register(struct pstore_info *psi)
 {
 	struct module *owner = psi->owner;
 
-	if (backend && strcmp(backend, psi->name))
+	if (backend && strcmp(backend, psi->name)) {
+		pr_warn("ignoring unexpected backend '%s'\n", psi->name);
 		return -EPERM;
+	}
 
 	spin_lock(&pstore_lock);
 	if (psinfo) {
+		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
+			psinfo->name, psi->name);
 		spin_unlock(&pstore_lock);
 		return -EBUSY;
 	}
-- 
2.7.4
