Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD1bw2PJdzDvfL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 07:48:12 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA8KhveO124143
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2016 15:48:09 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26ke7a0vtw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 15:48:09 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 9 Nov 2016 06:48:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D714F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 07:48:02 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA8Km2st33030358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 07:48:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA8Km2sc016825
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 07:48:02 +1100
Subject: Re: [Linux-ima-devel] [PATCH v6 02/10] ima: on soft reboot, restore
 the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-ima-devel
 <linux-ima-devel@lists.sourceforge.net>, Andrew Morton
 <akpm@linux-foundation.org>
Date: Tue, 08 Nov 2016 15:47:58 -0500
In-Reply-To: <CACE9dm87W1H0wJeBUce9_XxKz_W096r=T1KhQdFBYYhHnGcqGg@mail.gmail.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1477017898-10375-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <CACE9dm87W1H0wJeBUce9_XxKz_W096r=T1KhQdFBYYhHnGcqGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478638078.2879.205.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 21:46 +0200, Dmitry Kasatkin wrote:
> On Fri, Oct 21, 2016 at 5:44 AM, Thiago Jung Bauermann
> <bauerman@linux.vnet.ibm.com> wrote:
> > From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >
> > The TPM PCRs are only reset on a hard reboot.  In order to validate a
> > TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
> > of the running kernel must be saved and restored on boot.  This patch
> > restores the measurement list.
> >
> > Changelog v5:
> > - replace CONFIG_KEXEC_FILE with architecture CONFIG_HAVE_IMA_KEXEC (Thiago)
> > - replace kexec_get_handover_buffer() with ima_get_kexec_buffer() (Thiago)
> > - replace kexec_free_handover_buffer() with ima_free_kexec_buffer() (Thiago)
> > - remove unnecessary includes from ima_kexec.c (Thiago)
> > - fix off-by-one error when checking hdr_v1->template_name_len (Colin King)
> >
> > Changelog v2:
> > - redefined ima_kexec_hdr to use types with well defined sizes (M. Ellerman)
> > - defined missing ima_load_kexec_buffer() stub function
> >
> > Changelog v1:
> > - call ima_load_kexec_buffer() (Thiago)
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  security/integrity/ima/Makefile       |   1 +
> >  security/integrity/ima/ima.h          |  21 +++++
> >  security/integrity/ima/ima_init.c     |   2 +
> >  security/integrity/ima/ima_kexec.c    |  44 +++++++++
> >  security/integrity/ima/ima_queue.c    |  10 ++
> >  security/integrity/ima/ima_template.c | 170 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 248 insertions(+)
> >
> > diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> > index 9aeaedad1e2b..29f198bde02b 100644
> > --- a/security/integrity/ima/Makefile
> > +++ b/security/integrity/ima/Makefile
> > @@ -8,4 +8,5 @@ obj-$(CONFIG_IMA) += ima.o
> >  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> >          ima_policy.o ima_template.o ima_template_lib.o
> >  ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> > +ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
> >  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index db25f54a04fe..51dc8d57d64d 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -28,6 +28,10 @@
> >
> >  #include "../integrity.h"
> >
> > +#ifdef CONFIG_HAVE_IMA_KEXEC
> > +#include <asm/ima.h>
> > +#endif
> > +
> >  enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
> >                      IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
> >  enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
> > @@ -102,6 +106,21 @@ struct ima_queue_entry {
> >  };
> >  extern struct list_head ima_measurements;      /* list of all measurements */
> >
> > +/* Some details preceding the binary serialized measurement list */
> > +struct ima_kexec_hdr {
> > +       u16 version;
> > +       u16 _reserved0;
> > +       u32 _reserved1;
> > +       u64 buffer_size;
> > +       u64 count;
> > +};
> > +
> > +#ifdef CONFIG_HAVE_IMA_KEXEC
> > +void ima_load_kexec_buffer(void);
> > +#else
> > +static inline void ima_load_kexec_buffer(void) {}
> > +#endif /* CONFIG_HAVE_IMA_KEXEC */
> > +
> >  /* Internal IMA function definitions */
> >  int ima_init(void);
> >  int ima_fs_init(void);
> > @@ -122,6 +141,8 @@ int ima_init_crypto(void);
> >  void ima_putc(struct seq_file *m, void *data, int datalen);
> >  void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
> >  struct ima_template_desc *ima_template_desc_current(void);
> > +int ima_restore_measurement_entry(struct ima_template_entry *entry);
> > +int ima_restore_measurement_list(loff_t bufsize, void *buf);
> >  int ima_init_template(void);
> >
> >  /*
> > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > index 32912bd54ead..3ba0ca49cba6 100644
> > --- a/security/integrity/ima/ima_init.c
> > +++ b/security/integrity/ima/ima_init.c
> > @@ -128,6 +128,8 @@ int __init ima_init(void)
> >         if (rc != 0)
> >                 return rc;
> >
> > +       ima_load_kexec_buffer();
> > +
> >         rc = ima_add_boot_aggregate();  /* boot aggregate must be first entry */
> >         if (rc != 0)
> >                 return rc;
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > new file mode 100644
> > index 000000000000..36afd0fe9747
> > --- /dev/null
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -0,0 +1,44 @@
> > +/*
> > + * Copyright (C) 2016 IBM Corporation
> > + *
> > + * Authors:
> > + * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > + * Mimi Zohar <zohar@linux.vnet.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +#include "ima.h"
> > +
> > +/*
> > + * Restore the measurement list from the previous kernel.
> > + */
> > +void ima_load_kexec_buffer(void)
> > +{
> > +       void *kexec_buffer = NULL;
> > +       size_t kexec_buffer_size = 0;
> > +       int rc;
> > +
> > +       rc = ima_get_kexec_buffer(&kexec_buffer, &kexec_buffer_size);
> > +       switch (rc) {
> > +       case 0:
> > +               rc = ima_restore_measurement_list(kexec_buffer_size,
> > +                                                 kexec_buffer);
> > +               if (rc != 0)
> > +                       pr_err("Failed to restore the measurement list: %d\n",
> > +                               rc);
> > +
> > +               ima_free_kexec_buffer();
> > +               break;
> > +       case -ENOTSUPP:
> > +               pr_debug("Restoring the measurement list not supported\n");
> > +               break;
> > +       case -ENOENT:
> > +               pr_debug("No measurement list to restore\n");
> > +               break;
> > +       default:
> > +               pr_debug("Error restoring the measurement list: %d\n", rc);
> > +       }
> > +}
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> > index 32f6ac0f96df..4b1bb7787839 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -149,3 +149,13 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> >                             op, audit_cause, result, audit_info);
> >         return result;
> >  }
> > +
> > +int ima_restore_measurement_entry(struct ima_template_entry *entry)
> > +{
> > +       int result = 0;
> > +
> > +       mutex_lock(&ima_extend_list_mutex);
> > +       result = ima_add_digest_entry(entry);
> > +       mutex_unlock(&ima_extend_list_mutex);
> > +       return result;
> > +}
> > diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> > index febd12ed9b55..37f972cb05fe 100644
> > --- a/security/integrity/ima/ima_template.c
> > +++ b/security/integrity/ima/ima_template.c
> > @@ -37,6 +37,7 @@ static struct ima_template_field supported_fields[] = {
> >         {.field_id = "sig", .field_init = ima_eventsig_init,
> >          .field_show = ima_show_template_sig},
> >  };
> > +#define MAX_TEMPLATE_NAME_LEN 15
> >
> >  static struct ima_template_desc *ima_template;
> >  static struct ima_template_desc *lookup_template_desc(const char *name);
> > @@ -205,3 +206,172 @@ int __init ima_init_template(void)
> >
> >         return result;
> >  }
> > +
> > +static int ima_restore_template_data(struct ima_template_desc *template_desc,
> > +                                    void *template_data,
> > +                                    int template_data_size,
> > +                                    struct ima_template_entry **entry)
> > +{
> > +       struct binary_field_data {
> > +               u32 len;
> > +               u8 data[0];
> > +       } __packed;
> > +
> > +       struct binary_field_data *field_data;
> > +       int offset = 0;
> > +       int ret = 0;
> > +       int i;
> > +
> > +       *entry = kzalloc(sizeof(**entry) +
> > +                   template_desc->num_fields * sizeof(struct ima_field_data),
> > +                   GFP_NOFS);
> > +       if (!*entry)
> > +               return -ENOMEM;
> > +
> > +       (*entry)->template_desc = template_desc;
> > +       for (i = 0; i < template_desc->num_fields; i++) {
> > +               field_data = template_data + offset;
> > +
> > +               /* Each field of the template data is prefixed with a length. */
> > +               if (offset > (template_data_size - sizeof(field_data->len))) {
> > +                       pr_err("Restoring the template field failed\n");
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +               offset += sizeof(field_data->len);
> > +
> > +               if (offset > (template_data_size - field_data->len)) {
> > +                       pr_err("Restoring the template field data failed\n");
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +               offset += field_data->len;
> > +
> > +               (*entry)->template_data[i].len = field_data->len;
> > +               (*entry)->template_data_len += sizeof(field_data->len);
> > +
> > +               (*entry)->template_data[i].data =
> > +                       kzalloc(field_data->len + 1, GFP_KERNEL);
> > +               if (!(*entry)->template_data[i].data) {
> > +                       ret = -ENOMEM;
> > +                       break;
> > +               }
> > +               memcpy((*entry)->template_data[i].data, field_data->data,
> > +                       field_data->len);
> > +               (*entry)->template_data_len += field_data->len;
> > +       }
> > +
> > +       if (ret < 0) {
> > +               ima_free_template_entry(*entry);
> > +               *entry = NULL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +/* Restore the serialized binary measurement list without extending PCRs. */
> > +int ima_restore_measurement_list(loff_t size, void *buf)
> > +{
> > +       struct binary_hdr_v1 {
> > +               u32 pcr;
> > +               u8 digest[TPM_DIGEST_SIZE];
> > +               u32 template_name_len;
> > +               char template_name[0];
> > +       } __packed;
> > +       char template_name[MAX_TEMPLATE_NAME_LEN];
> > +
> > +       struct binary_data_v1 {
> > +               u32 template_data_size;
> > +               char template_data[0];
> > +       } __packed;
> > +
> > +       struct ima_kexec_hdr *khdr = buf;
> > +       struct binary_hdr_v1 *hdr_v1;
> > +       struct binary_data_v1 *data_v1;
> > +
> > +       void *bufp = buf + sizeof(*khdr);
> > +       void *bufendp = buf + khdr->buffer_size;
> > +       struct ima_template_entry *entry;
> > +       struct ima_template_desc *template_desc;
> > +       unsigned long count = 0;
> > +       int ret = 0;
> > +
> > +       if (!buf || size < sizeof(*khdr))
> > +               return 0;
> > +
> > +       if (khdr->version != 1) {
> > +               pr_err("attempting to restore a incompatible measurement list");
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +        * ima kexec buffer prefix: version, buffer size, count
> > +        * v1 format: pcr, digest, template-name-len, template-name,
> > +        *            template-data-size, template-data
> > +        */
> > +       while ((bufp < bufendp) && (count++ < khdr->count)) {
> > +               if (count > ULONG_MAX - 1) {
> > +                       pr_err("attempting to restore too many measurements");
> > +                       ret = -EINVAL;
> > +               }
> > +
> > +               hdr_v1 = bufp;
> > +               if ((hdr_v1->template_name_len >= MAX_TEMPLATE_NAME_LEN) ||
> > +                   ((bufp + hdr_v1->template_name_len) > bufendp)) {
> 
> based on following code  template_name_len does not include header
> (sizeof(*hdr_v1))?
> If so the check is wrong???

Yes, good catch.  In addition, before assigning hdr_v1 there should be a
size check as well. 

> 
> > +                       pr_err("attempting to restore a template name \
> > +                               that is too long\n");
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +               bufp += sizeof(*hdr_v1);
> > +
> > +               /* template name is not null terminated */
> > +               memcpy(template_name, bufp, hdr_v1->template_name_len);
> > +               template_name[hdr_v1->template_name_len] = 0;
> > +
> > +               if (strcmp(template_name, "ima") == 0) {
> > +                       pr_err("attempting to restore an unsupported \
> > +                               template \"%s\" failed\n", template_name);
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +               data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
> > +
> > +               /* get template format */
> > +               template_desc = lookup_template_desc(template_name);
> > +               if (!template_desc) {
> > +                       pr_err("template \"%s\" not found\n", template_name);
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               if (bufp > (bufendp - sizeof(data_v1->template_data_size))) {
> > +                       pr_err("restoring the template data size failed\n");
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +               bufp += (u_int8_t) sizeof(data_v1->template_data_size);
> > +
> > +               if (bufp > (bufendp - data_v1->template_data_size)) {
> > +                       pr_err("restoring the template data failed\n");
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> > +
> 
> It looks like a similar problem... sizeof(struct binary_data_v1) is
> missing in the check...

Following the template name, is the template data length and the
template data. 

> > +               ret = ima_restore_template_data(template_desc,
> > +                                               data_v1->template_data,
> > +                                               data_v1->template_data_size,
> > +                                               &entry);
> > +               if (ret < 0)
> > +                       break;
> > +
> > +               memcpy(entry->digest, hdr_v1->digest, TPM_DIGEST_SIZE);
> > +               entry->pcr = hdr_v1->pcr;
> > +               ret = ima_restore_measurement_entry(entry);
> > +               if (ret < 0)
> > +                       break;
> > +
> > +               bufp += data_v1->template_data_size;
> > +       }
> > +       return ret;
> > +}
> > --
> > 2.7.4
> >
> 
> In overall it is a bit hard to read this function somehow..

Ok, I'll see if there is any way of simplifying/cleaning up walking the
measurement list some more.

Mimi
