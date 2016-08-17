Return-Path: <cornelia.huck@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDjZw6jmYzDr56
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 18:49:28 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H8i7Zw110835
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 04:49:26 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24v3dgycm1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 04:49:26 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cornelia.huck@de.ibm.com>;
 Wed, 17 Aug 2016 09:49:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77BB01B08072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 09:50:57 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H8nL0N7340334
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 08:49:21 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H8nHDs010069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 02:49:20 -0600
Date: Wed, 17 Aug 2016 10:49:14 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Fam Zheng <famz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 virtualization@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, "Ed L. Cashin" <ed.cashin@acm.org>,
 Keith Busch <keith.busch@intel.com>, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>, Nitin
 Gupta <ngupta@vflare.org>
Subject: Re: [PATCH 06/15] genhd: Add return code to device_add_disk
In-Reply-To: <1471418115-3654-7-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-7-git-send-email-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20160817104914.37087cb3.cornelia.huck@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Aug 2016 15:15:06 +0800
Fam Zheng <famz@redhat.com> wrote:

> @@ -613,10 +614,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
>  	disk->flags |= GENHD_FL_UP;
> 
>  	retval = blk_alloc_devt(&disk->part0, &devt);
> -	if (retval) {
> -		WARN_ON(1);
> -		return;
> -	}
> +	if (retval)
> +		goto fail;
>  	disk_to_dev(disk)->devt = devt;
> 
>  	/* ->major and ->first_minor aren't supposed to be
> @@ -625,16 +624,26 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
>  	disk->major = MAJOR(devt);
>  	disk->first_minor = MINOR(devt);
> 
> -	disk_alloc_events(disk);
> +	retval = disk_alloc_events(disk);
> +	if (retval)
> +		goto fail;
> 
>  	/* Register BDI before referencing it from bdev */
>  	bdi = &disk->queue->backing_dev_info;
> -	bdi_register_owner(bdi, disk_to_dev(disk));
> +	retval = bdi_register_owner(bdi, disk_to_dev(disk));
> +	if (retval)
> +		goto fail;
> 
> -	blk_register_region(disk_devt(disk), disk->minors, NULL,
> -			    exact_match, exact_lock, disk);
> -	register_disk(parent, disk);
> -	blk_register_queue(disk);
> +	retval = blk_register_region(disk_devt(disk), disk->minors, NULL,
> +				     exact_match, exact_lock, disk);
> +	if (retval)
> +		goto fail;
> +	retval = register_disk(parent, disk);
> +	if (retval)
> +		goto fail;
> +	retval = blk_register_queue(disk);
> +	if (retval)
> +		goto fail;
> 
>  	/*
>  	 * Take an extra ref on queue which will be put on disk_release()
> @@ -644,10 +653,20 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> 
>  	retval = sysfs_create_link(&disk_to_dev(disk)->kobj, &bdi->dev->kobj,
>  				   "bdi");
> +	if (retval)
> +		goto fail;
> +
> +	retval = disk_add_events(disk);
> +	if (retval)
> +		goto fail;
> +
> +	retval = blk_integrity_add(disk);
> +	if (retval)
> +		goto fail;
> +	return 0;
> +fail:
>  	WARN_ON(retval);
> -
> -	disk_add_events(disk);
> -	blk_integrity_add(disk);
> +	return retval;
>  }

Noticed this when trying to figure out whether the error handling in
virtio_blk was correct:

Shouldn't you try to cleanup/rewind so that any structures are in a
sane state after failure? The caller doesn't know where device_add_disk
failed, and calling del_gendisk unconditionally like virtio_blk does is
probably not the right thing to do (at the very least, I don't think
unregistering a device that has not been registered is likely to work).
