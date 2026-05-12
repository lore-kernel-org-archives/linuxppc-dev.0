Return-Path: <linuxppc-dev+bounces-20723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFACCD343F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 03:12:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF1qm1pPLz2xpk;
	Tue, 12 May 2026 13:12:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778555572;
	cv=none; b=L8nnxy6dCovaW2/mhaitbwDXAAo85/5dlTXWxeB38TefqArL3JmV5uUdICbDICEtwi8cH22ebwcdGTg4eLvj1br2PJbAsHacZ0bO/qUl7AKH1ZIStk9oEL49teeGzh6WFthcSgCLwqWjoa2N+9p8yt3+deHKVn4jMGfqPyoFDjTa/iS8d/aCCChMaX2i7nqyA224poMekEmHRLtV2YrYEU+AL+OVJRVNkwUJ3dPvdg9pW2fYHiOE+c21B3Y1nviZH+2trWyTr+jAgRK0mzZUlER43/TbqfAVIqMwpdRhL7XiySqyaue0H0ziukT7zMSHAMSQXQsYJwaNdvfd92aegw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778555572; c=relaxed/relaxed;
	bh=I4poRjePR6cFEz+knzlKugzzQz/9NFbmis/RU8TnLm8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y2dzea7pkFjb640ZXTzIqGJWfYD5EociavnoBfho532Q0p8UbQrQ9zskZK6ZxtmshZTFnBRepZZAvpa2zDC8p1l2PrqaDamNAdlUhpiwLzmk5+xGdbfIbsK6T5NW2WuEghcxkOL055UyjS0aNE8utC/heYsgwJXRM7efGuacz1krdJR/DrOgUZILJ+sa4WrTCqlzBu00Mtv11zud8rlP3PFhRN8JdSgYcaToN0Tf+wy9duSwJKGjxWQs9YSbFXJb+jbEKHTUS3hMrHza1S8g0qWYn4n4jNCpfacP8KNb4T5kN+bT5M6CzwNoc9sXdNuOzQNt3iNZx1s2h/Kb48lhhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Azi14Ppr; dkim-atps=neutral; spf=pass (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Azi14Ppr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF1qd6WM2z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 13:12:43 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778555537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4poRjePR6cFEz+knzlKugzzQz/9NFbmis/RU8TnLm8=;
	b=Azi14PprPniBe1V5WjMKA+afCZiQgf72uIBSnpUmv60pYeWqC3IjNVcI+F6g/cUtrfmtoK
	9eWQnG6XAjQL2a/frLRhyjpMZjyu55AeB1Kab2o/jQHGfyaMSajaAmtzR8NrIrBYLHxonL
	73at8Z7GhpsUWTub3wdFAO6VUW0iJj0=
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <3234B4D3-8202-4E79-B85B-8B6373BB76F6@linux.dev>
Date: Tue, 12 May 2026 11:11:15 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-mm@kvack.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9BB5FC5-0785-4162-8D1A-2A51C7250B34@linux.dev>
References: <2841f424-580c-48c6-bb26-de30e4397b7f@kernel.org>
 <3234B4D3-8202-4E79-B85B-8B6373BB76F6@linux.dev>
To: David Hildenbrand <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On May 11, 2026, at 21:23, Muchun Song <muchun.song@linux.dev> wrote:
>=20
>=20
>=20
>> On May 11, 2026, at 20:22, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>>=20
>> =EF=BB=BFOn 5/11/26 13:18, Muchun Song wrote:
>>> Rename the memory block lookup helper to make the acquired reference
>>> explicit, add memory_block_put() to wrap put_device(), and collapse =
the
>>> redundant section-number wrapper into a single block-id based lookup
>>> interface.
>>>=20
>>> This makes it clearer to callers that a successful lookup holds a
>>> reference that must be dropped, reducing the chance of forgetting =
the
>>> matching put and leaking the memory block device reference.
>>=20
>> Better mention some of the other changes here, like removing =
find_memory_block().
>=20
> Will do.
>=20
>>=20
>> [...]
>>=20
>>>   unlock_device_hotplug();
>>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>>> index 5bb5599c6b2b..29edef1f975c 100644
>>> --- a/include/linux/memory.h
>>> +++ b/include/linux/memory.h
>>> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long =
start, unsigned long size,
>>> void remove_memory_block_devices(unsigned long start, unsigned long =
size);
>>> extern void memory_dev_init(void);
>>> extern int memory_notify(enum memory_block_state state, void *v);
>>> -extern struct memory_block *find_memory_block(unsigned long =
section_nr);
>>> +extern struct memory_block *memory_block_get(unsigned long =
block_id);
>>=20
>> While at it, please drop the "extern".
>=20
> OK.
>=20
>>=20
>>> +static inline void memory_block_put(struct memory_block *mem)
>>> +{
>>> +    put_device(&mem->dev);
>>> +}
>>> typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void =
*);
>>> extern int walk_memory_blocks(unsigned long start, unsigned long =
size,
>>>                 void *arg, walk_memory_blocks_func_t func);
>>> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int =
mgid);
>>> typedef int (*walk_memory_groups_func_t)(struct memory_group *, void =
*);
>>> int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t =
func,
>>>                  struct memory_group *excluded, void *arg);
>>> -struct memory_block *find_memory_block_by_id(unsigned long =
block_id);
>>> #define hotplug_memory_notifier(fn, pri) ({        \
>>>   static __meminitdata struct notifier_block fn##_mem_nb =3D\
>>>       { .notifier_call =3D fn, .priority =3D pri };\
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 462d8dcd636d..890c6453e887 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1417,14 +1417,13 @@ static void =
remove_memory_blocks_and_altmaps(u64 start, u64 size)
>>>       struct vmem_altmap *altmap =3D NULL;
>>>       struct memory_block *mem;
>>>=20
>>> -        mem =3D =
find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
>>> +        mem =3D memory_block_get(phys_to_block_id(cur_start));
>>>       if (WARN_ON_ONCE(!mem))
>>>           continue;
>>>=20
>>>       altmap =3D mem->altmap;
>>>       mem->altmap =3D NULL;
>>> -        /* drop the ref. we got via find_memory_block() */
>>> -        put_device(&mem->dev);
>>> +        memory_block_put(mem);
>>=20
>> Would guards come in handy here?
>=20
> You mean to introduce something like:
>=20
> scoped_guard(memory_block, id) {
> }
>=20
> Right? If yes, I will give it a try.

