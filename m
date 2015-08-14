Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7422B1A1D47
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:13:18 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D80914027F
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:13:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 14 Aug 2015 16:13:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C6ED93578058
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:13:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6D1Od45482234
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:13:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6CfRP009551
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:12:42 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mpe <mpe@ellerman.id.au>,
 benh <benh@kernel.crashing.org>, cyrilbur <cyrilbur@gmail.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey <mikey@neuling.org>
Subject: Re: [PATCH v4 06/11] cxl: Refactor adaptor init/teardown
In-reply-to: <1439439089-25151-7-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
 <1439439089-25151-7-git-send-email-dja@axtens.net>
Date: Fri, 14 Aug 2015 16:12:13 +1000
Message-Id: <1439531040-sup-2913@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Daniel Axtens's message of 2015-08-13 14:11:24 +1000:
> +/* This should contain *only* operations that can safely be done in
> + * both creation and recovery.
> + */
> +static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>  {
> -    struct cxl *adapter;
> -    bool free = true;
>      int rc;
>  
> +    adapter->dev.parent = &dev->dev;
> +    adapter->dev.release = cxl_release_adapter;
> +    pci_set_drvdata(dev, adapter);

These seem a bit odd here (though perfectly harmless) - not sure these
need to be done again on recovery (but maybe I'm wrong?) - seems more
like something that should be done early in cxl_init_adapter?

> -    if ((rc = cxl_update_image_control(adapter)))
> -        goto err2;
> +    rc = cxl_update_image_control(adapter);
> +    if (rc)

These types of coding style changes should really be in a separate patch
to make it easier to see exactly how you have changed the init path in
this one. I know mpe wanted these changed and after looking at the diff
pretty carefully I realise that you haven't actually changed much
functionally so I'll let this pass, but if you happen to do another
respin please move the style changes into a separate patch.

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
