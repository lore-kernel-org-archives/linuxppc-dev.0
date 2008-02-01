Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 0AF8DDDFB0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 07:11:56 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so322660anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 12:11:55 -0800 (PST)
Message-ID: <fa686aa40802011211n1b18d4ddg3fdb95f274221dd6@mail.gmail.com>
Date: Fri, 1 Feb 2008 13:11:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
In-Reply-To: <20080201200324.66A91FF004D@mail157-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1201890163-12219-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080201200324.66A91FF004D@mail157-sin.bigfish.com>
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
> This includes code for new fifo-based xps_hwicap in addition to the
> older opb_hwicap, which has a significantly different interface.  The
> common code between the two drivers is largely shared.
>
> Significant differences exists between this driver and what is
> supported in the EDK drivers.  In particular, most of the
> architecture-specific code for reconfiguring individual FPGA resources
> has been removed.  This functionality is likely better provided in a
> user-space support library.  In addition, read and write access is
> supported.  In addition, although the xps_hwicap cores support
> interrupt-driver mode, this driver only supports polled operation, in
> order to make the code simpler, and since the interrupt processing
> overhead is likely to slow down the throughput under Linux.
>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
> Fixed to add mutexes, and a few style issues.

Inconsistent indentation (tabs vs. spaces) in some places.  Otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> +static int __devexit hwicap_remove(struct device *dev)
> +{
> +       struct hwicap_drvdata *drvdata;
> +
> +       drvdata = (struct hwicap_drvdata *)dev_get_drvdata(dev);
> +
> +       if (!drvdata)
> +            return 0;
> +
> +        class_device_destroy(icap_class, drvdata->devt);
> +        cdev_del(&drvdata->cdev);
> +        iounmap(drvdata->base_address);
> +        release_mem_region(drvdata->mem_start, drvdata->mem_size);
> +        kfree(drvdata);
> +        dev_set_drvdata(dev, NULL);
> +        probed_devices[MINOR(dev->devt)-xhwicap_minor] = 0;
> +
> +       return 0;               /* success */
> +}

Here in particular


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
