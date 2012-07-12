Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4B5A72C0209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 14:53:11 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A96133EE0BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:53:07 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 880DC45DEB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:53:07 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5EEDA45DE9E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:53:07 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4AC4B1DB8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:53:07 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local
 (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E8BF91DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:53:06 +0900 (JST)
Message-ID: <4FFE5816.6070102@jp.fujitsu.com>
Date: Thu, 12 Jul 2012 13:52:38 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 3/13] memory-hotplug : unify argument of
 firmware_map_add_early/hotplug
References: <4FFAB0A2.8070304@jp.fujitsu.com>
 <4FFAB17F.2090209@jp.fujitsu.com> <4FFD9C08.2070502@linux.vnet.ibm.com>
In-Reply-To: <4FFD9C08.2070502@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

2012/07/12 0:30, Dave Hansen wrote:
> On 07/09/2012 03:25 AM, Yasuaki Ishimatsu wrote:
>> @@ -642,7 +642,7 @@ int __ref add_memory(int nid, u64 start,
>>   	}
>>
>>   	/* create new memmap entry */
>> -	firmware_map_add_hotplug(start, start + size, "System RAM");
>> +	firmware_map_add_hotplug(start, start + size - 1, "System RAM");
> 
> I know the firmware_map_*() calls use inclusive end addresses
> internally, but do we really need to expose them?  Both of the callers
> you mentioned do:
> 
> 	firmware_map_add_hotplug(start, start + size - 1, "System RAM");
> 
> or
> 
>                  firmware_map_add_early(entry->addr,
>                          entry->addr + entry->size - 1,
>                          e820_type_to_string(entry->type));
> 
> So it seems a _bit_ silly to keep all of the callers doing this size-1
> thing.  I also noted that the new caller that you added does the same
> thing.  Could we just change the external calling convention to be
> exclusive?

Thank you for your comment.

Does the following patch include your comment? If O.K., I will separate
the patch from the series and send it for bug fix.

---
 arch/x86/kernel/e820.c    |    2 +-
 drivers/firmware/memmap.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-next/arch/x86/kernel/e820.c
===================================================================
--- linux-next.orig/arch/x86/kernel/e820.c	2012-07-02 09:50:23.000000000 +0900
+++ linux-next/arch/x86/kernel/e820.c	2012-07-12 13:30:45.942318179 +0900
@@ -944,7 +944,7 @@
 	for (i = 0; i < e820_saved.nr_map; i++) {
 		struct e820entry *entry = &e820_saved.map[i];
 		firmware_map_add_early(entry->addr,
-			entry->addr + entry->size - 1,
+			entry->addr + entry->size,
 			e820_type_to_string(entry->type));
 	}
 }
Index: linux-next/drivers/firmware/memmap.c
===================================================================
--- linux-next.orig/drivers/firmware/memmap.c	2012-07-02 09:50:26.000000000 +0900
+++ linux-next/drivers/firmware/memmap.c	2012-07-12 13:40:53.823318481 +0900
@@ -98,7 +98,7 @@
 /**
  * firmware_map_add_entry() - Does the real work to add a firmware memmap entry.
  * @start: Start of the memory range.
- * @end:   End of the memory range (inclusive).
+ * @end:   End of the memory range.
  * @type:  Type of the memory range.
  * @entry: Pre-allocated (either kmalloc() or bootmem allocator), uninitialised
  *         entry.
@@ -113,7 +113,7 @@
 	BUG_ON(start > end);

 	entry->start = start;
-	entry->end = end;
+	entry->end = end - 1;
 	entry->type = type;
 	INIT_LIST_HEAD(&entry->list);
 	kobject_init(&entry->kobj, &memmap_ktype);
@@ -148,7 +148,7 @@
  * firmware_map_add_hotplug() - Adds a firmware mapping entry when we do
  * memory hotplug.
  * @start: Start of the memory range.
- * @end:   End of the memory range (inclusive).
+ * @end:   End of the memory range.
  * @type:  Type of the memory range.
  *
  * Adds a firmware mapping entry. This function is for memory hotplug, it is
@@ -175,7 +175,7 @@
 /**
  * firmware_map_add_early() - Adds a firmware mapping entry.
  * @start: Start of the memory range.
- * @end:   End of the memory range (inclusive).
+ * @end:   End of the memory range.
  * @type:  Type of the memory range.
  *
  * Adds a firmware mapping entry. This function uses the bootmem allocator
