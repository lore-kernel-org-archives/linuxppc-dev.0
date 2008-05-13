Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8117DDDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 11:14:03 +1000 (EST)
Message-ID: <4828EB53.7030407@am.sony.com>
Date: Mon, 12 May 2008 18:13:55 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: akpm@linux-foundation.org
Subject: [rfc patch] memory_hotplug: Check for walk_memory_resource() failure
	in online_pages()
References: <20080512.174151.193690130.davem@davemloft.net>
In-Reply-To: <20080512.174151.193690130.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, mikpe@it.uu.se,
	Badari Pulavarty <pbadari@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a check to online_pages() to test for failure of
walk_memory_resource().  This fixes a condition where a failure
of walk_memory_resource() can lead to online_pages() returning
success without the requested pages being onlined.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

I'm not entirely sure this is the proper way to handle this
condition.  Comments welcome.

 mm/memory_hotplug.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -408,8 +408,15 @@ int online_pages(unsigned long pfn, unsi
 	if (!populated_zone(zone))
 		need_zonelists_rebuild = 1;
 
-	walk_memory_resource(pfn, nr_pages, &onlined_pages,
+	ret = walk_memory_resource(pfn, nr_pages, &onlined_pages,
 		online_pages_range);
+	if (ret) {
+		printk(KERN_DEBUG "online_pages %lx at %lx failed\n",
+			nr_pages, pfn);
+		memory_notify(MEM_CANCEL_ONLINE, &arg);
+		return ret;
+	}
+
 	zone->present_pages += onlined_pages;
 	zone->zone_pgdat->node_present_pages += onlined_pages;
 
