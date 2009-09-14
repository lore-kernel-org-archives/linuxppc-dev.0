Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 858B5B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:20:11 +1000 (EST)
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4017DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:20:10 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8EIJPs9017617
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:19:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8EIK87R251812
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:20:08 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8EIK7YI013960
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:20:07 -0400
Message-ID: <4AAE8954.1090709@austin.ibm.com>
Date: Mon, 14 Sep 2009 13:20:04 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] kernel handling of CPU DLPAR
References: <4AAABC55.4070207@austin.ibm.com> <4AAABDF5.4090604@austin.ibm.com>
	<20090914064127.GC13139@centrinvest.ru>
In-Reply-To: <20090914064127.GC13139@centrinvest.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrey Panin wrote:
> On 254, 09 11, 2009 at 04:15:33PM -0500, Nathan Fontenot wrote:
>> This adds the capability to DLPAR add and remove CPUs from the kernel. The
>> creates two new files /sys/devices/system/cpu/probe and
>> /sys/devices/system/cpu/release to handle the DLPAR addition and
>> removal of
>> CPUs respectively.
>>
>> CPU DLPAR add is accomplished by writing the drc-index of the CPU to the
>> probe file, and removal is done by writing the device-tree path of the cpu
>> to the release file.
>>
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
>> +static ssize_t cpu_probe_store(struct class *class, const char *buf,
>> +			       size_t count)
>> +{
>> +	struct device_node *dn;
>> +	u32 drc_index;
>> +	char *cpu_name;
>> +	int rc;
>> +
>> +	drc_index = simple_strtoull(buf, NULL, 0);
>> +	if (!drc_index)
>> +		return -EINVAL;
>> +
>> +	rc = acquire_drc(drc_index);
>> +	if (rc)
>> +		return rc;
>> +
>> +	dn = configure_connector(drc_index);
>> +	if (!dn) {
>> +		release_drc(drc_index);
>> +		return rc;
>> +	}
>> +
>> +	/* fixup dn name */
>> +	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus/") + 1,
>> +			   GFP_KERNEL);
> 
> Unchecked memory allocation with immediate crash in case of failure.

Yep, thats a bad thing.  I'll fix this in an updated patch.  thanks.

-Nathan

> 
>> +	sprintf(cpu_name, "/cpus/%s", dn->full_name);
>> +	kfree(dn->full_name);
>> +	dn->full_name = cpu_name;
>> +
>> +	rc = add_device_tree_nodes(dn);
>> +	if (rc)
>> +		release_drc(drc_index);
>> +
>> +	return rc ? rc : count;
>> +}
>> +
>> +static ssize_t cpu_release_store(struct class *class, const char *buf,
>> +				 size_t count)
>> +{
>> +	struct device_node *dn;
>> +	u32 *drc_index;
>> +	int rc;
>> +
>> +	dn = of_find_node_by_path(buf);
>> +	if (!dn)
>> +		return -EINVAL;
>> +
>> +	drc_index = (u32 *)of_get_property(dn, "ibm,my-drc-index", NULL);
>> +	if (!drc_index) {
>> +		of_node_put(dn);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = release_drc(*drc_index);
>> +	if (rc) {
>> +		of_node_put(dn);
>> +		return rc;
>> +	}
>> +
>> +	rc = remove_device_tree_nodes(dn);
>> +	if (rc)
>> +		acquire_drc(*drc_index);
>> +
>> +	of_node_put(dn);
>> +	return rc? rc : count;
>> +}
>> +
>> static struct class_attribute class_attr_mem_release =
>> 			__ATTR(release, S_IWUSR, NULL, memory_release_store);
>> +static struct class_attribute class_attr_cpu_probe =
>> +			__ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
>> +static struct class_attribute class_attr_cpu_release =
>> +			__ATTR(release, S_IWUSR, NULL, cpu_release_store);
>>
>> static int pseries_dlpar_init(void)
>> {
>> @@ -576,6 +648,18 @@
>> 		printk(KERN_INFO "DLPAR: Could not create sysfs memory "
>> 		       "release file\n");
>>
>> +	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
>> +			       &class_attr_cpu_probe.attr);
>> +	if (rc)
>> +		printk(KERN_INFO "DLPAR: Could not create sysfs cpu "
>> +		       "probe file\n");
>> +
>> +	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
>> +			       &class_attr_cpu_release.attr);
>> +	if (rc)
>> +		printk(KERN_INFO "DLPAR: Could not create sysfs cpu "
>> +		       "release file\n");
>> +
>> 	return 0;
>> }
>> __initcall(pseries_dlpar_init);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
