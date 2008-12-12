Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0218BDE02D
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 02:01:46 +1100 (EST)
Date: Fri, 12 Dec 2008 18:01:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [RFC] Dummy GPIO driver for use with SPI
Message-ID: <20081212150144.GA28147@oksana.dev.rtsoft.ru>
References: <4942738A.80609@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4942738A.80609@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 12, 2008 at 09:22:02AM -0500, Steven A. Falco wrote:
> This patch adds a dummy GPIO driver, which is useful for SPI devices
> that do not have a physical chip select.

Hm. Then you don't need a chip-select, and SPI driver must understand
this case. When SPI controller has no "gpios" property, it should just
ignore any chip-select toggling operations.

As an implementation example you can use this patch:

http://patchwork.ozlabs.org/patch/12499/

grep for "SPI w/o chip-select line."

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