Hi David,

Did I get that right?

5 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5b5d41089e81..eba48320fc30 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -997,7 +997,6 @@ int walk_memory_blocks(unsigned long start, unsigned =
long size,
 {
 	const unsigned long start_block_id =3D phys_to_block_id(start);
 	const unsigned long end_block_id =3D phys_to_block_id(start + =
size - 1);
-	struct memory_block *mem;
 	unsigned long block_id;
 	int ret =3D 0;

@@ -1005,12 +1004,11 @@ int walk_memory_blocks(unsigned long start, =
unsigned long size,
 		return 0;

 	for (block_id =3D start_block_id; block_id <=3D end_block_id; =
block_id++) {
-		mem =3D memory_block_get(block_id);
+		CLASS(memory_block_get, mem)(block_id);
 		if (!mem)
 			continue;

 		ret =3D func(mem, arg);
-		memory_block_put(mem);
 		if (ret)
 			break;
 	}
@@ -1218,23 +1216,19 @@ int walk_dynamic_memory_groups(int nid, =
walk_memory_groups_func_t func,
 void memblk_nr_poison_inc(unsigned long pfn)
 {
 	const unsigned long block_id =3D pfn_to_block_id(pfn);
-	struct memory_block *mem =3D memory_block_get(block_id);
+	CLASS(memory_block_get, mem)(block_id);

-	if (mem) {
+	if (mem)
 		atomic_long_inc(&mem->nr_hwpoison);
-		memory_block_put(mem);
-	}
 }

 void memblk_nr_poison_sub(unsigned long pfn, long i)
 {
 	const unsigned long block_id =3D pfn_to_block_id(pfn);
-	struct memory_block *mem =3D memory_block_get(block_id);
+	CLASS(memory_block_get, mem)(block_id);

-	if (mem) {
+	if (mem)
 		atomic_long_sub(i, &mem->nr_hwpoison);
-		memory_block_put(mem);
-	}
 }

 static unsigned long memblk_nr_poison(struct memory_block *mem)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index b3333ca92090..32a5431cbb60 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -845,15 +845,12 @@ static void =
register_memory_blocks_under_nodes(void)
 			continue;

 		for (block_id =3D start_block_id; block_id <=3D =
end_block_id; block_id++) {
-			struct memory_block *mem;
-
-			mem =3D memory_block_get(block_id);
+			CLASS(memory_block_get, mem)(block_id);
 			if (!mem)
 				continue;

 			memory_block_add_nid_early(mem, nid);
 			do_register_memory_block_under_node(nid, mem);
-			memory_block_put(mem);
 		}

 	}
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..c9a1a7adcab6 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -237,13 +237,12 @@ static ssize_t sclp_config_mem_store(struct =
kobject *kobj, struct kobj_attribute
 	} else {
 		if (!sclp_mem->config)
 			goto out_unlock;
-		mem =3D memory_block_get(phys_to_block_id(addr));
-		if (mem->state !=3D MEM_OFFLINE) {
-			memory_block_put(mem);
-			rc =3D -EBUSY;
-			goto out_unlock;
+		scoped_class(memory_block_get, mem, =
phys_to_block_id(addr)) {
+			if (mem->state !=3D MEM_OFFLINE) {
+				rc =3D -EBUSY;
+				goto out_unlock;
+			}
 		}
-		memory_block_put(mem);
 		sclp_mem_change_state(addr, block_size, 0);
 		__remove_memory(addr, block_size);
 #ifdef CONFIG_KASAN
@@ -293,12 +292,12 @@ static ssize_t sclp_memmap_on_memory_store(struct =
kobject *kobj, struct kobj_att
 		return rc;
 	block_size =3D memory_block_size_bytes();
 	sclp_mem =3D container_of(kobj, struct sclp_mem, kobj);
-	mem =3D memory_block_get(phys_to_block_id(sclp_mem->id * =
block_size));
-	if (!mem) {
-		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
-	} else {
-		memory_block_put(mem);
-		rc =3D -EBUSY;
+	scoped_class(memory_block_get, mem,
+		     phys_to_block_id(sclp_mem->id * block_size)) {
+		if (!mem)
+			WRITE_ONCE(sclp_mem->memmap_on_memory, value);
+		else
+			rc =3D -EBUSY;
 	}
 	unlock_device_hotplug();
 	return rc ? rc : count;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 463dc02f6cff..fb67041941a8 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -18,6 +18,7 @@

 #include <linux/node.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/mutex.h>
 #include <linux/memory_hotplug.h>

@@ -163,6 +164,8 @@ static inline void memory_block_put(struct =
memory_block *mem)
 {
 	put_device(&mem->dev);
 }
+DEFINE_CLASS(memory_block_get, struct memory_block *, if (_T) =
memory_block_put(_T),
+	     memory_block_get(block_id), unsigned long block_id)
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void =
*);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t =
func);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 890c6453e887..3f89ffb286d6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1415,15 +1415,13 @@ static void remove_memory_blocks_and_altmaps(u64 =
start, u64 size)
 	for (cur_start =3D start; cur_start < start + size;
 	     cur_start +=3D memblock_size) {
 		struct vmem_altmap *altmap =3D NULL;
-		struct memory_block *mem;
-
-		mem =3D memory_block_get(phys_to_block_id(cur_start));
-		if (WARN_ON_ONCE(!mem))
-			continue;
+		scoped_class(memory_block_get, mem, =
phys_to_block_id(cur_start)) {
+			if (WARN_ON_ONCE(!mem))
+				continue;

-		altmap =3D mem->altmap;
-		mem->altmap =3D NULL;
-		memory_block_put(mem);
+			altmap =3D mem->altmap;
+			mem->altmap =3D NULL;
+		}

 		remove_memory_block_devices(cur_start, memblock_size);

Thanks,
Muchun

>=20
>>=20
>> In general
>>=20
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>=20
> Thanks.
>=20
> Muchun
>=20
>>=20
>> --
>> Cheers,
>>=20
>> David


