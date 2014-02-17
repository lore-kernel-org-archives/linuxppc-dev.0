Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E0F992C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 11:22:51 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 17 Feb 2014 10:22:45 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2B5552BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 11:22:42 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1H02wG512124620
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 11:02:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1H0Mfhj027226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 11:22:41 +1100
Message-ID: <1392596560.24061.12.camel@pasglop>
Subject: Re: [PATCH v3 3/3] powerpc/pseries: Report in kernel device tree
 update to drmgr
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 17 Feb 2014 11:22:40 +1100
In-Reply-To: <1391212692-16217-4-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1391212692-16217-4-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-31 at 15:58 -0800, Tyrel Datwyler wrote:
> Traditionally it has been drmgr's responsibilty to update the device tree
> through the /proc/ppc64/ofdt interface after a suspend/resume operation.
> This patchset however has modified suspend/resume ops to preform that update
> entirely in the kernel during the resume. Therefore, a mechanism is required
> for drmgr to determine who is responsible for the update. This patch adds a
> show function to the "hibernate" attribute that returns 1 if the kernel
> updates the device tree after the resume and 0 if drmgr is responsible.

This is not right.

We cannot change the kernel behaviour in a way that is incompatible with
existing userspace, and unless you can explain me why that is not the
case, it feels like this patch set does just that ....

What happens if you have an older drmgr which still does the update
itself ?

You can't just change user visible behaviours and interface without at
least explaining why it's ok to do so at the very least (and ensuring
that of course) without breaking existing userspace.

Now it's possible that the double update caused by this series is
harmless, in which case please explain it in the changeset, I certainly
can't assume it and if it's not, you'll need some other way for drmgr to
signal the kernel to indicate it supports the new behaviour before you
enable it.

Ben.

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
