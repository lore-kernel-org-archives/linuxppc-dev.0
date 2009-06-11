Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6738DB7152
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 22:18:49 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <9a2ad49f064c97e7eab14f27863be8e476f3dc56.1244722721.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/iseries: Mark signal_vsp_instruction() as maybe unused
Date: Thu, 11 Jun 2009 22:18:49 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

signal_vsp_instruction() is currently only used if CONFIG_PROC_FS
is enabled. However logically it has nothing to do with PROC_FS,
so rather than making it depend on that mark it as maybe unused.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/iseries/mf.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/mf.c b/arch/powerpc/platforms/iseries/mf.c
index 3689c24..fef4d51 100644
--- a/arch/powerpc/platforms/iseries/mf.c
+++ b/arch/powerpc/platforms/iseries/mf.c
@@ -267,7 +267,8 @@ static struct pending_event *new_pending_event(void)
 	return ev;
 }
 
-static int signal_vsp_instruction(struct vsp_cmd_data *vsp_cmd)
+static int __maybe_unused
+signal_vsp_instruction(struct vsp_cmd_data *vsp_cmd)
 {
 	struct pending_event *ev = new_pending_event();
 	int rc;
-- 
1.6.2.1
