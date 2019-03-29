Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991EEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 08:46:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102252082F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 08:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TsRRUTjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102252082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VwMf52l2zDqR7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 19:46:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="TsRRUTjI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VwDB6gD7zDqSw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 19:40:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44VwD501Wdz9v0nB;
 Fri, 29 Mar 2019 09:40:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=TsRRUTjI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id gDxM64uhAlSn; Fri, 29 Mar 2019 09:40:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44VwD45KQrz9v0n9;
 Fri, 29 Mar 2019 09:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553848820; bh=koHETluniav0+RASqkAnJs+Qi2Jh0mqL4hpr+62Nz60=;
 h=From:Subject:To:Cc:Date:From;
 b=TsRRUTjI/XEK8aWcyej7Qw4Pj/3qfpsUWMAHftoOQzOvrEXJJ1bTSugnEbfH+68oX
 Y0XN32xOoEDM6/meSlOdxzfM9nYJWhC9kHARA6nxYotZ2LvLxu9qvlcxisl0RRP4PN
 96+kinLFgTsGqMFw2uMt801MPr0Yt4m18+VDddhY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DDC38B82D;
 Fri, 29 Mar 2019 09:40:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0ZCAG_Ac1OeI; Fri, 29 Mar 2019 09:40:21 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 606B18B779;
 Fri, 29 Mar 2019 09:40:21 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2786B6FC95; Fri, 29 Mar 2019 08:40:21 +0000 (UTC)
Message-Id: <3632dd9c8115965b37fd0b8fc50b3352395933fa.1553848759.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 1/4] powerpc/boot: don't force gzipped uImage
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 08:40:21 +0000 (UTC)
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

