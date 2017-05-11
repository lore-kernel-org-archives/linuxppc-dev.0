Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNpMS5HXbzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 19:53:24 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4B9niZc012415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 05:53:21 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ac5r6g9rk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 05:53:21 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 11 May 2017 19:53:18 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4B9r8V866584658
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 19:53:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4B9qhO2016288
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 19:52:43 +1000
Subject: Re: [linux-next][bock] [bisected c20cfc27a] WARNING: CPU: 22 PID:	0
 at block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, sachinp <sachinp@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 11 May 2017 15:22:25 +0530
In-Reply-To: <20170510175506.GA5084@lst.de>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
 <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
 <1494227599.2983.2.camel@abdul.in.ibm.com>
 <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk>
 <1494343101.11532.4.camel@abdul.in.ibm.com> <20170510075642.GA10943@lst.de>
 <1494409780.11532.14.camel@abdul.in.ibm.com> <20170510175506.GA5084@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1494496345.6713.2.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-10 at 19:55 +0200, Christoph Hellwig wrote:
> Hi Abdul,
> 
> can you test the patch below?  I'll try to create a way to inject
> short WRITE SAME commands using qemu next, but I thought I'd give
> you a chance to try it as well.

No warnings with the patch. Thanks for all your support !

Reported-and-tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

> 
> ---
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c580b0138a7f..c7068520794b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2644,8 +2644,6 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
>  		return false;
>  	}
> 
> -	WARN_ON_ONCE(req->rq_flags & RQF_SPECIAL_PAYLOAD);
> -
>  	req->__data_len -= total_bytes;
> 
>  	/* update sector only for requests with clear definition of sector */
> @@ -2658,17 +2656,19 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
>  		req->cmd_flags |= req->bio->bi_opf & REQ_FAILFAST_MASK;
>  	}
> 
> -	/*
> -	 * If total number of sectors is less than the first segment
> -	 * size, something has gone terribly wrong.
> -	 */
> -	if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
> -		blk_dump_rq_flags(req, "request botched");
> -		req->__data_len = blk_rq_cur_bytes(req);
> -	}
> +	if (!(req->rq_flags & RQF_SPECIAL_PAYLOAD)) {
> +		/*
> +		 * If total number of sectors is less than the first segment
> +		 * size, something has gone terribly wrong.
> +		 */
> +		if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
> +			blk_dump_rq_flags(req, "request botched");
> +			req->__data_len = blk_rq_cur_bytes(req);
> +		}
> 
> -	/* recalculate the number of segments */
> -	blk_recalc_rq_segments(req);
> +		/* recalculate the number of segments */
> +		blk_recalc_rq_segments(req);
> +	}
> 
>  	return true;
>  }
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
