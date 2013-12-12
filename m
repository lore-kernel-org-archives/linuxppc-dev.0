Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 92EA82C02FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 11:19:11 +1100 (EST)
Message-Id: <3d9d024551c3c0e560d77f81926cb5774dda7067.1386807069.git.geoff@infradead.org>
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
References: <cover.1386807069.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/4] kexec: Add IND_FLAGS macro
To: Eric Biederman <ebiederm@xmission.com>
Date: Thu, 12 Dec 2013 00:18:56 +0000
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
all the possible kexec IND_ kimage_entry indirection flags.

Having this macro allows for simplified code in the prosessing of the
kexec kimage_entry items.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 include/linux/kexec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d78d28a..f755ec3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -67,6 +67,7 @@ typedef unsigned long kimage_entry_t;
 #define IND_INDIRECTION  0x2
 #define IND_DONE         0x4
 #define IND_SOURCE       0x8
+#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
 
 struct kexec_segment {
 	void __user *buf;
-- 
1.8.1.2
