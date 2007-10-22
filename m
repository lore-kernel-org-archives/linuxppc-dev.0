Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB4F7DDE39
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 23:56:52 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9MDunb4022164
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 09:56:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9MDulTt075496
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 07:56:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9MDulhs015682
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 07:56:47 -0600
Subject: Re: [bug] block subsystem related crash on Legacy iSeries viodasd.c
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <20071021124426.GS10674@kernel.dk>
References: <1192829614.11003.30.camel@farscape.rchland.ibm.com>
	<20071021124426.GS10674@kernel.dk>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 08:56:45 -0500
Message-Id: <1193061405.11003.33.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-10-21 at 14:44 +0200, Jens Axboe wrote:
> On Fri, Oct 19 2007, Will Schmidt wrote:
> > Hi Jens, Stephen, and Everyone else.
...
> You need this, will remember to fix that up for the new branch as well.
> 
> diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
> index e824b67..2ce3622 100644
> --- a/drivers/block/viodasd.c
> +++ b/drivers/block/viodasd.c
> @@ -270,6 +270,7 @@ static int send_request(struct request *req)
>          d = req->rq_disk->private_data;
> 
>  	/* Now build the scatter-gather list */
> +	memset(sg, 0, sizeof(sg));
>  	nsg = blk_rq_map_sg(req->q, req, sg);
>  	nsg = dma_map_sg(d->dev, sg, nsg, direction);
> 

That appears to do the trick.     Thanks!  

Tested-By: Will Schmidt <will_schmidt@vnet.ibm.com>
