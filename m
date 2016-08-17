Return-Path: <cornelia.huck@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDjz81fzjzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 19:07:00 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H96qLf145708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 05:06:58 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24vb9jkrtx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 05:06:55 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cornelia.huck@de.ibm.com>;
 Wed, 17 Aug 2016 10:06:51 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3A3C12190061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 10:06:13 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H96mEU21168556
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 09:06:48 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H96kv6027616
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 03:06:48 -0600
Date: Wed, 17 Aug 2016 11:06:45 +0200
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
In-Reply-To: <20160817084823.GB19326@al.usersys.redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-7-git-send-email-famz@redhat.com>
 <20160817104914.37087cb3.cornelia.huck@de.ibm.com>
 <20160817084823.GB19326@al.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20160817110645.45370f57.cornelia.huck@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Aug 2016 16:48:23 +0800
Fam Zheng <famz@redhat.com> wrote:

> On Wed, 08/17 10:49, Cornelia Huck wrote:
> > On Wed, 17 Aug 2016 15:15:06 +0800
> > Fam Zheng <famz@redhat.com> wrote:
> > 
> > > @@ -613,10 +614,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> > >  	disk->flags |= GENHD_FL_UP;
> > > 
> > >  	retval = blk_alloc_devt(&disk->part0, &devt);
> > > -	if (retval) {
> > > -		WARN_ON(1);
> > > -		return;
> > > -	}
> > > +	if (retval)
> > > +		goto fail;
> > >  	disk_to_dev(disk)->devt = devt;
> > > 
> > >  	/* ->major and ->first_minor aren't supposed to be
> > > @@ -625,16 +624,26 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> > >  	disk->major = MAJOR(devt);
> > >  	disk->first_minor = MINOR(devt);
> > > 
> > > -	disk_alloc_events(disk);
> > > +	retval = disk_alloc_events(disk);
> > > +	if (retval)
> > > +		goto fail;
> > > 
> > >  	/* Register BDI before referencing it from bdev */
> > >  	bdi = &disk->queue->backing_dev_info;
> > > -	bdi_register_owner(bdi, disk_to_dev(disk));
> > > +	retval = bdi_register_owner(bdi, disk_to_dev(disk));
> > > +	if (retval)
> > > +		goto fail;
> > > 
> > > -	blk_register_region(disk_devt(disk), disk->minors, NULL,
> > > -			    exact_match, exact_lock, disk);
> > > -	register_disk(parent, disk);
> > > -	blk_register_queue(disk);
> > > +	retval = blk_register_region(disk_devt(disk), disk->minors, NULL,
> > > +				     exact_match, exact_lock, disk);
> > > +	if (retval)
> > > +		goto fail;
> > > +	retval = register_disk(parent, disk);
> > > +	if (retval)
> > > +		goto fail;
> > > +	retval = blk_register_queue(disk);
> > > +	if (retval)
> > > +		goto fail;
> > > 
> > >  	/*
> > >  	 * Take an extra ref on queue which will be put on disk_release()
> > > @@ -644,10 +653,20 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
> > > 
> > >  	retval = sysfs_create_link(&disk_to_dev(disk)->kobj, &bdi->dev->kobj,
> > >  				   "bdi");
> > > +	if (retval)
> > > +		goto fail;
> > > +
> > > +	retval = disk_add_events(disk);
> > > +	if (retval)
> > > +		goto fail;
> > > +
> > > +	retval = blk_integrity_add(disk);
> > > +	if (retval)
> > > +		goto fail;
> > > +	return 0;
> > > +fail:
> > >  	WARN_ON(retval);
> > > -
> > > -	disk_add_events(disk);
> > > -	blk_integrity_add(disk);
> > > +	return retval;
> > >  }
> > 
> > Noticed this when trying to figure out whether the error handling in
> > virtio_blk was correct:
> > 
> > Shouldn't you try to cleanup/rewind so that any structures are in a
> > sane state after failure? The caller doesn't know where device_add_disk
> > failed, and calling del_gendisk unconditionally like virtio_blk does is
> > probably not the right thing to do (at the very least, I don't think
> > unregistering a device that has not been registered is likely to work).
> > 
> 
> Yes, I think all callers need to be reviewed before device_add_disk do the
> clean up on error. For this patchset I wanted to keep the change small.

But do the callers even have a chance to do this correctly right now?
They will either clean up too much, or too little. ('Too little' is
probably the more common case, given that you just added error
propagation...)

Can you make del_gendisk handle devices partially setup via
device_add_disk in all cases? Then you could mandate pairing
device_add_disk with del_gendisk in all cases, error or not, and you
should have a better chance on avoiding introducing new errors.
