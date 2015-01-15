Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D4F31A0D7A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:41:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 14:41:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 441BD2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:41:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F4fQt051118098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:41:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F4fPvV018572
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:41:25 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
In-reply-to: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 15:41:24 +1100
Message-Id: <1421295393-sup-926@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ryan Grimm's message of 2015-01-15 13:56:39 +1100:
> Add reset_loads_image and reset_image_select to sysfs.
> 
> reset_image_select identifies which image will be loaded to the card on the
> next PERST.  Valid entries are: "user" and "factory".
> 
> reset_loads_image defines functionality on a PERST.  Value of 0 means PERST
> will not cause image load.  A power cycle is required to load the image.  Value
> of 1 means PERST will cause image load.
> 
> sysfs updates the cxl struct in the driver then calls cxl_update_image_control
> to write the vals in the VSEC.

Let's combine both of these into a single sysfs file, with "none",
"user" and "factory" options and have the show & read functions handle
mapping those three options to the two bits in the register.

Of the two names I'd probably go with reset_image_select.

> +What:           /sys/class/cxl/<card>/reset_loads_image
> +Date:           December 2014
> +Contact:        linuxppc-dev@lists.ozlabs.org
> +Description:    read/write
> +                Value of 0 means PERST will not cause image load.  A power
> +                cycle is required to load the image.  Value of 1 means PERST
> +                will cause image load.

It also seems to be that having this disabled also means that PERST
doesn't fully reset the card. Might want to clarify that somewhat and
recommend it only be disabled for debugging purposes (e.g. to retain
the contents of the PSL trace arrays across a reset), and to always
enable it for production.

At the moment we don't set it at boot - we just go with whatever the
card is already set to do. I'm thinking it might be a good idea to
always set this bit on boot so the only time it's disabled is if a user
has explicitly gone and disabled it.

> +static ssize_t reset_loads_image_show(struct device *device,
> +                 struct device_attribute *attr,
> +                 char *buf)
> +{
> +    struct cxl *adapter = to_cxl_adapter(device);
> +    return sprintf(buf, "%d\n", adapter->perst_loads_image);

We've used scnprintf for the other sysfs reads in this file, why sprintf
here?

> +static ssize_t reset_loads_image_store(struct device *device,
> +                 struct device_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +    struct cxl *adapter = to_cxl_adapter(device);
> +    unsigned long val;
> +    int rc;
> +
> +        if (kstrtoul(buf, 0, &val) < 0)
> +                return -EINVAL;
> +
> +        adapter->perst_loads_image = !!val;
> +    if ((rc = cxl_update_image_control(adapter)))
> +        return rc;

Seems to be some indentation mismatches here - some lines are using
spaces other are using tabs. Please use tabs for everything.

> +static ssize_t reset_image_select_store(struct device *device,
> +                 struct device_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +    struct cxl *adapter = to_cxl_adapter(device);
> +    int rc;
> +
> +    if (!strncmp(buf, "user", 4))
> +        adapter->perst_select_user = true;
> +    else if (!strncmp(buf, "factory", 7))
> +        adapter->perst_select_user = false;
> +    else
> +                return -EINVAL;

More indentation mismatches here.


Cheers,
-Ian
