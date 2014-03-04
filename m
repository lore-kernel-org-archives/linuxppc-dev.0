Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B7382C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 23:22:50 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 4 Mar 2014 22:22:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 62AFE2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 23:22:45 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s24C2h4630212336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 23:02:44 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s24CMiKm024077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 23:22:44 +1100
Message-ID: <5315C592.4050605@linux.vnet.ibm.com>
Date: Tue, 04 Mar 2014 17:52:42 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/powernv Platform dump interface
References: <1393393321-9902-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1393802742-3891-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1393802742-3891-1-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/2014 04:55 AM, Stewart Smith wrote:
> This enables support for userspace to fetch and initiate FSP and
> Platform dumps from the service processor (via firmware) through sysfs.
>
> Based on original patch from Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>
> Flow:
>    - We register for OPAL notification events.
>    - OPAL sends new dump available notification.
>    - We make information on dump available via sysfs
>    - Userspace requests dump contents
>    - We retrieve the dump via OPAL interface
>    - User copies the dump data
>    - userspace sends ack for dump
>    - We send ACK to OPAL.
>
> sysfs files:
>    - We add the /sys/firmware/opal/dump directory
>    - echoing 1 (well, anything, but in future we may support
>      different dump types) to /sys/firmware/opal/dump/initiate_dump
>      will initiate a dump.

Stewart,

s/initiate/initiate FSP/

