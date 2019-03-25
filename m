Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83924C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:13:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04732083D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04732083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Sd7d5xfdzDqHx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 02:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Sd5f08sRzDqDZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 02:11:49 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2PFAr0e085156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 11:11:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rf07gmw8h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 11:11:47 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Mar 2019 15:11:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Mar 2019 15:11:42 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2PFBe1K59310242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2019 15:11:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60F8DA4054;
 Mon, 25 Mar 2019 15:11:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 010C2A405B;
 Mon, 25 Mar 2019 15:11:40 +0000 (GMT)
Received: from [9.145.37.149] (unknown [9.145.37.149])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2019 15:11:39 +0000 (GMT)
Subject: Re: [PATCH v3 3/7] ocxl: Create a clear delineation between ocxl
 backend & frontend
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325054438.15022-1-alastair@au1.ibm.com>
 <20190325054438.15022-4-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 25 Mar 2019 16:11:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325054438.15022-4-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032515-0020-0000-0000-000003275B4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032515-0021-0000-0000-00002179920C
Message-Id: <21fedf98-1b76-fc75-58d6-646e684f3e17@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-25_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250113
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a huge patch, there are probably ways to split it in smaller 
pieces to make the review easier. However, considering how much time 
we've already invested discussing and reviewing it, it's with by me to 
keep it as is.
The ref-counting and device management look good to me now. A few 
details below.


> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -17,12 +17,10 @@ static struct class *ocxl_class;
>   static struct mutex minors_idr_lock;
>   static struct idr minors_idr;
>   
> -static struct ocxl_afu *find_and_get_afu(dev_t devno)
> +static struct ocxl_file_info *find_file_info(dev_t devno)
>   {
> -	struct ocxl_afu *afu;
> -	int afu_minor;
> +	struct ocxl_file_info *info;
>   
> -	afu_minor = MINOR(devno);
>   	/*
>   	 * We don't declare an RCU critical section here, as our AFU
>   	 * is protected by a reference counter on the device. By the time the
> @@ -30,56 +28,52 @@ static struct ocxl_afu *find_and_get_afu(dev_t devno)
>   	 * the device is already at 0, so no user API will access that AFU and
>   	 * this function can't return it.
>   	 */


The comment is still true, but needs tuning. Something like:
"We don't declare an RCU critical section here, as our info structure is 
protected by a reference counter on the device. By the time the info 
reference is removed from the idr, the ref count of the device is 
already at 0, so no user API will access the corresponding AFU and this 
function can't return it."


> -	afu = idr_find(&minors_idr, afu_minor);
> -	if (afu)
> -		ocxl_afu_get(afu);
> -	return afu;
> +	info = idr_find(&minors_idr, MINOR(devno));
> +	return info;
>   }
>   
> -static int allocate_afu_minor(struct ocxl_afu *afu)
> +static int allocate_minor(struct ocxl_file_info *info)
>   {
>   	int minor;
>   
>   	mutex_lock(&minors_idr_lock);
> -	minor = idr_alloc(&minors_idr, afu, 0, OCXL_NUM_MINORS, GFP_KERNEL);
> +	minor = idr_alloc(&minors_idr, info, 0, OCXL_NUM_MINORS, GFP_KERNEL);
>   	mutex_unlock(&minors_idr_lock);
>   	return minor;
>   }
>   
> -static void free_afu_minor(struct ocxl_afu *afu)
> +static void free_minor(struct ocxl_file_info *info)
>   {
>   	mutex_lock(&minors_idr_lock);
> -	idr_remove(&minors_idr, MINOR(afu->dev.devt));
> +	idr_remove(&minors_idr, MINOR(info->dev.devt));
>   	mutex_unlock(&minors_idr_lock);
>   }
>   
>   static int afu_open(struct inode *inode, struct file *file)
>   {
> -	struct ocxl_afu *afu;
> +	struct ocxl_file_info *info;
>   	struct ocxl_context *ctx;
>   	int rc;
>   
>   	pr_debug("%s for device %x\n", __func__, inode->i_rdev);
>   
> -	afu = find_and_get_afu(inode->i_rdev);
> -	if (!afu)
> +	info = find_file_info(inode->i_rdev);
> +	if (!info)
>   		return -ENODEV;
>   
>   	ctx = ocxl_context_alloc();
>   	if (!ctx) {
>   		rc = -ENOMEM;
> -		goto put_afu;
> +		goto err;
>   	}
>   
> -	rc = ocxl_context_init(ctx, afu, inode->i_mapping);
> +	rc = ocxl_context_init(ctx, info->afu, inode->i_mapping);
>   	if (rc)
> -		goto put_afu;
> +		goto err;
>   	file->private_data = ctx;
> -	ocxl_afu_put(afu);
>   	return 0;
>   
> -put_afu:
> -	ocxl_afu_put(afu);
> +err:
>   	return rc;


The error path with goto is here useless. However, if 
ocxl_context_init() fails, the memory for the context is never released.
You may consider either getting rid of ocxl_context_alloc(), which is 
just a simple wrapper around kzalloc(), or merging the allocation in 
ocxl_context_init(). It would impact the external API, but having 2 
calls (alloc and init) feels like there's one too many.



> +static int ocxl_file_make_visible(struct ocxl_afu *afu)
>   {
>   	int rc;
> +	struct ocxl_file_info *info = ocxl_afu_get_private(afu);
>   
> -	cdev_init(&afu->cdev, &ocxl_afu_fops);
> -	rc = cdev_add(&afu->cdev, afu->dev.devt, 1);
> +	cdev_init(&info->cdev, &ocxl_afu_fops);
> +	rc = cdev_add(&info->cdev, info->dev.devt, 1);
>   	if (rc) {
> -		dev_err(&afu->dev, "Unable to add afu char device: %d\n", rc);
> +		dev_err(&info->dev, "Unable to add afu char device: %d\n", rc);
>   		return rc;
>   	}
> +
>   	return 0;
>   }
>   
> -void ocxl_destroy_cdev(struct ocxl_afu *afu)
> +void ocxl_file_make_invisible(struct ocxl_afu *afu)


This function is not called anywhere?



> -void ocxl_unregister_afu(struct ocxl_afu *afu)
> +void ocxl_file_unregister_afu(struct ocxl_afu *afu)
>   {
> -	free_afu_minor(afu);
> +	struct ocxl_file_info *info = ocxl_afu_get_private(afu);
> +
> +	if (!info)
> +		return;
> +


So that's likely where we miss the "make invisible" call. However, is it 
enough to rely on the private data to be set on the AFU?



> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 81086534dab5..e04e547df29e 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h


> +/**
> + * Free an AFU
> + *
> + * afu: The AFU to free
> + */
> +void ocxl_free_afu(struct ocxl_afu *afu);


This is obsolete and should go away.

   Fred

