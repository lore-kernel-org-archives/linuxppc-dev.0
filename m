Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32A031A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:05:37 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 10 Feb 2016 19:05:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D377C3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:05:33 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A95Mxm37683368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:05:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A951mp028653
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:05:01 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 11/18] cxl: Separate bare-metal fields in adapter and
 AFU data structures
In-reply-to: <1454765345-7417-12-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-12-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 20:04:32 +1100
Message-Id: <1455093092-sup-8574@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -825,6 +826,14 @@ static int pci_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
>      if (!afu)
>          return -ENOMEM;
>  
> +    afu->native = kzalloc(sizeof(struct cxl_afu_native), GFP_KERNEL);
> +    if (!afu->native) {
> +        kfree(afu);
> +        return -ENOMEM;
> +    }

This function is already using goto style error paths, so it would be
better to use it since you have some common cleanup to do:

int rc = -ENOMEM;

...

    if (!afu->native)
        goto err_free_afu;

...

err_free_afu_native:
    kfree(afu->native);
err_free_afu:
    kfree(afu);
    return rc;

> @@ -1162,6 +1173,13 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
>      if (!adapter)
>          return ERR_PTR(-ENOMEM);
>  
> +    adapter->native = kzalloc(sizeof(struct cxl_native), GFP_KERNEL);
> +    if (!adapter->native) {
> +        pci_disable_device(dev);
> +        cxl_release_adapter(&adapter->dev);
> +        return ERR_PTR(-ENOMEM);

Likewise, since there is now some cleanup in this error path that is
part in common with another error path in the function change both error
paths to use goto style error handling.
