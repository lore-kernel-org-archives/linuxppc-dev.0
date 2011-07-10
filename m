Return-Path: <baltoo@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AD12B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jul 2011 04:55:36 +1000 (EST)
Received: by vxb40 with SMTP id 40so2565585vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Jul 2011 11:55:32 -0700 (PDT)
MIME-Version: 1.0
Sender: baltoo@gmail.com
Date: Sun, 10 Jul 2011 20:55:32 +0200
Message-ID: <CABkP77e6vLmLxk3wCP39GJ7+yKnJZFc7BPUZ1OkdA8d7KkBCiw@mail.gmail.com>
Subject: [PATCH] powerpc/85xx: fix mpic configuration in CAMP mode
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Poonam Aggrwal <poonam.aggrwal@freescale.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the string to check for CAMP mode boot on MPC85xx (eg. P2020) to match
the one in the corresponding dts files (p2020rdb_camp_core{0,1}.dts).

Without this fix the mpic is configured as in the SMP boot mode, which causes
the first core to report a protected source interrupt error for devices
of the other core and lock up.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 088f30b..a1e5e70 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -58,7 +58,7 @@ void __init mpc85xx_rdb_pic_init(void)
 		return;
 	}

-	if (of_flat_dt_is_compatible(root, "fsl,85XXRDB-CAMP")) {
+	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(np, r.start,
 			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
-- 
1.7.5.1
