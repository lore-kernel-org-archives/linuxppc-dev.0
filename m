Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1681C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:12:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6812D208E4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxfuCnxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6812D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49KGzF5PZ4zDr1N
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 05:12:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KGgz6Kj0zDr5R
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 04:58:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hrdjt8PAYlRcK9St65pLelHqmaCoNpXHENLe8hK4Z60=; b=nxfuCnxfquzTGx2mvl5MicECy7
 3PGV6fYU1tcGZW+3d9uTnfhOhoTUJtnoar/3vKQLVKh4WZkNlptv0I1GjWhnZZHgX6nmyYeQ9SvjD
 0EnQDdj+zKEtqyxe5UUi36JpOyVfr82KbA1RREXrG3iVcDZuCgQohZyVewAqSEwltZz/Zxo+Wdert
 Erw1k7H26Bhn3nbIXHawCMWVvGjMI8IIiidO1ecAKZqIberR5WmLo5tpCUnZWmpCzzKW+dD0+EkGg
 HThPj/51C5DtK8crl59d7OUjNwo3rGoLZDd+NR1HxUqk74HIN2NisyX/2a/OnbBt/I5ak+kRrzkoH
 u/4lzEGA==;
Received: from geoff by merlin.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jXUgB-0003Di-PP; Sat, 09 May 2020 18:58:31 +0000
Message-Id: <fb477f5e91c6b74a1dec98df3cc0a1c91632d94d.1589049250.git.geoff@infradead.org>
In-Reply-To: <cover.1589049250.git.geoff@infradead.org>
References: <cover.1589049250.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Fri, 27 Mar 2020 09:41:41 -0700
Subject: [PATCH v2 2/9] powerpc/wrapper: Output linker map file
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 09 May 2020 18:58:31 +0000
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

To aid debugging wrapper troubles, output a linker map file
'wrapper.map' when the build is verbose.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/boot/wrapper | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ed6266367bc0..35ace40d9fc2 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -29,6 +29,7 @@ set -e
 # Allow for verbose output
 if [ "$V" = 1 ]; then
     set -x
+    map="-Map wrapper.map"
 fi
 
 # defaults
@@ -500,7 +501,7 @@ if [ "$platform" != "miboot" ]; then
         text_start="-Ttext $link_address"
     fi
 #link everything
-    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" \
+    ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" $map \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
-- 
2.20.1


