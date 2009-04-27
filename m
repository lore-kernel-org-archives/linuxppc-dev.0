Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B984DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 00:21:10 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 4E0E31E6B07
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 11:20:50 -0300 (BRT)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id dkPE02fWg7xC for <linuxppc-dev@ozlabs.org>;
	Mon, 27 Apr 2009 11:20:48 -0300 (BRT)
Received: from chagas.nectar.ath.cx (unknown [187.22.248.170])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id 11C5F1E6C51
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 11:20:41 -0300 (BRT)
Date: Mon, 27 Apr 2009 11:20:25 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] powerpc: convert mace to netdev_ops
Message-ID: <20090427142024.GC29608@ime.usp.br>
References: <20090426155708.GA23159@ime.usp.br>
	<20090426.230648.254087966.davem@davemloft.net>
	<20090427121633.GA29608@ime.usp.br>
	<20090427.054258.16622932.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090427.054258.16622932.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Dave.

On Apr 27 2009, David Miller wrote:
> You can fix the mace_set_timeout() function arguments by having a
> helper function that simply wraps around it and provides the second
> expection of argument types.

Hummm, this means that I'm not that bad... The wrapper function was the
first thing that came to my mind, but I just wanted to be as least
disruptive as possible.

> Your patch is also wrong, it's missing a lot of netdev_ops
> entries that are implicitly obtained via alloc_etherdev(),
> namely:

Thanks for pointing those out. I didn't find the documentation about
netdev_ops under Documentation (a simple grep didn't turn any results).

> 	.ndo_change_mtu		= eth_change_mtu,
> 	.ndo_set_mac_address 	= eth_mac_addr,
> 	.ndo_validate_addr	= eth_validate_addr,

Nice. I will incorporate such things.


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
