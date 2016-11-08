Return-Path: <dmitry.kasatkin@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD5QH31yHzDvhf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 10:40:07 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id p100so12086315lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 15:40:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1477017898-10375-8-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1477017898-10375-8-git-send-email-bauerman@linux.vnet.ibm.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 9 Nov 2016 01:40:02 +0200
Message-ID: <CACE9dm-gJ72B5fp2KrY6rV=-Ydnu66mU1xQmng7ZvT1WiTa67Q@mail.gmail.com>
Subject: Re: [Linux-ima-devel] [PATCH v6 07/10] ima: store the builtin/custom
 template definitions in a list
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel <linux-ima-devel@lists.sourceforge.net>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 21, 2016 at 5:44 AM, Thiago Jung Bauermann
<bauerman@linux.vnet.ibm.com> wrote:
> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>
> The builtin and single custom templates are currently stored in an
> array.  In preparation for being able to restore a measurement list
> containing multiple builtin/custom templates, this patch stores the
> builtin and custom templates as a linked list.  This will permit
> defining more than one custom template per boot.
>
> Changelog v4:
> - fix "spinlock bad magic" BUG - reported by Dmitry Vyukov
>
> Changelog v3:
> - initialize template format list in ima_template_desc_current(), as it
> might be called during __setup before normal initialization. (kernel
> test robot)
> - remove __init annotation of ima_init_template_list()
>
> Changelog v2:
> - fix lookup_template_desc() preemption imbalance (kernel test robot)
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima.h          |  2 ++
>  security/integrity/ima/ima_main.c     |  1 +
>  security/integrity/ima/ima_template.c | 52 +++++++++++++++++++++++++++--------
>  3 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 139dec67dcbf..6b0540ad189f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -85,6 +85,7 @@ struct ima_template_field {
>
>  /* IMA template descriptor definition */
>  struct ima_template_desc {
> +       struct list_head list;
>         char *name;
>         char *fmt;
>         int num_fields;
> @@ -146,6 +147,7 @@ int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
> +void ima_init_template_list(void);
>
>  /*
>   * used to protect h_table and sha_table
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 423d111b3b94..50818c60538b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -418,6 +418,7 @@ static int __init init_ima(void)
>  {
>         int error;
>
> +       ima_init_template_list();
>         hash_setup(CONFIG_IMA_DEFAULT_HASH);
>         error = ima_init();
>         if (!error) {
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 37f972cb05fe..c0d808c20c40 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -15,16 +15,20 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/rculist.h>
>  #include "ima.h"
>  #include "ima_template_lib.h"
>
> -static struct ima_template_desc defined_templates[] = {
> +static struct ima_template_desc builtin_templates[] = {
>         {.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
>         {.name = "ima-ng", .fmt = "d-ng|n-ng"},
>         {.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
>         {.name = "", .fmt = ""},        /* placeholder for a custom format */
>  };
>
> +static LIST_HEAD(defined_templates);
> +static DEFINE_SPINLOCK(template_list);
> +
>  static struct ima_template_field supported_fields[] = {
>         {.field_id = "d", .field_init = ima_eventdigest_init,
>          .field_show = ima_show_template_digest},
> @@ -53,6 +57,8 @@ static int __init ima_template_setup(char *str)
>         if (ima_template)
>                 return 1;
>
> +       ima_init_template_list();
> +
>         /*
>          * Verify that a template with the supplied name exists.
>          * If not, use CONFIG_IMA_DEFAULT_TEMPLATE.
> @@ -81,7 +87,7 @@ __setup("ima_template=", ima_template_setup);
>
>  static int __init ima_template_fmt_setup(char *str)
>  {
> -       int num_templates = ARRAY_SIZE(defined_templates);
> +       int num_templates = ARRAY_SIZE(builtin_templates);
>
>         if (ima_template)
>                 return 1;
> @@ -92,22 +98,28 @@ static int __init ima_template_fmt_setup(char *str)
>                 return 1;
>         }
>
> -       defined_templates[num_templates - 1].fmt = str;
> -       ima_template = defined_templates + num_templates - 1;
> +       builtin_templates[num_templates - 1].fmt = str;
> +       ima_template = builtin_templates + num_templates - 1;
> +
>         return 1;
>  }
>  __setup("ima_template_fmt=", ima_template_fmt_setup);
>
>  static struct ima_template_desc *lookup_template_desc(const char *name)
>  {
> -       int i;
> +       struct ima_template_desc *template_desc;
> +       int found = 0;
>
> -       for (i = 0; i < ARRAY_SIZE(defined_templates); i++) {
> -               if (strcmp(defined_templates[i].name, name) == 0)
> -                       return defined_templates + i;
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(template_desc, &defined_templates, list) {
> +               if ((strcmp(template_desc->name, name) == 0) ||
> +                   (strcmp(template_desc->fmt, name) == 0)) {
> +                       found = 1;
> +                       break;
> +               }
>         }
> -
> -       return NULL;
> +       rcu_read_unlock();
> +       return found ? template_desc : NULL;
>  }
>
>  static struct ima_template_field *lookup_template_field(const char *field_id)
> @@ -183,11 +195,29 @@ static int template_desc_init_fields(const char *template_fmt,
>         return 0;
>  }
>
> +void ima_init_template_list(void)
> +{
> +       int i;
> +
> +       if (!list_empty(&defined_templates))
> +               return;
> +
> +       spin_lock(&template_list);
> +       for (i = 0; i < ARRAY_SIZE(builtin_templates); i++) {
> +               list_add_tail_rcu(&builtin_templates[i].list,
> +                                 &defined_templates);
> +       }
> +       spin_unlock(&template_list);
> +       synchronize_rcu();

Btw, what is the purpose of synchronize rcu here?
i think it make sense before deleting the object, like:
--------------------------------
list_del_rcu(&p->list);
spin_unlock(&listmutex);
synchronize_rcu();
kfree(p);
--------------------------------

I think it is never deleted.
There is another similar place in the same file...


> +}
> +
>  struct ima_template_desc *ima_template_desc_current(void)
>  {
> -       if (!ima_template)
> +       if (!ima_template) {
> +               ima_init_template_list();
>                 ima_template =
>                     lookup_template_desc(CONFIG_IMA_DEFAULT_TEMPLATE);
> +       }
>         return ima_template;
>  }
>
> --
> 2.7.4
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-ima-devel mailing list
> Linux-ima-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-ima-devel



-- 
Thanks,
Dmitry
