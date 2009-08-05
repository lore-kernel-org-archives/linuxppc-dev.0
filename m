Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E015BB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 10:54:08 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 67C0ADDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 10:54:07 +1000 (EST)
Date: Wed, 5 Aug 2009 04:54:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/7] Device table matching for SPI subsystem
Message-ID: <20090805005404.GA14451@oksana.dev.rtsoft.ru>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
	<200908031916.02880.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200908031916.02880.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 03, 2009 at 07:16:02PM -0700, David Brownell wrote:
> On Wednesday 29 July 2009, Anton Vorontsov wrote:
> > 	platform_data is overkill for m25p80 chips, the
> > driver only needs to know exact chip model, and that's what device
> > tables are for.
> 
> To be fair, the platform_data also supports partitioning
> and labeling e.g. for cmdlinepart ...

With OF we do partitioning and labling via drivers/mtd/ofpart.c.

Though, so far there is no support for OF partitions in the m25p80
driver. I think we'd better put the OF partitions probing into
parse_mtd_partitions(), and avoid calling of_mtd_parse_partitons()
directly...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
