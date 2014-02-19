Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CAB492C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 09:07:45 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 15:07:43 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C125A19D8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:07:40 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JM7fQF7471442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 23:07:41 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JM7fqN021951
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 15:07:41 -0700
Message-ID: <53052B2C.5020504@linux.vnet.ibm.com>
Date: Wed, 19 Feb 2014 14:07:40 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH v3 3/3] powerpc/pseries: Report in kernel device tree
 update to drmgr
References: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1392843415-17153-5-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1392843415-17153-5-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/19/2014 12:56 PM, Tyrel Datwyler wrote:
> Traditionally it has been drmgr's responsibilty to update the device tree
> through the /proc/ppc64/ofdt interface after a suspend/resume operation.
> This patchset however has modified suspend/resume ops to preform that update
> entirely in the kernel during the resume. Therefore, a mechanism is required
> for drmgr to determine who is responsible for the update. This patch adds a
> show function to the "hibernate" attribute that returns 1 if the kernel
> updates the device tree after the resume and 0 if drmgr is responsible.

Ignore this one. Apparently, I forgot to clear it out of my patch
directory before I resent.

> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/suspend.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
> index 1d9c580..b87b978 100644
> --- a/arch/powerpc/platforms/pseries/suspend.c
> +++ b/arch/powerpc/platforms/pseries/suspend.c
> @@ -192,7 +192,30 @@ out:
>  	return rc;
>  }
> 
> -static DEVICE_ATTR(hibernate, S_IWUSR, NULL, store_hibernate);
> +#define USER_DT_UPDATE	0
> +#define KERN_DT_UPDATE	1
> +
> +/**
> + * show_hibernate - Report device tree update responsibilty
> + * @dev:		subsys root device
> + * @attr:		device attribute struct
> + * @buf:		buffer
> + *
> + * Report whether a device tree update is performed by the kernel after a
> + * resume, or if drmgr must coordinate the update from user space.
> + *
> + * Return value:
> + *	0 if drmgr is to initiate update, and 1 otherwise
> + **/
> +static ssize_t show_hibernate(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return sprintf(buf, "%d\n", KERN_DT_UPDATE);
> +}
> +
> +static DEVICE_ATTR(hibernate, S_IWUSR | S_IRUGO,
> +		   show_hibernate, store_hibernate);
> 
>  static struct bus_type suspend_subsys = {
>  	.name = "power",
> 
