Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs8gr2QLbzDqjt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 02:02:16 +1000 (AEST)
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
Subject: [PATCH v8 3/6] lib/cmdline.c: Remove quotes symmetrically.
Date: Tue, 12 Sep 2017 18:01:41 +0200
Message-Id: <9ad57a14bf19e798c5a3643e57a28e829a8518a2.1505231820.git.msuchanek@suse.de>
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

Remove quotes from argument value only if there is qoute on both sides.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 lib/cmdline.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 171c19b6888e..6d398a8b63fc 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -227,14 +227,12 @@ char *next_arg(char *args, char **param, char **val)
 		*val = args + equals + 1;
 
 		/* Don't include quotes in value. */
-		if (**val == '"') {
-			(*val)++;
-			if (args[i-1] == '"')
-				args[i-1] = '\0';
+		if ((args[i-1] == '"') && ((quoted) || (**val == '"'))) {
+			args[i-1] = '\0';
+			if (!quoted)
+				(*val)++;
 		}
 	}
-	if (quoted && args[i-1] == '"')
-		args[i-1] = '\0';
 
 	if (args[i]) {
 		args[i] = '\0';
-- 
2.10.2
