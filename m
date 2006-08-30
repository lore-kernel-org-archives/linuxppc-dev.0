Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E188067B6B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 19:43:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U9hb5Q010764
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 05:43:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7U9hbJD261936
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 03:43:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7U9hb2S022125
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 03:43:37 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] IB/ehca: includes
Date: Wed, 30 Aug 2006 11:43:34 +0200
References: <OF23CA96AE.C7DBFD52-ONC12571DA.00321849-C12571DA.00324865@de.ibm.com>
In-Reply-To: <OF23CA96AE.C7DBFD52-ONC12571DA.00321849-C12571DA.00324865@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608301143.35320.arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>, abergman@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 30 August 2006 11:13, Hoang-Nam Nguyen wrote:
> Further comments/suggestions are appreciated!

There are a few places in the driver where you declare
external variables (mostly ehca_module and ehca_debug_level)
from C files instead of a header.  This sometimes leads
to bugs when a type changes and is therefore considered
bad style.

ehca_debug_level is already declared in a header so you
should not need any other declaration.

For ehca_module, the usage pattern is very uncommon.
Declaring the structure in a header helps a bit, but I
don't really see the need for this structure at all.

Each member of the struct seems to be used mostly in a
single file, so I would declare it statically in there.
E.g. in drivers/infiniband/hw/ehca/ehca_pd.c, you can do

static struct kmem_cache *ehca_pd_cache;

int ehca_init_pd_cache(void)
{
	ehca_pd_cache = kmem_cache_init("ehca_cache_pd",
		sizeof(struct ehca_pd), 0, SLAB_HWCACHE_ALIGN,
		NULL, NULL);

	if (!ehca_pd_cache)
		return -ENOMEM;
	return 0;
}

void ehca_cleanup_pd_cache(void)
{
	if (ehca_pd_cache)
		kmem_cache_destroy(ehca_pd_cache);
}

Moreover, for some of your more heavily used caches, you may
want to look into using constructor/destructor calls to
speed up allocation.

	Arnd <><
