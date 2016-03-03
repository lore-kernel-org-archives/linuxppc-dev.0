Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 789491A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:10:51 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 3 Mar 2016 14:10:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6C5BD3578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:10:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u234Aesu54394970
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 15:10:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u234AFSN024685
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 15:10:16 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>, mpe <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 11/18] cxl: Separate bare-metal fields in adapter and
 AFU data structures
In-reply-to: <1456244519-18934-12-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-12-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Thu, 03 Mar 2016 15:09:20 +1100
Message-Id: <1456977899-sup-5701@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-02-24 03:21:52 +1100:
>  static int pci_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
>  {
>      struct cxl_afu *afu;
> -    int rc;
> +    int rc = -ENOMEM;
>  
>      afu = cxl_alloc_afu(adapter, slice);
>      if (!afu)
>          return -ENOMEM;
>  
> +    afu->native = kzalloc(sizeof(struct cxl_afu_native), GFP_KERNEL);
> +    if (!afu->native)
> +        goto err_free_afu;
> +
> +    mutex_init(&afu->native->spa_mutex);
> +
>      rc = dev_set_name(&afu->dev, "afu%i.%i", adapter->adapter_num, slice);
>      if (rc)
> -        goto err_free;
> +        goto err_free_native;
>  
>      rc = pci_configure_afu(afu, adapter, dev);
>      if (rc)
> -        goto err_free;
> +        goto err_free_native;
>  
>      /* Don't care if this fails */
>      cxl_debugfs_afu_add(afu);
> @@ -859,7 +866,9 @@ err_put1:
>      device_unregister(&afu->dev);
>      return rc;
>  
> -err_free:
> +err_free_native:
> +    kfree(afu->native);
> +err_free_afu:
>      kfree(afu);
>      return rc;

Great - thanks for changing that to use consistent error paths :)

> @@ -1162,6 +1172,12 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
>      if (!adapter)
>          return ERR_PTR(-ENOMEM);
>  
> +    adapter->native = kzalloc(sizeof(struct cxl_native), GFP_KERNEL);
> +    if (!adapter->native) {
> +        rc = -ENOMEM;
> +        goto err_release;
> +    }
> +
>      /* Set defaults for parameters which need to persist over
>       * configure/reconfigure
>       */
> @@ -1171,8 +1187,7 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
>      rc = cxl_configure_adapter(adapter, dev);
>      if (rc) {
>          pci_disable_device(dev);
> -        cxl_release_adapter(&adapter->dev);
> -        return ERR_PTR(rc);
> +        goto err_release;
>      }
>  
>      /* Don't care if this one fails: */
> @@ -1198,6 +1213,10 @@ err_put1:
>      cxl_deconfigure_adapter(adapter);
>      device_unregister(&adapter->dev);
>      return ERR_PTR(rc);
> +
> +err_release:
> +    cxl_release_adapter(&adapter->dev);
> +    return ERR_PTR(rc);
>  }

Likewise, looks much better now :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Cheers,
-Ian
