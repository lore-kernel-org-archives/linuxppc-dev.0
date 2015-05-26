Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B3A41A0E0F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 11:39:30 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E21771402B2
 for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2015 11:39:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 26 May 2015 11:39:28 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8D1423578055
 for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2015 11:39:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4Q1c30d59244778
 for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2015 11:38:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4Q1bd9h018943
 for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2015 11:37:39 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t4Q1bdnk018461
 for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2015 11:37:39 +1000
Received: from cyril.ozlabs.ibm.com (unknown [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1F1FCA004D
 for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2015 11:37:15 +1000 (AEST)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 1/2] powerpc/configs: Merge pseries_defconfig and
 pseries_le_defconfig
Date: Tue, 26 May 2015 11:36:56 +1000
Message-Id: <1432604217-8853-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two configs should be identical with the exception of big or little
endian.

The big endian version has XMON_DEFAULT turned on while the little endian
has XMON_DEFAULT not set. It makes the most sense for defconfigs not to use
xmon by default, production systems should get back up as quickly as
possible, not sit in xmon.

In the event debugging is required, the option can be enabled or xmon=on
can be specified on commandline.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
V2: Removes XMON_DEFAULT from big endian after Antons suggestion that it
should be a default for production systems. 

 arch/powerpc/configs/pseries_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index c2e39f6..4da8260 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -297,7 +297,6 @@ CONFIG_CODE_PATCHING_SELFTEST=y
 CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
-CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-- 
1.9.1
