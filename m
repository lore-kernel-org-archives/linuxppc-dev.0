Return-Path: <gilad@benyossef.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/9] ppc: avoid using on_each_cpu hard coded ret value
Date: Tue,  3 Jan 2012 16:19:09 +0200
Message-Id: <1325600353-10895-6-git-send-email-gilad@benyossef.com>
In-Reply-To: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
References: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Gilad Ben-Yossef <gilad@benyossef.com>, Paul Mackerras <paulus@samba.org>,
 Michal Nazarewicz <mina86@mina86.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

on_each_cpu always returns a hard coded return code of zero.

Removing all tests based on this return value saves run time
cycles for compares and code bloat for branches.

CC: Michal Nazarewicz <mina86@mina86.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Rob Herring <rob.herring@calxeda.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: devicetree-discuss@lists.ozlabs.org
---
 arch/powerpc/kernel/rtas.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 517b1d8..829629e 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -850,8 +850,7 @@ int rtas_ibm_suspend_me(struct rtas_args *args)
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
-	if (on_each_cpu(rtas_percpu_suspend_me, &data, 0))
-		atomic_set(&data.error, -EINVAL);
+	on_each_cpu(rtas_percpu_suspend_me, &data, 0);
 
 	wait_for_completion(&done);
 
-- 
1.7.0.4
