Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTKv00hcRzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:47:40 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id x35so2940149qtc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:47:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170223022954.14676-1-matthew.brown.dev@gmail.com>
References: <20170223022954.14676-1-matthew.brown.dev@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 23 Feb 2017 14:47:37 +1100
Message-ID: <CAOSf1CFyCh=35y9CY1Bh2Qx-dOLJMEju_rQWmYTVkqUPB=vs8A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stewart Smith <stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2017 at 1:29 PM, Matt Brown <matthew.brown.dev@gmail.com> wrote:
> From: Matt Brown <brownmatt1997@gmail.com>
>
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
>  arch/powerpc/include/asm/opal.h              |  1 +
>  arch/powerpc/platforms/powernv/opal-msglog.c | 49 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c        |  2 ++
>  3 files changed, 52 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 5c7db0f..b26944e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -277,6 +277,7 @@ extern int opal_async_comp_init(void);
>  extern int opal_sensor_init(void);
>  extern int opal_hmi_handler_init(void);
>  extern int opal_event_init(void);
> +extern void opal_hdat_sysfs_init(void);
>
>  extern int opal_machine_check(struct pt_regs *regs);
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
> index 39d6ff9..a637055 100644
> --- a/arch/powerpc/platforms/powernv/opal-msglog.c
> +++ b/arch/powerpc/platforms/powernv/opal-msglog.c
> @@ -31,7 +31,13 @@ struct memcons {
>         __be32 in_cons;
>  };
>
> +struct hdatInfo {
> +       char *base;
> +       u64 size;
> +};
> +
>  static struct memcons *opal_memcons = NULL;

> +static struct hdatInfo hdat_inf;
I have a few 'o's to spare if you need one.

>
>  ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
>  {
> @@ -136,3 +142,46 @@ void __init opal_msglog_sysfs_init(void)
>         if (sysfs_create_bin_file(opal_kobj, &opal_msglog_attr) != 0)
>                 pr_warn("OPAL: sysfs file creation failed\n");
>  }

> +
> +
> +
> +/* Read function for HDAT attribute in sysfs */
Bonus whitespace!

> +static ssize_t hdat_read(struct file *file, struct kobject *kobj,
> +                        struct bin_attribute *bin_attr, char *to,
> +                        loff_t pos, size_t count)
> +{
> +       if (!hdat_inf.base)
> +               return -ENODEV;
> +
> +       return memory_read_from_buffer(to, count, &pos, hdat_inf.base,
> +                                       hdat_inf.size);
> +}

Hmm... There's been some ideas floating around about removing Skiboot
from the linear mapping and that would break this. However, that is
something we should probably shouldn't worry about until it happens.

> +
> +
> +/* HDAT attribute for sysfs */
> +static struct bin_attribute hdat_attr = {
> +       .attr = {.name = "hdat", .mode = 0444},
> +       .read = hdat_read
> +};
> +
> +void __init opal_hdat_sysfs_init(void)
> +{
> +       u64 hdatAddr[2];
> +
> +       /* Check for the hdat-map prop in device-tree */
> +       if (of_property_read_u64_array(opal_node, "hdat-map", hdatAddr, 2)) {
> +               pr_debug("OPAL: Property hdat-map not found.\n");
> +               return;
> +       }
> +
> +       /* Print out hdat-map values. [0]: base, [1]: size */
> +       pr_debug("HDAT Base address: %#llx\n", hdatAddr[0]);
> +       pr_debug("HDAT Size: %#llx\n", hdatAddr[1]);
> +
> +       hdat_inf.base = phys_to_virt(hdatAddr[0]);
> +       hdat_inf.size = hdatAddr[1];
> +
> +       if (sysfs_create_bin_file(opal_kobj, &hdat_attr) != 0)
> +               pr_debug("OPAL: sysfs file creation for HDAT failed");
> +
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..cae3745 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -740,6 +740,8 @@ static int __init opal_init(void)
>                 opal_sys_param_init();
>                 /* Setup message log sysfs interface. */
>                 opal_msglog_sysfs_init();
> +               /* Create hdat object under sys/firmware/opal */
> +               opal_hdat_sysfs_init();
>         }
>
>         /* Initialize platform devices: IPMI backend, PRD & flash interface */
> --
> 2.9.3
>

Quibbling aside, look ok.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
