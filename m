Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C2C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 14:22:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89828214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Hx+BfaS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89828214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pQdQ1VMqzDq6K
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 00:22:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Hx+BfaS/"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pQbM0LxZzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 00:20:46 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pQbD5pl0zB09ZV;
 Tue, 23 Apr 2019 16:20:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Hx+BfaS/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id VdpRqyoSUggc; Tue, 23 Apr 2019 16:20:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pQbD4fHrz9v08G;
 Tue, 23 Apr 2019 16:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556029240; bh=fNqEjI2ZoGaORHatXbuqSr7VvXw1i5InB9mRSTYkSZg=;
 h=From:Subject:To:Cc:Date:From;
 b=Hx+BfaS/078i1Izh+JCP9TwRlOmYEo7khlERzQM40DQ08mbDtFoXaXnx0f8pZJ7aQ
 23kU/vdSR7I4cDiMWT/Ed48mYoJtUNQIG/9goAqqW204Z/eW3omWR3PHX+3tuZflde
 IZKbryBSuQlptGvdBkmuk0+RPCXQ4NVaY72lSegM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 062648B8E1;
 Tue, 23 Apr 2019 16:20:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Gsr_NR8wpuik; Tue, 23 Apr 2019 16:20:41 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C0F1B8B8C4;
 Tue, 23 Apr 2019 16:20:41 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2176F666CF; Tue, 23 Apr 2019 14:20:40 +0000 (UTC)
Message-Id: <2d3a59015307d368d6ac1a62fe7e47f5b39e2fe2.1556028978.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/4] powerpc/boot: don't force gzipped uImage
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 23 Apr 2019 14:20:40 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch modifies the generation of uImage by handing over
the selected compression type instead of forcing gzip

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 v2: no change
---
 arch/powerpc/boot/wrapper | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index f9141eaec6ff..4e9beecf2502 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -41,6 +41,7 @@ dts=
 cacheit=
 binary=
 compression=.gz
+uboot_comp=gzip
 pie=
 format=
 
@@ -131,6 +132,7 @@ while [ "$#" -gt 0 ]; do
 	;;
     -z)
 	compression=.gz
+	uboot_comp=gzip
 	;;
     -Z)
 	shift
@@ -138,15 +140,21 @@ while [ "$#" -gt 0 ]; do
         [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "none" ] || usage
 
 	compression=".$1"
+	uboot_comp=$1
 
         if [ $compression = ".none" ]; then
                 compression=
+		uboot_comp=none
         fi
+	if [ $uboot_comp = "gz" ]; then
+		uboot_comp=gzip
+	fi
 	;;
     --no-gzip)
         # a "feature" of the the wrapper script is that it can be used outside
         # the kernel tree. So keeping this around for backwards compatibility.
         compression=
+	uboot_comp=none
         ;;
     -?)
 	usage
@@ -369,6 +377,7 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
+	uboot_comp=none
 	;;
     esac
 
@@ -412,7 +421,7 @@ membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
 case "$platform" in
 uboot)
     rm -f "$ofile"
-    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
+    ${MKIMAGE} -A ppc -O linux -T kernel -C $uboot_comp -a $membase -e $membase \
 	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
-- 
2.13.3

