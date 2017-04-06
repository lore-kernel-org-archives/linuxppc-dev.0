Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzDLC2mTTzDqTK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 17:07:31 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id r45so4574888qte.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 00:07:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329232801.20544-1-matthew.brown.dev@gmail.com>
References: <20170329232801.20544-1-matthew.brown.dev@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 6 Apr 2017 17:07:28 +1000
Message-ID: <CAOSf1CGKs-mc_2LSMh3Ru5GgsEPDXFpVE1A_Yo0OFELNNUW+oQ@mail.gmail.com>
Subject: Re: [v8] powerpc/powernv: add 'firmware/exports' attributes to sysfs
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

On Thu, Mar 30, 2017 at 10:28 AM, Matt Brown
<matthew.brown.dev@gmail.com> wrote:
> The HDAT data area is consumed by skiboot and turned into a device-tree. In
> some cases we would like to look directly at the HDAT. This is not possible
> through /dev/mem as it is reserved memory which is stopped by the /dev/mem
> filter. There are also other memory areas which are reserved but could be
> useful to view for debugging purposes.
>
> This patch adds sysfs nodes to allow specified memory areas to be viewed.
> sysfs nodes are created for each property in the device-tree under
> /ibm,opal/firmware/exports/, and adds them to /sys/firmware/opal/exports/
> with root read-only permissions.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> Changelog
> v8
>         - fixed error handling
>         - added dynamic allocation of attributes
>         - using of_property_read_u64_array for reading attr vals
>         - reordered vars
>         - renaming vars
> ---
>  arch/powerpc/platforms/powernv/opal.c | 81 +++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..232f94e 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -604,6 +604,84 @@ static void opal_export_symmap(void)
>                 pr_warn("Error %d creating OPAL symbols file\n", rc);
>  }
>
> +static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
> +                            struct bin_attribute *bin_attr, char *buf,
> +                            loff_t off, size_t count)
> +{
> +       return memory_read_from_buffer(buf, count, &off, bin_attr->private,
> +                                      bin_attr->size);
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
> +       struct bin_attribute *attr_tmp;
> +       struct device_node *np;
> +       struct property *prop;
> +       struct kobject *kobj;
> +       u64 vals[2];
> +       int rc, n;
> +
> +       /* Create new 'exports' directory - /sys/firmware/opal/exports */
> +       kobj = kobject_create_and_add("exports", opal_kobj);
> +       if (!kobj) {
> +               pr_warn("kobject_create_and_add exports failed\n");
> +               return;
> +       }
> +
> +       np = of_find_node_by_path("/ibm,opal/firmware/exports");
> +       if (!np)
> +               return;
> +
> +       n = 0;
> +       for (prop = np->properties; prop != NULL; prop = prop->next)
> +               n++;
> +
> +       if (n < 2)
> +               goto cleanup;
> +
> +       for_each_property_of_node(np, prop) {
> +               if (!strcmp(prop->name, "name") ||
> +                               !strcmp(prop->name, "phandle"))
> +                       continue;
> +
> +               if (of_property_read_u64_array(np, prop->name, &vals[0], 2))
> +                       continue;
> +
> +               attr_tmp = kmalloc(sizeof(*attr_tmp), GFP_KERNEL);
> +
> +               if (attr_tmp == NULL) {
> +                       pr_warn("Failed kmalloc for bin_attribute attr_tmp");
> +                       continue;
> +               }
> +
> +               attr_tmp->attr.name = kstrdup(prop->name, GFP_KERNEL);
> +               attr_tmp->attr.mode = 0400;
> +               attr_tmp->read = export_attr_read;
> +               attr_tmp->private = __va(vals[0]);
> +               attr_tmp->size = vals[1];
> +
> +               if (attr_tmp->attr.name == NULL) {
> +                       pr_warn("Failed kstrdup for bin_attribute attr.name");
> +                       kfree(attr_tmp);
> +                       continue;
> +               }
> +               rc = sysfs_create_bin_file(kobj, attr_tmp);
> +               if (rc)
> +                       pr_warn("Error %d creating OPAL sysfs exports/%s file\n",
> +                                     rc, prop->name);
> +       }
> +
> +cleanup:
> +       of_node_put(np);
> +}
> +
>  static void __init opal_dump_region_init(void)
>  {
>         void *addr;
> @@ -742,6 +820,9 @@ static int __init opal_init(void)
>                 opal_msglog_sysfs_init();
>         }
>
> +       /* Export all properties */
> +       opal_export_attrs();
> +
>         /* Initialize platform devices: IPMI backend, PRD & flash interface */
>         opal_pdev_init("ibm,opal-ipmi");
>         opal_pdev_init("ibm,opal-flash");
> --
> 2.9.3
>

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
