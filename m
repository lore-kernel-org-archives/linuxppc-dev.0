Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7DB1B7151
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 22:18:26 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <aacfb5952246dc41f6949f08be6bdd71fddecc6f.1244722700.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/iseries: Fix unused function warning in iSeries DT
	code
Date: Thu, 11 Jun 2009 22:18:26 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_BLK_DEV_INITRD is unset dt_prop_u64() is unused, which
causes a warning. We don't really want to tie the definition to
BLK_DEV_INITRD, so mark it as maybe unused.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/iseries/dt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 4543c4b..c5a87a7 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -204,7 +204,8 @@ static void __init dt_prop_u32(struct iseries_flat_dt *dt, const char *name,
 	dt_prop(dt, name, &data, sizeof(u32));
 }
 
-static void __init dt_prop_u64(struct iseries_flat_dt *dt, const char *name,
+static void __init __maybe_unused dt_prop_u64(struct iseries_flat_dt *dt,
+					      const char *name,
 		u64 data)
 {
 	dt_prop(dt, name, &data, sizeof(u64));
-- 
1.6.2.1
