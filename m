Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1041A0D6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 08:58:43 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 16:58:40 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C47E6C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:49:48 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FLwaPf27984052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 21:58:36 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FLwaCa027886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:58:36 -0500
Message-ID: <54B8380B.3000405@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 16:58:35 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 3/3] CXL: Add reset to sysfs
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421290601-3293-3-git-send-email-grimm@linux.vnet.ibm.com>
 <1421299043-sup-4240@delenn.ozlabs.ibm.com>
In-Reply-To: <1421299043-sup-4240@delenn.ozlabs.ibm.com>
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

On 01/15/2015 12:42 AM, Ian Munsie wrote:
> Excerpts from Ryan Grimm's message of 2015-01-15 13:56:41 +1100:
>> This allows an image to be downloaded to the flash without rebooting the
>> machine.  The driver perform a PERST, which results in FPGA image downloaded to
>> flash and the CAPP unit enters recovery.  CAPP recovery triggers an HMI, which
>> is handled by EEH in Linux.  EEH removes the driver, calls into Sapphire to
>> reinitialize the PHB, and then loads the driver.
>>
>> reset_image_select must be set to "user" and reset_load_image set to 1.  The
>> driver writes "user" to the vsec if a user image was loaded.  It writes 1 to
>> reset_load_image on initialization by default.  Other values could be used by
>> hand for debugging purposes.
>
> That last paragraph will need to be updated if we merge those two sysfs
> files into one. Might as well mention an example of why someone might do
> a reset with no image selected for reload, e.g. the PSL trace arrays are
> preserved, which can be read out through debugfs after the card comes
> back up.
>

OK, fixed that up a bit.  Let me know if the commit logs and 
documentations make sense.  There's a bit of overlap and hopefully it's 
clear now.

>> +What:           /sys/class/cxl/<card>/reset
>> +Date:           October 2014
>> +Contact:        linuxppc-dev@lists.ozlabs.org
>> +Description:    write only
>> +                Writing 1 here will issue a PERST to card.
>
> "..., which may cause the card to reload the FPGA image depending on the
> settings of reset_image_select."
>
>

Sure, can be explicit about that.

>
>> +    if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
>
> Can you add a comment here to explain why we first do a warm reset?
>
>
>> +        dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
>> +        return rc;
>> +    }
>> +
>> +    /* Do mmio read to trigger EEH.  Retry for a few seconds. */
>
> This seems a little unusual - can you expand this comment a little to
> explain *why* we are using this method to trigger an EEH and reset the
> card?
>

Added better commenting to both above.

>> +    i = 0;
>> +        while ((val = mmio_read32be(adapter->p1_mmio) != 0xffffffff) &&
>> +        (i < 5)) {
>> +                msleep(500);
>> +        i++;
>> +        }
>> +
>> +        if (val != 0xffffffff)
>> +                dev_err(&dev->dev, "cxl: PERST failed to trigger EEH\n");
>> +
>> +    return rc;
>
> Some of the indentation here is a bit funky - some lines are using tabs,
> others are using spaces.
>

Ouch, yep, fixed.

>
>> @@ -806,8 +837,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
>>       CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
>>       CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
>>       adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
>> -    adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
>> -    adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
>> +    adapter->perst_loads_image = true;
>> +    adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> ...
>> +    if ((rc = cxl_update_image_control(adapter)))
>> +        goto err2;
>
> Thanks - that seems like a better default than what we had before,
> should make things more stable :)
>

Yeah for sure.

-Ryan

>
>
> Cheers,
> -Ian
>
