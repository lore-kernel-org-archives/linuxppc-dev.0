Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00EE81A0D5C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:18:20 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 16:18:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 600922BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:18:17 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F6IG1t18481344
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:18:17 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F6IGpj026709
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:18:16 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] CXL: Add reset to sysfs
In-reply-to: <1421299043-sup-4240@delenn.ozlabs.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421290601-3293-3-git-send-email-grimm@linux.vnet.ibm.com>
 <1421299043-sup-4240@delenn.ozlabs.ibm.com>
Date: Thu, 15 Jan 2015 17:18:16 +1100
Message-Id: <1421302467-sup-4087@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > @@ -806,8 +837,8 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
> >      CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
> >      CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
> >      adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> > -    adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
> > -    adapter->perst_select_user = !!(image_state & CXL_VSEC_PERST_SELECT_USER);
> > +    adapter->perst_loads_image = true;
> > +    adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> ...
> > +    if ((rc = cxl_update_image_control(adapter)))
> > +        goto err2;
> 
> Thanks - that seems like a better default than what we had before,
> should make things more stable :)

In fact, would you mind pulling this part out into a separate patch? It
seems like a serious contender to go to stable as it might help with
cards that get into a funny state and don't come back up properly after
a reboot (symptoms are that the adapter wide tlbia / slbia times out and
the driver aborts initialisation).

Cheers,
-Ian
