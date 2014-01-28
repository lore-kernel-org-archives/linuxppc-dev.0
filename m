Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C33DA2C03E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 06:45:16 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jan 2014 01:15:13 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 79C701258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:16:55 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SJjCpD45416476
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:15:12 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SJjB10014435
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 01:15:11 +0530
Message-ID: <52E808C3.4080701@linux.vnet.ibm.com>
Date: Tue, 28 Jan 2014 13:45:07 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/3] powerpc/pseries: Report in kernel device tree
 update to drmgr
References: <1390420717-23907-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1390420717-23907-4-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1390420717-23907-4-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2014 01:58 PM, Tyrel Datwyler wrote:
> Traditionally it has been drmgr's responsibilty to update the device tree
> through the /proc/ppc64/ofdt interface after a suspend/resume operation.
> This patchset however has modified suspend/resume ops to preform that update
> entirely in the kernel during the resume. Therefore, a mechanism is required
> for drmgr to determine who is responsible for the update. This patch adds a
> show function to the "hibernate" attribute that returns 1 if the kernel
> updates the device tree after the resume and 0 if drmgr is responsible.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/suspend.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
> index 16a2552..723115d 100644
> --- a/arch/powerpc/platforms/pseries/suspend.c
> +++ b/arch/powerpc/platforms/pseries/suspend.c
> @@ -174,7 +174,30 @@ out:
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
