Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnyV51vHlzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:12:12 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M58aIt073947
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:12:08 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vj6qbr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 01:12:08 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 22 Mar 2017 15:12:05 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2M5Bsd749086640
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:12:02 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2M5BSRi010564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 16:11:28 +1100
Subject: Re: [v6] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170321235323.6314-1-matthew.brown.dev@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 22 Mar 2017 16:11:06 +1100
MIME-Version: 1.0
In-Reply-To: <20170321235323.6314-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4354b063-39aa-87ea-b690-522d8dec352d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/03/17 10:53, Matt Brown wrote:
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> Changelog
>
> v6
> 	- attribute names are stored locally, removing potential null pointer errors
> 	- added of_node_put for the corresponding of_find_node
> 	- folded exports node creation into opal_export_attr()
> 	- fixed kzalloc flags to GFP_KERNEL
> 	- fixed struct array indexing
> 	- fixed error message
> ---
>  arch/powerpc/platforms/powernv/opal.c | 84 +++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..953537e 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -604,6 +604,87 @@ static void opal_export_symmap(void)
>  		pr_warn("Error %d creating OPAL symbols file\n", rc);
>  }
>
> +static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
> +			     struct bin_attribute *bin_attr, char *buf,
> +			     loff_t off, size_t count)
> +{
> +	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
> +				       bin_attr->size);
> +}
> +
> +static struct bin_attribute *exported_attrs;
> +static char **attr_name;

Can these be moved inside opal_export_attrs()?


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
