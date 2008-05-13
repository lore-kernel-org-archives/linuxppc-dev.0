Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1F425DDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 02:23:27 +1000 (EST)
Message-ID: <4829C07A.4040407@am.sony.com>
Date: Tue, 13 May 2008 09:23:22 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: PS3: Fix memory hotplug
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
check of find_lmb().  Add the corresponding lmb_add()
call to ps3_mm_add_memory() so that that check will
succeed.

This fixes the condition where the PS3 boots up with
just the 128 MiB of boot memory.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Paul,

Please send this one upstream at your earliest convenience.

-Geoff

 arch/powerpc/platforms/ps3/mm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -317,6 +317,8 @@ static int __init ps3_mm_add_memory(void
 		return result;
 	}
 
+	lmb_add(start_addr, map.r1.size);
+
 	result = online_pages(start_pfn, nr_pages);
 
 	if (result)
