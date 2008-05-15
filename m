Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 05DD8DE5CD
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 06:36:06 +1000 (EST)
Message-ID: <482C9897.90709@am.sony.com>
Date: Thu, 15 May 2008 13:09:59 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch v2] PS3: Fix memory hotplug
References: <4829C07A.4040407@am.sony.com>
In-Reply-To: <4829C07A.4040407@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A change was made to walk_memory_resource() in commit
4b119e21d0c66c22e8ca03df05d9de623d0eb50f that added a
check of find_lmb().  Add the coresponding lmb_add()
call to ps3_mm_add_memory() so that that check will
succeed.

This fixes the condition where the PS3 boots up with
only the 128 MiB of boot memory.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

v2: Add call to lmb_analyze().

 arch/powerpc/platforms/ps3/mm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -317,6 +317,9 @@ static int __init ps3_mm_add_memory(void
 		return result;
 	}
 
+	lmb_add(start_addr, map.r1.size);
+	lmb_analyze();
+
 	result = online_pages(start_pfn, nr_pages);
 
 	if (result)
