Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C794A1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 09:30:33 +1100 (AEDT)
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F8FA140BC4
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2016 09:30:32 +1100 (AEDT)
Received: by mail-oi0-x243.google.com with SMTP id i14so24872oig.2
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 14:30:32 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1455176180-19670-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1455176180-19670-1-git-send-email-andrew.donnellan@au1.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Feb 2016 09:00:10 +1030
Message-ID: <CACPK8XcDL2ogtbAf7yXXs0RpAjHAr4p7SpQo56VDFgeVhnCO4Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] powerpc/powernv: new function to access OPAL msglog
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 11, 2016 at 6:06 PM, Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> Currently, the OPAL msglog/console buffer is exposed as a sysfs file, with
> the sysfs read handler responsible for retrieving the log from the OPAL
> buffer. We'd like to be able to use it in xmon as well.
>
> Refactor the OPAL msglog code to create a new function, opal_msglog_copy(),
> that copies to an arbitrary buffer. Separate the initialisation code into
> generic memcons init and sysfs file creation.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> ---
>
> Changes V2->V3:
> - incorporate comments from Joel Stanley
> - opal_msglog_sysfs_init() now bails out if opal_memcons isn't set
>
> Changes V1->V2:
> - Incorporate comments from mpe
> - Move the memcons pointer out of the bin_attribute struct
> - Decouple memcons init from sysfs init
> ---
>  arch/powerpc/include/asm/opal.h              |  3 +++
>  arch/powerpc/platforms/powernv/opal-msglog.c | 34 ++++++++++++++++++++--------
>  arch/powerpc/platforms/powernv/opal.c        |  7 ++++--
>  3 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 07a99e6..9d86c66 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -248,6 +248,7 @@ extern int opal_elog_init(void);
>  extern void opal_platform_dump_init(void);
>  extern void opal_sys_param_init(void);
>  extern void opal_msglog_init(void);
> +extern void opal_msglog_sysfs_init(void);
>  extern int opal_async_comp_init(void);
>  extern int opal_sensor_init(void);
>  extern int opal_hmi_handler_init(void);
> @@ -273,6 +274,8 @@ void opal_free_sg_list(struct opal_sg_list *sg);
>
>  extern int opal_error_code(int rc);
>
> +ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count);
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_POWERPC_OPAL_H */
> diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
> index 44ed78a..c7a8f72 100644
> --- a/arch/powerpc/platforms/powernv/opal-msglog.c
> +++ b/arch/powerpc/platforms/powernv/opal-msglog.c
> @@ -31,26 +31,25 @@ struct memcons {
>         __be32 in_cons;
>  };
>
> -static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
> -                               struct bin_attribute *bin_attr, char *to,
> -                               loff_t pos, size_t count)
> +static struct memcons *opal_memcons = NULL;
> +
> +ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
>  {
> -       struct memcons *mc = bin_attr->private;
>         const char *conbuf;
>         ssize_t ret;
>         size_t first_read = 0;
>         uint32_t out_pos, avail;
>
> -       if (!mc)
> +       if (!opal_memcons)
>                 return -ENODEV;
>
> -       out_pos = be32_to_cpu(ACCESS_ONCE(mc->out_pos));
> +       out_pos = be32_to_cpu(ACCESS_ONCE(opal_memcons->out_pos));
>
>         /* Now we've read out_pos, put a barrier in before reading the new
>          * data it points to in conbuf. */
>         smp_rmb();
>
> -       conbuf = phys_to_virt(be64_to_cpu(mc->obuf_phys));
> +       conbuf = phys_to_virt(be64_to_cpu(opal_memcons->obuf_phys));
>
>         /* When the buffer has wrapped, read from the out_pos marker to the end
>          * of the buffer, and then read the remaining data as in the un-wrapped
> @@ -58,7 +57,7 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
>         if (out_pos & MEMCONS_OUT_POS_WRAP) {
>
>                 out_pos &= MEMCONS_OUT_POS_MASK;
> -               avail = be32_to_cpu(mc->obuf_size) - out_pos;
> +               avail = be32_to_cpu(opal_memcons->obuf_size) - out_pos;
>
>                 ret = memory_read_from_buffer(to, count, &pos,
>                                 conbuf + out_pos, avail);
> @@ -76,7 +75,7 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
>         }
>
>         /* Sanity check. The firmware should not do this to us. */
> -       if (out_pos > be32_to_cpu(mc->obuf_size)) {
> +       if (out_pos > be32_to_cpu(opal_memcons->obuf_size)) {
>                 pr_err("OPAL: memory console corruption. Aborting read.\n");
>                 return -EINVAL;
>         }
> @@ -91,6 +90,13 @@ out:
>         return ret;
>  }
>
> +static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
> +                               struct bin_attribute *bin_attr, char *to,
> +                               loff_t pos, size_t count)
> +{
> +       return opal_msglog_copy(to, pos, count);
> +}
> +
>  static struct bin_attribute opal_msglog_attr = {
>         .attr = {.name = "msglog", .mode = 0444},
>         .read = opal_msglog_read
> @@ -117,8 +123,16 @@ void __init opal_msglog_init(void)
>                 return;
>         }
>
> -       opal_msglog_attr.private = mc;
> +       opal_memcons = mc;
> +}
>
> +void __init opal_msglog_sysfs_init(void)
> +{
> +       if (!opal_memcons) {
> +               pr_warn("OPAL: message log initialisation failed, not creating sysfs entry\n");
> +               return;
> +       }
> +
>         if (sysfs_create_bin_file(opal_kobj, &opal_msglog_attr) != 0)
>                 pr_warn("OPAL: sysfs file creation failed\n");
>  }
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 4e0da5a..0256d07 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -724,6 +724,9 @@ static int __init opal_init(void)
>                 of_node_put(leds);
>         }
>
> +       /* Initialise OPAL message log interface */
> +       opal_msglog_init();
> +
>         /* Create "opal" kobject under /sys/firmware */
>         rc = opal_sysfs_init();
>         if (rc == 0) {
> @@ -739,8 +742,8 @@ static int __init opal_init(void)
>                 opal_platform_dump_init();
>                 /* Setup system parameters interface */
>                 opal_sys_param_init();
> -               /* Setup message log interface. */
> -               opal_msglog_init();
> +               /* Setup message log sysfs interface. */
> +               opal_msglog_sysfs_init();
>         }
>
>         /* Initialize platform devices: IPMI backend, PRD & flash interface */
> --
> Andrew Donnellan              Software Engineer, OzLabs
> andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
> +61 2 6201 8874 (work)        IBM Australia Limited
>
