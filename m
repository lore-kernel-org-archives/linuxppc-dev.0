Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B22B1A08DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:24:11 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 13:54:09 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 53EF9125805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:53:28 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8OwKI49545448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:58 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8O4xx018406
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:04 +0530
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc: start loop at section start of start in
 vmemmap_populated()
Date: Wed, 11 Jun 2014 16:23:39 +0800
Message-Id: <1402475019-19699-4-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vmemmap_populated() checks whether the [start, start + page_size) has valid
pfn numbers, to know whether a vmemmap mapping has been created that includes
this range.

Some range before end might not be checked by this loop:
  sec11start......start11..sec11end/sec12start..end....start12..sec12end
as the above, for start11(section 11), it checks [sec11start, sec11end), and
loop ends as the next start(start12) is bigger than end. However,
[sec11end/sec12start, end) is not checked here.

So before the loop, adjust the start to be the start of the section, so we don't miss ranges like the above.

After we adjust start to be the start of the section, it also means it's
aligned with vmemmap as of the sizeof struct page, so we could use
page_to_pfn directly in the loop.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 4963790..253b4b9 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -175,9 +175,10 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
 static int __meminit vmemmap_populated(unsigned long start, int page_size)
 {
 	unsigned long end = start + page_size;
+	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
 
 	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
-		if (pfn_valid(vmemmap_section_start(start)))
+		if (pfn_valid(page_to_pfn((struct page *)start)))
 			return 1;
 
 	return 0;
-- 
1.7.9.5
