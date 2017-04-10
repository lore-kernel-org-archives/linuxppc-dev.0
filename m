Return-Path: <joel.stan@gmail.com>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1f1907KWzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 15:31:09 +1000 (AEST)
Received: by mail-yb0-x243.google.com with SMTP id k6so4727918ybk.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Apr 2017 22:31:08 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <CAOSf1CGKs-mc_2LSMh3Ru5GgsEPDXFpVE1A_Yo0OFELNNUW+oQ@mail.gmail.com>
References: <20170329232801.20544-1-matthew.brown.dev@gmail.com>
 <CAOSf1CGKs-mc_2LSMh3Ru5GgsEPDXFpVE1A_Yo0OFELNNUW+oQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 10 Apr 2017 15:00:45 +0930
Message-ID: <CACPK8XdoV478DnVGWtsgtBOU4Y_ncRmG+qT7DeRYZ_-k7i-cNw@mail.gmail.com>
Subject: Re: [v8] powerpc/powernv: add 'firmware/exports' attributes to sysfs
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 6, 2017 at 4:37 PM, Oliver O'Halloran <oohall@gmail.com> wrote:
> On Thu, Mar 30, 2017 at 10:28 AM, Matt Brown
> <matthew.brown.dev@gmail.com> wrote:
>> The HDAT data area is consumed by skiboot and turned into a device-tree. In
>> some cases we would like to look directly at the HDAT. This is not possible
>> through /dev/mem as it is reserved memory which is stopped by the /dev/mem
>> filter. There are also other memory areas which are reserved but could be
>> useful to view for debugging purposes.
>>
>> This patch adds sysfs nodes to allow specified memory areas to be viewed.
>> sysfs nodes are created for each property in the device-tree under
>> /ibm,opal/firmware/exports/, and adds them to /sys/firmware/opal/exports/
>> with root read-only permissions.
>>
>> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Thanks. I took the version that mpe put in the powerpc tree. It is
part of the 4.10.9-openpower1 kernel.

  https://github.com/open-power/op-build/pull/1016

Cheers,

Joel

>> ---
>> Changelog
>> v8
>>         - fixed error handling
>>         - added dynamic allocation of attributes
>>         - using of_property_read_u64_array for reading attr vals
>>         - reordered vars
>>         - renaming vars
>> ---
>>  arch/powerpc/platforms/powernv/opal.c | 81 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 2822935..232f94e 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -604,6 +604,84 @@ static void opal_export_symmap(void)
>>                 pr_warn("Error %d creating OPAL symbols file\n", rc);
>>  }
>>
>> +static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
>> +                            struct bin_attribute *bin_attr, char *buf,
>> +                            loff_t off, size_t count)
>> +{
>> +       return memory_read_from_buffer(buf, count, &off, bin_attr->private,
>> +                                      bin_attr->size);
>> +}
>> +
>> +/*
>> + * opal_export_attrs: creates a sysfs node for each property listed in
>> + * the device-tree under /ibm,opal/firmware/exports/
>> + * All new sysfs nodes are created under /opal/exports/.
>> + * This allows for reserved memory regions (e.g. HDAT) to be read.
>> + * The new sysfs nodes are only readable by root.
>> + */
>> +static void opal_export_attrs(void)
>> +{
>> +       struct bin_attribute *attr_tmp;
>> +       struct device_node *np;
>> +       struct property *prop;
>> +       struct kobject *kobj;
>> +       u64 vals[2];
>> +       int rc, n;
>> +
>> +       /* Create new 'exports' directory - /sys/firmware/opal/exports */
>> +       kobj = kobject_create_and_add("exports", opal_kobj);
>> +       if (!kobj) {
>> +               pr_warn("kobject_create_and_add exports failed\n");
>> +               return;
>> +       }
>> +
>> +       np = of_find_node_by_path("/ibm,opal/firmware/exports");
>> +       if (!np)
>> +               return;
>> +
>> +       n = 0;
>> +       for (prop = np->properties; prop != NULL; prop = prop->next)
>> +               n++;
>> +
>> +       if (n < 2)
>> +               goto cleanup;
>> +
>> +       for_each_property_of_node(np, prop) {
>> +               if (!strcmp(prop->name, "name") ||
>> +                               !strcmp(prop->name, "phandle"))
>> +                       continue;
>> +
>> +               if (of_property_read_u64_array(np, prop->name, &vals[0], 2))
>> +                       continue;
>> +
>> +               attr_tmp = kmalloc(sizeof(*attr_tmp), GFP_KERNEL);
>> +
>> +               if (attr_tmp == NULL) {
>> +                       pr_warn("Failed kmalloc for bin_attribute attr_tmp");
>> +                       continue;
>> +               }
>> +
>> +               attr_tmp->attr.name = kstrdup(prop->name, GFP_KERNEL);
>> +               attr_tmp->attr.mode = 0400;
>> +               attr_tmp->read = export_attr_read;
>> +               attr_tmp->private = __va(vals[0]);
>> +               attr_tmp->size = vals[1];
>> +
>> +               if (attr_tmp->attr.name == NULL) {
>> +                       pr_warn("Failed kstrdup for bin_attribute attr.name");
>> +                       kfree(attr_tmp);
>> +                       continue;
>> +               }
>> +               rc = sysfs_create_bin_file(kobj, attr_tmp);
>> +               if (rc)
>> +                       pr_warn("Error %d creating OPAL sysfs exports/%s file\n",
>> +                                     rc, prop->name);
>> +       }
>> +
>> +cleanup:
>> +       of_node_put(np);
>> +}
>> +
>>  static void __init opal_dump_region_init(void)
>>  {
>>         void *addr;
>> @@ -742,6 +820,9 @@ static int __init opal_init(void)
>>                 opal_msglog_sysfs_init();
>>         }
>>
>> +       /* Export all properties */
>> +       opal_export_attrs();
>> +
>>         /* Initialize platform devices: IPMI backend, PRD & flash interface */
>>         opal_pdev_init("ibm,opal-ipmi");
>>         opal_pdev_init("ibm,opal-flash");
>> --
>> 2.9.3
>>
>
> Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
