Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1407C1A0DD5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 08:46:31 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 16:46:29 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 40D3D6E8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:38:20 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FLkRcW25690140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 21:46:27 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FLkQg7006217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:46:27 -0500
Message-ID: <54B83531.5090807@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 16:46:25 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 2/3] CXL: Snoop control
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421290601-3293-2-git-send-email-grimm@linux.vnet.ibm.com>
 <1421297757-sup-8434@delenn.ozlabs.ibm.com>
In-Reply-To: <1421297757-sup-8434@delenn.ozlabs.ibm.com>
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

On 01/15/2015 12:16 AM, Ian Munsie wrote:
> Excerpts from Ryan Grimm's message of 2015-01-15 13:56:40 +1100:
>> Add mode to opal call.  SNOOP control turns CAPP unit snooping on/off.  This is
>> needed for the following reset patch, which turns snoops off in the CAPP
>> recovery path.
>
> Looking at patch 3 in this series I think this description needs to be
> updated, as it doesn't seem to turn off snoops?
>

OK, will make commit message more clear.

Maybe I'll rename the first line to CXL: Enable CAPP recovery, since 
that's what it does.

>
>> +/* CAPI modes for PHB */
>> +enum {
>> +        OPAL_PHB_CAPI_MODE_PCIE         = 0,
>> +        OPAL_PHB_CAPI_MODE_CAPI         = 1,
>> +        OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
>> +        OPAL_PHB_CAPI_MODE_SNOOP_ON     = 3,
>> +};
>
> Spaces have been used for indention here
>

Fixed.

>
>> +/* CAPI feature flags (in device-tree) */
>> +#define OPAL_PHB_CAPI_FLAG_SNOOP_CONTROL        0x00000001
>> +#define OPAL_PHB_CAPI_FLAG_REVERT_TO_PCIE       0x00000002
>
> It doesn't look like these are used?

Yeah.

>
>
>> -int pnv_phb_to_cxl(struct pci_dev *dev)
>> +int pnv_phb_to_cxl(struct pci_dev *dev, uint64_t mode)
>
> Should we rename this function since it no longer just sets the PHB to
> CXL mode? Maybe something like pnv_phb_set_cxl_mode?
>

Good call.  The names are updated in the skiboot code base...missed this 
one.

>
>> +    if ((rc = pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON))) {
>> +        dev_err(&dev->dev, "enable capp snoops: %i\n", rc);
>> +    }
>
> Ok, we turn on snooping here, but I don't see where we turned it off -
> has patch 3 changed so that never happens?
>

snoops are disabled by Sapphire in the CAPP recovery path.

> Also - why this late in in the init sequence? Not saying it's wrong, just
> wondering if this has to happen after all the AFUs have been initialised, or if
> it can happen earlier in the adapter initialisation, like when we set
> the PHB to capi mode?
>

It has no effect when the driver is bound initially since Sapphire 
already turns on snoops as part of the phb to cxl procedure.

I did it this way to handle CAPP recovery.  The driver doesn't know that 
capp recovery happened...EEH unbinds the driver, Sapphire does the CAPP 
recovery procedure, then EEH rebinds the driver.

The last step in capp recovery is to turn on snoops.  I'll put a comment 
to explain that better...but, sure it could be earlier in the sequence.

-Ryan

>
> Cheers,
> -Ian
>
