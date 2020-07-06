Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61F3206F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61F3206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0mYD1N3qzDqRw
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 23:26:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0mV66v0VzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 23:23:26 +1000 (AEST)
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MY6TD-1kQJV83zEz-00YREB; Mon, 06 Jul 2020 15:23:08 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/spufs: add CONFIG_COREDUMP dependency
Date: Mon,  6 Jul 2020 15:22:46 +0200
Message-Id: <20200706132302.3885935-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HSXUex+Hyp8M4v2RjcnosYJe4sr40EmqBm+xjrUdR7+o2Misc3r
 1kMmJqevXZ+qBLu+u8C1+358+EB894VzeRa/AQM+0IHCYPnJVj5fRA2mq/65V6wxvYVhIj6
 zOp5dCgWD+MECVW7a8vGH0/OqPW2bem3MWbubeSwLJnCWlxmdyl4cO54pBlGlGTlhhBjSkd
 Z4xrvlkn/NwEguUFG+SqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X6Xvt1YNp3A=:WWupkQhwaFleUuNXgLc0f/
 tHVkc3VldLYoIXJ1rTalgheXkZyp7GOgWruRR+qtgVacg6Kl6Fn3dz1uf5afbC42HO6LXLWGC
 sa4iwUcnDJlMiWu1qtOXUOdEOz6JUmn/UcM5a9o5L6tbsNjIVERP/1VMach0I/GMNdbz08pDa
 YwM+TS1/wlylHNmsHkL3GcSFr7rfve/ZpAsrqTX0iywdNw/HN6eVrXpi1Rzl0/zyE9gE51TnM
 oLrtHIuBHBxKRWiI08edAnzEcdZOsM/O+cmzcmqOwT68128Joh3u/WUzekAEd/MNsPj6P7AEs
 xLcwxaH3xu50aWJvy8oSnrgWL2my1H4NV3phGi0/XYeeP3nfaA5Tls8KH4HToFefFuxuM4npb
 1wExSjZHxlYJwlmCXkD5mx66RMnUHWeeoLKZq5qRwrqkjpiufZ3vOFZsCcpGunTwbYkJbYOZ+
 cDVucuzMAnwZxjKXflENqXqfdHf7oYyJCnuHlrhHL0IfEGG27Fr0JIn7+f+au/z0MPTUJ2MoR
 UuxuUWKuqKS9+RvRX0Rl5YxHlxlXqIgPFqNLi2Xz9TRLurIUV2gMGGiRktczq8Hou27xOpx7J
 JY+Ngug8odcydALXT8wtxOdmzSYYr0PYJ2VwK8U7l8XS23tROStxh8McuaGDxONDMIF2FqTQ5
 WBHJ9OEBtrDCNm3i/19w8WkV/DjjtAxlRNALQ2leeJa2P8kszbSR3+K91IIP7139s4AtI51Z/
 C0vjQNW6Vw2kdHfUXXgBmfQ+py1gbH4PcE1GuqNmomGG0HtrXa8/1WDCb6dsN22R5S3FKTP9d
 90EJApMcEhSxOmvfESfuw2YCiZRhhT5nF4kxO2j0xjNRigg/DSK1pM9o4n47Mz51R0fk5ui
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
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The kernel test robot pointed out a slightly different error message
after recent commit 5456ffdee666 ("powerpc/spufs: simplify spufs core
dumping") to spufs for a configuration that never worked:

   powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_proxydma_info_dump':
>> file.c:(.text+0x4c68): undefined reference to `.dump_emit'
   powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_dma_info_dump':
   file.c:(.text+0x4d70): undefined reference to `.dump_emit'
   powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_wbox_info_dump':
   file.c:(.text+0x4df4): undefined reference to `.dump_emit'

Add a Kconfig dependency to prevent this from happening again.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 0f7c8241912b..f2ff359041ee 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -44,6 +44,7 @@ config SPU_FS
 	tristate "SPU file system"
 	default m
 	depends on PPC_CELL
+	depends on COREDUMP
 	select SPU_BASE
 	help
 	  The SPU file system is used to access Synergistic Processing
-- 
2.27.0

