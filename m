Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 21609DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 03:59:48 +1100 (EST)
Date: Thu, 18 Dec 2008 19:59:46 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH v1] Add support for getting device platform data to I2C
	device
Message-ID: <20081218165946.GA4029@oksana.dev.rtsoft.ru>
References: <1229566451-29411-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1229566451-29411-1-git-send-email-Mingkai.hu@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 10:14:11AM +0800, Mingkai Hu wrote:
> There is no standard way of getting device platform data from
> dts file to the I2C device when it's probed. This patch adds
> a function pointer to the of_modalias_table to get such bindings
> properties into device's platform data.

Unfortunately this approach leads to inability to make the bindings
modular.

Note that distributions compile kernels with allmodconfig*, so the
kernel builds with all modules, but _all_ these bindings will be
kernel's built-ins. Given that these bindings are needed for every
not-so-trivial I2C (or SPI) driver, the approach doesn't seem to
scale good enough.

You can find more discussion on this matter in this huge thread:
http://lkml.org/lkml/2008/10/16/248

And the solution that everybody seem to agree with (SPI driver example):
http://lkml.org/lkml/2008/10/30/393

* Well, this is not quite true, but they're very close to allmodconfig.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
