Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id 0E616B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Aug 2010 04:42:17 +1000 (EST)
Received: by pxi2 with SMTP id 2so3644366pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 06 Aug 2010 11:42:15 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc: fix i8042 module build error
To: martyn.welch@ge.com, benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 06 Aug 2010 12:42:12 -0600
Message-ID: <20100806183839.32149.6238.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_i8042_{kbd,aux}_irq needs to be exported

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Stephen and Ben, this fixes up the build error in linux-next.  If you prefer,
I can stuff this patch into my next-powerpc branch.  Ben, I've got other
commits in that branch that I'll be sending to you early next week anyway.

 arch/powerpc/kernel/setup-common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 15ade0d..9d4882a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -96,7 +96,9 @@ struct screen_info screen_info = {
 
 /* Variables required to store legacy IO irq routing */
 int of_i8042_kbd_irq;
+EXPORT_SYMBOL_GPL(of_i8042_kbd_irq);
 int of_i8042_aux_irq;
+EXPORT_SYMBOL_GPL(of_i8042_aux_irq);
 
 #ifdef __DO_IRQ_CANON
 /* XXX should go elsewhere eventually */
