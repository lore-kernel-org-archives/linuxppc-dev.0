Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422E51A0E15
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 06:44:29 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Fri, 16 Jan 2015 14:44:27 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A75B56E8045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 14:36:16 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0GJiNB327459780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 19:44:23 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0GJiNt7016600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 14:44:23 -0500
Message-ID: <54B96A15.1000800@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 14:44:21 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 3/3] CXL: Add ability to reset the card
References: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421360837-40287-3-git-send-email-grimm@linux.vnet.ibm.com>
 <1421381813-sup-3338@delenn.ozlabs.ibm.com>
In-Reply-To: <1421381813-sup-3338@delenn.ozlabs.ibm.com>
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

On 01/15/2015 11:27 PM, Ian Munsie wrote:
> Hi Ryan,
>
> Excerpts from Ryan Grimm's message of 2015-01-16 09:27:17 +1100:
>> Adds reset to sysfs which will PERST the card.  If load_image_on_perst is set
>> to "user" or "factory", the PERST will cause that image to be loaded.
>>
>> load_image_on_perst is set to "user" for production.
>
> While it generally will be "user" for production, some cards may only
> ship with only a factory image, which is then going to be the image used
> for production.  It might be better to say that it will default to
> whichever image the card has already loaded.

K, yeah.

>
>
>>                   Value of "none" means PERST will not cause image to be loaded
>> -                to the card.  A power cycle is required to load the image.
>> +                to the card.  A power cycle is required to load the image.
>> +                "none" is useful for debugging so the contents of the trace
>> +                arrays are preserved.
>>                   Value of "user" and "factory" means PERST will cause either the
>> -                user or factory image to be loaded.
>> +                user or factory image to be loaded.  "user" is default and
>> +                should be used in production.
>
> git am spotted some whitespace at the end of a couple of lines here
>

Fixed...darn whitespace.

>
>
>> +    /* pcie_warm_reset requests a fundamental pci reset which includes a
>> +     * PERST assert/deassert.  PERST triggers a loading of the image
>> +     * if "user" or "factory" is selected in sysfs */
>> +    if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
>> +        dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
>> +        return rc;
>> +    }
>> +
>> +    /* the PERST done above fences the PHB.  So, reset depends on EEH
>> +     * to unbind the driver, tell Sapphire to reinit the PHB, and rebind
>> +     * the driver.  Do an mmio read explictly to ensure EEH notices the
>> +     * fenced PHB.  Retry for a few seconds before giving up. */
>
> Great, thanks for adding the explanations here :)
>
>
>> @@ -806,8 +843,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
>>       CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
>>       CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
>>       adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
>> -    adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
>> -    adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
>> +    adapter->perst_loads_image = true;
>> +    adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> <snip>
>> +    if ((rc = cxl_update_image_control(adapter)))
>> +        goto err2;
>
> Please move these two hunks into a separate patch (can be first in the
> series) along with the cxl_update_image_control() function from patch 1
> - I'd like to get this backported to stable, which will be simpler if it
> is in it's own patch.
>
>

K, I completely agree.

>> +static ssize_t reset_adapter_store(struct device *device,
>> +                   struct device_attribute *attr,
>> +                   const char *buf, size_t count)
>> +{
>> +    struct cxl *adapter = to_cxl_adapter(device);
>> +    int rc;
>> +
>> +    if ((rc = cxl_reset(adapter)))
>> +        return rc;
>> +    return count;
>> +}
>
> Please add a check here so the reset only occurs when a "1" is written
> to this file to match the documentation.
>

Yeah, it's probably good to do that :)

-Ryan

>
> Cheers,
> -Ian
>
