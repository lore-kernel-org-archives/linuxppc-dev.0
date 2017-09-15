Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv1tg1cMdzDrZf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 03:03:07 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Jonathan Corbet <corbet@lwn.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Michal Suchanek <msuchanek@suse.de>,
 Kamlakant Patel <kamlakant.patel@broadcom.com>,
 Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
 Tamara Diaconita <diaconitatamara@gmail.com>,
 Trond Myklebust <trond.myklebust@primarydata.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Baoquan He <bhe@redhat.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/fadump: stop removing quotes in argument parsing.
Date: Fri, 15 Sep 2017 19:02:48 +0200
Message-Id: <7c84e1fab6b78006eabf819b453b826aff078be1.1505494668.git.msuchanek@suse.de>
In-Reply-To: <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
References: <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
In-Reply-To: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
References: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
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
 arch/powerpc/kernel/fadump.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 1678d99ea835..275ea42a27d5 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -494,13 +494,6 @@ static void __init fadump_update_params(struct param_info *param_info,
 	if (!val)
 		return;
 
-	/* remove one leading and one trailing quote if both are present */
-	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
-		shortening += 2;
-		vallen -= 2;
-		val++;
-	}
-
 	strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
 	tgt += FADUMP_EXTRA_ARGS_LEN;
 	*tgt++ = ' ';
-- 
2.10.2
