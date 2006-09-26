Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C201067CBC
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 12:55:42 +1000 (EST)
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton
	Blanchard's new hvcall interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <45186F25.9000700@garzik.org>
References: <200609251550.01514.ossthema@de.ibm.com>
	<45186F25.9000700@garzik.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:53:51 +1000
Message-Id: <1159239231.5462.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, pmac@au1.ibm.com,
	netdev <netdev@vger.kernel.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-25 at 20:07 -0400, Jeff Garzik wrote:
> patch does not apply.
> 
> also, it would seem like varargs would be appropriate here.

Not really... these are hypervisor calls, their calling convention is
not varargs, thus we would need some conversion layer if using them,
with possible performance loss (it's also hard to do right as we are
passing args by registers, not stack).

Ben.
