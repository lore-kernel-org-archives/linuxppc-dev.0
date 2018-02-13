Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgszz631HzF1Ps
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 06:29:34 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1DJTTge029145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:29:32 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g43kyxb85-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:29:32 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 19:29:30 -0000
Subject: Re: [bug report] ocxl: Add AFU interrupt support
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180213081234.GA19567@mwanda>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 20:29:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180213081234.GA19567@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dc0b4b1c-b3f5-bc4e-1f96-96055fecd77d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Thanks for the report. I'll fix the first issue. The 2nd is already on 
its way to upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=dedab7f0d3137441a97fe7cf9b9ca5

(though we still have a useless cast in there; will fix as well).

May I ask what static checker you're using?

Thanks,

   Fred

Le 13/02/2018 à 09:12, Dan Carpenter a écrit :
> Hello Frederic Barrat,
> 
> The patch aeddad1760ae: "ocxl: Add AFU interrupt support" from Jan
> 23, 2018, leads to the following static checker warning:
> 
>      drivers/misc/ocxl/file.c:163 afu_ioctl()
>      warn: maybe return -EFAULT instead of the bytes remaining?
> 
> drivers/misc/ocxl/file.c
>     111  static long afu_ioctl(struct file *file, unsigned int cmd,
>     112                  unsigned long args)
>     113  {
>     114          struct ocxl_context *ctx = file->private_data;
>     115          struct ocxl_ioctl_irq_fd irq_fd;
>     116          u64 irq_offset;
>     117          long rc;
>     118
>     119          pr_debug("%s for context %d, command %s\n", __func__, ctx->pasid,
>     120                  CMD_STR(cmd));
>     121
>     122          if (ctx->status == CLOSED)
>     123                  return -EIO;
>     124
>     125          switch (cmd) {
>     126          case OCXL_IOCTL_ATTACH:
>     127                  rc = afu_ioctl_attach(ctx,
>     128                                  (struct ocxl_ioctl_attach __user *) args);
>     129                  break;
>     130
>     131          case OCXL_IOCTL_IRQ_ALLOC:
>     132                  rc = ocxl_afu_irq_alloc(ctx, &irq_offset);
>     133                  if (!rc) {
>     134                          rc = copy_to_user((u64 __user *) args, &irq_offset,
>     135                                          sizeof(irq_offset));
>     136                          if (rc)
>                                      ^^
> copy_to_user() returns the number of bytes remaining but we want to
> return -EFAULT on error.
> 
>     137                                  ocxl_afu_irq_free(ctx, irq_offset);
>     138                  }
>     139                  break;
>     140
> 
>      drivers/misc/ocxl/file.c:320 afu_read()
>      warn: unsigned 'used' is never less than zero.
> 
> drivers/misc/ocxl/file.c
>     279          ssize_t rc;
>     280          size_t used = 0;
>                  ^^^^^^
> This should be ssize_t
> 
>     281          DEFINE_WAIT(event_wait);
>     282
>     283          memset(&header, 0, sizeof(header));
>     284
>     285          /* Require offset to be 0 */
>     286          if (*off != 0)
>     287                  return -EINVAL;
>     288
>     289          if (count < (sizeof(struct ocxl_kernel_event_header) +
>     290                          AFU_EVENT_BODY_MAX_SIZE))
>     291                  return -EINVAL;
>     292
>     293          for (;;) {
>     294                  prepare_to_wait(&ctx->events_wq, &event_wait,
>     295                                  TASK_INTERRUPTIBLE);
>     296
>     297                  if (afu_events_pending(ctx))
>     298                          break;
>     299
>     300                  if (ctx->status == CLOSED)
>     301                          break;
>     302
>     303                  if (file->f_flags & O_NONBLOCK) {
>     304                          finish_wait(&ctx->events_wq, &event_wait);
>     305                          return -EAGAIN;
>     306                  }
>     307
>     308                  if (signal_pending(current)) {
>     309                          finish_wait(&ctx->events_wq, &event_wait);
>     310                          return -ERESTARTSYS;
>     311                  }
>     312
>     313                  schedule();
>     314          }
>     315
>     316          finish_wait(&ctx->events_wq, &event_wait);
>     317
>     318          if (has_xsl_error(ctx)) {
>     319                  used = append_xsl_error(ctx, &header, buf + sizeof(header));
>     320                  if (used < 0)
>                              ^^^^^^^^
> Impossible.
> 
>     321                          return used;
>     322          }
>     323
>     324          if (!afu_events_pending(ctx))
>     325                  header.flags |= OCXL_KERNEL_EVENT_FLAG_LAST;
>     326
>     327          if (copy_to_user(buf, &header, sizeof(header)))
>     328                  return -EFAULT;
>     329
>     330          used += sizeof(header);
>     331
>     332          rc = (ssize_t) used;
>                       ^^^^^^^^^^^^^^
> You could remove the cast.
> 
>     333          return rc;
>     334  }
> 
> regards,
> dan carpenter
> 
