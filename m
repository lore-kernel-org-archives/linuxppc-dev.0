Return-Path: <axboe@kernel.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7671FB7196
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 14:36:16 +1000 (EST)
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBAC8DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 14:36:15 +1000 (EST)
Date: Wed, 17 Jun 2009 06:36:09 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Warning in block code
Message-ID: <20090617043609.GT11363@kernel.dk>
References: <1245202783.21602.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245202783.21602.5.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17 2009, Benjamin Herrenschmidt wrote:
> Hoy !
> 
> I see that:
> 
> block/blk-settings.c: In function ???blk_set_default_limits???:
> block/blk-settings.c:115: warning: large integer implicitly truncated to unsigned type
> 
> Comes from
> 
> 	lim->bounce_pfn = BLK_BOUNCE_ANY;
> 
> With BLK_BOUNCE_ANY being a
> 
> include/linux/blkdev.h:#define BLK_BOUNCE_ANY		(-1ULL)
> 
> And struct queue_limit.bounce_pfn is:
> 
> 	unsigned long		bounce_pfn;
> 
> (The warning is fishy as both quantities are unsigned, but there -is-
> truncation happening here).

Should be safe to just make it -1UL now.

-- 
Jens Axboe
