Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 927E2683A8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 23:42:43 +1000 (EST)
Date: Fri, 30 Sep 2005 14:42:30 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Message-Id: <20050930144230.25f4917e.ajz@cambridgebroadband.com>
In-Reply-To: <20050930142218.348041d6.ajz@cambridgebroadband.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 30 Sep 2005 14:22:18 +0100
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> Till now I have worked around this problem by calling
> dcache_invalidate_range() and dcache_flush_range() before and after
> accesses to these areas.  I'm now considering changing to Kalle's
> way of doing it.
> 
> Are there any drawbacks to this approach?


To answer my own question: yes there is a drawback.

I've just done some performance tests on my driver.  In the first
test the driver uses invalidate/flush calls to keep the cache
coherent. In the second test I just use Kalle's mod to setbat().

In the second test the perfomance of the driver is roughly 1/3 of the
performance in the first test.

What I really want is a way of asserting GBL whenever the CPM accesses
ANY memory area other than DPRAM.  Hm.

Alex
