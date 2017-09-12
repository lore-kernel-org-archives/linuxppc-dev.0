Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs8gs684zzDqjt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 02:02:17 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jason Baron <jbaron@akamai.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, Daniel Axtens <dja@axtens.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Neuling <mikey@neuling.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>,
 David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt," <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>,
 Laura Abbott <lauraa@codeaurora.org>, Tejun Heo <tj@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Lokesh Vutla <lokeshvutla@ti.com>,
 Baoquan He <bhe@redhat.com>, Ilya Matveychikov <matvejchikov@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/6] powerpc/fadump: update the dequoting logic to match
 lib/cmdline.c
Date: Tue, 12 Sep 2017 18:01:42 +0200
Message-Id: <490bce7afcb8ae57880cb83d5cf1a07ba1a0fc60.1505231820.git.msuchanek@suse.de>
In-Reply-To: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
References: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
In-Reply-To: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
References: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 0e08f1a80af2..b214c1e333dd 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -501,10 +501,12 @@ static void __init fadump_update_params(struct param_info *param_info,
 	}
 
 	/* next_arg removes one leading and one trailing '"' */
-	if (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1) == '"')
-		shortening += 1;
-	if (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1 + vallen + shortening) == '"')
+	if ((*(tgt + FADUMP_EXTRA_ARGS_LEN + 1 + vallen + shortening) == '"') &&
+	    (quoted || (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1) == '"'))) {
 		shortening += 1;
+		if (!quoted)
+			shortening += 1;
+	}
 
 	/* remove one leading and one trailing quote if both are present */
 	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
-- 
2.10.2
