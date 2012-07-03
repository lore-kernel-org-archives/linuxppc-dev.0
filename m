Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3568E2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:55:41 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7CE0E3EE0C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:55:39 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C79745DEB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:55:39 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 412D345DEAD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:55:39 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 240271DB8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:55:39 +0900 (JST)
Received: from g01jpexchyt10.g01.fujitsu.local
 (g01jpexchyt10.g01.fujitsu.local [10.128.194.49])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C9AEC1DB8044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:55:38 +0900 (JST)
Message-ID: <4FF2894A.7020303@jp.fujitsu.com>
Date: Tue, 3 Jul 2012 14:55:22 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v2 3/13] unify argument of firmware_map_add_early/hotplug
References: <4FF287C3.4030901@jp.fujitsu.com>
In-Reply-To: <4FF287C3.4030901@jp.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, cl@linux.com,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two ways to create /sys/firmware/memmap/X sysfs:

  - firmware_map_add_early
    When the system starts, it is calledd from e820_reserve_resources()
  - firmware_map_add_hotplug
    When the memory is hot plugged, it is called from add_memory()

But these functions are called without unifying value of end argument as below:

  - end argument of firmware_map_add_early()   : start + size - 1
  - end argument of firmware_map_add_hogplug() : start + size

The patch unifies them to "start + size - 1".

CC: David Rientjes <rientjes@google.com>
CC: Jiang Liu <liuj97@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

---
 mm/memory_hotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-07-03 14:21:58.332264022 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-07-03 14:22:00.190240794 +0900
@@ -642,7 +642,7 @@ int __ref add_memory(int nid, u64 start,
 	}

 	/* create new memmap entry */
-	firmware_map_add_hotplug(start, start + size, "System RAM");
+	firmware_map_add_hotplug(start, start + size - 1, "System RAM");

 	goto out;
