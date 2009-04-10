Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77B16DDF8E
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 16:40:07 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n3A6dYxu002139
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 16:39:34 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3A6e6oZ1081448
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 16:40:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3A6e6k0028154
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 16:40:06 +1000
Message-ID: <49DEE9C2.1040500@in.ibm.com>
Date: Fri, 10 Apr 2009 12:10:02 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [CFQ/OOPS]  rb_erase with April 9 next tree
References: <20090409163305.8c7a0371.sfr@canb.auug.org.au>
	<49DE1969.1000709@in.ibm.com> <20090409172918.GE5178@kernel.dk>
	<20090409174420.GG5178@kernel.dk>
In-Reply-To: <20090409174420.GG5178@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jens Axboe wrote:
>
> Can you see if this fixes it for you?
>
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index e01b103..64de5c0 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1654,6 +1654,7 @@ retry:
>  		}
>
>  		RB_CLEAR_NODE(&cfqq->rb_node);
> +		RB_CLEAR_NODE(&cfqq->p_node);
>  		INIT_LIST_HEAD(&cfqq->fifo);
>
>  		atomic_set(&cfqq->ref, 0);
>   
Yes. The above patch fixed this oops. Thanks

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
