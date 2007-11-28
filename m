Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2701DE085
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 06:52:35 +1100 (EST)
Subject: RE: [PATCH] e1000: Fix for 32 bits platforms with 64 bits resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
In-Reply-To: <36D9DB17C6DE9E40B059440DB8D95F5203DF7871@orsmsx418.amr.corp.intel.com>
References: <20071116073821.548CCDDDF4@ozlabs.org>
	<36D9DB17C6DE9E40B059440DB8D95F5203DF7871@orsmsx418.amr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 06:52:12 +1100
Message-Id: <1196279532.13230.14.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, "Kok, Auke-jan H" <auke-jan.h.kok@intel.com>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-28 at 10:47 -0800, Brandeburg, Jesse wrote:
> 
> > The side effect is that I removed the assignments to the netdev
> > fields mem_start, mem_end and base_addr, which are totally useless
> > for PCI devices.
> 
> also, concerning this, ifconfig shows the output of these variables, I
> don't think we want to blatantly remove them, as it is actually removing
> information that is, if not used, at least displayed to user space.

It's not the right place to have that information and there is no
room in the user space field to fit more than 32 bits on 32 bits
platforms so I'd rather remove it. It's really only for ISA drivers that
have user configurable addresses.

Ben.
