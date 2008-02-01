Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 301E2DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 16:56:44 +1100 (EST)
Date: Thu, 31 Jan 2008 23:56:14 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
Message-ID: <20080201055613.GY14201@localdomain>
References: <1201805233-15112-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1201827769-7439-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080201050228.7A6E117C0053@mail145-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080201050228.7A6E117C0053@mail145-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
>
> +static ssize_t
> +hwicap_read(struct file *file, char *buf, size_t count, loff_t *ppos)
> +{
> +	struct hwicap_drvdata *drvdata = file->private_data;
> +	ssize_t bytes_to_read = 0;
> +	u32 *kbuf;
> +	u32 words;
> +	u32 bytes_remaining;
> +	int status;
> +
> +        spin_lock(&hwicap_spinlock);
> +	if (drvdata->is_accessing)
> +		return -EBUSY;

Need to unlock before returning (several places in this patch).
