Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 725101007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 02:16:40 +1100 (EST)
Message-ID: <4B056158.5060104@embedded-sol.com>
Date: Thu, 19 Nov 2009 17:16:40 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: tg3: link is permanently down after ifdown and ifup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a problem with tg3 driver on a custom MPC8536 based board
running linux-2.6.31, with tg3 and Broadcom phy drivers taken from
linux-2.6.32-rc7. Broadcom NIC is BCM57760, phy is BCM57780.

The problem I'm seeing is that the downing and interface leads to
permanent link loss, even after interface is upped again. E.g, to
reproduce the problem it is sufficient to run:

modprobe tg3
ifconfig eth2 up
ifconfig eth2 down
ifconfig eth2 up

After ifdown PHY LEDs also go down and do not come back
after ifup. Ethtool reports that no link is detected. After reloading
the driver the link comes back.

Am I the only one seeing this problem  ?
Any help on fixing this is appreciated.

Thanks a lot.

Felix.
