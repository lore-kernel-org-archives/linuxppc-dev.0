Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EDFA679F1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Jun 2005 19:29:43 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j589TcBk014378
	for <linuxppc-embedded@ozlabs.org>; Wed, 8 Jun 2005 10:29:38 +0100
Date: Wed, 8 Jun 2005 10:29:38 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20050608102938.023f271f.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: consistent_alloc() on 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I need to allocate un-cached memory on an 82xx and consistent_alloc() in
arch/ppc/mm/cachemap.c appears to be the thing I need.  However, this
code only seems to be built for 8xx and 4xx platforms, and not 6xx
platforms. Specifically, it is built if CONFIG_NOT_COHERENT_CACHE is
defined, which is the case if

	CONFIG_8xx = y, or
	CONFIG_4xx = y, but not if
	CONFIG_6xx = y

Does anybody know why it isn't built for 6xx cores?

I'm working on the ATM driver and it seems that certain external memory
areas accessed by the PQII CPM by-pass the cache.  So it would seem to
me that CONFIG_NOT_COHERENT_CACHE would actually be applicable for these
processors too....

Alex
