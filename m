Return-Path: <dja@axtens.net>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CD921A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:24:31 +1000 (AEST)
Received: by pacbt3 with SMTP id bt3so9036715pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 20:24:29 -0700 (PDT)
Message-ID: <1442978466.2081.1.camel@axtens.net>
Subject: Re: [PATCH] cxl: Fix lockdep warning while creating afu_err_buff
 attribute
From: Daniel Axtens <dja@axtens.net>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 mikey@neuling.org
Date: Wed, 23 Sep 2015 13:21:06 +1000
In-Reply-To: <1442977679-4468-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1442977679-4468-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Daniel Axtens <dja@axtens.net>

Thanks Vaibhav!

On Wed, 2015-09-23 at 08:37 +0530, Vaibhav Jain wrote:
> Presently a lockdep warning is reported during creation of afu_err_buff
> bin_attribute for the afu. This is caused due to the variable attr.key
> not pointing to a static class key, hence the function lockdep_init_map
> reports this warning:
> 
>  BUG: key <some-address> not in .data!
> 
> The patch fixes this issue by calling sysfs_attr_init on the
> attr_eb.attr structure before populating it with the afu_err_buff file
> details. This will populate the attr.key variable with a static class
> key so that lockdep_init_map stops complaining about the lockdep key not
> being static.
> 
> Reported-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index 25868c2..02006f7 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -592,6 +592,8 @@ int cxl_sysfs_afu_add(struct cxl_afu *afu)
>  
>  	/* conditionally create the add the binary file for error info buffer */
>  	if (afu->eb_len) {
> +		sysfs_attr_init(&afu->attr_eb.attr);
> +
>  		afu->attr_eb.attr.name = "afu_err_buff";
>  		afu->attr_eb.attr.mode = S_IRUGO;
>  		afu->attr_eb.size = afu->eb_len;

-- 
Regards,
Daniel
