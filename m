Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vknh45gCTzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 12:24:52 +1100 (AEDT)
Received: by mail-qk0-x244.google.com with SMTP id j127so8208202qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:24:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170302054442.6533-1-matthew.brown.dev@gmail.com>
References: <20170302054442.6533-1-matthew.brown.dev@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 17 Mar 2017 12:24:49 +1100
Message-ID: <CAOSf1CGZ9y1abXM8P=kGRd7VGjKm08Qa=zmScVT+n-vDAWxWKQ@mail.gmail.com>
Subject: Re: [Patch v5] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 2, 2017 at 4:44 PM, Matt Brown <matthew.brown.dev@gmail.com> wrote:
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
> This patch also adds sysfs nodes for all properties in the device-tree
> under /ibm,opal/firmware/exports.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> Changes between v4 and v5:
>         - all properties under /ibm,opal/firmware/exports in the device-tree
>           are now added as new sysfs nodes
>         - the new sysfs nodes are now placed under /opal/exports
>         - added a generic read function for all exported attributes
> ---
>  arch/powerpc/platforms/powernv/opal.c | 84 +++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..fbb8264 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -36,6 +36,9 @@
>  /* /sys/firmware/opal */
>  struct kobject *opal_kobj;
>
> +/* /sys/firmware/opal/exports */
> +struct kobject *opal_export_kobj;
> +
>  struct opal {
>         u64 base;
>         u64 entry;
> @@ -604,6 +607,82 @@ static void opal_export_symmap(void)
>                 pr_warn("Error %d creating OPAL symbols file\n", rc);
>  }
>
> +

> +static int opal_exports_sysfs_init(void)
> +{
> +       opal_export_kobj = kobject_create_and_add("exports", opal_kobj);
> +       if (!opal_export_kobj) {
> +               pr_warn("kobject_create_and_add opal_exports failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}

This can be folded into opal_export_attrs().

> +
> +static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
> +                            struct bin_attribute *bin_attr, char *buf,
> +                            loff_t off, size_t count)
> +{
> +       return memory_read_from_buffer(buf, count, &off, bin_attr->private,
> +                                      bin_attr->size);
> +}
> +
> +static struct bin_attribute *exported_attrs;
> +/*
> + * opal_export_attrs: creates a sysfs node for each property listed in
> + * the device-tree under /ibm,opal/firmware/exports/
> + * All new sysfs nodes are created under /opal/exports/.
> + * This allows for reserved memory regions (e.g. HDAT) to be read.
> + * The new sysfs nodes are only readable by root.
> + */
> +static void opal_export_attrs(void)
> +{
> +       const __be64 *syms;
> +       unsigned int size;
> +       struct device_node *fw;
> +       struct property *prop;
> +       int rc;
> +       int attr_count = 0;
> +       int n = 0;
> +

> +       fw = of_find_node_by_path("/ibm,opal/firmware/exports");
> +       if (!fw)
> +               return;

devicetree nodes are reference counted so when you take a reference to
one using of_find_node_* you should use of_put_node() to drop the reference
when you're finished with it. Of course, there's plenty of existing code that
doesn't do this, but that's no reason to make a bad problem worse ;)

> +
> +       for (prop = fw->properties; prop != NULL; prop = prop->next)
> +               attr_count++;
> +
> +       if (attr_count > 2)
> +               exported_attrs = kmalloc(sizeof(exported_attrs)*(attr_count-2),
> +                               __GFP_IO | __GFP_FS);

Why are you using __GFP_IO | __GFP_FS instead of GFP_KERNEL? Also,
using kzalloc(), which zeros memory, over kmalloc() is a good idea in
general since structures can contain fields that change the behaviour
of the function that you pass them to.

> +
> +
> +       for_each_property_of_node(fw, prop) {
> +
> +               syms = of_get_property(fw, prop->name, &size);
> +
> +               if (!strcmp(prop->name, "name") ||
> +                               !strcmp(prop->name, "phandle"))
> +                       continue;
> +
> +               if (!syms || size != 2 * sizeof(__be64))
> +                       continue;
> +

> +               (exported_attrs+n)->attr.name = prop->name;

References to DT properties are only valid if you have a reference to
the DT node that contains them. DT nodes and properties can (in
theory) be changed at runtime, but in practice this only really
happens for nodes that refer to hotpluggable devices (memory, PCI,
etc), but its still poor form to rely on things not happening. You can
make a copy of the name with kstrdup() and store that pointer for as
long as you like, since you can guarantee the copy will exist until
you explicitly free() it.

> +               (exported_attrs+n)->attr.mode = 0400;
> +               (exported_attrs+n)->read = export_attr_read;
> +               (exported_attrs+n)->private = __va(be64_to_cpu(syms[0]));
> +               (exported_attrs+n)->size = be64_to_cpu(syms[1]);

(exported_attrs+n)->field is kinda wierd syntax. Using the array
indexing format: 'exported_attrs[n].field' is usually nicer than
pointer arithmatic, but with nested structures its a bit unwieldy.
Personally I'd do something like:

attr = &exported_attr[n];
attr->field1 = value1;
attr->field2 = value2;

But that's just, like, my opinion man.

> +
> +               rc = sysfs_create_bin_file(opal_export_kobj, exported_attrs+n);
> +               if (rc)
> +                       pr_warn("Error %d creating OPAL %s file\n", rc,
> +                               prop->name);

I think this is a bit too value an error message. Could you make it a
little more specific? E.g something like "error creating OPAL sysfs
export '%s'

> +               n++;
> +       }
> +
> +}
> +
>  static void __init opal_dump_region_init(void)
>  {
>         void *addr;
> @@ -742,6 +821,11 @@ static int __init opal_init(void)
>                 opal_msglog_sysfs_init();
>         }
>
> +       rc = opal_exports_sysfs_init();
> +       if (rc == 0) {
> +               /* Export all properties */
> +               opal_export_attrs();
> +       }
>         /* Initialize platform devices: IPMI backend, PRD & flash interface */
>         opal_pdev_init("ibm,opal-ipmi");
>         opal_pdev_init("ibm,opal-flash");
> --
> 2.9.3
>
