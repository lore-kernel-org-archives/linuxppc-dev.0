Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.230])
	by ozlabs.org (Postfix) with ESMTP id 0DD82DE017
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 05:42:25 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so1010418qbe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 10:42:24 -0800 (PST)
Message-ID: <fa686aa40802011042r749b61aqfe30284eff11b99f@mail.gmail.com>
Date: Fri, 1 Feb 2008 11:42:23 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
In-Reply-To: <20080201182253.903B5F18046@mail130-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1201827769-7439-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080201182253.903B5F18046@mail130-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, ntl@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/1/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> new file mode 100644
> index 0000000..83f2d0b
> --- /dev/null
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> +static int hwicap_open(struct inode *inode, struct file *file)
> +{
> +       struct hwicap_drvdata *drvdata;
> +       int status;
> +
> +       drvdata = container_of(inode->i_cdev, struct hwicap_drvdata, cdev);
> +
> +       if (down_interruptible(&drvdata->sem))
> +               return -ERESTARTSYS;
> +
> +       drvdata->is_open = 1;

It doesn't look like this flag is used anywhere anymore.

> +
> +       status = hwicap_initialize_hwicap(drvdata);
> +       if (status) {
> +               dev_err(drvdata->dev, "Failed to open file");
> +               return status;

returning without up()

> +       }
> +
> +       file->private_data = drvdata;
> +       drvdata->write_buffer_in_use = 0;
> +       drvdata->read_buffer_in_use = 0;
> +
> +       up(&drvdata->sem);
> +
> +       return 0;
> +}
> +

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
