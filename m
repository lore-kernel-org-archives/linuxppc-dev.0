Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C2FC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 11:15:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808962080F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 11:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808962080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GSdz6NLRzDrLk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 22:15:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GSX80WBCzDr7b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 22:10:48 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A3E2307C94C;
 Fri, 14 Dec 2018 11:10:46 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-139.ams2.redhat.com [10.36.117.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3F276836F;
 Fri, 14 Dec 2018 11:10:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 1/9] agp: efficeon: no need to set PG_reserved on GATT
 tables
Date: Fri, 14 Dec 2018 12:10:06 +0100
Message-Id: <20181214111014.15672-2-david@redhat.com>
In-Reply-To: <20181214111014.15672-1-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 14 Dec 2018 11:10:46 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@redhat.com>, David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The l1 GATT page table is kept in a special on-chip page with 64 entries.
We allocate the l2 page table pages via get_zeroed_page() and enter them
into the table. These l2 pages are modified accordingly when
inserting/removing memory via efficeon_insert_memory and
efficeon_remove_memory.

Apart from that, these pages are not exposed or ioremap'ed. We can stop
setting them reserved (propably copied from generic code).

Cc: David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/char/agp/efficeon-agp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index 7f88490b5479..c53f0f9ef5b0 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -163,7 +163,6 @@ static int efficeon_free_gatt_table(struct agp_bridge_data *bridge)
 		unsigned long page = efficeon_private.l1_table[index];
 		if (page) {
 			efficeon_private.l1_table[index] = 0;
-			ClearPageReserved(virt_to_page((char *)page));
 			free_page(page);
 			freed++;
 		}
@@ -219,7 +218,6 @@ static int efficeon_create_gatt_table(struct agp_bridge_data *bridge)
 			efficeon_free_gatt_table(agp_bridge);
 			return -ENOMEM;
 		}
-		SetPageReserved(virt_to_page((char *)page));
 
 		for (offset = 0; offset < PAGE_SIZE; offset += clflush_chunk)
 			clflush((char *)page+offset);
-- 
2.17.2

