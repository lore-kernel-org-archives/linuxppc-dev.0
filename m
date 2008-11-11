Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A657DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 13:22:14 +1100 (EST)
Subject: Re: [RFC PATCH] Support for big page sizes on 44x (Updated)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ilya Yanok <yanok@emcraft.com>
In-Reply-To: <1226369868.7530.60.camel@pasglop>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1226369868.7530.60.camel@pasglop>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 13:22:03 +1100
Message-Id: <1226370123.7530.61.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, pvr@emcraft.com, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Well, the main thing is the implementation of kmap and kmap_atomic.
> 
> They both basically assumes that all the reserved PTEs for kmap and
> kmap_atomic are in a single PTE page since it uses a simple addition
> (substraction for _atomic really but heh, that's about the same).
> 
> Note that PKMAP (kmap) and FIXMAP (kmap_atomic) can be in two different
> PTE pages. But it's important that the whole PKMAP is entirely contained
> within a PTE page. It doesn't have to -start- on a PTE page boundary
> though. 

Also note that if you end up with PKMAP and FIXMAP on two different PTE
pages, make sure they are both instanciated at boot time.

Ben.
