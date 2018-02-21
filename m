Return-Path: <srs0=nusq=fp=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmv0T6mLqzF0xk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 10:32:25 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zmv0T5qW7z8wPF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 10:32:25 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zmv0T1JZFz9sWG
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 10:32:24 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LNTUGJ088265
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 18:32:23 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9ej7g8rq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 18:32:22 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 21 Feb 2018 23:32:21 -0000
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information
 to userspace
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
 Greg KH <gregkh@linuxfoundation.org>, Andrew
 Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 10:32:14 +1100
In-Reply-To: <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519255934.2867.3.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wed, 2018-02-21 at 17:43 +1100, Balbir Singh wrote:
> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.c
> om> wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Some required information is not exposed to userspace currently
> > (eg. the
> > PASID), pass this information back, along with other information
> > which
> > is currently communicated via sysfs, which saves some parsing
> > effort in
> > userspace.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
> >  include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> > 
> > diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> > index d9aa407db06a..11514a8444e5 100644
> > --- a/drivers/misc/ocxl/file.c
> > +++ b/drivers/misc/ocxl/file.c
> > @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct
> > ocxl_context *ctx,
> >         return rc;
> >  }
> > 
> > +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> > +               struct ocxl_ioctl_get_metadata __user *uarg)
> 
> Why do we call this metadata? Isn't this an afu_descriptor?
> 

It's metadata for the descriptor.

> > +{
> > +       struct ocxl_ioctl_get_metadata arg;
> > +
> > +       memset(&arg, 0, sizeof(arg));
> > +
> > +       arg.version = 0;
> 
> Does it make sense to have version 0? Even if does, you can afford
> to skip initialization due to the memset above. I prefer that
> versions
> start with 1
> 

Setting it to 0 is for the reader, not the compiler. I'm not clear on
the benefit of starting the version at 1, could you clarify?

> > +
> > +       arg.afu_version_major = ctx->afu->config.version_major;
> > +       arg.afu_version_minor = ctx->afu->config.version_minor;
> > +       arg.pasid = ctx->pasid;
> > +       arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
> > +       arg.global_mmio_size = ctx->afu->config.global_mmio_size;
> > +
> > +       if (copy_to_user(uarg, &arg, sizeof(arg)))
> > +               return -EFAULT;
> > +
> > +       return 0;
> > +}
> > +
> >  #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH"
> > :                        \
> >                         x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC"
> > :       \
> >                         x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE"
> > :         \
> >                         x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD"
> > :     \
> > +                       x == OCXL_IOCTL_GET_METADATA ?
> > "GET_METADATA" : \
> >                         "UNKNOWN")
> > 
> >  static long afu_ioctl(struct file *file, unsigned int cmd,
> > @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file,
> > unsigned int cmd,
> >                                         irq_fd.eventfd);
> >                 break;
> > 
> > +       case OCXL_IOCTL_GET_METADATA:
> > +               rc = afu_ioctl_get_metadata(ctx,
> > +                               (struct ocxl_ioctl_get_metadata
> > __user *) args);
> > +               break;
> > +
> >         default:
> >                 rc = -EINVAL;
> >         }
> > diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> > index 4b0b0b756f3e..16e1f48ce280 100644
> > --- a/include/uapi/misc/ocxl.h
> > +++ b/include/uapi/misc/ocxl.h
> > @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
> >         __u64 reserved3;
> >  };
> > 
> > +/*
> > + * Version contains the version of the struct.
> > + * Versions will always be backwards compatible, that is, new
> > versions will not
> > + * alter existing fields
> > + */
> > +struct ocxl_ioctl_get_metadata {
> 
> This sounds more like a function name, do we need it to be
> _get_metdata?
> 

It pretty much is a function, it returns to userspace metadata about
the descriptor being operated on.

> > +       __u16 version;
> > +
> > +       // Version 0 fields
> > +       __u8  afu_version_major;
> > +       __u8  afu_version_minor;
> > +       __u32 pasid;
> > +
> > +       __u64 pp_mmio_size;
> > +       __u64 global_mmio_size;
> > +
> 
> Should we document the fields? pp_ stands for per process, but is not
> very clear at first look. Why do we care to return only the size,
> what
> about lpc size?
> 

Yes, I would rather call it per_pasid_mmio_size, but consistency with
the rest of the driver (& exposed sysfs entries) is also important.

> > +       // End version 0 fields
> > +
> > +       __u64 reserved[13]; // Total of 16*u64
> > +};
> 
> 
> Balbir Singh.
> 

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
