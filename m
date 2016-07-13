Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqW0f6wNbzDqFd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 06:39:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DKdPJ1060305
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 16:39:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243entrskq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 16:39:44 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 06:39:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C79192CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 06:39:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DKdca918153636
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 06:39:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DKdcHE010638
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 06:39:38 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 07/15] powerpc/powernv: Add support for the cxl kernel api
 on the real phb
In-reply-to: <c4f8848f-4832-a21e-776d-40726b290b54@au1.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-8-git-send-email-imunsie@au.ibm.com>
 <c4f8848f-4832-a21e-776d-40726b290b54@au1.ibm.com>
Date: Thu, 14 Jul 2016 06:39:36 +1000
Message-Id: <1468441320-sup-8544@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2016-07-12 20:39:13 +1000:
> Some comments below - with those addressed:
> 
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Thanks for the review :)

> > V1->V2:
> >     - Add an explanation of the peer model to the commit message,
> >       and a comment above the pnv_cxl_enable_device_hook function.
> 
> The comments are good!

Thanks :)

> > +/*
> > + * Sets flags and switches the controller ops to enable the cxl kernel api.
> > + * Original the cxl kernel API operated on a virtual PHB, but certain cards
> 
> Originally

Will fix.

> > +EXPORT_SYMBOL(pnv_cxl_enable_phb_kernel_api);
...
> > +EXPORT_SYMBOL(pnv_pci_on_cxl_phb);
> 
> Should these two exports be _GPL as well?

Yep, they should be - will fix in V3.

Looks like we have several more in this file that should be _GPL as
well, but since they weren't introduced in this series (just moved from
another file) I might send a separate patch for those after this has
been merged.

> > -static void pnv_pci_release_device(struct pci_dev *pdev)
> > +void pnv_pci_release_device(struct pci_dev *pdev)
> 
> Why is this being unstatic-ified? I don't see us introducing any new 
> uses of it.

Left over from an earlier cut - will undo this for V3.

> > -static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
> > +const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
> 
> It looks like we don't currently use this - is this being unstatic-ised 
> in view of allowing a switch back to regular mode in future?

Oops, again left over from an earlier cut (for that reason). Will undo
this for V3 - if we allow switching back in the future we can remove the
static then.

> > +extern void pnv_pci_release_device(struct pci_dev *pdev);

Will also remove this declaration of pnv_pci_release_device.

> > +extern const struct pci_controller_ops pnv_pci_ioda_controller_ops;
> 
> See applicable comments about static.

Will remove.

Cheers,
-Ian
