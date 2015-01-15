Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB0861A0D68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 08:45:59 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 16:45:56 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 93AB138C8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:45:54 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FLjsOd27328670
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 21:45:54 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FLjs8A005220
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:45:54 -0500
Message-ID: <54B83510.1090009@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 16:45:52 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421295393-sup-926@delenn.ozlabs.ibm.com>
In-Reply-To: <1421295393-sup-926@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian,

Thanks for reviewing!

On 01/14/2015 11:41 PM, Ian Munsie wrote:
> Excerpts from Ryan Grimm's message of 2015-01-15 13:56:39 +1100:
>> Add reset_loads_image and reset_image_select to sysfs.
>>
>> reset_image_select identifies which image will be loaded to the card on the
>> next PERST.  Valid entries are: "user" and "factory".
>>
>> reset_loads_image defines functionality on a PERST.  Value of 0 means PERST
>> will not cause image load.  A power cycle is required to load the image.  Value
>> of 1 means PERST will cause image load.
>>
>> sysfs updates the cxl struct in the driver then calls cxl_update_image_control
>> to write the vals in the VSEC.
>
> Let's combine both of these into a single sysfs file, with "none",
> "user" and "factory" options and have the show & read functions handle
> mapping those three options to the two bits in the register.
>

I like that idea!

> Of the two names I'd probably go with reset_image_select.
>
>> +What:           /sys/class/cxl/<card>/reset_loads_image
>> +Date:           December 2014
>> +Contact:        linuxppc-dev@lists.ozlabs.org
>> +Description:    read/write
>> +                Value of 0 means PERST will not cause image load.  A power
>> +                cycle is required to load the image.  Value of 1 means PERST
>> +                will cause image load.
>
> It also seems to be that having this disabled also means that PERST
> doesn't fully reset the card. Might want to clarify that somewhat and
> recommend it only be disabled for debugging purposes (e.g. to retain
> the contents of the PSL trace arrays across a reset), and to always
> enable it for production.
>

Yeah, that is the main reason you'd disable it.  Will add that info to 
the doc.

> At the moment we don't set it at boot - we just go with whatever the
> card is already set to do. I'm thinking it might be a good idea to
> always set this bit on boot so the only time it's disabled is if a user
> has explicitly gone and disabled it.
>
>> +static ssize_t reset_loads_image_show(struct device *device,
>> +                 struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    struct cxl *adapter = to_cxl_adapter(device);
>> +    return sprintf(buf, "%d\n", adapter->perst_loads_image);
>
> We've used scnprintf for the other sysfs reads in this file, why sprintf
> here?
>

No reason, scnprintf is safer so fixed.

>> +static ssize_t reset_loads_image_store(struct device *device,
>> +                 struct device_attribute *attr,
>> +                 const char *buf, size_t count)
>> +{
>> +    struct cxl *adapter = to_cxl_adapter(device);
>> +    unsigned long val;
>> +    int rc;
>> +
>> +        if (kstrtoul(buf, 0, &val) < 0)
>> +                return -EINVAL;
>> +
>> +        adapter->perst_loads_image = !!val;
>> +    if ((rc = cxl_update_image_control(adapter)))
>> +        return rc;
>
> Seems to be some indentation mismatches here - some lines are using
> spaces other are using tabs. Please use tabs for everything.
>

Fixed.

>> +static ssize_t reset_image_select_store(struct device *device,
>> +                 struct device_attribute *attr,
>> +                 const char *buf, size_t count)
>> +{
>> +    struct cxl *adapter = to_cxl_adapter(device);
>> +    int rc;
>> +
>> +    if (!strncmp(buf, "user", 4))
>> +        adapter->perst_select_user = true;
>> +    else if (!strncmp(buf, "factory", 7))
>> +        adapter->perst_select_user = false;
>> +    else
>> +                return -EINVAL;
>
> More indentation mismatches here.
>
>

Fixed.

-Ryan

> Cheers,
> -Ian
>
