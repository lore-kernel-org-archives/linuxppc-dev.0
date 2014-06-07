Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C59EF1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jun 2014 11:29:02 +1000 (EST)
Date: Sat, 7 Jun 2014 11:29:01 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, joel@jms.id.au,
 neelegup@linux.vnet.ibm.com
Subject: [PATCH] powernv: Fix permissions on sysparam sysfs entries
Message-ID: <20140607112901.37bd551f@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Everyone can write to these files, which is not what we want.

Cc: stable@vger.kernel.org # 3.15
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index d202f9b..9d1acf2 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -260,10 +260,10 @@ void __init opal_sys_param_init(void)
 			attr[i].kobj_attr.attr.mode = S_IRUGO;
 			break;
 		case OPAL_SYSPARAM_WRITE:
-			attr[i].kobj_attr.attr.mode = S_IWUGO;
+			attr[i].kobj_attr.attr.mode = S_IWUSR;
 			break;
 		case OPAL_SYSPARAM_RW:
-			attr[i].kobj_attr.attr.mode = S_IRUGO | S_IWUGO;
+			attr[i].kobj_attr.attr.mode = S_IRUGO | S_IWUSR;
 			break;
 		default:
 			break;
