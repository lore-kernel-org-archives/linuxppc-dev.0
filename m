Return-Path: <grant.likely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3F56B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Jan 2011 03:20:34 +1100 (EST)
Received: by gxk21 with SMTP id 21so306824gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Jan 2011 08:20:31 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc/83xx: fix build failures on dt compatible list.
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	galak@kernel.crashing.org, linux-kernel@vger.kernel.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 Jan 2011 09:20:28 -0700
Message-ID: <20110119161908.25999.76832.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a4f740cf, "of/flattree: Add of_flat_dt_match() helper function"
introduced build failures in arch/powerpc/platform/83xx by mistyping
'static' as 'struct' in the compatible string list, and omitting a few
semicolons.  This patch fixes it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Ben, I can put this one into my merge-devicetree branch and I'll ask Linus
to merge it in a few days.


 arch/powerpc/platforms/83xx/mpc830x_rdb.c |    4 ++--
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 661d354..d0c4e15 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -57,12 +57,12 @@ static void __init mpc830x_rdb_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
-struct const char *board[] __initdata = {
+static const char *board[] __initdata = {
 	"MPC8308RDB",
 	"fsl,mpc8308rdb",
 	"denx,mpc8308_p1m",
 	NULL
-}
+};
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index b54cd73..f859ead 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -60,11 +60,11 @@ static void __init mpc831x_rdb_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
-struct const char *board[] __initdata = {
+static const char *board[] __initdata = {
 	"MPC8313ERDB",
 	"fsl,mpc8315erdb",
 	NULL
-}
+};
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
