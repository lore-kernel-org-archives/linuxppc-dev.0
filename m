Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsBl74RKVzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 22:34:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v7] powerpc/powernv: add hdat attribute to sysfs
In-Reply-To: <20170322222716.21767-1-matthew.brown.dev@gmail.com>
References: <20170322222716.21767-1-matthew.brown.dev@gmail.com>
Date: Mon, 27 Mar 2017 22:34:42 +1100
Message-ID: <87inmvdkbx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matt,

Sorry if you're getting sick of this at v7, but here's a few more
comments :D

Matt Brown <matthew.brown.dev@gmail.com> writes:

> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.

You need to update the change log now that the patch has expanded in its
purpose.


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

You should pretty much never have a blank line in your variable
declarations.

> +	struct bin_attribute *attr_tmp;
> +	const __be64 *syms;
> +	unsigned int size;
> +	struct device_node *fw;

It's traditional to call these "np" for "node pointer" (or less commonly "dn").

> +	struct property *prop;
> +	int rc;
> +	int attr_count = 0;
> +	int n = 0;

It's usually better to delay initialisation of variables until when
they're needed, so in this case just prior to the loop that uses them.
Also notice attr_count is only used prior to the use of n, so you could
just use n for both. Though see below.

You should also group common types on one line when possible. And I and
some other folks with good taste, like the longest variable lines first
followed by the shorter ones, so in this case eg:

	struct bin_attribute *exported_attrs, *attr_tmp;
	struct kobject *opal_export_kobj;
	struct device_node *np;
	struct property *prop;
	int rc, attr_count, n;
	const __be64 *syms;
	unsigned int size;
	char **attr_name;

> +
> +	/* Create new 'exports' directory */
> +	opal_export_kobj = kobject_create_and_add("exports", opal_kobj);

Now that this is a local it doesn't need such a verbose name, it could
just be kobj.

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

So here we count the properties of the node.

> +	if (attr_count > 2) {
> +		exported_attrs = kzalloc(sizeof(exported_attrs)*(attr_count-2),
> +				GFP_KERNEL);
> +		attr_name = kzalloc(sizeof(char *)*(attr_count-2), GFP_KERNEL);

And here we alloc space for that number - 2.

> +	}
> +
> +	for_each_property_of_node(fw, prop) {

But this loop does no checking vs attr_count. I know you have the check
for "name" and "phandle" below, but if ever you didn't have those
properties this loop would overflow the end of exported_attrs and
corrupt something else on the heap.

> +		attr_name[n] = kstrdup(prop->name, GFP_KERNEL);

Here we allocate memory for the property name ...

> +		syms = of_get_property(fw, attr_name[n], &size);
> +
> +		if (!strcmp(attr_name[n], "name") ||
> +				!strcmp(attr_name[n], "phandle"))
> +			continue;

But then here we don't free the attr_name we just kstrdup'ed.

>
> +		if (!syms || size != 2 * sizeof(__be64))
> +			continue;

And same here, as well as we've now allocated an extra bin_attr in
exported_attrs that we'll never use.


> +		syms = of_get_property(fw, attr_name[n], &size);
...
> +		if (!syms || size != 2 * sizeof(__be64))
> +			continue;
...
> +		attr_tmp->private = __va(be64_to_cpu(syms[0]));
> +		attr_tmp->size = be64_to_cpu(syms[1]);

The actual reading of the property can be done in a cleaner way using
one of the helpers, eg:

	u64 vals[2];
	...
	if (of_property_read_u64_array(np, prop->name, &vals, 2))
		continue.

And if it succeeds then vals has the two values in CPU endian.

> +		attr_tmp = &exported_attrs[n];

Notice here we use exported_attrs, ...

> +		attr_tmp->attr.name = attr_name[n];

And here we use attr_name.

But we never use them again. We do need to keep the bin_attr alive, we
gave it to sysfs_create_bin_file() after all, but we don't actually need
an array of them. And attr_name is completely unnecessary once we've
assigned the pointer to attr.name.

So the solution is to drop the allocation of exported_attrs and
attr_name prior to the loop.

Then in the loop we do:

	for_each_property_of_node(fw, prop)

		Check for name or phandle, else continue
		Read the property value using read_u64_array, else continue
		Allocate one attr else warn and continue
                Strdup the prop->name into attr->name, else kfree(attr), warn, continue
                Intialise the attr
                Call sysfs_create_bin_file(), if it fails, warn and kfree(attr)

cheers
