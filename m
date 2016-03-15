Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPKmP4Ff4zDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 14:27:01 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powernv/hmi: Use the "unknown" checkstop type as a fallback
Date: Tue, 15 Mar 2016 14:26:49 +1100
Message-Id: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HMI code knows about three types of errors: CORE, NX and UNKNOWN.
If OPAL were to add a new type, it would not be handled at all since
there is no fallback case.  Instead of explicitly checking for UNKNOWN,
treat any checkstop type without a handler as unknown.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/opal-hmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index d000f4e..bff4dd1 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -157,7 +157,7 @@ static void print_checkstop_reason(const char *level,
 	case CHECKSTOP_TYPE_NX:
 		print_nx_checkstop_reason(level, hmi_evt);
 		break;
-	case CHECKSTOP_TYPE_UNKNOWN:
+	default:
 		printk("%s	Unknown Malfunction Alert.\n", level);
 		break;
 	}
-- 
2.7.3
