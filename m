Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9FBB8B71B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:39:54 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1EB1DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 11:39:53 +1000 (EST)
Subject: Warning in block code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <jens.axboe@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Jun 2009 11:39:43 +1000
Message-Id: <1245202783.21602.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hoy !

I see that:

block/blk-settings.c: In function ‘blk_set_default_limits’:
block/blk-settings.c:115: warning: large integer implicitly truncated to unsigned type

Comes from

	lim->bounce_pfn = BLK_BOUNCE_ANY;

With BLK_BOUNCE_ANY being a

include/linux/blkdev.h:#define BLK_BOUNCE_ANY		(-1ULL)

And struct queue_limit.bounce_pfn is:
 
	unsigned long		bounce_pfn;

(The warning is fishy as both quantities are unsigned, but there -is- truncation
happening here).

Cheers,
Ben.
