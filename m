Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpT8V0K0zzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 12:13:45 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2N1DY7J065889
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 21:13:34 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29btuwk778-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 21:13:34 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 23 Mar 2017 11:13:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2N1DH8330736610
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 12:13:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2N1CqX3031542
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 12:12:52 +1100
Subject: Re: [v7] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170322222916.8480278038@b03ledav004.gho.boulder.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 23 Mar 2017 12:12:28 +1100
MIME-Version: 1.0
In-Reply-To: <20170322222916.8480278038@b03ledav004.gho.boulder.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <67385469-4485-5821-7b86-5138538e2d4b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/03/17 09:27, Matt Brown wrote:
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> Changelog:
>
> v7:	
> 	- moved exported_attrs and attr_name into opal_export_attrs
> ---
>  arch/powerpc/platforms/powernv/opal.c | 84 +++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..b8f057f 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -604,6 +604,87 @@ static void opal_export_symmap(void)
>  		pr_warn("Error %d creating OPAL symbols file\n", rc);
>  }
>
> +static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
> +			     struct bin_attribute *bin_attr, char *buf,
> +			     loff_t off, size_t count)
> +{
> +	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
> +				       bin_attr->size);
> +}
> +
> +/*
> + * opal_export_attrs: creates a sysfs node for each property listed in
> + * the device-tree under /ibm,opal/firmware/exports/
> + * All new sysfs nodes are created under /opal/exports/.
> + * This allows for reserved memory regions (e.g. HDAT) to be read.
> + * The new sysfs nodes are only readable by root.
> + */
> +static void opal_export_attrs(void)
> +{
> +	/* /sys/firmware/opal/exports */
> +	struct kobject *opal_export_kobj;
> +	struct bin_attribute *exported_attrs;
> +	char **attr_name;
> +
> +	struct bin_attribute *attr_tmp;
> +	const __be64 *syms;
> +	unsigned int size;
> +	struct device_node *fw;
> +	struct property *prop;
> +	int rc;
> +	int attr_count = 0;
> +	int n = 0;
> +
> +	/* Create new 'exports' directory */
> +	opal_export_kobj = kobject_create_and_add("exports", opal_kobj);
> +	if (!opal_export_kobj) {
> +		pr_warn("kobject_create_and_add opal_exports failed\n");
> +		return;
> +	}
> +
> +	fw = of_find_node_by_path("/ibm,opal/firmware/exports");
> +	if (!fw)
> +		return;
> +
> +	for (prop = fw->properties; prop != NULL; prop = prop->next)
> +		attr_count++;
> +
> +	if (attr_count > 2) {
> +		exported_attrs = kzalloc(sizeof(exported_attrs)*(attr_count-2),
> +				GFP_KERNEL);
> +		attr_name = kzalloc(sizeof(char *)*(attr_count-2), GFP_KERNEL);
> +	}
> +
> +	for_each_property_of_node(fw, prop) {
> +
> +		attr_name[n] = kstrdup(prop->name, GFP_KERNEL);
> +		syms = of_get_property(fw, attr_name[n], &size);
> +
> +		if (!strcmp(attr_name[n], "name") ||
> +				!strcmp(attr_name[n], "phandle"))
> +			continue;
> +
> +		if (!syms || size != 2 * sizeof(__be64))
> +			continue;
> +
> +		attr_tmp = &exported_attrs[n];
> +		attr_tmp->attr.name = attr_name[n];
> +		attr_tmp->attr.mode = 0400;
> +		attr_tmp->read = export_attr_read;
> +		attr_tmp->private = __va(be64_to_cpu(syms[0]));
> +		attr_tmp->size = be64_to_cpu(syms[1]);
> +
> +		rc = sysfs_create_bin_file(opal_export_kobj, attr_tmp);
> +		if (rc)
> +			pr_warn("Error %d creating OPAL sysfs exports/%s file\n",
> +					rc, attr_name[n]);
> +		n++;
> +	}
> +
> +	of_node_put(fw);
> +
> +}
> +
>  static void __init opal_dump_region_init(void)
>  {
>  	void *addr;
> @@ -742,6 +823,9 @@ static int __init opal_init(void)
>  		opal_msglog_sysfs_init();
>  	}
>
> +	/* Export all properties */
> +	opal_export_attrs();
> +
>  	/* Initialize platform devices: IPMI backend, PRD & flash interface */
>  	opal_pdev_init("ibm,opal-ipmi");
>  	opal_pdev_init("ibm,opal-flash");
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
