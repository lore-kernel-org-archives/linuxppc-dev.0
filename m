Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB0C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 01:27:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD01D20867
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 01:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmAwW09l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD01D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 436DCM2GTqzDrWX
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 12:27:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PmAwW09l";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=richard.weiyang@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PmAwW09l"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 436D8R609JzDrSK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 12:25:11 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id y56so6268090edd.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 17:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xkaflSrUK4l/r2eO1FX25FanLd+q2Sm+RRC+guMDzQw=;
 b=PmAwW09lRAgN47FMDLlf8nwFPPH2jGl4gjBhrk2FBk3y2OoYAPk0F2p0QUhjnF3wtP
 83xFTt1abTum/gJJ5nAYLg2xU+nOcpyL3qUqCuNnnZ7pkyhSikh4dUKSdoXfZpDHQE/d
 BKkC7zkGgLFpUrOTb+tkDQKYvHosMFmzu+zWd4fAKMnOC3XfhexEWrvooniTIccvGrrR
 +7Qk/RDK7mO7BVOr4cbY1x0OxJ2xR+oyeMnNMoeupUFgJzqMoGO0jRwo53zVJHTFdRFw
 MDtEFvpfgdWRqCWQWWuBGW7ctqmFecyobG22Mz1N3RTviZWaq+JuNbXYVzYVi9SjbaoM
 Zs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=xkaflSrUK4l/r2eO1FX25FanLd+q2Sm+RRC+guMDzQw=;
 b=LS/OIp3wEe1f836M+Ns94t+2JZYmy8/eecssq67hayk91qIiv/Er5ht27ArchmJC1f
 41/69vh/FfB9qCXwS1QXcTv9Uhy+Hp6XI+GigyOEf1iMmV3pQo19XvT6gOAfOtkJYdYg
 OzHGLTE6GeA43fQXN0+ooo1vd0nWe3tS5Mt+TcJjZxdMfowy9tj6bw/agD+CZt7MYh0z
 Dnq/0ttWN9wK4QCTGI8Q1fcsmxY76JU1b1tXCp/0wYiJEjPl2ysifp2w1yFx1aKXfqTc
 ksizz7PUuDADpZD4ktKucq/UnCxaNFwkSDT6Et6MsRvdhXf2ZB0Ck/4ZPPB9MjTxhmvR
 xJrQ==
X-Gm-Message-State: AA+aEWaWsGWf8K1erwg8eWGGDQNv6muFNeq3jkkOLc7XCALFguGT0o4Q
 iQ+vbsRS0ea1QXqvpRE3SOM=
X-Google-Smtp-Source: AFSGD/VZIPh+k7Jv1lKfc+wuayhwG8OcPx1613dMk4Mzx/rOydh6bVYrgo/hvKR/RIjoO5mXP32sBw==
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr6909794eds.265.1543627508379; 
 Fri, 30 Nov 2018 17:25:08 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id a13sm1726020edt.83.2018.11.30.17.25.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 17:25:07 -0800 (PST)
Date: Sat, 1 Dec 2018 01:25:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 1/4] mm/memory_hotplug: Introduce memory block types
Message-ID: <20181201012507.lxfscl6ho3gc6gnn@master>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130175922.10425-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Oscar Salvador <osalvador@suse.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org,
 x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Michal Such??nek <msuchanek@suse.de>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Banman <andrew.banman@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 30, 2018 at 06:59:19PM +0100, David Hildenbrand wrote:
>Memory onlining should always be handled by user space, because only user
>space knows which use cases it wants to satisfy. E.g. memory might be
>onlined to the MOVABLE zone even if it can never be removed from the
>system, e.g. to make usage of huge pages more reliable.
>
>However to implement such rules (especially default rules in distributions)
>we need more information about the memory that was added in user space.
>
>E.g. on x86 we want to online memory provided by balloon devices (e.g.
>XEN, Hyper-V) differently (-> will not be unplugged by offlining the whole
>block) than ordinary DIMMs (-> might eventually be unplugged by offlining
>the whole block). This might also become relevat for other architectures.
>
>Also, udev rules right now check if running on s390x and treat all added
>memory blocks as standby memory (-> don't online automatically). As soon as
>we support other memory hotplug mechanism (e.g. virtio-mem) checks would
>have to get more involved (e.g. also check if under KVM) but eventually
>also wrong (e.g. if KVM ever supports standby memory we are doomed).
>
>I decided to allow to specify the type of memory that is getting added
>to the system. Let's start with two types, BOOT and UNSPECIFIED to get the
>basic infrastructure running. We'll introduce and use further types in
>follow-up patches. For now we classify any hotplugged memory temporarily
>as as UNSPECIFIED (which will eventually be dropped later on).
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>Cc: Andrew Banman <andrew.banman@hpe.com>
>Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
>Cc: Oscar Salvador <osalvador@suse.com>
>Cc: Dave Hansen <dave.hansen@linux.intel.com>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Michal Such??nek <msuchanek@suse.de>
>Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/base/memory.c  | 38 +++++++++++++++++++++++++++++++++++---
> include/linux/memory.h | 27 +++++++++++++++++++++++++++
> 2 files changed, 62 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 0c290f86ab20..17f2985c07c5 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -381,6 +381,29 @@ static ssize_t show_phys_device(struct device *dev,
> 	return sprintf(buf, "%d\n", mem->phys_device);
> }
> 
>+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
>+			 char *buf)
>+{
>+	struct memory_block *mem = to_memory_block(dev);
>+	ssize_t len = 0;
>+
>+	switch (mem->type) {
>+	case MEMORY_BLOCK_UNSPECIFIED:
>+		len = sprintf(buf, "unspecified\n");
>+		break;
>+	case MEMORY_BLOCK_BOOT:
>+		len = sprintf(buf, "boot\n");
>+		break;
>+	default:
>+		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
>+				mem->state);
>+		WARN_ON(1);
>+		break;
>+	}
>+
>+	return len;
>+}
>+
> #ifdef CONFIG_MEMORY_HOTREMOVE
> static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
> 		unsigned long nr_pages, int online_type,
>@@ -442,6 +465,7 @@ static DEVICE_ATTR(phys_index, 0444, show_mem_start_phys_index, NULL);
> static DEVICE_ATTR(state, 0644, show_mem_state, store_mem_state);
> static DEVICE_ATTR(phys_device, 0444, show_phys_device, NULL);
> static DEVICE_ATTR(removable, 0444, show_mem_removable, NULL);
>+static DEVICE_ATTR_RO(type);

