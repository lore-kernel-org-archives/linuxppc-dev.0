Return-Path: <gorcunov@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id F076ADDEF9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:56:53 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so945015wri
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 11:56:52 -0800 (PST)
Date: Wed, 21 Nov 2007 22:56:42 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] PPC: fix missed increment on device interface counter
Message-ID: <20071121195642.GA7273@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PPCML <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cyrill Gorcunov <gorcunov@gmail.com>

This patch adds simple increment on device interface counter
(it seems to be accidently missed)

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

 arch/powerpc/platforms/pasemi/electra_ide.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/electra_ide.c b/arch/powerpc/platforms/pasemi/electra_ide.c
index 12fb0c9..8e73086 100644
--- a/arch/powerpc/platforms/pasemi/electra_ide.c
+++ b/arch/powerpc/platforms/pasemi/electra_ide.c
@@ -42,7 +42,7 @@ static int __devinit electra_ide_init(void)
 	np = of_find_compatible_node(NULL, "ide", "electra-ide");
 	i = 0;
 
-	while (np && i < MAX_IFS) {
+	while (np && i++ < MAX_IFS) {
 		memset(r, 0, sizeof(r));
 
 		/* pata_platform wants two address ranges: one for the base registers,
