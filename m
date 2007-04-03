Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E9F1BDDF4A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 23:04:43 +1000 (EST)
Date: Tue, 3 Apr 2007 23:05:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] [SPARC/64] Remove get_property
Message-Id: <20070403230505.f96ea210.sfr@canb.auug.org.au>
In-Reply-To: <20070403225222.88e92221.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All the usages have been renamed to of_get_property.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-sparc/prom.h   |    1 -
 include/asm-sparc64/prom.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

Hi Dave,

If you take the curent powerpc tree (commit
1b56c1da9eec35c610fa2168d754ce567615a6ee) and apply all the patches I
sent today (1-6 then 1-17) then merge that with your current for-2.6.22
tree (commit ab571e3091f055b0f8648822e11ee6413993f899), then you can
apply this.  :-)

I did a test sparc64 allmodconfig build (and it get as far as can be
expected :-))

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 39ad222..030461d 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -93,7 +93,6 @@ extern int of_device_is_compatible(const struct device_node *device,
 extern const void *of_get_property(const struct device_node *node,
 				   const char *name,
 				   int *lenp);
-#define get_property(node,name,lenp) of_get_property(node,name,lenp)
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index 6394bd1..dd0a6cd 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -101,7 +101,6 @@ extern int of_device_is_compatible(const struct device_node *device,
 extern const void *of_get_property(const struct device_node *node,
 			     const char *name,
 			     int *lenp);
-#define get_property(node,name,lenp) of_get_property(node,name,lenp)
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
-- 
1.5.0.3