This is correct, while looks not consistent with other attributes.

Not that beautiful :-)

> 
> /*
>  * Block size attribute stuff
>@@ -620,6 +644,7 @@ static struct attribute *memory_memblk_attrs[] = {
> 	&dev_attr_state.attr,
> 	&dev_attr_phys_device.attr,
> 	&dev_attr_removable.attr,
>+	&dev_attr_type.attr,
> #ifdef CONFIG_MEMORY_HOTREMOVE
> 	&dev_attr_valid_zones.attr,
> #endif
>@@ -657,13 +682,17 @@ int register_memory(struct memory_block *memory)
> }
> 
> static int init_memory_block(struct memory_block **memory,
>-			     struct mem_section *section, unsigned long state)
>+			     struct mem_section *section, unsigned long state,
>+			     int type)
> {
> 	struct memory_block *mem;
> 	unsigned long start_pfn;
> 	int scn_nr;
> 	int ret = 0;
> 
>+	if (type == MEMORY_BLOCK_NONE)
>+		return -EINVAL;

No one will pass in this value. Can we omit this check for now?

>+
> 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> 	if (!mem)
> 		return -ENOMEM;
>@@ -675,6 +704,7 @@ static int init_memory_block(struct memory_block **memory,
> 	mem->state = state;
> 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
> 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
>+	mem->type = type;
> 
> 	ret = register_memory(mem);
> 
>@@ -699,7 +729,8 @@ static int add_memory_block(int base_section_nr)
> 
> 	if (section_count == 0)
> 		return 0;
>-	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE);
>+	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE,
>+				MEMORY_BLOCK_BOOT);
> 	if (ret)
> 		return ret;
> 	mem->section_count = section_count;
>@@ -722,7 +753,8 @@ int hotplug_memory_register(int nid, struct mem_section *section)
> 		mem->section_count++;
> 		put_device(&mem->dev);
> 	} else {
>-		ret = init_memory_block(&mem, section, MEM_OFFLINE);
>+		ret = init_memory_block(&mem, section, MEM_OFFLINE,
>+					MEMORY_BLOCK_UNSPECIFIED);
> 		if (ret)
> 			goto out;
> 		mem->section_count++;
>diff --git a/include/linux/memory.h b/include/linux/memory.h
>index d75ec88ca09d..06268e96e0da 100644
>--- a/include/linux/memory.h
>+++ b/include/linux/memory.h
>@@ -34,12 +34,39 @@ struct memory_block {
> 	int (*phys_callback)(struct memory_block *);
> 	struct device dev;
> 	int nid;			/* NID for this memory block */
>+	int type;			/* type of this memory block */
> };
> 
> int arch_get_memory_phys_device(unsigned long start_pfn);
> unsigned long memory_block_size_bytes(void);
> int set_memory_block_size_order(unsigned int order);
> 
>+/*
>+ * Memory block types allow user space to formulate rules if and how to
>+ * online memory blocks. The types are exposed to user space as text
>+ * strings in sysfs.
>+ *
>+ * MEMORY_BLOCK_NONE:
>+ *  No memory block is to be created (e.g. device memory). Not exposed to
>+ *  user space.
>+ *
>+ * MEMORY_BLOCK_UNSPECIFIED:
>+ *  The type of memory block was not further specified when adding the
>+ *  memory block.
>+ *
>+ * MEMORY_BLOCK_BOOT:
>+ *  This memory block was added during boot by the basic system. No
>+ *  specific device driver takes care of this memory block. This memory
>+ *  block type is onlined automatically by the kernel during boot and might
>+ *  later be managed by a different device driver, in which case the type
>+ *  might change.
>+ */
>+enum {
>+	MEMORY_BLOCK_NONE = 0,
>+	MEMORY_BLOCK_UNSPECIFIED,
>+	MEMORY_BLOCK_BOOT,
>+};
>+
> /* These states are exposed to userspace as text strings in sysfs */
> #define	MEM_ONLINE		(1<<0) /* exposed to userspace */
> #define	MEM_GOING_OFFLINE	(1<<1) /* exposed to userspace */
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
