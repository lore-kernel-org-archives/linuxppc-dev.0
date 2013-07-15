Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4FF62C0240
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:55:47 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 16 Jul 2013 02:40:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 43B8A3578051
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:55:45 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6FGeM8C3932542
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:40:22 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6FGthBY010554
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:55:44 +1000
Subject: [PATCH 03/11] pstore/Kconfig: Select ZLIB_DEFLATE and ZLIB_INFLATE
 when PSTORE is selected
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 22:25:37 +0530
Message-ID: <20130715165537.1520.88939.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pstore will make use of deflate and inflate algorithm to compress and decompress
the data. So when Pstore is enabled select zlib_deflate and zlib_inflate.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 fs/pstore/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index ca71db6..983d951 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -1,6 +1,8 @@
 config PSTORE
 	bool "Persistent store support"
 	default n
+	select ZLIB_DEFLATE
+	select ZLIB_INFLATE
 	help
 	   This option enables generic access to platform level
 	   persistent storage via "pstore" filesystem that can
