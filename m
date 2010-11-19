Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8D2E1007D2
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2010 08:47:08 +1100 (EST)
Subject: Re: Change in PCI behaviour
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4CE69AF6.6090408@mlbassoc.com>
References: <4CE69AF6.6090408@mlbassoc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 20 Nov 2010 08:46:58 +1100
Message-ID: <1290203218.32570.48.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-11-19 at 08:42 -0700, Gary Thomas wrote:
> In this case, note that PCI device 0000:00:0c.0 is at 0xc0000000.
> This causes problems because it's a truly stupid device that does
> not work properly at PCI [relative] address 0x00000000.  It simply
> does not respond at that address.  Pick anywhere else and it will
> work fine! 

Hrm, we used to have a trick avoid giving out the first meg of a bus to
avoid that sort of thing, I suppose it got lost. The rest is related to
the way you map your PCI I suppose in your dts. You can switch back to a
1:1 instead of 1:0 mapping I suppose.

One way to achieve the above result would be to, in your platform code,
reserve the mem region that corresponds to PCI 0...1M (c0000000...+1M)
before the device resources are assigned/allocated.

I though we had code to do that with the "legacy" regions somewhere...
oh well, no code at hand to check right now.

Cheers,
Ben.
