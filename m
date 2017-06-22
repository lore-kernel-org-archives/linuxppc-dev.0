Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtNWF2JBJzDr00
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 10:58:49 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id f127so315059pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 17:58:49 -0700 (PDT)
Message-ID: <1498093120.1181.5.camel@gmail.com>
Subject: Re: [PATCH V4 2/2] powerpc/powernv : Add support for OPAL-OCC
 command/response interface
From: Cyril Bur <cyrilbur@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org,  mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com
Date: Thu, 22 Jun 2017 10:58:40 +1000
In-Reply-To: <1498032387-26010-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1498032387-26010-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1498032387-26010-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-21 at 13:36 +0530, Shilpasri G Bhat wrote:
> In P9, OCC (On-Chip-Controller) supports shared memory based
> commad-response interface. Within the shared memory there is an OPAL
> command buffer and OCC response buffer that can be used to send
> inband commands to OCC. This patch adds a platform driver to support
> the command/response interface between OCC and the host.
> 

Sorry I probably should have pointed out earlier that I don't really
understand the first patch or exactly what problem you're trying to
solve. I've left it ignored, feel free to explain what the idea is
there or hopefully someone who can see what you're trying to do can
step in.

As for this patch, just one thing.


> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> - Hold occ->cmd_in_progress in read()
> - Reset occ->rsp_consumed if copy_to_user() fails
> 
>  arch/powerpc/include/asm/opal-api.h            |  41 +++-
>  arch/powerpc/include/asm/opal.h                |   3 +
>  arch/powerpc/platforms/powernv/Makefile        |   2 +-
>  arch/powerpc/platforms/powernv/opal-occ.c      | 313 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>  arch/powerpc/platforms/powernv/opal.c          |   8 +
>  6 files changed, 366 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c
> 

[snip]

> +
> +static ssize_t opal_occ_read(struct file *file, char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct miscdevice *dev = file->private_data;
> +	struct occ *occ = container_of(dev, struct occ, dev);
> +	int rc;
> +
> +	if (count < sizeof(*occ->rsp) + occ->rsp->size)
> +		return -EINVAL;
> +
> +	if (!atomic_cmpxchg(&occ->rsp_consumed, 1, 0))
> +		return -EBUSY;
> +
> +	if (atomic_cmpxchg(&occ->cmd_in_progress, 0, 1))
> +		return -EBUSY;
> +

Personally I would have done these two checks the other way around, it
doesn't really matter which one you do first but what does matter is
that you undo the change you did in the first cmpxchg if the second
cmpxchg causes you do return.

In this case if cmd_in_progress then you'll have marked the response as
consumed...

> +	rc = copy_to_user((void __user *)buf, occ->rsp,
> +			  sizeof(occ->rsp) + occ->rsp->size);
> +	if (rc) {
> +		atomic_set(&occ->rsp_consumed, 1);
> +		atomic_set(&occ->cmd_in_progress, 0);
> +		pr_err("Failed to copy OCC response data to user\n");
> +		return rc;
> +	}
> +
> +	atomic_set(&occ->cmd_in_progress, 0);
> +	return sizeof(*occ->rsp) + occ->rsp->size;
> +}
> +

[snip]
