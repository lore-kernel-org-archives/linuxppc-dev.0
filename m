Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8708C1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:16:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 15:16:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5B2362BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:16:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F5Grav13172756
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:16:53 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F5Gqfw008968
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:16:53 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] CXL: Snoop control
In-reply-to: <1421290601-3293-2-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421290601-3293-2-git-send-email-grimm@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 16:16:52 +1100
Message-Id: <1421297757-sup-8434@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ryan Grimm's message of 2015-01-15 13:56:40 +1100:
> Add mode to opal call.  SNOOP control turns CAPP unit snooping on/off.  This is
> needed for the following reset patch, which turns snoops off in the CAPP
> recovery path.

Looking at patch 3 in this series I think this description needs to be
updated, as it doesn't seem to turn off snoops?


> +/* CAPI modes for PHB */
> +enum {
> +        OPAL_PHB_CAPI_MODE_PCIE         = 0,
> +        OPAL_PHB_CAPI_MODE_CAPI         = 1,
> +        OPAL_PHB_CAPI_MODE_SNOOP_OFF    = 2,
> +        OPAL_PHB_CAPI_MODE_SNOOP_ON     = 3,
> +};

Spaces have been used for indention here


> +/* CAPI feature flags (in device-tree) */
> +#define OPAL_PHB_CAPI_FLAG_SNOOP_CONTROL        0x00000001
> +#define OPAL_PHB_CAPI_FLAG_REVERT_TO_PCIE       0x00000002

It doesn't look like these are used?


> -int pnv_phb_to_cxl(struct pci_dev *dev)
> +int pnv_phb_to_cxl(struct pci_dev *dev, uint64_t mode)

Should we rename this function since it no longer just sets the PHB to
CXL mode? Maybe something like pnv_phb_set_cxl_mode?


> +    if ((rc = pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON))) {
> +        dev_err(&dev->dev, "enable capp snoops: %i\n", rc);
> +    }

Ok, we turn on snooping here, but I don't see where we turned it off -
has patch 3 changed so that never happens?

Also - why this late in in the init sequence? Not saying it's wrong, just
wondering if this has to happen after all the AFUs have been initialised, or if
it can happen earlier in the adapter initialisation, like when we set
the PHB to capi mode?


Cheers,
-Ian
