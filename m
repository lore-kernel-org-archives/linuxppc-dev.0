Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 83198DDF33
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:13:05 +1000 (EST)
Date: Wed, 25 Apr 2007 16:13:09 -0700 (PDT)
Message-Id: <20070425.161309.02297897.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: David Miller <davem@davemloft.net>
In-Reply-To: <1177541265.14873.222.camel@localhost.localdomain>
References: <1177539404.14873.199.camel@localhost.localdomain>
	<20070425.152419.110959714.davem@davemloft.net>
	<1177541265.14873.222.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Apr 2007 08:47:45 +1000

>  - property names. That's what you had to deal with for Sparc. I think
> it's fair enough to use strcasecmp for these. They are supposed to not
> have case, while they happen to do here or there, there is almost no
> chance of conflict (several properties with a name differring only by
> the case).
> 
>  - property content. (That include node names which are really only the
> content of the "name" property of that node). The ATA/ata case was for
> property content in fact (name property and type property iirc) which is
> a different thing and must be kept case sensitive I beleive. That covers
> the case of of_device_is_compatible() which should use strcmp (or the
> -n- version of it of course).
> 
> Do we agree on that ?

Ok, I think so.

Meanwhile any feedback on the idea of pushing all of this
consolidation and cleanup work through one of our trees
instead of having all of these difficult dependencies
between the two?

Thanks.
