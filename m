Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3DA76DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 04:22:42 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
Date: Thu, 30 Aug 2007 20:22:23 +0200
References: <200708291815.18197.fenkes@de.ibm.com>
In-Reply-To: <200708291815.18197.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708302022.24167.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 29 August 2007, Joachim Fenkes wrote:
> Previously, ibmebus derived a device's bus_id from its location code. The
> location code is not guaranteed to be unique, so we might get bus_id
> collisions if two devices share the same location code. The OFDT full_name,
> however, is unique, so we use that instead.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>

Actually, I think it would be much better to convert the code to be more
like of_platform_device, or to even replace all of ibmebus with that.

The whole logic of dynamically adding and removing device is rather bogus,
and it prevents autoloading of device drivers. of_platform_make_bus_id
is the function that is responsible for creating unique names over there.

	Arnd <><