>    - Each dump that we've been notified of gets a directory
>      in /sys/firmware/opal/dump/ with a name of the dump type and ID (in hex,
>      as this is what's used elsewhere to identify the dump).
>    - Each dump has files: id, type, dump and acknowledge
>      dump is binary and is the dump itself.
>      echoing 'ack' to acknowledge (currently any string will do) will
>      acknowledge the dump and it will soon after disappear from sysfs.
>
> OPAL APIs:
>    - opal_dump_init()
>    - opal_dump_info()

opal_dump_info2()

>    - opal_dump_read()
>    - opal_dump_ack()
>    - opal_dump_resend_notification()
>
> Currently we are only ever notified for one dump at a time (until
> the user explicitly acks the current dump, then we get a notification
> of the next dump), but this kernel code should "just work" when OPAL
> starts notifying us of all the dumps present.
>
> Changes since v2:
>   - fix bug where we would free the dump buffer after userspace read it,
>     refetching if needed. Refetching doesn't currently work, so we must
>     keep the dump around for subsequent reads.
>
> Changes since v1:
>   - Add support for getting dump type from OPAL through new OPAL call
>     (falling back to old OPAL_DUMP_INFO call if OPAL_DUMP_INFO2 isn't
>      supported)
>   - use dump type in directory name for dump
>
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> ---
>   Documentation/ABI/stable/sysfs-firmware-opal-dump |   41 ++
>   arch/powerpc/include/asm/opal.h                   |   14 +
>   arch/powerpc/platforms/powernv/Makefile           |    2 +-
>   arch/powerpc/platforms/powernv/opal-dump.c        |  525 +++++++++++++++++++++
>   arch/powerpc/platforms/powernv/opal-wrappers.S    |    6 +
>   arch/powerpc/platforms/powernv/opal.c             |    2 +
>   6 files changed, 589 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/stable/sysfs-firmware-opal-dump
>   create mode 100644 arch/powerpc/platforms/powernv/opal-dump.c
>
> diff --git a/Documentation/ABI/stable/sysfs-firmware-opal-dump b/Documentation/ABI/stable/sysfs-firmware-opal-dump
> new file mode 100644
> index 0000000..32fe7f5
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-firmware-opal-dump
> @@ -0,0 +1,41 @@
> +What:		/sys/firmware/opal/dump
> +Date:		Feb 2014
> +Contact:	Stewart Smith <stewart@linux.vnet.ibm.com>
> +Description:
> +		This directory exposes interfaces for interacting with
> +		the FSP and platform dumps through OPAL firmware interface.
> +
> +		This is only for the powerpc/powernv platform.
> +
> +		initiate_dump:	When '1' is written to it,
> +				we will initiate a dump.

initiate FSP dump

> +				Read this file for supported commands.
> +
> +		0xXX-0xYYYY:	A directory for dump of type 0xXX and
> +				id 0xYYYY (in hex). The name of this
> +				directory should not be relied upon to
> +				be in this format, only that it's unique
> +				among all dumps. For determining the type
> +				and ID of the dump, use the id and type files.
> +				Do not rely on any particular size of dump
> +				type or dump id.
> +
> +		Each dump has the following files:
> +		id:		An ASCII representation of the dump ID
> +				in hex (e.g. '0x01')
> +		type:		An ASCII representation of the type of
> +				dump in the format "0x%x %s" with the ID

Better 0x%x - %s ?

> +				in hex and a description of the dump type
> +				(or 'unknown').
> +				Type '0xffffffff unknown' is used when
> +				we could not get the type from firmware.
> +				e.g. '0x02 System/Platform Dump'
> +		dump:		A binary file containing the dump.
> +				The size of the dump is the size of this file.
> +		acknowledge:	When 'ack' is written to this, we will
> +				acknowledge that we've retrieved the
> +				dump to the service processor. It will
> +				then remove it, making the dump
> +				inaccessible.
> +				Reading this file will get a list of
> +				supported actions.
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 40157e2..89c840c 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -154,9 +154,15 @@ extern int opal_enter_rtas(struct rtas_args *args,
>   #define OPAL_FLASH_VALIDATE			76
>   #define OPAL_FLASH_MANAGE			77
>   #define OPAL_FLASH_UPDATE			78
> +#define OPAL_DUMP_INIT				81
> +#define OPAL_DUMP_INFO				82
> +#define OPAL_DUMP_READ				83
> +#define OPAL_DUMP_ACK				84
>   #define OPAL_GET_MSG				85
>   #define OPAL_CHECK_ASYNC_COMPLETION		86
> +#define OPAL_DUMP_RESEND			91
>   #define OPAL_SYNC_HOST_REBOOT			87
> +#define OPAL_DUMP_INFO2				94
>
>   #ifndef __ASSEMBLY__
>
> @@ -237,6 +243,7 @@ enum OpalPendingState {
>   	OPAL_EVENT_EPOW			= 0x80,
>   	OPAL_EVENT_LED_STATUS		= 0x100,
>   	OPAL_EVENT_PCI_ERROR		= 0x200,
> +	OPAL_EVENT_DUMP_AVAIL		= 0x400,
>   	OPAL_EVENT_MSG_PENDING		= 0x800,
>   };
>
> @@ -826,6 +833,12 @@ int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
>   int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
>   int64_t opal_manage_flash(uint8_t op);
>   int64_t opal_update_flash(uint64_t blk_list);
> +int64_t opal_dump_init(uint8_t dump_type);
> +int64_t opal_dump_info(uint32_t *dump_id, uint32_t *dump_size);
> +int64_t opal_dump_info2(uint32_t *dump_id, uint32_t *dump_size, uint32_t *dump_type);
> +int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
> +int64_t opal_dump_ack(uint32_t dump_id);
> +int64_t opal_dump_resend_notification(void);
>
>   int64_t opal_get_msg(uint64_t buffer, size_t size);
>   int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
> @@ -861,6 +874,7 @@ extern void opal_get_rtc_time(struct rtc_time *tm);
>   extern unsigned long opal_get_boot_time(void);
>   extern void opal_nvram_init(void);
>   extern void opal_flash_init(void);
> +extern void opal_platform_dump_init(void);
>
>   extern int opal_machine_check(struct pt_regs *regs);
>
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 8d767fd..3528c11 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,6 +1,6 @@
>   obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
>   obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
> -obj-y			+= rng.o
> +obj-y			+= rng.o opal-dump.o
>
>   obj-$(CONFIG_SMP)	+= smp.o
>   obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
> new file mode 100644
> index 0000000..0c767c5
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
> @@ -0,0 +1,525 @@
> +/*
> + * PowerNV OPAL Dump Interface
> + *
> + * Copyright 2013,2014 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kobject.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/pagemap.h>
> +#include <linux/delay.h>
> +
> +#include <asm/opal.h>
> +
> +#define DUMP_TYPE_FSP	0x01

Better define other dump type (sysdump etc) here and use it below ?

> +
> +struct dump_obj {
> +	struct kobject  kobj;
> +	struct bin_attribute dump_attr;
> +	uint32_t	id;  /* becomes object name */
> +	uint32_t	type;
> +	uint32_t	size;
> +	char		*buffer;
> +};
> +#define to_dump_obj(x) container_of(x, struct dump_obj, kobj)
> +
> +struct dump_attribute {
> +	struct attribute attr;
> +	ssize_t (*show)(struct dump_obj *dump, struct dump_attribute *attr,
> +			char *buf);
> +	ssize_t (*store)(struct dump_obj *dump, struct dump_attribute *attr,
> +			 const char *buf, size_t count);
> +};
> +#define to_dump_attr(x) container_of(x, struct dump_attribute, attr)
> +
> +static ssize_t dump_id_show(struct dump_obj *dump_obj,
> +			    struct dump_attribute *attr,
> +			    char *buf)
> +{
> +	return sprintf(buf, "0x%x\n", dump_obj->id);
> +}
> +
> +static const char* dump_type_to_string(uint32_t type)
> +{
> +	switch (type) {
> +	case 0x01: return "SP Dump";
> +	case 0x02: return "System/Platform Dump";
> +	case 0x03: return "SMA Dump";
> +	default: return "unknown";
> +	}
> +}
> +
> +static ssize_t dump_type_show(struct dump_obj *dump_obj,
> +			      struct dump_attribute *attr,
> +			      char *buf)
> +{
> +	
> +	return sprintf(buf, "0x%x %s\n", dump_obj->type,

Better 0x%x - %s ?

> +		       dump_type_to_string(dump_obj->type));
> +}
> +
> +static ssize_t dump_ack_show(struct dump_obj *dump_obj,
> +			     struct dump_attribute *attr,
> +			     char *buf)
> +{
> +	return sprintf(buf, "ack - acknowledge dump\n");

Not sure but better "echo ack - acknowledge dump"?

> +}
> +
> +/*
> + * Send acknowledgement to OPAL
> + */
> +static int64_t dump_send_ack(uint32_t dump_id)
> +{
> +	int rc;
> +
> +	rc = opal_dump_ack(dump_id);
> +	if (rc)
> +		pr_warn("%s: Failed to send ack to Dump ID 0x%x (%d)\n",
> +			__func__, dump_id, rc);
> +	return rc;
> +}
> +
> +static void delay_release_kobj(void *kobj)
> +{
> +	kobject_put((struct kobject *)kobj);
> +}
> +
> +static ssize_t dump_ack_store(struct dump_obj *dump_obj,
> +			      struct dump_attribute *attr,
> +			      const char *buf,
> +			      size_t count)
> +{
> +	dump_send_ack(dump_obj->id);
> +	sysfs_schedule_callback(&dump_obj->kobj, delay_release_kobj,
> +				&dump_obj->kobj, THIS_MODULE);
> +	return count;
> +}
> +
> +/* Attributes of a dump
> + * The binary attribute of the dump itself is dynamic
> + * due to the dynamic size of the dump
> + */
> +static struct dump_attribute id_attribute =
> +	__ATTR(id, 0666, dump_id_show, NULL);
> +static struct dump_attribute type_attribute =
> +	__ATTR(type, 0666, dump_type_show, NULL);
> +static struct dump_attribute ack_attribute =
> +	__ATTR(acknowledge, 0660, dump_ack_show, dump_ack_store);
> +
> +static ssize_t init_dump_show(struct dump_obj *dump_obj,
> +			      struct dump_attribute *attr,
> +			      char *buf)
> +{
> +	return sprintf(buf, "1 - initiate dump\n");

initiate FSP dump

> +}
> +
> +static int64_t dump_fips_init(uint8_t type)
> +{
> +	int rc;
> +
> +	rc = opal_dump_init(type);
> +	if (rc)
> +		pr_warn("%s: Failed to initiate FipS dump (%d)\n",
> +			__func__, rc);
> +	return rc;
> +}
> +
> +static ssize_t init_dump_store(struct dump_obj *dump_obj,
> +			       struct dump_attribute *attr,
> +			       const char *buf,
> +			       size_t count)
> +{
> +	dump_fips_init(DUMP_TYPE_FSP);
> +	pr_info("%s: Initiated FSP dump\n", __func__);

This might mislead if OPAL fails to initiate FSP dump.. Better move this to 
dump_fips_init () ?

> +	return count;
> +}
> +
> +static struct dump_attribute initiate_attribute =
> +	__ATTR(initiate_dump, 0600, init_dump_show, init_dump_store);
> +
> +static struct attribute *initiate_attrs[] = {
> +	&initiate_attribute.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group initiate_attr_group = {
> +	.attrs = initiate_attrs,
> +};
> +
> +static struct kset *dump_kset;
> +
> +static ssize_t dump_attr_show(struct kobject *kobj,
> +			      struct attribute *attr,
> +			      char *buf)
> +{
> +	struct dump_attribute *attribute;
> +	struct dump_obj *dump;
> +
> +	attribute = to_dump_attr(attr);
> +	dump = to_dump_obj(kobj);
> +
> +	if (!attribute->show)
> +		return -EIO;
> +
> +	return attribute->show(dump, attribute, buf);
> +}
> +
> +static ssize_t dump_attr_store(struct kobject *kobj,
> +			       struct attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct dump_attribute *attribute;
> +	struct dump_obj *dump;
> +
> +	attribute = to_dump_attr(attr);
> +	dump = to_dump_obj(kobj);
> +
> +	if (!attribute->store)
> +		return -EIO;
> +
> +	return attribute->store(dump, attribute, buf, len);
> +}
> +
> +static const struct sysfs_ops dump_sysfs_ops = {
> +	.show = dump_attr_show,
> +	.store = dump_attr_store,
> +};
> +
> +static void dump_release(struct kobject *kobj)
> +{
> +	struct dump_obj *dump;
> +
> +	dump = to_dump_obj(kobj);
> +	vfree(dump->buffer);
> +	kfree(dump);
> +}
> +
> +static struct attribute *dump_default_attrs[] = {
> +	&id_attribute.attr,
> +	&type_attribute.attr,
> +	&ack_attribute.attr,
> +	NULL,
> +};
> +
> +static struct kobj_type dump_ktype = {
> +	.sysfs_ops = &dump_sysfs_ops,
> +	.release = &dump_release,
> +	.default_attrs = dump_default_attrs,
> +};
> +
> +static void free_dump_sg_list(struct opal_sg_list *list)
> +{
> +	struct opal_sg_list *sg1;
> +	while (list) {
> +		sg1 = list->next;
> +		kfree(list);
> +		list = sg1;
> +	}
> +	list = NULL;
> +}
> +
> +static struct opal_sg_list *dump_data_to_sglist(struct dump_obj *dump)
> +{
> +	struct opal_sg_list *sg1, *list = NULL;
> +	void *addr;
> +	int64_t size;
> +
> +	addr = dump->buffer;
> +	size = dump->size;
> +
> +	sg1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!sg1)
> +		goto nomem;
> +
> +	list = sg1;
> +	sg1->num_entries = 0;
> +	while (size > 0) {
> +		/* Translate virtual address to physical address */
> +		sg1->entry[sg1->num_entries].data =
> +			(void *)(vmalloc_to_pfn(addr) << PAGE_SHIFT);
> +
> +		if (size > PAGE_SIZE)
> +			sg1->entry[sg1->num_entries].length = PAGE_SIZE;
> +		else
> +			sg1->entry[sg1->num_entries].length = size;
> +
> +		sg1->num_entries++;
> +		if (sg1->num_entries >= SG_ENTRIES_PER_NODE) {
> +			sg1->next = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +			if (!sg1->next)
> +				goto nomem;
> +
> +			sg1 = sg1->next;
> +			sg1->num_entries = 0;
> +		}
> +		addr += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
> +	return list;
> +
> +nomem:
> +	pr_err("%s : Failed to allocate memory\n", __func__);
> +	free_dump_sg_list(list);
> +	return NULL;
> +}
> +
> +static void sglist_to_phy_addr(struct opal_sg_list *list)
> +{
> +	struct opal_sg_list *sg, *next;
> +
> +	for (sg = list; sg; sg = next) {
> +		next = sg->next;
> +		/* Don't translate NULL pointer for last entry */
> +		if (sg->next)
> +			sg->next = (struct opal_sg_list *)__pa(sg->next);
> +		else
> +			sg->next = NULL;
> +
> +		/* Convert num_entries to length */
> +		sg->num_entries =
> +			sg->num_entries * sizeof(struct opal_sg_entry) + 16;
> +	}
> +}
> +
> +static int64_t dump_read_info(uint32_t *id, uint32_t *size, uint32_t *type)
> +{
> +	int rc;
> +	*type = 0xffffffff;
> +
> +	rc = opal_dump_info2(id, size, type);
> +
> +	if (rc == OPAL_PARAMETER)
> +		rc = opal_dump_info(id, size);
> +
> +	if (rc)
> +		pr_warn("%s: Failed to get dump info (%d)\n",
> +			__func__, rc);
> +	return rc;
> +}
> +
> +static int64_t dump_read_data(struct dump_obj *dump)
> +{
> +	struct opal_sg_list *list;
> +	uint64_t addr;
> +	int64_t rc;
> +
> +	/* Allocate memory */
> +	dump->buffer = vzalloc(PAGE_ALIGN(dump->size));
> +	if (!dump->buffer) {
> +		pr_err("%s : Failed to allocate memory\n", __func__);
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Generate SG list */
> +	list = dump_data_to_sglist(dump);
> +	if (!list) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Translate sg list addr to real address */
> +	sglist_to_phy_addr(list);
> +
> +	/* First entry address */
> +	addr = __pa(list);
> +
> +	/* Fetch data */
> +	rc = OPAL_BUSY_EVENT;
> +	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
> +		rc = opal_dump_read(dump->id, addr);
> +		if (rc == OPAL_BUSY_EVENT) {
> +			opal_poll_events(NULL);
> +			msleep(20);
> +		}
> +	}
> +
> +	if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL)
> +		pr_warn("%s: Extract dump failed for ID 0x%x\n",
> +			__func__, dump->id);
> +
> +	/* Free SG list */
> +	free_dump_sg_list(list);
> +
> +out:
> +	return rc;
> +}
> +
> +static ssize_t dump_attr_read(struct file *filep, struct kobject *kobj,
> +			      struct bin_attribute *bin_attr,
> +			      char *buffer, loff_t pos, size_t count)
> +{
> +	ssize_t rc;
> +
> +	struct dump_obj *dump = to_dump_obj(kobj);
> +
> +	if (!dump->buffer) {
> +		rc = dump_read_data(dump);
> +
> +		if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL) {
> +			vfree(dump->buffer);
> +			dump->buffer = NULL;
> +
> +			return -EIO;
> +		}
> +		if (rc == OPAL_PARTIAL) {
> +			/* On a partial read, we just return EIO
> +			 * and rely on userspace to ask us to try
> +			 * again.
> +			 */
> +			pr_info("%s: Platform dump partially read.ID = 0x%x\n",

s/read.ID/read. ID/

Rest looks good.

-Vasant

> +				__func__, dump->id);
> +			return -EIO;
> +		}
> +	}
> +
> +	memcpy(buffer, dump->buffer + pos, count);
> +
> +	/* You may think we could free the dump buffer now and retrieve
> +	 * it again later if needed, but due to current firmware limitation,
> +	 * that's not the case. So, once read into userspace once,
> +	 * we keep the dump around until it's acknowledged by userspace.
> +	 */
> +
> +	return count;
> +}
> +
> +static struct dump_obj *create_dump_obj(uint32_t id, size_t size,
> +					uint32_t type)
> +{
> +	struct dump_obj *dump;
> +	int rc;
> +
> +	dump = kzalloc(sizeof(*dump), GFP_KERNEL);
> +	if (!dump)
> +		return NULL;
> +
> +	dump->kobj.kset = dump_kset;
> +
> +	kobject_init(&dump->kobj, &dump_ktype);
> +
> +	sysfs_bin_attr_init(&dump->dump_attr);
> +
> +	dump->dump_attr.attr.name = "dump";
> +	dump->dump_attr.attr.mode = 0400;
> +	dump->dump_attr.size = size;
> +	dump->dump_attr.read = dump_attr_read;
> +
> +	dump->id = id;
> +	dump->size = size;
> +	dump->type = type;
> +
> +	rc = kobject_add(&dump->kobj, NULL, "0x%x-0x%x", type, id);
> +	if (rc) {
> +		kobject_put(&dump->kobj);
> +		return NULL;
> +	}
> +
> +	rc = sysfs_create_bin_file(&dump->kobj, &dump->dump_attr);
> +	if (rc) {
> +		kobject_put(&dump->kobj);
> +		return NULL;
> +	}
> +
> +	pr_info("%s: New platform dump. ID = 0x%x Size %u\n",
> +		__func__, dump->id, dump->size);
> +
> +	kobject_uevent(&dump->kobj, KOBJ_ADD);
> +
> +	return dump;
> +}
> +
> +static int process_dump(void)
> +{
> +	int rc;
> +	uint32_t dump_id, dump_size, dump_type;
> +	struct dump_obj *dump;
> +	char name[22];
> +
> +	rc = dump_read_info(&dump_id, &dump_size, &dump_type);
> +	if (rc != OPAL_SUCCESS)
> +		return rc;
> +
> +	sprintf(name, "0x%x-0x%x", dump_type, dump_id);
> +
> +	/* we may get notified twice, let's handle
> +	 * that gracefully and not create two conflicting
> +	 * entries.
> +	 */
> +	if (kset_find_obj(dump_kset, name))
> +		return 0;
> +
> +	dump = create_dump_obj(dump_id, dump_size, dump_type);
> +	if (!dump)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void dump_work_fn(struct work_struct *work)
> +{
> +	process_dump();
> +}
> +
> +static DECLARE_WORK(dump_work, dump_work_fn);
> +
> +static void schedule_process_dump(void)
> +{
> +	schedule_work(&dump_work);
> +}
> +
> +/*
> + * New dump available notification
> + *
> + * Once we get notification, we add sysfs entries for it.
> + * We only fetch the dump on demand, and create sysfs asynchronously.
> + */
> +static int dump_event(struct notifier_block *nb,
> +		      unsigned long events, void *change)
> +{
> +	if (events & OPAL_EVENT_DUMP_AVAIL)
> +		schedule_process_dump();
> +
> +	return 0;
> +}
> +
> +static struct notifier_block dump_nb = {
> +	.notifier_call  = dump_event,
> +	.next           = NULL,
> +	.priority       = 0
> +};
> +
> +void __init opal_platform_dump_init(void)
> +{
> +	int rc;
> +
> +	dump_kset = kset_create_and_add("dump", NULL, opal_kobj);
> +	if (!dump_kset) {
> +		pr_warn("%s: Failed to create dump kset\n", __func__);
> +		return;
> +	}
> +
> +	rc = sysfs_create_group(&dump_kset->kobj, &initiate_attr_group);
> +	if (rc) {
> +		pr_warn("%s: Failed to create initiate dump attr group\n",
> +			__func__);
> +		kobject_put(&dump_kset->kobj);
> +		return;
> +	}
> +
> +	rc = opal_notifier_register(&dump_nb);
> +	if (rc) {
> +		pr_warn("%s: Can't register OPAL event notifier (%d)\n",
> +			__func__, rc);
> +		return;
> +	}
> +
> +	opal_dump_resend_notification();
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 3e8829c..3e02783 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -126,6 +126,12 @@ OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
>   OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
>   OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
>   OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
> +OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
> +OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
> +OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
> +OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
> +OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
>   OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
>   OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
> +OPAL_CALL(opal_dump_resend_notification,	OPAL_DUMP_RESEND);
>   OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 65499ad..262cd1a 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -474,6 +474,8 @@ static int __init opal_init(void)
>   	if (rc == 0) {
>   		/* Setup code update interface */
>   		opal_flash_init();
> +		/* Setup platform dump extract interface */
> +		opal_platform_dump_init();
>   	}
>
>   	return 0;
>
