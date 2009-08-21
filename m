Return-Path: <vgallard@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2FD96B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 08:43:20 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8D9D7DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 08:43:19 +1000 (EST)
From: Victor Gallardo <vgallardo@amcc.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH] [JFFS2] Fix csize integer overflow issue due to truncation
Date: Fri, 21 Aug 2009 15:43:15 -0700
Message-Id: <1250894595-21052-1-git-send-email-vgallardo@amcc.com>
Cc: Prodyut Hazarika <phazarika@amcc.com>, linuxppc-dev@ozlabs.org,
	Victor Gallardo <vgallardo@amcc.com>, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a kernel BUG_ON(tn->size == 0) panic in check_node_data
due to integer overflow in read_dnone().

The code incorrectly assigns a uin32_t local variable (csize) to
uint16_t structure member in jffs2_tmp_dnode_info. This results
in an overflow when the local variable csize is greater than
65536 (0x10000)

This issue is seen when kernel PAGE_SIZE is 64K.

The following example illustrates the issue:

fs/jffs2/nodelist.h
  struct jffs2_tmp_dnode_info
  {
    ...
    uint16_t csize;
    ...
  };

fs/jffs2/readinode.c
  static inline int read_dnode(...)
  {
    struct jffs2_tmp_dnode_info *tn;
    uint32_t len, csize;
    ...
    csize = je32_to_cpu(rd->csize);
    ...
    tn->csize = csize;  // <=== result truncated if > 0x10000
    ...
  }

  static int check_node_data(...)
  {
    ...
    BUG_ON(tn->csize == 0);
    ...
  }

Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
Acked-by: Prodyut Hazarika <phazarika@amcc.com>
Acked-by: Feng Kan <fkan@amcc.com>
---
 fs/jffs2/nodelist.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 507ed6e..67f36c3 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -231,7 +231,7 @@ struct jffs2_tmp_dnode_info
 	uint32_t version;
 	uint32_t data_crc;
 	uint32_t partial_crc;
-	uint16_t csize;
+	uint32_t csize;
 	uint16_t overlapped;
 };
 
-- 
1.5.5
