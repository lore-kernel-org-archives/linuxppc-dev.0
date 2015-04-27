Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 095D41A0245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 18:03:35 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D2E65140328
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 18:03:34 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 50A613578047
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R83MqX3539368
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R82vBZ005515
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:02:57 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: [PATCH v2 2/4] pci: Support 64-bit address translation
Date: Mon, 27 Apr 2015 13:32:31 +0530
Message-Id: <1430121753-24818-3-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 slof/fs/translate.fs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/slof/fs/translate.fs b/slof/fs/translate.fs
index e2633e5..9654f24 100644
--- a/slof/fs/translate.fs
+++ b/slof/fs/translate.fs
@@ -33,11 +33,9 @@
       dup l@ FF AND 0<> ( prop_type address data cfgspace_offset? )
       3 pick 0= ( prop_type address data cfgspace_offset? reg_prop? )
       AND NOT IF 
-         2dup 8 + ( prop_type address data address data' )
-         2dup l@ 2 pick 8 + l@ + <= -rot l@  >= and  IF
+         2dup 4 + ( prop_type address data address data' )
+         2dup @ 2 pick 8 + @ + <= -rot @  >= and  IF
             l@ 03000000 and 18 rshift nip
-            \ no 64bit translations supported pretend it is 32bit
-            dup 3 = IF  1-  THEN
             ( prop_type type )
             swap drop ( type )
             UNLOOP EXIT
-- 
1.8.3.1
