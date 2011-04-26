Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A0AFB6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Apr 2011 10:02:10 +1000 (EST)
Subject: Re: device not available because of BAR 0 collisions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <4DB5D548.7020303@harris.com>
References: <4DB5D548.7020303@harris.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Apr 2011 10:01:54 +1000
Message-ID: <1303776114.2513.152.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-04-25 at 16:10 -0400, Steven A. Falco wrote:
> I'm getting an error message when trying to talk to some custom
> hardware:
> 
> dx83xx 0001:43:00.0: device not available because of BAR 0
> [0xa1000000-0xa1ffffff] collisions
> 
> I see in setup-res.c that this message comes out when there is no
> parent for
> a device resource.

 .../...

It mostly happens in arch/powerpc/kernel/pci-common.c and the generic
setup-res.c

Try #define DEBUG at the top (before the #includes) of pci-common.c and
pci_32.c (remove the exiting #undef in the last one) and send us the
full dmesg log, along with the output of cat /proc/iomem

Cheers,
Ben.
