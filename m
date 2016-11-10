Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tF3PT1FYyzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 00:12:44 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAAD8Wh5029029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 08:12:42 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mp0891d4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 08:12:42 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 23:12:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AA5EC2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 00:12:37 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAADCb6d33292490
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 00:12:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAADCaOZ026116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 00:12:37 +1100
Subject: Re: [Linux-ima-devel] [PATCH v6 02/10] ima: on soft reboot, restore
 the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: kexec@lists.infradead.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linux-ima-devel
 <linux-ima-devel@lists.sourceforge.net>, linux-security-module
 <linux-security-module@vger.kernel.org>, "Eric W.	Biederman"
 <ebiederm@xmission.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 10 Nov 2016 08:12:32 -0500
In-Reply-To: <1478638078.2879.205.camel@linux.vnet.ibm.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1477017898-10375-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <CACE9dm87W1H0wJeBUce9_XxKz_W096r=T1KhQdFBYYhHnGcqGg@mail.gmail.com>
 <1478638078.2879.205.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1478783552.31015.34.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 15:47 -0500, Mimi Zohar wrote:
> On Tue, 2016-11-08 at 21:46 +0200, Dmitry Kasatkin wrote:
> > On Fri, Oct 21, 2016 at 5:44 AM, Thiago Jung Bauermann

> > > +/* Restore the serialized binary measurement list without extending PCRs. */
> > > +int ima_restore_measurement_list(loff_t size, void *buf)
> > > +{
> > > +       struct binary_hdr_v1 {
> > > +               u32 pcr;
> > > +               u8 digest[TPM_DIGEST_SIZE];
> > > +               u32 template_name_len;
> > > +               char template_name[0];
> > > +       } __packed;
> > > +       char template_name[MAX_TEMPLATE_NAME_LEN];
> > > +
> > > +       struct binary_data_v1 {
> > > +               u32 template_data_size;
> > > +               char template_data[0];
> > > +       } __packed;
> > > +
> > > +       struct ima_kexec_hdr *khdr = buf;
> > > +       struct binary_hdr_v1 *hdr_v1;
> > > +       struct binary_data_v1 *data_v1;
> > > +
> > > +       void *bufp = buf + sizeof(*khdr);
> > > +       void *bufendp = buf + khdr->buffer_size;
> > > +       struct ima_template_entry *entry;
> > > +       struct ima_template_desc *template_desc;
> > > +       unsigned long count = 0;
> > > +       int ret = 0;
> > > +
> > > +       if (!buf || size < sizeof(*khdr))
> > > +               return 0;
> > > +
> > > +       if (khdr->version != 1) {
> > > +               pr_err("attempting to restore a incompatible measurement list");
> > > +               return 0;
> > > +       }
> > > +
> > > +       /*
> > > +        * ima kexec buffer prefix: version, buffer size, count
> > > +        * v1 format: pcr, digest, template-name-len, template-name,
> > > +        *            template-data-size, template-data
> > > +        */
> > > +       while ((bufp < bufendp) && (count++ < khdr->count)) {
> > > +               if (count > ULONG_MAX - 1) {
> > > +                       pr_err("attempting to restore too many measurements");
> > > +                       ret = -EINVAL;
> > > +               }
> > > +
> > > +               hdr_v1 = bufp;
> > > +               if ((hdr_v1->template_name_len >= MAX_TEMPLATE_NAME_LEN) ||
> > > +                   ((bufp + hdr_v1->template_name_len) > bufendp)) {
> > 
> > based on following code  template_name_len does not include header
> > (sizeof(*hdr_v1))?
> > If so the check is wrong???
> 
> Yes, good catch.  In addition, before assigning hdr_v1 there should be a
> size check as well. 
> 
> > 
> > > +                       pr_err("attempting to restore a template name \
> > > +                               that is too long\n");
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > > +               bufp += sizeof(*hdr_v1);

This line should have been before the test above.

> > > +
> > > +               /* template name is not null terminated */
> > > +               memcpy(template_name, bufp, hdr_v1->template_name_len);
> > > +               template_name[hdr_v1->template_name_len] = 0;
> > > +
> > > +               if (strcmp(template_name, "ima") == 0) {
> > > +                       pr_err("attempting to restore an unsupported \
> > > +                               template \"%s\" failed\n", template_name);
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > > +               data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
> > > +
> > > +               /* get template format */
> > > +               template_desc = lookup_template_desc(template_name);
> > > +               if (!template_desc) {
> > > +                       pr_err("template \"%s\" not found\n", template_name);
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               if (bufp > (bufendp - sizeof(data_v1->template_data_size))) {
> > > +                       pr_err("restoring the template data size failed\n");
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > > +               bufp += (u_int8_t) sizeof(data_v1->template_data_size);
> > > +
> > > +               if (bufp > (bufendp - data_v1->template_data_size)) {
> > > +                       pr_err("restoring the template data failed\n");
> > > +                       ret = -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > 
> > It looks like a similar problem... sizeof(struct binary_data_v1) is
> > missing in the check...
> 
> Following the template name, is the template data length and the
> template data. 
> 
> > > +               ret = ima_restore_template_data(template_desc,
> > > +                                               data_v1->template_data,
> > > +                                               data_v1->template_data_size,
> > > +                                               &entry);
> > > +               if (ret < 0)
> > > +                       break;
> > > +
> > > +               memcpy(entry->digest, hdr_v1->digest, TPM_DIGEST_SIZE);
> > > +               entry->pcr = hdr_v1->pcr;
> > > +               ret = ima_restore_measurement_entry(entry);
> > > +               if (ret < 0)
> > > +                       break;
> > > +
> > > +               bufp += data_v1->template_data_size;
> > > +       }
> > > +       return ret;
> > > +}
> > > --
> > > 2.7.4
> > >
> > 
> > In overall it is a bit hard to read this function somehow..
> 
> Ok, I'll see if there is any way of simplifying/cleaning up walking the
> measurement list some more.

I moved some code around so that the bufp pointer update is immediately
after the  buffer overflow tests and moved one check outside the while
loop.  I tried defining a buffer overflow macro, but that didn't seem to
help.

The updated patches are available in the next-kexec-restore branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Mimi
