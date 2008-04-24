Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7204FDDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 10:42:42 +1000 (EST)
Subject: Re: [PATCH 2/2 v2] mpic_u3msi: mpic_u3msi: failed allocation unnoticed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1208993783.9245.10.camel@concordia.ozlabs.ibm.com>
References: <480F6905.3070808@tiscali.nl> <480F8754.7000200@tiscali.nl>
	<df21920e067e73985f73047e2d8bcbda@kernel.crashing.org>
	<480FB766.1040405@tiscali.nl>
	<1208993783.9245.10.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 24 Apr 2008 10:42:29 +1000
Message-Id: <1208997749.9060.77.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-24 at 09:36 +1000, Michael Ellerman wrote:
> 
> I think the real bug is that we're using irq_hw_number_t to represent
> something which isn't. At the end of the day we have to stash the
> hwirq
> into the MSI message data, which is a u32.
> 
> I guess we could imagine a driver that does something magic to allow
> it
> to put something bigger than a u32 in the MSI message, but I doubt it.
> 
> So I think ﻿mpic_msi_alloc_hwirqs() should return a long, which allows
> it to return a full u32 plus the negative error values.

Until it's used on 32 bits...

Make it return an int error code and pass the hwirq elsewhere or use the
"illegal" hwirq number (each PIC defines one) as the error return.

Cheers,
Ben.
