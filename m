Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWG5NMGzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:38 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id 187so16867297pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:38 -0800 (PST)
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
Subject: [PATCH 01/18] pstore: Use dynamic spinlock initializer
Date: Mon,  6 Mar 2017 13:55:15 -0800
Message-Id: <1488837332-71582-2-git-send-email-keescook@chromium.org>
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

The per-prz spinlock should be using the dynamic initializer so that
lockdep can correctly track it. Without this, under lockdep, we get a
warning at boot that the lock is in non-static memory.

Fixes: 109704492ef6 ("pstore: Make spinlock per zone instead of global")
Fixes: 76d5692a5803 ("pstore: Correctly initialize spinlock and flags")
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
---
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index bc927e30bdcc..e11672aa4575 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -532,7 +532,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	}
 
 	/* Initialize general buffer state. */
-	prz->buffer_lock = __RAW_SPIN_LOCK_UNLOCKED(buffer_lock);
+	raw_spin_lock_init(&prz->buffer_lock);
 	prz->flags = flags;
 
 	ret = persistent_ram_buffer_map(start, size, prz, memtype);
-- 
2.7.4
