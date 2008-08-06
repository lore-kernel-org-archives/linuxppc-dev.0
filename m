Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id AD20EDEA94
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 07:12:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: to schedule() or not to schedule() ?
Date: Wed, 6 Aug 2008 23:12:10 +0200
References: <4895F9EB.8050508@hypersurf.com>
	<1217977256.7593.2.camel@localhost>
	<4899059A.3020703@hypersurf.com>
In-Reply-To: <4899059A.3020703@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808062312.11078.arnd@arndb.de>
Cc: Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 August 2008, Kevin Diggs wrote:
> For the purpose of learning, there is no direct, correct way to yield 
> the cpu when in a timer fired routine, right?
> 

No, in a timer, you interrupt a totally unrelated thread, so sleeping
would prevent that from running on, as well as preventing other timers
from being run, so it's not an option.

One thing that might work for you would be to re-arm the existing
timer and return from your function, so you get back to it after
a short while.

	Arnd <><
